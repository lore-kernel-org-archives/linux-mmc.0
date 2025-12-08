Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6423101B1
	for <linux-mmc@vger.kernel.org>; Mon,  8 Dec 2025 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189781; cv=none; b=TpJhbEjOaYvBnc/jUzbzxnRvmgzpg9pTU8k3XTxPrB3Nw7k7FfIRMHEYcRET2w7e98g7z0noF9B7davDV5SX9VViTsXcHysxAmRU7ub9dW5z0np96xV86h3bPHQZhd3xIp3vXiwW0afIT+txqB4Kzp7+lQSbqQGtx/njWQ7eeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189781; c=relaxed/simple;
	bh=HK/yqkkTFmBLZmw2X6xV0iKMer+hVC1rCZ6BasOG4k0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=brGOTyfSb4J1djRLKjVDUdnQREnjwxHNe6VM6rScd88RxmIIKFGe7Jekcyifop2K9oYzMrMbL6myFP/MedajIpTSUUmGXH7HQvBFGDPCK0mEHQ2G7cVfOBZFVfjpBj72GIoY8yPmRIG0A03gHmuboA70xxNu9E05ycaB+OXW7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=semex-engcon.com; spf=pass smtp.mailfrom=semex-engcon.com; dkim=pass (2048-bit key) header.d=semex-engcon.com header.i=u.mohr@semex-engcon.com header.b=rzMoBJGi; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=semex-engcon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semex-engcon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semex-engcon.com header.i=u.mohr@semex-engcon.com header.b="rzMoBJGi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=semex-engcon.com;
	s=s1-ionos; t=1765189766; x=1765794566; i=u.mohr@semex-engcon.com;
	bh=HK/yqkkTFmBLZmw2X6xV0iKMer+hVC1rCZ6BasOG4k0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rzMoBJGiCa2ZOqMSvm1Ia8P1GGRcVJo/n0GfmRsHHuYlJitFNElDg11jeb6k1u9H
	 fj2o9JxR0QwjmxMnuQLKwe2KTVg4QwFhJzg0r5oyu8VCFEsitpVZcC27rth8SF6UH
	 5Hk3Ttbf2MwodO3Y4OFn3cjrMnJOAf35ttEz0PAYIH1IMmRMz1uE5xFreEUc9vVgH
	 CSdievXDktBYfQEahzuGMyAYPQOlDZs1Md2r7GX8o49FBQvb2B/SxFCStDvmfqRET
	 7vf8AYiV8RGza/N3rqhvGmlBbt1BEPsZl8wf7U2Yda+JZ8tykBTMYmSGH1E6s1Yn4
	 8TYP7bcBNYZiC1VHfw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.71] ([89.246.161.248]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mf3yk-1vysNb3maw-00fsFx; Mon, 08 Dec 2025 11:29:25 +0100
Message-ID: <b74be2f7-e199-4b56-9094-8a093b07ac7f@semex-engcon.com>
Date: Mon, 8 Dec 2025 11:29:16 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ulrich Mohr <u.mohr@semex-engcon.com>
Subject: atmel-mci: slot number vs SDIO function ID
To: linux-mmc@vger.kernel.org
Cc: Aubin Constans <aubin.constans@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nqO+Yo2s7TGnhJwUzQG9FglkliQ2Cr1dAb2yc8uhEyAefECkynD
 YvOr/qwnvX6vmu5Vrn3bXLo8FrSIz+ckiJl6ulmAYROZXETO7nXTvDIaLx2OBjo8jAAoxau
 mPJAwMUNrcVzi4BM5JZv0FkXXSRpPthrP92dIgllUZPSMhZxSf1y3G45PB/Pi26VYYjS5KK
 5S1HxvoX3GXpWmGCrw2hA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jknU6gtERUs=;zHadWvm4XQJGDoPOGYgntjRdq+I
 522ndoZ9ic/aWQ2NoFpfy9MFJvJVG1Z3AX0UxUPXI2s7I2/yM7POBfyjIVP08qyXzsalfgWi5
 eboKHukLCmIx++RSQiwb1mKkVixWXrxeBQSktrmXyKHRvcsBEoLrmBg3BE3h/pT2Ovqlkzd/9
 jeNudTuq4nS18lQVjlA0s0cLvBPqNXZq8McuE2EXfTxXNUlLZn0k1+idt257CrKiLTe0JYxi6
 gi3tyxzN/MzpwN2+rPn7JLWiJ1mIh0sStQsQ78f9IVoq+LFemtngvIxo71KXyYdnNpu/vCIOg
 NMPIZaQ2H6QQtUCypH60CyoHW7Eey4Y2vyCawLrT7u2BLfUJ02XJxAqxDeB8IcgHvSHxvQJw7
 dOp/21GgPZ009VUKRus7hlO+VFoGkhvcj5Gd3y0Zo6o5wQf/+3Z106r5PCFGXdXwNIipFYTnT
 L/hOdr7/RudU36iqZu7g5jhniWNGvnZnONxa3t59h1BbnRMOQWyQP7hqhioS528t8D5SxU58o
 uG6vP7SxkdlgA6qE9dw7zTD+aHALu8OB3LFmBLV9uLMjqkolwzDD45HhHl2L40DTGqqUYVET2
 0NaHm5CdbP+tGjXIIHpnpo1vNJTmaWoLEOEhYlhoczjGPOh+vAWYvrczahBAXEvrSKdPJUL5s
 XtCKoF8Ar8bqqBcrY7oLjNwWgEU1oHjGS8XfwIINGeZMbkmwO+JZ9U0M42cozlY/nf2CFk1pY
 v/wxXxl1dTzx92WXk+DprFXUj2proAmtKrGEKVDAh9H53XF/11nGRBN2mGFcY30kcKPyPA9kJ
 blibVMuAgqkzcb56PvkdOyWGIiYFOi+WS+RMnkuaRBLi5qH92fNq0TFnZNVZMvT//Sh+Z9tpG
 Tq7L06lbjDkrUYggT0INDdeCFH4hn/D/Q1CzRfPOI4axtuPvBMD2qUhizk4f5WSdjtcr9fV3d
 Dhzr6/wZ2pjqv6Z+ag6JQPbuIzIqYeBB9KXm9IHcZnZqPfCwFGKn6dWd16hehteoUEKcRmUQf
 LGuc9KcBccPAPguu9CcON/G2GetvMLqeqyu7EUY+s53o/nR1Ba4GaAO7bAUS0DUZzticOOdPQ
 4qfTEkr2Fjrdm25oskjwKGjP7ziLZg+hTdPRn3vJcDZ3A+rk1G+ME2c0+q6BurhWWEL0d+iE7
 gyEQl1yWRy5eOe+0ylR0SeCzHdb7MvZXNWVVcfR+x3cuPLUi34mWuVYUGCa+0fDRNb2V298DD
 ssTwL7eR7QG4mA8kmCTgYHMS9uIcFOmpn8ZfaVbnVnuWjjTgx7CLCc5rL+qws2T8kZZF8yAGz
 s1cLovnJGgY0OgmME3JwaLOdKf0SoVjb8lGYOGhie6CHMGp7b0QRRpe442bfK+7z+RZaruqEX
 J2kdZBwK5zjRM0p4oLs1OBCT17rV6hn3jDWECuU51SiNXsQGCxBXDiXmn4PyWhdPr6millbfI
 E7E/95WbXblfuMGVccybFarYgC3RxG9WfUwB2shrnB/EJELRL3vPcub9zSvazZGIdO3e3JlLM
 lbS3+GCdnqJE5orOYHNJjLQ4nXz7YanVcXyS45dMRG2aHEnaqzAq0DeEBlmJwps/Ysy2agVp7
 rrcY/fJW/vfBJnqSGeHuoLfmL0mxlOLRQ75UN3yjIBjSIZG5s/KeJcy6zL5khjKyOsnGnfnGe
 jkYNm+pgRE74nq7RORuMr95P5ihCZEBpF4ri/It7mvdkr9tqGNtJZXVI/1ph43QfJcQ5OkxT+
 1XyA2Bb63wj+5pCJxNfJmZ8d6N1vKFOHbe8kk4XujaQ8ZShVDXToMwS5tCr5Ef8sifUTNrAbO
 6r5S

Hello,

I encounter problems using a specific SDIO card with the atmel-mci=20
driver. As far as I understand, the reason for this problem is a=20
colliding usage of the 'reg' property in the SDIO and the atmel-mci=20
implementation.

In detail:

This is a custom hardware board, based on a SAMA5D36 processor, where=20
the SDIO card is attached to MMC2. The SDIO card is a silabs wf200 wifi=20
transceiver.

This driver need a device tree node as child to the mmc device tree node=
=20
to work, as documented in=20
Documentation/devicetree/bindings/net/wireless/silabs,wfx.yaml, and this=
=20
device tree request the 'reg' property set to 1 to indicate that we want=
=20
this device tree node to match SDIO function 1. Such usage of the 'reg'=20
property to select the SDIO function is documented in=20
Documentation/devicetree/bindings/mmc/mmc-controller.yaml.
On the other hand, the documentation of the atmel-mci controller claims=20
that the 'reg' property selects the MMC slot to be used, as documented=20
in Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml

These two definitions collide and prevent the driver of the wifi card to=
=20
work with the atmel mci controller: If I set the 'reg' value to 1, the=20
generic SDIO implementation matches the device tree properly, but the=20
card does not come up because it is on slot 0 and the atmel-mmc=20
implemention uses slot 1 instead because of his interpretation of the=20
'reg' value. If I set the 'reg' value to 0, then the card is properly=20
detected, but the device tree node does not match and therefore the wfx=20
driver probe fails.

Since the multi-slot support in the atmel-mci is marked 'experimental'=20
(for years...), I guess that this implementation should be changed to=20
correspond to the definition of the 'reg' property as described=20
in=C2=A0Documentation/devicetree/bindings/mmc/mmc-controller.yaml?

I did a patch that solved my problem, by adding another device tree=20
property 'slot' to the atmel-mci driver and use that new property=20
instead of the 'reg' property to identify the slot. But I am unsure that=
=20
this is the right way.

I observed this on linux kernel version 6.6.118, but there seems to be=20
no changes handling that topic since then.

Best regards, Ulrich Mohr

