Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A51238149
	for <linux-mmc@vger.kernel.org>; Wed,  2 Jul 2025 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444622; cv=none; b=s/x+plaHaKO5WmB5ur6BKHyFIsCv+r9UFoeMBKWTRYL5QYVfX79u8lMZTyHmOZQUzzU91jPu35Gt39f93a8fpanbQIFm9SkbhoD9HDbDBqrYqKJH5c3ElUJcUVoK5kzqA0mIqk589MZLvMOaKe7bZIrJDYT1/FFWSOuxs/zMcUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444622; c=relaxed/simple;
	bh=aBG7MgjOOG3Xa/e5UgKgIfWeFa8i1Ww8PoCPrBNksUY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y+jE9GLzkAYl78/NcZDvVeL9ZihyREZZdLYLXTiW2+kHka45bPamHSTGeqH6zVcJ02CxhVdT3UzVF82eghxrXpl0yPUUZxiCHWO4TSRNuBnn3c24XB7N+qJ3hulwqNxh6cC4IhcD0Y9cvdE2Gy5znoDfHNfx2akhChlgciFNXLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BSaurJJE; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BSaurJJE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751444616; x=1752049416; i=markus.elfring@web.de;
	bh=g1XsRcpn+HtHVcfmmFv9n5gsxBqZWLRmdxakcbNjknw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BSaurJJESfGFcPtihwk3+R6FylZAyyhxL0mgn9VQiLleXXGrAuxyTFkgrRRNNPah
	 239LT/2cYz0zR1itEjEq4n4e4oMvz5zjPexATafIOi27RI1MFZ61qmPicI4RkZAQA
	 NX3nClVRiVd5k33e24rrupruOuI8yIQ7WG8yrYY8iu6d6w7ppOAc8K6h7+Ib1W7/a
	 pFjUYQ3GAAqfTZCLbZV9UaC+6utU2F1hBqFWBG/ICNAKFG1C6Pv1842lrMGmu+zat
	 z9/bY1wwIrgtVilyKXETzGzK3zelFLmYwxzebQlan5hTJVQEw4qCI6319mplAI+iC
	 BYKrK0lwUty3Z7rbJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.250]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7WN-1u8IQq3DQ7-00PUYh; Wed, 02
 Jul 2025 10:23:35 +0200
Message-ID: <a2c129b6-1d40-4dac-a585-097aba30cc67@web.de>
Date: Wed, 2 Jul 2025 10:23:27 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mmc-utils: Remove unnecessary null pointer checks
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>, Avri Altman <avri.altman@wdc.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <c89ce826-7ff4-4d02-9c15-7f61c157003c@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <c89ce826-7ff4-4d02-9c15-7f61c157003c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZvcpaOW9sF19pcmQWPjKpifdcZ/4Fk7XQih1FuclFr7ydD/8gEu
 35LcikO2IJ+x+ssw5atr9SWcDZD1Mf5BIUTddKoynY2ZW9VVnpJcz8EA/qzbduITlDcfX44
 ieqEmB288klX/Lx982j7fRlKtPlAcgOMfymXZvW4InGlQFJk3RA5WCC3954xOImHDhLs+qF
 SF+HjYhXT9g+M9v9NPFpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2gIDd6vwouc=;r8uO0lw9J2Nhi3DTta5XF+rKQLe
 +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
 zpWBObxQ+4KM8HaYJiUo6wsQPansYTiUx5DFoGe25LWb2NT3F9lpb0cYeSseDU/fmeQr9E2mc
 EXvieagS4amlsWv4kQ6GDu+mXRiRWws4oqMERzod1Qxpc6YzTTrNg2V/jjDOPrDgHr6eWhq8m
 ARhBfwYjk1g54wnXCTJOm862tjp3pQNnNKJXnfNsmduKqqCiU9gco5EjqcYCB01Y/IXKIGbu3
 c/9E7XeFwZ4zs8dGm+ACirygKgNydMDez9v/nCk4nk9IKmQi192NUBX5le2UJMjV+EgtQ45bV
 R28NSX4D/8n+kRGwPzil4R8dw98oDBjVW+LVGHFm+LEmutwqWH1KDXsqtSz9m3IwIZ/hABQwh
 HMwPZ/qiq/TXHZmZcIgOeIrKlDJvkvvvn3vru9DdViTpclKQ8m74fZrPVo3bszIo2wye+PVC5
 TjTMbdvjYVanufstUPd737CUpiQ5L0yTQ22weajvPYtAs4lBTrybicWCT2NFkCDHQt+hdTbXx
 GqKtGYOtF2F+oaGO5WEOJN2Ico/8DP/vzJbcPdgy2+fqgHIKVDMwTrW2A55vrMZBORh87FpQB
 kGSH4XXel2jhgJDRI/J11Fz7PUaLRdibfa4wUS/ZMVmhkQn6X8vsvTv3Adqn/JIo5jz+sOK8c
 JDnZNgSZX0FeQb6yO57x/M2G+O7oRYrn72PlAggB+TaUKrIm95M+UlsJK3RdyXrXHRvaJRU/N
 kUb7YBlweAYb5xvcWKL/rY8fy2qF4omNIaNneYQpPne56lCUYylz5vogD7KtQJqelo1HFOjhp
 WhsSYOKXyOLFYpyr6Ihza6Ai2RB5VNG0n3ntM8QagG8kn8xTIG/1aGL3a8C21LRjJ83v1OSra
 mamnV3SekP1EhEKzN6PN+kjZFR03Ni3BJw22NP4ksvatFTICWa2GKltUFll5OqcVCl7VRnm

> https://stackoverflow.com/questions/18775608/free-a-null-pointer-anyway-=
or-check-first

I am curious if another software developer (besides me) can get into the m=
ood
to apply a corresponding update suggestion which could be generated by the=
 software =E2=80=9CCoccinelle=E2=80=9D.
https://coccinelle.gitlabpages.inria.fr/website/

@Remove_unnecessary_pointer_checks@
expression x;
@@
-if (\(x !=3D 0 \| x !=3D NULL\))
    free(x);


Regards,
Markus
