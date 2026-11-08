Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163925;
	b=2eICXbBmuwJ6UPzsaA9rb1zxycZthgyzPRSbfxJ2Pmhd/5Jeu00FGA6NOaAUrbJets/e
	 dRgkr4ACNWU1n+3SU2NPfYTF4VqFZmmMdJCmyTTbXv9iLxXZqnJ9KaMNKZTBhSXJ9TJTz
	 R+mbQXRMlKMKkK8mIb7cfSpN8co8PjIwWvgCJs+q6DTWJUnvTC3U5zZZnygGoAkZ7VXhT
	 2xGYSa/3IXHuiSVJBVrxpOoGwZM9WxRkELxT50V3BFIoUdImHAz1IoNVP0B6Rc3tqcHRp
	 ml/wZHqPZFr2uNDXzxA2iQb6BusdMEpesadoPEXcYJVFJm2vOw3OWOHChWxzT4InlZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163925;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Date:
	 Message-ID:From:To:Cc:Subject:Content-Type:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=D+xixqgoKNfdiImYb2FzVYO/LJ2cNmhJlARiZ8rB8/8=;
	b=UlV2tnr1f/xHG/NPOT9SMr3t3NvOWQEPcjC+R2gyPtx2I2KJFXZ/6dJReWS5nRnPbZp8
	 MvIdkJxpytOcss4lXsVphB6ImqKro34120usHgZmcpZrMcp6puZVs0LrmM763x0oyk/Mk
	 DEQbgHHcFBEBIL/fLjsVTuuSaPLpmgCsgnNTuSXc+t3yll5i8qhSTO/pC6+nXc5QWP7RS
	 8MYDW5oEvdQYlVJq8dkJSMFINrpVuC+VLWAEfUhQGbIq6PSP1+eY0/9ffC/xYgs7WMfMo
	 PoFNI43jQLxPC13MAltXIW0WTiHPNJAc4KCujbQd567zGJOqNfjCocFXi+M5iKCFtTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=pjjonas@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Zc4z8duA;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6982606A31C
	for <linux-mmc@vger.kernel.org>; Sun,  8 Nov 2026 18:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6982606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=pjjonas@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Zc4z8duA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794163916; x=1794768716; i=pjjonas@web.de;
	bh=D+xixqgoKNfdiImYb2FzVYO/LJ2cNmhJlARiZ8rB8/8=;
	h=X-UI-Sender-Class:Date:Message-ID:From:To:Cc:Subject:
	 Content-Type:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=Zc4z8duAfpf/sHXhQsu8u5TGc4ECkB6bgEzLkrSA5ZqT1DJ0qYTami0fOZL7N5ya
	 p6L1OyazgKjsRxppN8HviYn+pqd3cgZaiL5z+7ymOxPJtYQqfCCM0FM+Wz05lYAOE
	 4gTqr5V/IIc5Eqp83oyaqdan5lnd/bhg/T8bUxKIFkJAy3IDd5++j68P2p2e2TxC5
	 oyeQuWlVP4zvNDFFKXr1Rn/Uw3uN8N7jpotV/S7RxVXJyD2QF1ZjLNowHHG3TqdvM
	 7Hi4i3Uwnr0agYMmloxoAD0T1lp3zH7/NR4jgBBbbec+s0eoAkY9mkkY9WEyKfDMD
	 dN8z5Th0tkjDc8Ou6Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Vsr-1wMFkD14rJ-00tk7O; Sun, 08
 Nov 2026 19:51:56 +0100
Date: Sun, 08 Nov 2026 19:51:40 +0100
Message-ID: <523eb7d1cc0811df4a5e4c534538f3dd@web.de>
From: Philipp <pjjonas@web.de>
To: linux-mmc@vger.kernel.org
Cc: regressions@lists.linux.dev, ulf.hansson@linaro.org
Subject: [REGRESSION] rtsx_usb_sdmmc: RTS5129 (0bda:0129) no longer detects SD card
Content-Type: text/plain; charset=utf-8
X-Provags-ID: V03:K1:Jjyv29NwY+h7ag9Lj6+In+hPdQDEKHDrxxcDKmq6xIJjMYb05Ak
 4xThrAGFcB1Obe38I6PISi48Fq+vS5Cix1WhV16zaMqdnYy4MVuoA8O0eUkzuw1Bx2LXPcY
 +rrei/QCb3AbLhDbOyHIpDAwwiora8ZBQCRH2iuqVHdpqzBK7P/IhCRf96n7nisdEtdaroB
 Q/N764Kw4j7Q9jXRHGEMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TLiYle14owA=;GhfHPJFZyGa9+xWSvhySdBxcYXK
 3sNGXHKK1pJYV7JCBAXVVmw5nFpYi8dmRlOcwB3pbe3lwyR9gnX8WbuVn9kjp3jlgVmxU4RC3
 7H0q4X+ISFrQUHrnsqSVgz+yH0H71NgXcdkfcZbMZjf2QgNFuex16oc4cS6bFXF1YGq0FgHRt
 CggvQOQ8qzdaCCyvDNcG4ReMTG2dA1FsAJOYFwPHY+q2A6yQAQcTUGgbydA8TiJ1d3PbM4gai
 6IW1bEbul7pefRFaEIaf1UZJTzSBtIVMj3q8rpe9MOPnshJSorx6HW/r9FE1RvSG+2IYpq26j
 HK3CV+hMINxI+IZmR37WQ0/v348a47Aw3VlsLAA7dCwucFwKKWW5c8TmizxzM+SniF5f6ek/x
 i2h3CrCibPl53M2DrzZbe8SnqDDfM0sRq1+Al7UUxuXLPzzdvLTWVuMe0gmzr4tgMoCWeENyc
 XuhgaiGxrHNwYHcK7XLDPqR67gMn5mxX92lZC6ziM5iIxI4RPsAHATcgRCaPQ1Dif4riwQTgD
 dI4VMgVbT+jqwoCGhYd4UdrqHJuW40txDWirAbK/bJULoWgjH/LZk1Jyh+eFTStb3VF/iaacH
 l2sP+Fb+pezAH4sHPadoB9m5xMO4EcRH3ZL1c9tS2m/K3UFOvkssKOzxNXv3Kux0aLfuh4bzz
 IvVUhfSDKf6s3jAsq54th+pp5BF+fqndtI8Vc740/ITtuHrMOH1NrSdDqmO6MfooCyVVIkYo3
 8N+5KlGcAgvw2K1dmNiSVCAQuWvoJ0DC4bg16SCafHf4sVF1oy8qJ9YqPpQ8SfTRjVoFdCpzn
 Z8mOAEEj3nyESWQ2NC+eZfZJ4s1PbokxXFm8ckcN4B5MuY6TtJJOx5gH6OkYbp4Nesz9mdwz9
 AH4RfaSCwUPOqzhNMpSyVq7hsMrW8cSLNnQ4jq3QpG1k6MonxSc2BVO/tK4DSkVLyqFwMoNmr
 e0dQwkzsp8kk3/7UNUzsOSN4qdgrnTiQEuzMRMsQcUrtOnrieoNwGJ6GSKBkXPSI2Ry9lFUHo
 jkXtGXGpOjOJVpPTG0mYC0CkvyV+5qKrGcZCVVGxxr9okYJLcCGfAqrkCnjNKEBbxtZWH23Jf
 2cpPJ9Bpc5RE8uSXLwGFlPA/NcTwsHMl6IihUNy3j36UcTEbmvOZDbXvqHEKqQ1pBAYrJFc00
 8fCdr/WkHmuY6eiJCEIPxxs2bk72z61706WzAzB8rHItWiLcU9dYxYfCsHGJmD4So3romf/SB
 z7+oh/YKkEPn6xirPh6YWqaC8cjKAkRTvK+iZr7sl3I5rO3J+xh3/RR05g8taOKUtS1mBefdN
 8aLAS4hiSG1KP0GVP575sdKRci6TQZfos5WxFkLx9q99Ej0Z8zalCpPOPGfQSlCafDnjv9AdV
 6vtBZZYWm2jfN6Hxxj1zrOCuMeNzdkrUgfd0EFKaF7wVqplbtrFtLLceUffZ1g3QETQ8o7nHr
 r0ndM5Ao9GKzkNBqO1+LzvvL7FGMZ9IG3yBCb2iySKHQTHCRY0z9m9vZceO4NLyVpEKxn19ah
 mv6JDoHpZcAqY18Q+M7Ie2KVxWudpkvAIc2+uT8W/npXSjBeP0wuf6CPVZN82SL2RWmNCe0Ou
 yqIl96rhOMoN89+DQoZYKVFMADbrdgBYnKqIYzw4gCNX64rTjQAK9OiHYmRlgywMMVomELIiz
 OWxvTSWPl9J5km06J4/TclQMd8HYhZ3xJ2BcKBqnDlBd/Y7/gqH7oCdalU7/AzsUF63/DTOvR
 dl+E3VUYkmEw3BqZtlT+QTTTiEtz0l8aVzuATlwvs+Q6zwkNM2qVdvyH1+zdjBfdikAVgUQvG
 iNXNoHYURoAdDoK+3Zblbe8mZzTLpHo5joE/5romhHt4lMjOif6Ey9uUwW57pZnHO1BhvR6SQ
 Obnz9njFvssZrSyg8DeTGbEo1H0X9nt1Ma4TV1gvdYnZ0JfPQSN1Ohj/Cf5CSz8GyrKv6OGln
 /MYNObUyqvLONwsFtHPIab6Mp/Z09LLlzT8/uPW53Pxa5lBWFyqvBfDDQoGVJ9MkwMuPUNEq9
 5+pd3XnHNX0YYsEwu4jZP0Z9KTFBCjaJk4Ku5iDK+edf79TGCFtmlslyR8KwXrjO6cEGrukOF
 1a09S7hKOL98zAFeq4NFhpAiDHwU6tXwQJnyDhbYKil1ob8boKW90TRP892HjwwlCZ6NyV3pU
 tfK1o7BHc4lahCfbyCcYb6OBfLGZD4EM8X73pgw758a9qyMX8qh3WlsuvXpqnl37hjRqYJDte
 X65OdD9AH1fFPnoPvJVsykQnxTmgyfX+rpaZ+Inzselv64FxxXyk+OkNXVqbMki0DGH0umYTh
 wj1scoR/dyiohaHWLqkQfC9Y5dLA+KYyiwCtg6If1QTBbmLmgQh/0roDh+mHiJvm9bxqOyhuS
 0fH+roFeRNtuHuhVhOJ16P3/Qa27ioisz24c3kFjVrfe3e6UYcO3P46L6eUqd2tWzP+NFEtSx
 R0AiA7s0gVi2zB3h7gTZ6wbioYbEypYNMzc+uUZKl77ZLpE9NT6Yeol4UBxQjgprE3vzS9Yod
 dyPxjKUxSkaGqzEAspXFCZHxHAbu5SGFaOM8Lfyf23DDs7UOMS7Afr4CLjAMuFtWpUScEus99
 bpMoh9tR3jHTn58mlYPHOsd6WsddUvzdmySRakhRKhXz9blbWaJonFoNVmOidqHlby0cgeAzz
 seiiVlSoe2/a43V/DCDu51RVZhY7DAIgVWuhUFyS2y30DvixDLgGNESFy4QKcUUd/44A9fCmQ
 50aOTzy9KNCQd7491EL/oLoXXI8CsZjAyMiSXd0K9h87HmGx1p0oepJsV3VOZLr4DdxakaF7o
 Qtj/VLSAcIiCZ4F5IWO3iTJyilsuTFjnQbsLG+DBgAyX1/+CAXGE5Z/anOGNriXKm2tvZwxQl
 EDJTSR2thKOlOCXFy9NbgPRBTA6hqP1w5Phc+JWShGThajZmMk2BVrYI+7whJZZZmv/THHfzP
 f87kNXR9SpxZvMISdF/vEg0EZ4h/551EM8pdFrM+DuH9DGvgr2WoAVQjH7xwXfZbSs76NRFrs
 ra0fyrkbZ/tVe5zS6vxQa9Z3CoNnwgKdDlTwhaVTFZ2EZAuaFiwd0FZUAAQrgoyfoqS7vtRCh
 npOeT55fym994ShcAN9Euhk+pzpufRVD2sVYm/WM1momw44h+zhUDR2xDLvWWf4UXhSUadEjO
 tdipexGycFXVpmyhtwpx91AJ+yvrcX3jCkd2O6iUnFQiZMHqSM//6bjlGNSHREquYBJEH463W
 SqHRM/osbR1pROsB/GhBLqPJMedIKZ0zqS/CoN5jiNsXwQC/Hn+WVeoAJiMyDwx0k57nElAgE
 27d+KrttHR7N3VjAU0j2fzXWWCmp6WOqpxKZ+44QZ5PMd0qVCJXvlCoKVfQpzAUlWrf/+kQOD
 Dil0EFYjecnF75VLnjogAFstkx2MFTq6c1MU/j6WpEPbnb+UGA6tnVKCPFhbxEx+nMrCeoXDI
 DqGzeBhXc91vuQ6mdLlderGkTA6GVvxSQ2T3FeW2WRCRx2PkhLUVOO92lhXtJY15aTRAOXlWI
 KpWUa21eTLtCa9epBaDvlw5gky9PU2QoYq5VP5nVdDsz/fbkZUM27q91cPnzTGvRih7URcZyl
 lSIf+cjXY90wFUE4LXQSqjAzrS1ch1xsBaqnimRZYfUWC3/6jIaACYwwcyudbzOjAIsp7Lr01
 NUCbM0xHRI9B/t9/QCqiThEmpXl3VBGIdo6KLxSh7wz/+t2HZn1FvBe1zzIAenUlMvF7AN0Hu
 yMcUtQZGOmM85n+z24BiCVLODU5abUzMgL0JuvD/GcljFGPzbnIfg1qYz7vFTiR/xzgJJr1KQ
 raeBVP6TXmMCpnfXPbfDWWjFvP7wJboCedSsLbt/KTk8besTkZTDECjzfJMk0IvsYc9TMBV8/
 GzYkB16GJy8MYmlctUJ9017Q2Nv7tQi9q0HJ56cRztEtYjkDWOorDDnPZoEsAA7+Hgv6nBlKr
 JRda/N6jl7rigvY1em/3af9m0iToNiPHsYCG7FeANNR9Hs+s7fc5aoyvKsvDZ6F8mYQKjnNAw
 bcYVzYhe04ikPLKVxLqqiP14uM9Nsf9CMCpP5FbEhmYgGK4OVUkrFrVlGBr6KF8st9KRHKCUC
 APm4HUJwQjMdUpXmsMvzFnEIbwVAjP2o3cDYwfqzV8RpYa5hmi/CXxMRPAG5zPD5t5IZlbt1i
 54CATo29ffh2a5sCBi+DBfLV/WFCCNGL7h/08EV5wLsviumPWKISqiYz6cYLH2QB5lm2yxDhB
 DJNc+Tkma2rmBlmV/TC6718WmPsbpM3GZFyxJpmKWdpqIVxsoRCAhymySova+bIGfZeJax0g7
 83IuL1AHBAJBv7Q1vEgta2ZS3RnJhkU1H+2tW8512ADJnsmgwUyye4VHXjNj3b+hWtFdlQ/y1
 5DlFHFjIc3TkjvBfmh959tOBf5+h5UuRHgXrMqMrTpbmaNo8VsKJZdOUvu80OHWjS1gxsa4Uz
 SOz8J6jrl7AB4n9OHkKRhpG4EiX/NMvzXoXIFppq0wuQNWZgkh1IuNba9RCSQhxEdXcpkuoLJ
 PJvBW1EZLbbItWKFfx85urlmJrYVaTgaehsI6tD2LPYK8svGt56rxtxensk1d9+jaU3Y57FFr
 MTBeBUZJ0TeJFC1/zl+0bZdLCpHag9RIudQBC/osRUTeWsDrHB2qAV9KmfwenAszf//hxjduv
 e6KO0j7zGHxCiHBWs+Wgf1TStLQUQmnbi2fWvW06hEhIsFplCoC9t+0TwtzckAC3nCEi7hbSE
 htri/Lr450nottWnJD6tUvuov+t/k52Q6e5BatO1R+JSOyUTEb9e+O/aeAS9eZnR9qzUIXzCR
 ePFE8e4COwrc12NJYhNz+JqFhhFdFRcreyqoHCJ6Pes9kZzc5+Qr/jBntTPRyvSmqUG8nEsEY
 Po2lBHDpAVVNoySja72SmlwVXqCQncE2KDvD39cMzJqG+HZ/2uVpx8gWbl8XNGMnp/76Gd0uV
 TIzDNOYY8M8TF5+lrAZLCJpZVF/5STxV152vLmtj6iBCOrW6Gw/b+ZxuUCqQNP6xqwryejjmN
 rwOStcR+Pu+e87QXHQMXmanPLINFcsO+07Jj2sP77JQsbHXaPLV6PHHPybS/jFUqo582tkRX1
 +f03QXEJ0UkMjf08wM0FKuYhroTG9jsQQ7IH9Qg7jC5F9oxLePhsGYxr33xrKCZ1ZxJG59vLX
 WbKHVfSYI0dOs1EKGr9vSZBEyP11tjR0BscO2eQH0ek8bhdPtgb1T48RVnlL7eY+zwsDUsveC
 WVwH1uPKNfGvWvLImIAqu3Y5YT4gaMbWW3wYnfMXmVkpDoJLqYeg/WAoR/yhcOVNzqtah/dwn
 ZzrtvWkq0QYisl7Tn/aIS5XqsA0el8CyWTELq3EXdTFaX0aK8GG+2hqtDtEgseDjCcGd00PTi
 X7MMkGy+paoRuEocTK5uri3G4dCppKfbbIEYkm+uJbz1EU+R9PSKwqHd7ugxYHz7VmY/oJouP
 nelJ/nz4/S16nU3Ve9Gm1a3hmNwCTbAiqSNGVxhQZn3amBKdFynIElTAgR1bTKrB9/MFmwZdl
 v8x//4I8mzXWIGudlpe9dvs1i/GRJvLeTlhUW+98S1BpOd2+aOE6AOt9WGlgPqJzO93xd1+u+
 dPg0kcw/PD2Lg9y/2v2D165TNBUzDLQ9B/3A9mTAe6CgYOpQrlIkVgQkDmEz4D5yQdHxMWvNG
 nTgUMdjrYVAZXD8LZVfjB/G2cqHNiGQQPTjlS4XofjdbU8sxBLawo6kb0DEb3ywxC4YHKnJXb
 ZMGqMmNd7WOhGd5/bxgsolGpYcSvYJ3+tgmgna+bQ4DoWB3463lce7HTYVGGfJQhMkYFN6Vfu
 0NciM4VMe7TzVQz1JIYDtlmtRVC6UIpYfNpT7ntKikqQ3j7F6qYORf96cCB0l6FafpFYW2sDe
 PxSFImupcTWAYMhL1rDvR95RlYfs6mKNWTek8s3E3AqN2c8HKcNevk7ZPBKRkwzBHQ0/LXBoF
 E2WaICb8RHK3jDT0kAWx+ziUzsPBa/mQsxnFgssKHrxib6x/kV2Acl1m9C8Jq+ljEuXsVNgYw
 fkJnvhQWh4xFrhL9qYpervwummw15lZykzp33Lcj1pOCLL4uMrS0tnhCu9DHQ1fl+J7yEAB1X
 pBz3EButbL27xIz5ZOaeMaBqr7I+W0xhNudeaGrVtiPaol2V+cvMImkIB/owVhe8CbUH3uTp+
 6ZIKMwJsf3sMfP4Dmi2SPvDDqtus6ts45r7zpPm9+EB0LFRa57Jq0/n4h3iy+E8SKT4xF0epV
 hnSVOldmWqvhh+SSCUK9CGfDvs6odQv+MPHXDgSlOkkkF9UFkik/fIzDzlW0wrsrLLkAPz06F
 ZLOepsMw7LdJfkb4lGYezmkNwSD00CzDe7fPAeyr3mjDQY0NUka6BYZKXl5oLs5/sq620HAOj
 0xHM5ZjRkVQHhSFos0mZKP+pyhh5PBfXe9qg6zRV9m920wgZa5UlvYUyNchw9MNtum+VANTav
 BFQULVarai+iVUGsO0oU7JOrsSWHVfY/ziWa8cNG8JWbYvcqIwA3UNZTFJG3OzHQ1TkUjmXmc
 rg38X2Xp0Htu24ggTibhzCCkfXF3VIoT92lTFBvMwOjWy2nQJrRKcFqd6Hh5WiM15f1UzIW6l
 H8/ikF5eLTefhQzy5rw4taf7OcyOrRbNEX+Y6IZjd44RQUHZuDiEqfrtJDw2IX2i8GJZfeuhS
 9cTej90F806rg/htcddp3bl/4Db3uRmyr8ZC4Wz1dDWR3bvnCAHDqfGx77ScsCO8mgF77l45U
 N3NXMMC8OjKNYV5OcaQCLin4GIj7zwjz9yUmJGJkFC9xuvKq5uBHrSj47gxlKaLI4sdRvohG6
 q4je+mTJ1/cM7qunZP5wP/YrS+AIGTFkOTe5JRkAJgC2uRECePZM0tebWlVx8dMUbYcvhYI1v
 au3M02jLDTBQJB58Itzx6fFaFbriM4agV1r7s7+0917JDUbheXQMLRdE/CcGzf9iIGrWC9pr6
 eqLFaF0hV2hmx2dGEVqP3m/f132KkPePb97U4NGnD/R2/x+y9ertWaAbVpgsDiFMaulN/SQ3y
 Taf6NIhMMTgjYrnmgT2M8wW600EAwkWlfOQgeedQItEly1cGqBMk35EfmRDkYclMBqHyvYvUd
 IwincJTzdJOm/rf7nmg4McFDyeRJ8EwkOvQlPgEWQ53evZRhok5gkVSL/jUddABa8lGuef+jN
 4M7yyTzAeTdIAiUpayNgJQs7HAztRVN4U2B6LRxildnXCq7kvFmae6Q==
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list

Hi,

the SD card in the internal Realtek RTS5129 USB card reader
(0bda:0129) of my Lenovo V110-15IKB is no longer detected.

Works:  6.12.116, 7.2.x
Broken: 6.18.x, 7.3.3

On broken kernels rtsx_usb and rtsx_usb_sdmmc load and the platform
devices rtsx_usb_sdmmc.0.auto / rtsx_usb_ms.1.auto exist, but no
mmc host/card appears (no mmc0, no mmcblk0) and there are no errors
in dmesg. Reloading rtsx_usb / rtsx_usb_sdmmc, re-inserting the card
and disabling USB autosuspend (power/control=on) do not help.

Since 7.2.x worked but 6.18.x does not, I suspect a change that was
backported to stable.

Distribution: NixOS (distribution kernel, no custom patches).

#regzbot introduced: v6.12..v6.18

Thanks,
Philipp
