Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793130426;
	b=jcJyzzQgk7lAubD2lSVv1O7ulqjsQ/4pcz8Zz50iBHYvX9MC3WoYujiVQBE+IbzfzcZi
	 BTB4SVAM9ON4vdCEgK/i9X7WPmqtVSn1DZoBceRVFZpdjdDQjKbGsKTRhFCDJS+yk2kRC
	 tTjektgPIutLtBSmoR4/l5MSC91L255LEr6LMN9DZO3PZWBA2S4YZIFTD6WEzgE8TsS9t
	 kAfgWoxsP622i5jZkzWL9hIZkN4J4J56lGCbeWJ7b8zIybeKKZLIxqSAxPvJoTyvzli+2
	 P46Ust90+vQzMLbLXkxtz3aswOYT4iIvt9qANDZa+p42mZ5h9yN7GkeFhtN2xYlAvsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130426;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vXupvzMkXEFxaRDSdiUYDES7qK/BByeFIiZk+85P+Ms=;
	b=SLrVIFZHaqFoXKk1Lu3SEMD7M3Zm5ffYHsAloY7MmU2HIOpcjjFav8D0ZZJUD6SrXtIN
	 0/KdBnpPHbMIt5KIU95/cl4bpkQpmO3Pr/BkyemPL+IH7r9hNJLYNIfCV3HwmiS6y8Imf
	 xlUSQ/0xyRLvXUj//pFLPl/HwKj5WHuwJKOob5OmYaBBVdTNBeRTEizGhcJueHJ5yMe9E
	 1BefJ7nj1aXU0fo5PGN5LNl+iANAj/qUfq3swg7NXo4n2Ms0KNF86XM/niEZXm3n/GnYq
	 qd598OX+NR/T4bVqA9eidok6w39sm9CLpXKIpqB1Y0giGMWx20o1AdQuHp8EWpwMIzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LzujQoxQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I6PH0zyX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19894606A31D
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 19:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19894606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LzujQoxQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I6PH0zyX
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RIHSjo2945866
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 19:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vXupvzMkXEFxaRDSdiUYDES7qK/BByeFIiZk+85P+Ms=; b=LzujQoxQ17BLu3f5
	CN627i/BGLQfk7BgVJKjA85vLKTX5g/qZZoC2kl/3DIJZdh/j83jFT+QUiTVqbj2
	RL6Zo4/purFVj773fYIDpUF1RMk3jELvq2WrhzHpNnAQy4OrP7aM9Dp1qwOILf9U
	k8Ojf5uC+spAsHB1T/Ju/lrznb2t0WoB5wqIoluWT+3nv4XPPoxVhmtLOXJMCXdh
	9jvL1LnRYK7sZmACOehN6Qps01hH9WnmZlHIjCDcZDaYinXSQx2qv688nwYoRkxZ
	Y+WRQdhd7IczYHUpFYaeTX9SM5fJJPRiX8lWYksweVDK8y2VZBEPGgDxI+gM4UcH
	bVL0cw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq6argu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 19:47:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a0619b1fe5so191804b3a.3
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 12:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793130424; cv=none;
        d=google.com; s=arc-20260327;
        b=RHjFwa6BjrO9Evlz4r3HitXox9ZUhdbzDMDkUx92izETl5SE0Fu/s7Vaqm+qKgVlvF
         zrK07vCsSqDH4Rg5CvVits2khP/iU5CjKNrRw2pQ/0boUmCNIWicI8OIQ1TXFv+oGA2p
         ScqZXFVGXSiJbS8FQvA2/pNt776dgT8XsFj4iiDvfz6oEN7aGCzdxzKIX9kz4Dwjc0wb
         nMSXz4DXUXygdlj3VE0HVlHBbgcyPBtQNxSUY9S/0TDlEk3MlsNOy22ih34K0FxDfcRY
         Fxox6HszpqVIXmOHbOYtE6U1l+ZJtj0mc44W8A61MyBgp+AasL0EYBi8G8jZxXF7OWR6
         bKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vXupvzMkXEFxaRDSdiUYDES7qK/BByeFIiZk+85P+Ms=;
        fh=bw0rVfl0g6MgEjP7LQW9G+23Qyw8ZJqYJrEf0/f3Af8=;
        b=I2MOtzOxZGf3JdLiBcmRP11KSxlyWCvbm/CI8zFQCKn4KisLLWz1500ZSfWZ+NzXsq
         mGCY6zYFshbVLaGJ3eHjSoeYcsk9K5GuQBFaqreJoN6g4ke5riilZHqCJ+n9sed2iDJq
         8S3j5pGACd9Ogfafe3QQSk3NEMHA59L66cC9ZCF80zYrQxL1olmrfdTZIXwoFuvohK1r
         tss+d7i5yKJsGsntcc9NQ7XP8dnaARnc0LvdhC0Smw8gQxoT5yLhp7rtHOX4y5EnQZvz
         iU+cpwh+7KICnpLtGObWp86FSfZpfJRdSYCOyei9JT0Gbb2k9uV9JNuLPzXm9KfkK9FM
         Vp/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793130424; x=1793735224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vXupvzMkXEFxaRDSdiUYDES7qK/BByeFIiZk+85P+Ms=;
        b=I6PH0zyXswXsI0b/+7VmGrLu7/KnpbM19lsLS7dYEWr3lsdYlKBsDvTMjMZZD0FjNw
         9chhVheMrh7uoRZ9QHNeLEtYD+TVPXZ4tkhRwA5skDJQc7+qplHEEMHQYqVFeqOqY0b6
         n+0Zobo1TQwEnGRuc3GsTTl2kKQ9oNq3Q18WKa7OO9VOlzxHx6n97EElJIIT55Y8dqCr
         iBTh3RLr45ovZt0tL4HbcbD5vl/bXhCdp+ZPZoQW2eSPGMACcjzj8Jx07xHntzBVaCNZ
         /0CeUZNpAlh4ze3kbmYnUl2yFvlk7kc9h98GYLyTTtkyvya3WRN2PoQykLRlrTkf683V
         Utwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130424; x=1793735224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vXupvzMkXEFxaRDSdiUYDES7qK/BByeFIiZk+85P+Ms=;
        b=g/2MC/sL/j2ExBcnM1pSUY3YdFEdYlQkWzI+lDmYPYym3YtyfBIDpuGbDS7fqRPfFH
         TuWcieeu022B6yxJJkP3AyNILNm0k75tVxJqhmITziKbs7G4QNNfxuLxVyZ2HNG6xWRe
         MmroeDfB1EUyzOinjyLgY1NujCbHWA/BWumnXNThwsV5pxKUddaFhWh/j8FrpUSnmpGa
         m6WAhnN5Z/0gGIJNRQHmFqdnAX9HvDJkoFC48URaOizW8LNLjrmRHCVhme+iEI1M1ZZr
         ERUBob2OBAqoC/0DzbvTswaUImWFBmKwWsqkBmXTd803Z3GleXQB2cDdeNADrNL7sLLq
         Qj3g==
X-Gm-Message-State: AFq9FYIZlfpn+YxWLvvXiO5/2JELcgSbUYD0bBbRncptmrW0txvQzpxp
	7jv15/MkJcKgpYK3DCmdI0Am386PeyOmrBRRlqOvQtqgd4eIvUWYCkw0l7NoCfPwyD/Wki+sDYY
	kQ4rRfIGk21gS9yU1sZshR+nYpNRaqQqtnDrbOVi6QlQJhcesbv3bX4S28jNJEsJCzelMDZevpD
	/LnMo9HL6pv3dyPboWP4URgyXuu3Qm0thkMCBCZg==
X-Gm-Gg: AYBFou1z9D7wEJPtREaqWcLOYQXrFAscQFrLO9akSGgTM+QRuiwaOJHhUkjnxG8ZKKI
	XWaEFmRafmIkROgZfMajRdwdLwPDz2sJeXrmh8Fy19wWvwFAux8uhA+REq5RqAusMM5fvt0wdGT
	h8Ptn1KbAwgUeZ8mMaSGwg1t2zBnTepSbtqtmO5pXSBRHTmwmdpla4TgALaA==
X-Received: by 2002:a05:6a00:399f:b0:89f:3c81:e733 with SMTP id d2e1a72fcca58-8a6e6b165f2mr200687b3a.25.1793130423826;
        Tue, 27 Oct 2026 12:47:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:399f:b0:89f:3c81:e733 with SMTP id
 d2e1a72fcca58-8a6e6b165f2mr200670b3a.25.1793130423390; Tue, 27 Oct 2026
 12:47:03 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
 <20261027144051.249211-2-ulf.hansson@oss.qualcomm.com> <583dc515-855c-48d6-aefb-abaef26b2564@linux.dev>
In-Reply-To: <583dc515-855c-48d6-aefb-abaef26b2564@linux.dev>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 20:46:52 +0100
X-Gm-Features: AclHuK_bapBmxktEdZVjMgWgZxWqamgn8RlHpTC8snrfTiBMci97VrdDBV-_joE
Message-ID: <CAPx+jO_+P-ksGzbYp9Aky7etMyKtTUvtAZJZJpauw03Y8zP0Lg@mail.gmail.com>
Subject: Re: [PATCH v10 1/6] dt-bindings: mmc: Extend keep-power-in-suspend
 beyond SDIO
To: Shawn Lin <shawn.lin@linux.dev>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0ffb8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=Q-fNiiVtAAAA:8 a=EUspDBNiAAAA:8
 a=HEP-3NFZZEzz-JMo_uAA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: umgvpWHPnHe7WqS_1H73vDYYGZ4c6SL_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OSBTYWx0ZWRfX0V24uuuTQmhF
 hmoGaHtOl2kZ7+H9uSAs/l/XlLZWmv5QRdq2uSyN8Zqmi3WHW5wgaYPY4VzdD0EV6Byt5zbbQn/
 PX7QvNxTyfAVQpHVgfqVaA1lxxbq5QU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OSBTYWx0ZWRfXyra0B3Ac9kjn
 x/Opy2Mu148b/W5ccPJjClIsh+ZfqFcIG6L017jveIkWU0TPPeqm0zdqPghfMcbsfuoCCE32Zl+
 ZJyo+4cQpsOaIqKCabFAhgWmaURz81CdfyoNUbOgIXqTKzrmJUF6ZOLCiMDZpvHGmEdagpukVEI
 vU95ZNJAgwDJPlplRMR8f2InGus4lDEMOIPoLYcXb9t26W0vvvHTSNJ9+5d1BhjTACg9RB/ySy6
 ESgbHi5AJeYIZdv/ohra5mMIRiuGiFGjZZ4h48t2tOyhLwKLc2HymKShaZMpTZRfrT5krFuey/H
 mjwGeFfk5L+CpGk+oyCD/A92ZwXaQzRbGiba7sCprCv0PdTAFFtAKb4S/2x8R37YrZESz9K3fZx
 iYfPqFWJnxXz+sWeJkQyK+TxwjBcVJCRhZTKdkKWoB8hIjPO0rx+szsBwf37ORkC1kurtEwAlAJ
 KSB9GQ9YDI02TfJKGRQ==
X-Proofpoint-ORIG-GUID: umgvpWHPnHe7WqS_1H73vDYYGZ4c6SL_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270079

On Tue, Oct 27, 2026 at 4:02=E2=80=AFPM Shawn Lin <shawn.lin@linux.dev> wro=
te:
>
> Hi
>
> =E5=9C=A8 2026/10/27 =E6=98=9F=E6=9C=9F=E4=BA=8C 22:40, Ulf Hansson =E5=
=86=99=E9=81=93:
> > From: Kamal Dasu <kamal.dasu@broadcom.com>
> >
> > keep-power-in-suspend is currently documented as SDIO-only, but the
> > requirement it describes -- preserving card power across a
> > suspend/resume cycle -- applies just as well to any card type. Drop
> > the SDIO-only restriction so eMMC and SD platforms can use it too.
> >
>
> I don't see how SD could use it from the following patches. Perhaps we
> should still be more strict here to say SDIO and eMMC only, unless
> SD part is implemented later.

I didn't have the bandwidth to implement this for SD at this very
moment, but the idea is to add it for SD too.

That said, I was also thinking that maybe it would make sense to add a
sysfs node to allow the behavior to be controlled by userspace.
Thoughts?

>
> > Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > ---
> >   .../devicetree/bindings/mmc/mmc-controller-common.yaml          | 2 +=
-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-commo=
n.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> > index 8b9b3b036129..2fc8e06d5ec9 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> > @@ -301,7 +301,7 @@ properties:
> >     keep-power-in-suspend:
> >       $ref: /schemas/types.yaml#/definitions/flag
> >       description:
> > -      SDIO only. Preserves card power during a suspend/resume cycle.
> > +      Preserves card power during a suspend/resume cycle.
> >
> >     wakeup-source:
> >       $ref: /schemas/types.yaml#/definitions/flag
>

Kind regards
Uffe
