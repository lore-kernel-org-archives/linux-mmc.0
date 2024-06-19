Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4EB155738;
	Wed, 19 Jun 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813974; cv=none; b=comwZLZgYABrC0KvUxKkg93fprPBdV9yGvE4FY/Da7uvFL1FXMZbPR/EY5K188Xs6RUORIBVKnFnn7pz/6DK9sPTLbZmmI1UF3fOEXrjytZXNGU+Ib1z6QEl1/KQIrOspHLAeRrTCs3Qf+WRxjFQrGSU/UqNGDHfP0iUBTyA7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813974; c=relaxed/simple;
	bh=VDk4rIFbETubK9ufRR/9SYfLygy4F1eGvRvkr/vRtuE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=BFYxwduYtgQ1PCGNPlbw1LLTOV/Mm8nm/eT2YLO/VvOFXq2LVccQdOhEtgFm0QSthfxb9GDSp4YQS47QC+VcRUxzeERhbJlr/jwyTRBpezUQHdMGaYYEdaT4tl/4kctkpmmIe3FpYMNj28Zs4BrBSvGSLXHazvwiJJbvYodq0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ldydWDIM; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ldydWDIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718813935; x=1719418735; i=markus.elfring@web.de;
	bh=VDk4rIFbETubK9ufRR/9SYfLygy4F1eGvRvkr/vRtuE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ldydWDIMr/+ZTOUv80YzDchYNj80VlFbTjqKtGwOkA8Kb2nK2dovWSqlWbroLjNn
	 ZWBZ9wSVfkW+tUBGNtXej0B5icbTHgMIGzy3AvKZNkq/k3ZL8n8hNoCGLTuI2On+B
	 JD3Vw5gBlJzxGUXnWppQuoVCVqFfa/ol92CkKFquKRspqr3rDyD0ZoScoZkIEdHYI
	 FnwWpb3y/3gClyRZVYKf5H166ejmO4g0k+UEoQKw4XenWyyEMOckWN+6gL/8oBUkl
	 I+mobzF+tNqZU47tJzgt+LTJnbQaaceqEbr1bjD27Bp0NRkgbrvB7Z8a61+o8qyt+
	 ml0FFCq6QPZB5ERm+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3qK-1sqa171o3W-00iYBG; Wed, 19
 Jun 2024 18:18:55 +0200
Message-ID: <af302db1-1d97-4974-9c97-de4a10100d20@web.de>
Date: Wed, 19 Jun 2024 18:18:51 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shan-Chun Hung <schung@nuvoton.com>, devicetree@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Shan-Chun Hung <shanchun1218@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Adrian Hunter
 <adrian.hunter@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jacky Huang <ychuang3@nuvoton.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Sergey Khimich <serghox@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Yang Xiwen <forbidden405@outlook.com>
References: <20240619054641.277062-3-shanchun1218@gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240619054641.277062-3-shanchun1218@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k1mrJAOcJlXuocLqX1OhI2UrV6TlyIsnFPINC8gLzbZQuSpL7NS
 7gOhTksQpP3Ai2KvZJ+OhNvD+kbvQHcGyebKgQzbNLI8jt+thHRUwALEnapcl84EAn+Cu6t
 aHlkXwlOiuZHeShyqandEHPTG9Xvy5uTfAuaA1wUkL5U8Ujm55C0aR3QEBcy1hLvl/g7kQr
 bTVOIPl2+emK9TWgUz2Nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yZhy6m7gbJ8=;Efza5QPFGR+Cc2f63d0wb4eAO9D
 et0vonfRbECF6iozz6cmZSKqw/IqtSgzQ+LbC2hPSyfPfhV5SOcGOQBXFu2WcQSFKWC8kF14m
 HJNcJdsI1pLlz6K0fDEdGz+fjS8PmokklKGUari0rkbleJeUM+lt2ZgG24rTXiiSByoYJe0Gt
 zUpFtLIS9/aTm6Flim7banE1SvIpkWnIo25Nzxlj1sJDNjJSApuRXPn8pgjISeomj5Dp5H4vB
 Q0hTB/loEPa9HHjmiZKvPP8u+DAMtna8ifT6oYlln2TaUSA7BZ8jFSkofAGVChXXwD6bRkRX1
 hKUiqhi6pJuHEMTLb0efQVrTe5epQu49xweRUlFUO+MpMnmuvqo3ZVQjTIVDG1IEr92T4Hl61
 ghKBpWpv2GtbCkOJESkOutUgBtcVfLb6iuHdA4pEvijLHvcqHC4ntLD884WZ1m/y13IC7witS
 ykbZl+0KegaUhxJIynt+kcaV8YKl+VvCQu8aqveOek2EDC4X0xRz/OR1I3VOXXNqMaPjbqpd1
 w+rZKRXW3ilnXW6pSPG/ZB2iGehJglBTK3GMDs7U9aDiIOxKefHaYx8pPCHQjxrh/9hvCLF8p
 oOsbup1S662vVE98svDUOtOaihSz7H64Vp7vSRjY2xHiXrBhCMePYH6O0L+9uBftlWjBrd001
 eY+PbctvJIN2UH0NCIfZQGf++yJ1OGvy0PyWrqhQ4ZJsWvV8DTzbYRXA1YwopedqMuEEk7vKh
 I3UNUCFj1fVggW1/0w5JdEuJ21U7kg+CLxoIRqTMhItlFCvpmQEcooJHsKcGwX1Fc9fLWMwZW
 WuPzhgQxclcbGh5twh84tZabzLF7tcIVPHDVvC8+TYCNQN4nK96qRaiy3IS7kHbPlt

=E2=80=A6
> Signed-off-by: schung <schung@nuvoton.com>

Can an other personal name eventually be more appropriate here
(according to the Developer's Certificate of Origin)?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n438


=E2=80=A6
> +++ b/drivers/mmc/host/sdhci-of-ma35d1.c
> @@ -0,0 +1,297 @@
=E2=80=A6
> +MODULE_AUTHOR("shanchun1218@google.com");
=E2=80=A6

How do you think about to improve such information another bit?

Regards,
Markus
