#!/usr/bin/python3
import sys
import ast
import numpy as np
import math

if sys.argv[1] == 'cyclic':

	entrada = input('Cs (Amb []): ')
	cs = ast.literal_eval(entrada)
	entrada = input('Ts (Amb []): ')
	ts = ast.literal_eval(entrada)
	u = 0;
	for ci, ti in zip(cs,ts):
		u += float(ci/ti)
	print('U = ' + str(u))
	h = np.lcm.reduce(ts)
	print('H = ' + str(h))
	maxci = max(cs)
	mindi = min(ts)
	tss = range(maxci, mindi+1)
	for tsec in tss:
		if h%tsec == 0:
			valid = 1
			print(str(tsec) + ' temps secundari')
			for ti in ts:
				if((2*tsec - np.gcd(tsec, ti)) > ti):
					valid = 0
					print('No valid')
			if valid == 1:
				print(str(2*tsec - np.gcd(tsec,ti)) + ' mes petit que deadline')
				print(str(tsec) + ' valid')


elif sys.argv[1] == 'rm':

	entrada = input('Cs (Amb []): ')
	cs = ast.literal_eval(entrada)
	entrada = input('Ts (Amb []): ')
	ts = ast.literal_eval(entrada)
	entrada = input('Prioritats (Amb []):')
	prio = ast.literal_eval(entrada)
	u = 0;
	for ci, ti in zip(cs,ts):
		u += float(ci/ti)
	if (u <= (len(cs)*(np.power(2,float(1/len(cs))) - 1))):
		print('Planificable per formula 1.')


	else:
		u = []
		productori = 1
		for ci, ti in zip(cs,ts):
			u.append(float(ci/ti))
		for ui in u:
			productori = productori * (ui + 1)
		if productori <= 2:
			print('Planificable per formula 2.')
		else:
			#Time analysis
			for i in range(0, len(cs)):#Per a cada tasca
				pri = prio[i]
				ci = cs[i]
				wold = 0
				wnew = 1
				w = 1
				tmp = 0
				while (w != wold):
					sum_tasks = 0
					wold = w
					for a in range(0,len(prio)): #interant prio
						if(prio[a] > pri and tmp == 1):
							sum_tasks += (math.ceil(wold/ts[a]))*cs[a]
					w = ci + sum_tasks
					tmp = 1
				if w <= ts[i]:
					print('Tasca planificable amb w = ' + str(w) +  ' (mes petita que ' + str(ts[i]) + ' )')
				else:
					print('Tasca no planificable amb w = ' + str(w) +  ' (mes petita que ' + str(ts[i]) + ' )')
			print('Acabat.')


elif sys.argv[1] == 'dm':

	entrada = input('Cs (Amb []): ')
	cs = ast.literal_eval(entrada)
	entrada = input('Ds (Amb []): ')
	ds = ast.literal_eval(entrada)
	entrada = input('Ts (Amb []): ')
	ts = ast.literal_eval(entrada)
	entrada = input('Prioritats (Amb []) (A partir de Deadline):')
	prio = ast.literal_eval(entrada)
	#Time analysis
	for i in range(0, len(cs)):#Per a cada tasca
		pri = prio[i]
		ci = cs[i]
		wold = 0
		wnew = 1
		w = 1
		tmp = 0
		while (w != wold):
			sum_tasks = 0
			wold = w
			for a in range(0,len(prio)): #interant prio
				if(prio[a] > pri and tmp == 1):
					sum_tasks += (math.ceil(wold/ts[a]))*cs[a]
			w = ci + sum_tasks
			tmp = 1
		if w <= ds[i]:
			print('Tasca planificable amb w = ' + str(w) +  ' (mes petita que ' + str(ds[i]) + ' )')
		else:
			print('Tasca no planificable amb w = ' + str(w) +  ' (mes petita que ' + str(ts[i]) + ' )')
	print('Acabat.')

elif sys.argv[1] == 'edf':
	entrada = input('Cs (Amb []): ')
	cs = ast.literal_eval(entrada)
	entrada = input('Ds (Amb []): ')
	ds = ast.literal_eval(entrada)
	entrada = input('Ts (Amb []): ')
	ts = ast.literal_eval(entrada)
	u = 0;
	for ci, ti in zip(cs,ts):
		u += float(ci/ti)
	print('U = ' + str(u))

	if (u <= 1 and ds == ts):
		print('Planificable (u < 1, D = T).')
	else:
		h = np.lcm.reduce(ts)
		print('H = ' + str(h))
		sums = 0
		for i in range (0, len(cs)):
			sums += (ts[i]-ds[i])*(cs[i]/ts[i])
		l = float(sums/(float(1-u)))
		l = math.ceil(l)
		period_aval = min(h, l)
		print(str(period_aval) + ' periode avaluació')
		#sumatoris mes petits que l per a cada d
		des = []
		for tasca in range(0, len(cs)):
			de = 0
			k = 0
			while (de <= l):
				de = k*ts[tasca]+ds[tasca]
				if(de <= l):
					des.append(de)
					k+=1
		print("D aconseguits:")
		for de in des:
			print(str(de))

		for de in des:
			sum_g = 0
			for tasca in range(0, len(cs)):
				sum_g += math.floor((de + ts[tasca] - ds[tasca])/ts[tasca])*cs[tasca]
			print("Suma fins L = " + str(de) + " : " + str(sum_g))
			if sum_g <= l:
				print('Part correcte ( <= ' + str(l))
			else:
				print('Part incorrecte ( > ' + str(l))

elif sys.argv[1] == 'bs':
	print('Cyclic with background server')

elif sys.argv[1] == 'ps':
	entrada = input('Cs (Amb []): ')
	cs = ast.literal_eval(entrada)
	entrada = input('Ts (Amb []): ')
	ts = ast.literal_eval(entrada)
	prod = 1
	for task in range(0, len(ts)):
		prod *= (cs[task]/ts[task] + 1)
	umax = 2/prod - 1
	if(umax <= 1):
		print('Planificable. U = ' + str(umax))
		temps = range(min(ts)+1,max(ts))
		print("Possibles valors Ts, Cs: ")
		for tes in temps:
			print("Ts = " + str(tes))
			print("Cs = " + str(umax*tes))

	else:
		print('No planificable.')
	