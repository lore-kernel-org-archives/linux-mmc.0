Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629540;
	b=4lPKxAr96mQsei2HEacCb77TcNW9eH9JXu37HfbvAlO4TWPGzRezIZLSyrNszgzNADzi
	 SjoT2XiNKcdpJeymuj0DIKF9u7LB9+bYVPM3xCTH278/vahKIZGq13GhI0WqxibsYtr/V
	 KdjnmtA1uAYKzR0ciB5zrmKde+eHbAbcaRoyfJCOVOLpmVkp4jlOs+ZWF+t5PVBI67nF0
	 8XmpxFKgE2DojVLEVoIGIaQ1g6HseEVFodWXChVZVs4IMsiVNpsY450eHmvYcM6p4iS6v
	 5DIWldgClQvHpKIPBN8dWlK1JNuo31Jw25K+FcKeiJVO4cwgzVO7sGyhxYR6rcYDQMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629540;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:To:
	 Cc:References:Subject:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=jKVuEFMOINIY5Htg8/As9gfzw7+lu0N+Nfz1wg8f/DI=;
	b=iUZ7BfUzF1fCo3qyOMScP/4Kw8m6KJIW164V3D4/ujRNgWcWCi8j8umnpFqH6W3qrB1g
	 FBAa4xfwhK8MC56yElw6BW8GzenoWQ7kHd4p90Hj2bq7fKBCMfUeRGymc78haKLKO7Osb
	 Ax4/yCh6Nm3BUquijE8744m0QlfTvBfF2trwUOLuRwi6mvMjvJgC5wE9cgnuIN5p03zki
	 9IY9XIr4C3BIz9Orqjvm10t7htsSY/MOaHYqv3A39QrDcDNoAEltrS2oA59ESmbJjZ7zD
	 btQIJWmCn0DyaADi6o1GlkUtqfc0sbEHJyOGNKDCkqlrz41pAoiqSep5mpH7dsbZL7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=r3HMaAz1;
	arc=none smtp.remote-ip=217.72.192.78
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BDC606A321
	for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 17:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06BDC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=r3HMaAz1
DKIM2-Signature:  i=1; m=1; t=1795629538;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:oNlf3CbIVJtVNreLlu3MnvUR9X/7
   A528SrBn1LHKCzMrAxjX4l9CjM2JR1Zr6Rks0581mUBkCvk9UIr2OB768sv5WQ3zzBrWdpxUVep
   /AKIAK3+5WgbfJeRVwigRZWLkV/TLa28btPU5bUcHA/UQg0Dlv4tk20LvAczWA5zMrTod1Uyq2j
   aIcUcb1QYCIS8vKGPwwOGM3mXoNj12AQr3LZG7WV7XjTfxjXIgfPQABsdDVINiOvnzHa1DxMYs6
   RTL4WHGOAL6EF/BMhoTQCgGRtu44yZCq6niQjQJgA0rv118vPZRKc9GF7yhbHDvJY5FHiOnH9bI
   oHAOB+dC7zZ1eg==;
Message-Instance:  m=1;
 h=sha256:
   lmvbPPoXWPtZ8c/t7oZRDcn1Wg4fFzPnVx6DZBkURb8=:
   HlTrTtPFtM8YQLppqJTfti6DmCjijPQr4Bw7fmdC1tk=,
  sha512:
   7LQwmWi3hZwi00uOwguqYpYN1PERawT1nGQseL4oqI4whxYJNbmO1FH99e9YWls1LFS9jkDw4gdqOr3KS9qTEA==:
   TPX4BXdwTHahaP/giU+niTYbqgfS8tyGh3YD26eFpQ9tRALn7KR8iU7LV93AJNWKkVh+Fir4l6CKMstmm1/s8Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795629026; x=1796233826; i=markus.elfring@web.de;
	bh=jKVuEFMOINIY5Htg8/As9gfzw7+lu0N+Nfz1wg8f/DI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=r3HMaAz13zzHe1UmkdzQdpQZWlp5bKCepRfa4xb96wRxUH8yIMxA8sVNzp0iJZ4/
	 24e95euU7tzdRycHVYILQFoG4ntlcqtyxOR6hw0X04prO6opoiQZdFga0z50zjq4t
	 CpiBTFH5e6oMC1RPdAx2d6FkW8FVOl+gF90fsX8nGX8iQuJIK9MYmxS++GLi9AGJk
	 bKful39zg7bgx2z3VCv/bYIMzw+uZhdnMYtJxKWaGti1L5CGOPZHUZ2yQazOo2cBA
	 BUbZRFofDaJ71r1p8Ax1kp/hzELL5ht3YomAX0vwL8BYSA9HF5NSKFXGrT7hqqlHS
	 hF6KU3/7m/+81E/qNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpCmT-1yJ5Lh0TPz-00m9bR; Wed, 25
 Nov 2026 18:50:26 +0100
Message-ID: <bc602723-07fb-4af9-9201-272dd0fe759e@web.de>
Date: Wed, 25 Nov 2026 18:50:09 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Lee Jones <lee@kernel.org>, linux-mmc@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com, aaro.koskinen@iki.fi, adrian.hunter@intel.com,
 aidanmacdonald.0x0@gmail.com, alcooperx@gmail.com, allen.lkml@gmail.com,
 apelete@seketeli.net, aubin.constans@microchip.com,
 bcm-kernel-feedback-list@broadcom.com, chenhuacai@kernel.org,
 christian.loehle@arm.com, djakov@kernel.org, drzeus@drzeus.cx,
 florian.fainelli@broadcom.com, geert+renesas@glider.be,
 hkallweit1@gmail.com, jan.glauber@gmail.com, jarkko.lavinen@nokia.com,
 jbrunet@baylibre.com, jh80.chung@samsung.com, josua@solid-run.com,
 juha.yrjola@nokia.com, kamal.dasu@broadcom.com, khilman@baylibre.com,
 krzysztof.kozlowski@oss.qualcomm.com, lars@metafoo.de,
 lgs201920130244@gmail.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 martin.blumenstingl@googlemail.com, mirq-linux@rere.qmqm.pl,
 neil.armstrong@linaro.org, niklas.soderlund+renesas@ragnatech.se,
 oakad@yahoo.com, paul@crapouillou.net, pb@handhelds.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, pramod.gurav@linaro.org,
 riteshh@codeaurora.org, rric@kernel.org, sameo@openedhand.com,
 shawn.lin@rock-chips.com, support@cavium.com, tony@atomide.com,
 u.kleine-koenig@baylibre.com, ulfh@kernel.org,
 wsa+renesas@sang-engineering.com, yoshihiro.shimoda.uh@renesas.com,
 zhoubinbin@loongson.cn
References: <20261123191703.179283-1-lee@kernel.org>
Subject: Re: [PATCH 00/13] mmc: Assorted bug fixes across MMC host drivers
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261123191703.179283-1-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c6f46j/ersS3I4y3nFaZXuQPkOth7qOpMhbsMpgMo53cYuiChQI
 k7ciQ2JJlBHxHL71038+AkpdFTp+J4DNEpnDs7GmJdb210a2uTSXoyJZlGWFyRluJT4N6KY
 7aeglt/IPlesC728+SzX6FdxQuXjFpu002kFWVNNxGF4Yir1vIPn+rnV9ru0YDXZs/AEF84
 LwpTLzsphu+QcEVxO4cjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GuGkJ/j8flk=;EJHOt/zAyS7VlxQ+vRMCm8DRq2R
 xmu7qBswB6/ewdmMDQ9FMNzeHNgGxulcFgRqKRwYbWQNTRkDmSOhMuXE2gHFox5ifLEPG4t+c
 WXaLf0d8mZsozvo8bC8Hy4ksDho84EqRc7bz3T4XEVfsC6ci0ILpN+ieTyzBYvDdjcQBxdo1M
 Se1Q6B5BfJwfyAZhuA4dJIl12HnF/g4mqd+xXsRWJyWTJF/HHLwJtwfJXbMtyaQncxTwLhldG
 DM+06cXUhlUqu8bOxulFpWhcicq39NaCNqqvbXM6OyNIsL9k9q42YmeEz40da74zxPTkyapCT
 y7WJjUk2m8PmiOUAJ4pbBYYYt/g0MKm3N9Kw3kBXAK1g9wgOombb0BXOESikCrjEHdm0YE11o
 xmnFAfYctGWpQZSkl7Q5pIABNNG4xeQQ/o3lVGRp2Pis0l1Ev68T1qsVqkY9ky1TslGl8KpT5
 WfTupRZomkqYXJy6qIEzvXU2ZUBP4bbiHfZPpxZUE9w+9BFRp9HGC+PU1/2IkRvB73xGpGSuh
 pODkyKTbND9CCYp/jRzFc5Tm36+zVrwnCwSuXWXSiPC8BNwFIPsCw/LuStEQh1GH5F9hsC0aF
 4HpcB5T90S84UJeKZkc6s16+2ZhMZbXOm0oUKfxEYUtuLo5kA1f1k5psy8PiIv3TnL4Hw+uAh
 VCLNlWW6oJZZqrUP/K/FuTTrbcGyTDfuSndhsNdTn5vhrpIiNaYVXOGF/wubqdFTBX2QE65Ey
 qE7SVPu9h/CTwVHl9Txphw+OA+lOWNgUMajAQ9z+F3K5ptxfpa28O5FebdPUPvm7eP4GRusTR
 r86E33oZkA734xiPANcWZQHtOsbyoBJxO0YLMmA3BSFcdrULWtL0lkrXCPmMnOG/Nlhe/ViLx
 7VP5aXBvP4edj7HM/ydr/6h5eQkxfZsOWR8Czfqm1zfEsjs9nQhdJp94o7gBjClG8dvKA62dH
 yE0dXmiQyNN4KnMfZ/4uoDrcLkgwF/VugPLWhrFrOGLdxkOSpbD0/XImHkKVwXcTihwiTVvwN
 FvCbslJjY2ei/IMeuYQKWcViKoraKLktM/lSDQ3QDZEVkwKSxnTUdKI7pVM3b5sRv34A9xmPG
 wa6A3EoUZec55gSb7nilx0DHmhGduEhhjEY7KexFas3C1lmRuWZ+S/yVdV9F2EQ6M3QKbnccf
 eoCtEw7fzbVf0XqqpJ8L9bROYuZ4fanDMlE4vKL0TV5XP+8iOeolyNeEDEqtBpgDYM+DW2c/I
 0FMB37S+43GzSwmnzaqvRIMQZ9dikXS6bvqUjASDRszQP5odwfh+Hm6ocKZ0x9cnalhya+v64
 dye7GQ+HDJLTN8dT+1CBxaaeK+NlTeGyZ0B65yNYIeffh1IDzAXw7tRf9+ObwiY/o7q5SvSPg
 UcZoxndPb1TSqIwftGTcjt3+qxX194R7VYmHK4zcO7yF19StGZ42NaNNaX1k8EtFCdfObLNP6
 TVfVq4XLf+fOz0AILDZ4lKT6mcTkzFHGSl8M9TmgxEokT34qRak0/F23q6haVJK7O2P5ROoaL
 OtDJbbexXVtCQ/OLn6RXnsAsN0FuQKFKVa4V4tuYUsGc29L1El9FUwK1ze4mSHY/iCZIoxDvK
 qCs27Bz29f/9x7sB35oXdHBO2CDcwINSN8nehX19fKNkZNhSNuzJC0VWTcoyTA0RGs7Kq2FDU
 fUOAX/GftB3KPBzTEsnrUV0W1ykE2mepKhOAYJPZRnJpvF0Dm3QNebKghok7CTWoFzGDX50on
 7xc0b0AyzqqXDwmmDOXbPEcaHF5Kyo4ZUQLrc2Ur1yCQqko4NK0Qp5Y9Y6cRRjWgZXQlHeSuu
 tAmLnPwCzRUUpfsd+ylISlQViAnETGP8OmZcCT12u8pan9dOo+FfTolAaNRIOKvie6W6sRIZb
 HlyIUU8gw8aJGii9QQp/wk428Q5JLfrIi5BiSSpfVSJl+utJabRkfcVzJX0qaBnQPdq1e9qk3
 OB9wNYfLcDMzjgD50TkQitVnHszod0UkK68itR2slxz2D5hyMRfnWsu5kBmrLC1MaB9/4vUWg
 /R6+2Q+2xkdYjod0KI2yM1nZCf4JMYPXXGyrqzT47WE+uYh+mfH8+lyA4O6U9rfPVCSy2Aohf
 9mMj8Xs9WWK6EP5rTdWn5LXptipg6eE5axvllhfz/3VtxhSpCiDBzrqqk8Pi6Tz8SUUtpo2S4
 XD0LhUYLmLmFhmglOXjqKnax9jA2I15WGPr2Eel+9itUjwsIH5UUthFaqre33+i9i6quCBBkm
 jkiIsS4vzhgpQ7ACzge2N/Od7/dTgTEY1Zuq3T21SI9msYV6mHbkE/Hh1bmBiTGfQPDUz1tCy
 yaIU9vu8itqSiqlHfH0IlE2J+QweLFeyLDR3Jg4wQ9hC66RLoNAkw8nHV+88O6uoZ6HGZ7vGY
 KVCabEOeqtmFrYxfoA5M/DIWgkndHhZCNeekrLrQydMNE5u9I5E7Rt0SaFlJXlvnzzscpxP9t
 vx4MZqKy1CWP1NIX0xCwIx+JBFeIkfoeEI0XPr9SomleQOV7rE7/nz52SOka5qnvzPdynsVhW
 oZ4qLm34+h6or5vsv9g7xFxM6deY+Vk46ygFi9vcDcu0HLnPQRLfGofgaJ4SJNi6IFPXMgEYw
 QPjUUbTtDgrSFsijNwxMmOYbo/f2Mmll4QcMfxU3i4I97sx3AFqLv/b8X6hFt4vtfUx9W9bQ5
 /octbJAk6okfY7qY/bigDcvBajyKqJCvnMkISlgmTkhWt56axRRClW7zsQ67y4Wviw3mWaABG
 8QN5dfqEYp1uIQKMa0DdBaDjrA72KqMSw2wIy2Ygpe++lndB0ZDyqx9yZ8KL8EW/j2YNV4qUp
 gEp+kHDQ8+GMg94GJ2y5P1m7KJRZV+bPKmPYL2NZkPVl26ZYv7gVC1AkecXeO+/MtoVRrOaMf
 fDUD9xaZnTEwaiZmF4+tS9ftoqjIxvD6QjfcctUO4vWRmsawKbQT4myfLvQfQy3ZA3ntRlFYh
 j7UKgVmcx9cNMSwSa4EcW9DyltvRHAdc47r7smoGfEkhG6l3hveUu6LwQ1TVzSYAHIgtmSiZr
 6jS9UwOXKXLComQ26if8ZsdWdGcAVqLGsqQbI7qtyGmV7eiHS0rqmnIAlxIbokKrZNMI3LAoS
 4WSQEwhFbNtudkt1uq54IJw3a729hJGR1OBMJwK2M2/7MPz+i0VYckrVDF9xE/O8wRie2y0++
 PRK31eNd7i0hH+fqielJgUORNQ5wXC6ihBIf0jh/7iaVzzRCjSdOLPPAYXJMZ8jBBVablS3Ka
 XAtRoKdN+gXWIthBwcaVtCw/IHpdka1jzHrSXNhnNo4n/URmmGmIe8c3Fy+BlMoD2EMkFDOoX
 HuDIbulLHKfjS5j6eRn7GUTtFYubljYnSbU0MrKE6o9oDrL+Wdof2JfAj/rd15H1AB6y+clT2
 xAwGicaKl2kxw43E/fD6cnT8VkNseh4cAWdVbgjwDA6IAl8Sh3qeGIYxo7LWfOF2PGBPM8VPA
 XL7EBYYQwrYVRhAo8THdOKhiWUxnkwEt4qnTxza2jc00hyVKXLPYvz8zl5b1DR4qdKmK+L2w9
 +WFdSsSrjp095Wyz5RRbC+FVEmGWPvc+icg7K8+dT6I08mQT0NUFU47iX0x+LIbSwxuP+EL2V
 XohgG8wYRWiX9KFqEkbWGAD+7ZWgnfN2TBfo6m1ndu5DLiw+c+zjbTs3N0tS/h+ZBEfPbI70A
 jVqQFpj4iFWO/g+3YFzEdjdXvM8dCgNHprOJ58JdeVLBU/ucyDBo0vaUWjmBfVk2BzWunr1TP
 WCH0D4Muv6e10h/S57WBagvShMOXq1NdNKH/tsNZ3pAWSQa/0MMJ6znJwWBnSvBBXf1pr0XyB
 m4ZFitVJi1LSYw0P1CBgIfQo7mu2h9jI2oC+IOiMAbP/j4BbnxPLA+yTGhllw4gG5Q/rLlW7j
 eLPHVIfEt2sWFD/F+qrwr66x0C9NRpvaSl4B5f4wJXxpr92ABuS7G2xf7YAIkcHe66DFTHWPi
 P6R54lZ0ldwK0fOvXi1caV3x58Lr3wrmnjpTxRFKA7AhusMcx1uOA/k2oNYt2vuvkdQYczcyC
 zFMl22w7NUHIHC6KWDBHuSFw9jyS8JOmGO+qonmL9eizxvL0hfGyjxVHshgQGh7w8XX/f8cuE
 gpUmhucZZVi58Yva+x2W/pDieSah0dj3UWSRuOvH7umnqiSnT+hBNSIa3BcP38BCzVWHyk1/a
 9RqiI0oV6YpILDTFVB/Vps4MhkDmLVhJwyQDOjr7CSHJHo/SpfiJA7zKeVsUFX3Qxb9n4TdIr
 EI90xN2aoMcGyk16bD6VxgkFbshxEMAGf8hqufpEiBGkaKeTccjk0mLw08qHDjERFqV73nhn/
 PLoTF+gJOdiQuiw+LZQO1WMZzJOFYrm79d4cA9vI7n+JkIVRX81crJgE48eHeJqg82toqACBs
 1/YTGDIqHHURXKxQOQKRE5+Q7ABn0jnoulZJaIYIjYBs/iW14Pn5V+hfAfHtEBo1e/GJzZrgg
 t0hEQh8uDyeRlV9HfrZhnd9iGnYZkP5dyDJyaxkmDHmyc5YjW6fSpr5g9r/Qcnk/Qd/5ZhICm
 6bsb00EXjUaeZ5bTGfleK4ia5Lqs48l9xDwZmvej/uMQVzMiTTiHYm2Qot061mKhwFZwwRhYz
 Y+J1g6ew7cCLhAd1bc9c63TkQsyzva/IGhbPLxTuICD8T3a9VhuJkPiZhwug8gTngIV6KQXtG
 va/GwRXLmUw2gbf09CAXfGA7uKGKgi4BEyTQCdn1KaPxpK8ezaHXPXu9zWb9JZDUrxvePICqu
 0///fGafKpdYlx10Li3/c7n+7fgAflIDQLSDHjCs1MGIC0+FxNQlMPhiDoE7BTFPN8CrtihE3
 ralkdBlArNqLq23CHed0Uzb2z18ebwHaxPMfAgybNhr1jdiZjt21q2nfa+hJGt43PNCJbxwqf
 ybFBoy2IpG0IfAIK+C4YMTHcfOCAWsj95mdwhaWGONJMHDerPaJfl3rv87IdPrJVT95mnaRon
 zQDA1/Q/52Wzy+tFwrjro9y3GJTadwbzfW4l5RJ2/5zI56V/3+NaL3rbySxZQNaOnOSLVMgyp
 i1u8R5cbWve8A/RZp3s363/vPYRKfV8S0jsyLTGQiOUqmemPmY00c7Zxnf3yHKZyBdyPemd1F
 NAQqIvsdP93C/WtWLNtNHvFQfCrdhV3x5SBkO9y2R6CGuQi20kZDagtRO+pOTC+db3L+4bVkE
 zqm6btWQF/rzBH7Z8M1bSvqhcm5+cm9x1/fqHvyV87tNJ3UAyu+F3evdmKk0lEDpp/wBrJ08t
 C8UzjHNYWOflIAaxLFIzKmw2qS6Y2Ust+DiHe3vrq8YuJHqplk7f/XHUoDkO2HECEipd4HXqZ
 F0gVFJab87dQ+wOc2Q+3OTLaJ2Sbs824pPq0vYaiUboKc0MKUP1v2nDMCKWMw09fAd+mjBHui
 mqIvrim0AAr46tU3uIYWK9/xw8lbcOUFKZnEy8KfmCC9P91lGxACXe9Us4B91Gwe23ii7NXb2
 NBs5nq/XAEvdrZPP678tYGsGe8pMpufiZXq8f7HljfR/4OaKqboO3us7POUpRGO9OHBSc+XSv
 X2WzLcoIsL0FbHFykBDyGYW6bkszqvKCQH6igD4p+Sy4ntJUt6DlDD/5XC2rP1CqSZLEcI6Xd
 p+4Ed2xUGXEqbsl1LjsoCP4W/TnL0eODf7mWzj7JYXQ+EDlpS5dGp3qCbsAibO6lgoB0z950n
 aAIuWrUyixe0uujSfmLV4jRH6YVAfCnQzzU1YHwLi+C8ApnIzpzch3V+BZMZkLsNuKxYb+4zt
 Y61rrsqiWxG2+hxESXz+ZUc3b99vFZUdWoAGhg6i1axX837nebIGxEyfTnPd7Zrkp6azuzwKM
 NPDS3tU6XnnB0jJqj2TT+QqiT1KLeutgYS2JjM16LGJ22m1npM74khQOsC99V2AD1+5wuiLOn
 eQVJterPgFE7fQQ6879pPb5e/ojm5QBdtwp7T4JfI6kfZj3a64pRdt8FmLiEGup9KcakEAu9L
 hsB6450hUsh6sFjfwYZx4H5Tzm8vt5Gqyc2oc98THAll8ga6G4YH5qKmYsQ+EhTeCUZLaYNJF
 43KGRUu0NclKrsq+cvglyQJ3gZpaSBJP75MeUKwMKIwBhnE/p2KlHXnHb6zmQIQCK1stv8SgK
 Q1OC+QMSxoARPMJfSx4cyBTmAzbBX7Q4sfCKZGLq303Anb8NauxxVjETMvaMloZGP7GyFUPdU
 rIkP6ExLRmY5sYD6r1q0dexrLwhyMLtBAvWx7PABZDBI8oZo+UEgls+iUd5LsB5kxRx7/cWd6
 7nKMKbzn6sfoMR2WSyPamgEgWKkMeC0ZtrXvwwcEz3qYX1bB4TI1DRb8y2tfjsh4/NlA9VWzb
 tiUjbipCxp0tUQvAOSHRmhRqSu4hvaMj6AV4LoZXKL0ZX98GczXZKjlmA8QHTr5jTglnzBJfQ
 r1gj0aVdLG9pFWhgqVBEKPWAcXE9oMkQTmu6DpfaP9JqSfUa8xxxGCWrux0s83rDtMTwMJLgr
 wIkiGXcieIa2ndxGd/CWXJuOsxbL7Y3SiMQ77bwc1JZCDvclk6C+WFWIKUN8uuTeHLjtfibVL
 q6GzmzkKMnUHHfip3r6T3sD0FCQ0PIA8rlT7r5o+rTiCeiam4Oc8YQKDgbgCkB28XZMXslNUB
 Q/pWR4268GT/ExIhnS/WAN/OGlr7nE02Yzaz/iYAStst7MDkz2MWaoreGooAhRbkh8gCx3AF8
 T17E2m3opoVrlqZzWL4vYPlsp1tnyVHaonVvbTCXsGd6G8KCQkpCmrshAp2BSNZeNIhctartX
 fJp/56nSK9nr+dWGfgVeLIVfFDGZH8/ZJ7E8hKjMPv2Qyh4e2qvKiHEwQ+lSIRRJ4PL/0pYi2
 OXAB3kDPsEQpJhuPt+pQSKMQiKn8y1Gb5Cd4bZ/UWRRLQL/KQGw/Funa48+rS6ig7P99lytSz
 Fuz+0kIiFT89DH+7yyhf16Qi4u7Q7H4aihVixdqfVUySlQqfGdVlZpfnuVeA1LFl7atDe5ern
 Q5gGwSE/9onXZNSWvsg7ChLDYe0h7grn4/en7xdO4juWqnp+Q+quEUI+HFtp/LZsY2a/DxXo6
 +0Xve1inZPf0G7q8nnK8SzFzX9vuIHeJC0yr4T/k3FIp4LYNU7aH9gXkf/8aP07hQs5Otl7kR
 0+PX3bN19XGgIWoJzUS3OakMG0Rfnhk5Mpi5qin7J8eM5c9wA6Eb1Kkan5ctRM7M5exKdL54h
 GYaVfWHNDLl/F6qnFl4cNmxG47AaUlKFazGxMV7B9O9igQK/TTOOLXHbLE4ZNGz1QgJfL5CFj
 7usw4ioWYWU4D1tOdF0Z3Y1iCa2XzOmzbFFNl9tDlcAghOcXGtW5XYf2Q8XBvwhHkdpFrBmVR
 l+dOIfSMfQv402+9cZPUonr4XTv4/exph6ui9Yn69ynZWxiEXnma08zd6WStzrFPRNnQVQHAh
 9eCdn7qjXjVxBtbSRGwsO9+ptiuxn+qQcEMYtfaB0oB14CLVHHMBdXLrvKerVYneqi5RNsqwX
 X8RIW+8vduFeG0Lv6+BJcm6HOCdsFyQWtAK3GS/RSu6I4N413J9HKjvIOG/wARP7jjWVGDTDh
 FJQJ3ZqQhwgdwFOh9UC7ZSqr+hXfMAIzz3f/bsPj2BJJYZVq44jl/l22tSf4+9AqvUWmf6kM/
 bUO++nhqurwgdHfK90A5KZv73nkSNTsJBiu75PBm4m2wAW7d/j80LO2f9nKHHgtRUg1uC3J0H
 7+pJOv5D1kKdKhCk6zi6OPB8wuNxLPioNvzPa650Ano6VpJVcUPbNX1jWe8LQqVrODEn0AOZN
 IcKsqP/Zcja0KHlRbItG5d8D2hy/3cecmUhtDybLlAv/THReCR4tTi552LewgZUrZVJrTH2EK
 /VQD2nnrUeCm7eGC7SvtGaZXCqmGxi7On4tuX3C3PAElT0NmnWF6dOKDkAB/Y5pE7V71TcAr1
 SNXWZYD0rPZC/unMg1Px4nPnCsj6RMVT+6CDJWnFqGFEn5UhNol/xI6LAmzWED1bhHYHwa3/Z
 xgPn1we+0RaJ9kyKN1P5NFotLZipYrJntW/70oOMZcbFnh2sEfOpxHA91qZAapnj/1kN1Msjl
 Ly3Gi1QamN5xOD7ahRjvNrQTvB+U51o9Iq7jwV4c7MRX+DKAY8Ud8fbPiT+swW0sd1EToH7Sg
 /uBFQGSTe4fTCOaVc9UHg5PC/e3yYNULnZI1fbjDl8pXwc3alYcw2fJhLa1QdODBvcFjhAJDv
 tzKAoTUOc7AzMDMcXbQ7d/BciEaNw9t3B+gAitdOrL+P714Wq8hDpC6Wj/PqTN6T/aC9bYywV
 C3V7NzSe3agbZ8rB5fvBgpC5uuVX0z4JTUWwQE4XgIxGdLwcVZalBPlq1iajYJ9wVO9CjLdNy
 3mVPorfUfSN1EwjvrNzkzQiCCKjPq59JF/m19f+48QUBmB5dlD+bAhZuHVqTUaNH8KPKoBHX5
 Q3+wbocUUzuW6IEfaraIiU62O2dX4lxHsrHhrYbCR5+/aFkBd/0EHnH58p1nmeHqPkE6ENb7X
 lHcGzr7aIzbz80HpqziPUa3nvaARijrnslPD/gqRaZg6gdxnFoUE1c3wXbob8TTr/5C46mpM0
 BGRlLlxLJZnmkP6Y3Bimg/NBO9YOYXjxZBZFYpdmAB6AvTdpLhoaQO3s5X/bC2JR+Ldi9Th5Q
 vkUOzuO5egf0PG7ZYkxbrFrUSO7eJpcmJA0dxcInZ7p0sSuu3LoxgADNGFvKILRMPeGne4Rpe
 8Hd74wq93SYRl7THlcq8Phmihp/JPOxmqNAqbPmP9yf3L85gMqdoL+Dl+g49CDq535/yP0IhH
 cBr+sQZ/FpLNLgYqmDPqfOaDaEBCPHkxnqCUdxndAJaiTWksA==

=E2=80=A6
> Lee Jones (13):
>   mmc: cavium: Remove MMC slots before destroying slot platform devices
>   mmc: cavium: Prevent slot_pdev[] out-of-bounds write during probe
>   mmc: sdhci-msm: Resume runtime PM before accessing registers on remove
>   mmc: meson-gx: Fail request when descriptor chain DMA mapping fails
>   mmc: jz4740: Skip DMA cleanup in PIO mode during post_req
>   mmc: renesas_sdhi: Guard host->cmd access in internal DMAC issue work
>   mmc: tifm_sd: Synchronise timeout handler with request completion
>   mmc: omap: Shut down cover timer before disabling cover BH work
>   mmc: renesas_sdhi: Disable internal DMAC BH work items on release
>   mmc: jz4740: Apply DMA max_seg_size limit to unified tx-rx channel
>   mmc: dw_mmc: Disarm central watchdog when ending a request
>   mmc: renesas_sdhi: Fix SDIO manual tap correction in SDR104 mode
>   mmc: sdhci-brcmstb: Handle absent optional sdio_freq clock in probe
=E2=80=A6

How do you think about to sort (and group) desired adjustments
by affected software components?

Regards,
Markus
