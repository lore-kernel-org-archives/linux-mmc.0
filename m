Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794318001;
	b=l8eNZ6fVOnGJoO3LWFQ3JXWDgYhm+5PnJidmY0sik2i9JUxxQDkbWDw2It5ShWfsLSm+
	 lS93IH5i6KCEBqEbYCw+TrNHpNLLyJtmEO3EkaQEOUGnES1vtTmjsTUD43FyknTGtJ7iu
	 g6HFpF0BbwOSwhDME0Y4Enu3q6shVI8mGjTbhijcaWPJ9fc/Ecy6QZtDjGoGUKuf24kkq
	 7wWIP72ZMgaxbQB/3xpCM6WHHY8ZIzfARlv2fh2KEqqO0WQaL526gfjw5K31Ks5brPvAx
	 mt0cmlK52ITxJ+H7eF+iwCP+ZqMzEUeDsRAI5iNtdkIGOiesDNYqJqhz7Q8IT+JiavQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318001;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Mg6oCc/9mKynP5F9a/znRNXHsUn30pti9r2EQTEQynM=;
	b=v8oTUJJflE8t7RW1ZGer5/K2ke1rFQyBhEdFyk8z2aDZu6QLsTLixpy3bEJREWUL6a4t
	 zTwkSHcx9vaPi2ArdgJIyNfJXbUg9WSKFMUHgXwJvgxjQR/qVwlhX3W5xhdgx1MXUB9Tl
	 /Lf2PwZ7DXc8CkpQUOJhOG9vT6W2AFEOUvW3WmM6xyLlTB0Fcx49c2dD5mWk9UdQiHR2F
	 irN2lMre2ZYtOtYBm2OgwM8XA7kcQe0pa7CDeeL2NqY5wZO3FkLwyQ0Sz4p6hKtgbllQE
	 t3FGXyVj15mVJGD2ucLLyq123mhuEWoMwzuRf0YLxK5SBzQ80WOQT0TQQj9jdo514Sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o0mLqlxo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AEBTT3ni;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8156D606A332
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 13:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8156D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o0mLqlxo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AEBTT3ni
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABAF3M3217311
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 13:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mg6oCc/9mKynP5F9a/znRNXHsUn30pti9r2EQTEQynM=; b=o0mLqlxoSJH4Vg+j
	xmwO9g4nHNXv/rczj6LLRRYhI8zuBowS5nt8SyRGQ0SPUTsx8d0zsE8MV9KqcoCw
	xbKZjqX7pye5oSoHGDt2R9bnFLoutzMs2bNQ06GVuZJv0Zap74CZRwLobZDA3CiN
	H0jDzriebLpxV80HVbkIElkKidp6vx4UMrI9aYBdpjx3NTstUyFC9WfmmEVbgFoE
	rlh/slodkkYFGELZgaA+bTRFCHudApaw/fKC0c1d5wUNWKNJ7vQuxP8tx/schRNJ
	W2x6aQzLEeh0M8LwOMntJ32rl2rBfy7c9semCBHWqm4acybcmQz5hWK5E/BgbX1w
	xcd+dg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huvtd9vdu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 13:39:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea71803effso20451675ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 05:39:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794317998; cv=none;
        d=google.com; s=arc-20260327;
        b=E4RIbcaTCKhg4GEL8gLk19IZzOdgCOvUlIQd5WfINDuMbeG9s4Fn3oJDZkkgO4Yy7Q
         bkRmIPxSGX6yrOn0NJqRQaIDGJ/fL0Hj+2BuBxpPnQK+l8hBwfrlS0CABmrXQukpMELW
         Ul+eaZvvsyBwWGsv/Iyqccpv8ROwZ0d6ej+iJs/fTqU4LlHA45wIMwU0jQBJrH+PV+2a
         4hy/b6rQduFbTmy+9vy4j/g3jz9IQIg1l8EZwIdXmBXcz+ksQ0xmEzGRuWz2r9EghcTy
         f0XQ7LwRGMd5g/wW/01BVJ/kwREALpYRP0kgLCm113vU9Mf8yE+NiNyyViDjrkZtk+h8
         4/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mg6oCc/9mKynP5F9a/znRNXHsUn30pti9r2EQTEQynM=;
        fh=SyKmNkYg38dVbOCzQ14VtV/nZvuHSFxiU9bsz2OTKHw=;
        b=B/blyCL/hzSGnleABY7oD6UDOBomwaV+I3iBTV8TJw4Eb8IxqrY1GitBuFDCCY7sUn
         Uo3Y26hzZ8TBVQaDrQ40KKQ2mVKnXkeAd636T9qNXFddEkbvwfZEay5N2DdW9lZaupRr
         h1y3yy/V8UalHYfg/iWIZuC2ozdaIA/H0l3VK009TDhuxNrL1esESxhYspLD8IYWcbCR
         9y+9LWzHEYHJ6G5VjDPq0Zun8C5L9UXd5LHWW6eKwd1/uRW0t6ZBGKyLppx8/LP1TVbK
         m+Vd5VU1Y1tF+1ccKYq6iqw2UWl/jUYqEmq//YoIBMURzBtr70KtKCTWh9dlbYEPhTXo
         dVzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794317998; x=1794922798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mg6oCc/9mKynP5F9a/znRNXHsUn30pti9r2EQTEQynM=;
        b=AEBTT3niRxwkOvBn5PfTYHEEcXV9y8DYQTP8wphE0jO+4mXDr2ZbfkA2tvfdDnGzzh
         ZclOGEnMaeeN3UQtEfUMTLgzHclU0Tah1YM+Z0gFO2ainIiuXbOedLkYI+y5j0Kni8ej
         lc6AF7COX8bNd2bzDoTLs14dtLxBGMDsRM5i0pWSjcrR2MPWzYqYz/A8PEhTJ0c8VPGK
         8vHHFWT7e8wawGvKvPSst/FsnRdBAWG2PCp7SSMerzx5XjmfVgV8nMUAmtchlTH1I8oN
         YGDLpl++Cj2oLDZDJaX1rkDsd50jOS9ZCG0YTLWYC/hUiHoWv4Uz1zXE688NoTM9RvdB
         7fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794317998; x=1794922798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mg6oCc/9mKynP5F9a/znRNXHsUn30pti9r2EQTEQynM=;
        b=C+v1AApDeGNR6AQQEwjjcFFVZXvHdcv8ozMJtFTr0MVkyU6Yx1LTaVdLudsgZHP78G
         vPYr16ARJFQDLcZnFRvmepmlEoplSbZZyDvCfEzamNillarELvLXiP7lGV7cH1FRRUvn
         j0kTF1sxnI4Y6yXoiftymP1ZPlal4qazmBn0QMf8hXiIJJZLdq4U/blr1Jdd2waEAdj1
         5TmKJccceRGSwKPEBHLSYQjmYshsHbPm8zMdz8IfGQIhIF5hYfiNXTOu4LSfmrayVBws
         IV32diEk8PmjREe3tmaB5MyeKP+I/Gm15eGFHfQvybmftAuSi4s2g23SQb+FOCT0nR23
         2fxQ==
X-Forwarded-Encrypted: i=1; AL+hErE1aYkSTnV9LPgGmEAhS9+pe++YWhAX+NlOHjeyR37pU8scXrlbxKwptrqxhcjnOrPaCoNKw2bUWpw=@vger.kernel.org
X-Gm-Message-State: APuU4Z++2qAGNB1z/UZkQzdN8AS8bJzsO7ih3SZx/mF+sooTgGR5N/gN
	vr/rIDL6hb2Y1Mcb+9j/zBYuAZQl2F+d+YPxaUWHDhy4WCpsxYbltbAEAp9QAylYBu4Fd4sjpBU
	KurPJvcP6IEGdVrnRivbWMW5LOxo93uOSEYRoGu0NwI1Psf0wbZKqkgViZorH6D/tFbxAFVhCAt
	zdQjXFTAxmrwiLUpKvCpsn4+yJjMjoHiBDu/xMRA==
X-Gm-Gg: AYBFou0GWB8kb+KlAB8yq7aVLQ3kCnqrpg1TtA1EaF9xoMwKuRTif1lFiV+6AKE88dd
	ISmbOsmcWdxV3VhfL32BgSJwHl/KrNHpSnZipWsvJWKRun0xP3XmKj9XznMRYKtGXG3PvbpP9ck
	gssJGfPImJHfxZYO4h2Ir/sK2KDKhy38kYv/yL6t4UOmWD44C+VkaACTrSjQ==
X-Received: by 2002:a17:902:ecc7:b0:2ed:29eb:177f with SMTP id d9443c01a7336-2edb9164bf0mr23948535ad.13.1794317998148;
        Tue, 10 Nov 2026 05:39:58 -0800 (PST)
X-Received: by 2002:a17:902:ecc7:b0:2ed:29eb:177f with SMTP id
 d9443c01a7336-2edb9164bf0mr23948385ad.13.1794317997703; Tue, 10 Nov 2026
 05:39:57 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031200925.3364-1-yuanzhenpeng210@gmail.com>
 <CAFBinCBo0C=KABcg5ueDTRSJhF9vmWnPwYHbaMGTOYppOsabwA@mail.gmail.com>
 <CAEDN0nDjYLE5hy7gVLQ3hv1WESVJQWgc7T_8aLqzRui036A-_A@mail.gmail.com>
 <CAEDN0nBEK5PvkV-eC11XHYG04Occgs6o9_9K67OZn+xtkh68yQ@mail.gmail.com> <CAFBinCCxfp65Fe0D1UnupghgiOkTB0-m=+L0kNSOUm7DzRFKcQ@mail.gmail.com>
In-Reply-To: <CAFBinCCxfp65Fe0D1UnupghgiOkTB0-m=+L0kNSOUm7DzRFKcQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 14:39:46 +0100
X-Gm-Features: AclHuK9Cj5Yfw2Skuhr4nlPjsEojXxiMikKw6Cl-Wxr-T9dRxocHgrBfMronDNQ
Message-ID: <CAPx+jO_oAnJFY9hodP6gxPCD2ch0=+0MNXkKoJXz=3OzeAq+iQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: meson-mx-sdhc: add DMA bounce buffer support
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: HELPMEEADICE <yuanzhenpeng210@gmail.com>, linux-mmc@vger.kernel.org,
        ulfh@kernel.org, neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 4LoIxAeICpL31N715dDfcm30tQg3EEK_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NCBTYWx0ZWRfX6ZyDEnQocFaX
 c1D0S52btXxVNpj//8Fl2j6URmS5cYY0ueoZcXbUdjy+1sifUL9vP0Y3dYpG4cIrH4d/dCtGLLP
 EjFZDDuELrXbIUj7o8AwC0wdI6w4fj0=
X-Proofpoint-ORIG-GUID: 4LoIxAeICpL31N715dDfcm30tQg3EEK_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NCBTYWx0ZWRfXyEmxZlafe8LQ
 gbhUR1VCqlyYefp/4sUX/yBuzS4feL/9vty60PlbewA1Ql7xSCIRoDEeZY1sLlVh+cSNCNRZDvG
 83b+WnpNeRxAipEQpMM3sn2CXCVHBtlNf+/CP/09xS6DmanlaQ0dFe8s5w96NZXslnz9fdAbwI6
 e657VR5+uLiAQ+gx1VEb0EDdGgkXcrZmcbmt+7pu+9grIIZNVIPp7T5sW8ZYOw8ORXFwXeXLCZq
 6ubqrB5QYdu8LmHHNC3O2BDnWK35tedEW0Panxbo4Xb3dkA5GXZyMkCQ1I6jvBXmy9Fz/yUTgx0
 rSo53kAnYb3kf53Fcw1n6R+7v34g33uoOVctQl0BjE3UNaKLaLW0AUtw5vi5MPrh/yhAgZfaHWp
 CobXkfSgbkH54N+q5BD6HUflUurXEqrtG0gBOyOAh05XUOlycBHQ4YrKyJsQkbRUH+NEzQ0AWCb
 dhwAUOrtZEbL/ugasdQ==
X-Authority-Analysis: v=2.4 cv=ArR7T+9P c=1 sm=1 tr=0 ts=6af31eaf cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=mK_AVkanAAAA:8 a=pGLkceISAAAA:8
 a=BQpyg1UmJCR0kPwaJroA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=3gWm3jAn84ENXaBijsEo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100054

On Sun, Nov 1, 2026 at 11:52=E2=80=AFPM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi,
>
> On Sun, Nov 1, 2026 at 9:55=E2=80=AFAM HELPMEEADICE <yuanzhenpeng210@gmai=
l.com> wrote:
> >
> > Hi Martin,
> >
> > Thank you again for your feedback!
> >
> > I've completed the comparison between the original driver,
> > MMC_CAP2_MERGE_CAPABLE, and the 128 KiB bounce buffer implementation
> > on my Xunlei OneCloud (Amlogic S805).
> >
> > The results show that MMC_CAP2_MERGE_CAPABLE alone does not improve
> > performance on this platform.
> >
> > Runtime instrumentation confirmed that:
> >
> > - dma_get_merge_boundary() returns 0.
> > - host->can_dma_map_merge remains 0.
> I see, so that will prevent it from doing anything.
>
> > - The block queue's max_segments remains 1.
> > - The merge-only variant behaves essentially the same as the original d=
river.
> >
> > Here are the sequential read results (MiB/s, mean of 5 runs):
> >
> >                  Baseline   Merge-only   Bounce
> >     4 KiB          11.81       12.20      13.01
> >    64 KiB          12.88       12.80      57.52
> >   128 KiB          12.97       12.80      67.68
> >     1 MiB          13.11       13.05      69.43
> >
> > The bounce buffer improves sequential read throughput by up to 5.3x
> > and sequential write throughput by up to 2.1x.
> Let's wait for Ulf's feedback in the next few days if it's something
> that should go into MMC core (either by default or opt-in) or if we
> should keep it driver specific.

I think I need to see an updated patch to see whether it makes sense
to move this to the mmc core. And even it would, we can always apply
it and make rework on top.

Kind regards
Uffe
