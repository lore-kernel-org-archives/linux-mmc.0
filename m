Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B8F42464D
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169529; cv=pass; b=niR+ejWVaphGEunHWQzBPJQk6UUf7iWKUkBmYGrL1arGdTgcYq44ZypuJOfjs4MNLYDozRhZJ/PwgCO+qyuhyxQYVp9NHqmrJqDUYHsquw2HkijgQLftjb5g4RA+DvEuLnT4db8nXsxdiAiRUgSTi2b8ac7cRXPThskfnKDQprs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169529; c=relaxed/simple;
	bh=DR9jc94UbAZlc1vz8P3KBFPfy5DTN0ZpfMKWOEzc4Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLgUJKWu4fxby+3Oqj5euiJEA9HJMMBLEqZd0ZT8/Aphs+ZWjmAIkAetfJL6wTYaIXyxmuSsruf+uoU2eKdoOfRfWWOjyzRL4sB+6gQ3Sm5Mt1CneJt2m/JfoibQn3H8UlMqg4/jlOEZKhLh+sJgYVFO/F7dXtK9nR8jioVhzfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vrxl8EBv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZBtwvIEQ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vrxl8EBv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZBtwvIEQ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmJRX3823897
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uQhFCurjaDXR3WGoPcZEAa7P9BUI2AuTWzyC0A17kDQ=; b=Vrxl8EBvs4Wob3/n
	8PuDPaUKBKZ7kKwmyHpuopdCrT0iCYW4BaPd7K1JbrB3vqPbswCxTMEG8ty3pNz4
	iY/9UW8EZtLS6gGaws1k9Sk1HNi+1Cenyj7RczhzrIp2ksVUmtIasFbhgSOyJ0xj
	Q+lFMfb7T9jPtpoT48OBh+iQwDCappAyW7xR2DRkUZNPTdw2Pf8yOBmYpcMF76eR
	E7P89/FRPqopY4ynFNylLJhCAmyZcuFcgow4QpyllHCkF4Sx5FmtYiHGbS8///y4
	Sey7W10aclJeJzOWTca5Du49TKp4NwPC5TpME82lGJ+29Tyh+CL2GIWrmp81x4Ip
	U1/U8g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbsse0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:27 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-907c59bd65aso30898646d6.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 09:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169527; cv=none;
        d=google.com; s=arc-20260327;
        b=mUcCKfpVAkanT0rxzdZ14vpMJgDUDVWRVfWM0u1RyW64auEeHW6m+EEFfGAla46lDy
         sqoH+elxgfdJCt/nqOsWe1j/2G0lT+fSgVUHOg/ewl8qMh3WAYZ/GV+7XFQrjV85Ytqq
         1iBl1zLNYOgV1p+rM58wswSCQ5Oyk+dZpNiEwugYv17RZBk72kWglQwDp5QkdDFbsazT
         mScEe+DGaEkthwIKf2QUTAvxRJQIBxq4UQ/gAF21q4XRKuf6CqMTNaSqnC2Goj+Ofpog
         XIFxsYVo1gcdravX3bLqceNUu1laJ6Fzx0nS9HimqaZ0NScp0dq5PyHTQkIkKO2CTgqW
         3J4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uQhFCurjaDXR3WGoPcZEAa7P9BUI2AuTWzyC0A17kDQ=;
        fh=y89rkYKwL52zkUS1iqJtziwQtB8D2w+mwlR2ETHIAbo=;
        b=ovSawIWNd/PzpfkmPGMBeaJlVCtuiUk/JzRjgpMkNlcM2HPfPMjt+H7yOBeud158XV
         27G7EWuwVPpoMnO8wL06cySvVApcHjKCc0wFgZTweMHL8wBgB7Ljli78Y3NzhXwnv2DP
         VL8KSGabOYlMPG4BmX8SGYexUrIQP7a0mhJayYt1lbvWRAv8JfR3F475LwgExL6JsaMm
         CvIeaYtSjRob0dFjgItkSDlKGxFOgvdFKQb0wxr3prtntsbvvXQj+8Sf5D2C9R+s/eww
         UqPIKtLHN2XFXSWO8eGP0dWAVeouUqPlz1aQyomOXlLvRGUYJCN1o/PHv0QonfP4Ul9F
         s/9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785169527; x=1785774327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uQhFCurjaDXR3WGoPcZEAa7P9BUI2AuTWzyC0A17kDQ=;
        b=ZBtwvIEQndfsVQJsjg3av3OfZSuuTs0I+dK1vNF2TxzX2y7Bv+IJ63pew70LpbmJ1Y
         jBGYoMBXk8ifkBKxqchA7VEj6+MvFZGBPTxV77yxvLJWDj/lRYQ/fJyvYI4MLMJhtcWt
         Icd/IKwDcN991pGPbQMGu224O9WAgTm/dvuPAUmg/EA+GcaXWRB9zY5QFVdI8OKRsbfC
         okdWvDOHeafoIYQl1regtiJml64QUekH+rxux68UiCGO1vTBP24eTZldxOZM/VZ/wmoJ
         M5RhL4HgnZWODOHnW0VK1K/t3OR3s26B2o0z30/w+8b21p8fLgwyQv3F7V9iAMe4qkYT
         4dtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169527; x=1785774327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uQhFCurjaDXR3WGoPcZEAa7P9BUI2AuTWzyC0A17kDQ=;
        b=c5GcNW/h1VkRc0XFe138NVw3wEPIcf4h73LmNmAx19eRDs1ssA1sBLiijDUnDFM4vZ
         mdrzaYxumTqyk+xZrnE9VVN0CRqXEbPZFuPNOsW+cbbNAsZcgMTCmybB8sQZa7GPIB0E
         JcLxqvpDXlFmPwKPJhqwbVZ2Pu4smN2piy6lO6m2YXnJmmkFkYL7kRco2NKocnI3vw0i
         1LUOoZT2A+TVXRtmYO5Ht0Qp95ZDT/pAKDETJ5HrmX7uOkn0SWmzMe9LOyCD5zd9iNcO
         9El8HkaP6Job2A1j8ry4wxpu4iQAEmiKBGlyHoe4elkk2fdGuju8ixi4x1Zq4KKorGvw
         mnBw==
X-Gm-Message-State: AOJu0YwN7ZZJLNe6A5n939MPoOipDRiUWpbEh+ggJTHTKBF3W7Fi0sK/
	dwbcEZeUGUkxjZkRGCf+6x6YbpRAFP9JSmtSL5M0UmIxwhnkOgp46Wiw0OOdlARVo4HBz83GJQk
	04ptwgaKRDB/T8nYxthsMpXp/vcNOczHpOQqsKLPimKbOV83XPR6grhjecK20oeovJptoVl//uO
	2fFcK2iOwfXAVUwPGGuqTZPpL7PceZ2/dSE1GYUg==
X-Gm-Gg: AR+sD13I6MTzGDRK+4C093mgIBE6tfctBsuk9my6aOUW4jP5uy8Gc7S988GbyX3RJhQ
	mX+U+yftyKsG+50YHf8wtr4L3fINip/MDG2rMQynsVmLO94i2PfTK3RytLc5UU1pO6COCGlp+Du
	XtV6frYpS6bXb8XT3ar/pqGfnAzTWqIqmf07DOg2CLLoe0F/PmgVpLjiJN0w==
X-Received: by 2002:a05:6214:5d05:b0:8e8:b302:8afb with SMTP id 6a1803df08f44-9081244d1cfmr3824246d6.0.1785169526573;
        Mon, 27 Jul 2026 09:25:26 -0700 (PDT)
X-Received: by 2002:a05:6214:5d05:b0:8e8:b302:8afb with SMTP id
 6a1803df08f44-9081244d1cfmr3823726d6.0.1785169526070; Mon, 27 Jul 2026
 09:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726215740.34574-1-rosenp@gmail.com>
In-Reply-To: <20260726215740.34574-1-rosenp@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 18:25:14 +0200
X-Gm-Features: AUfX_mzV41Dy28150FZEgEpdXU8-rxizSSlUanYnPvCzcsOwdi410NZkRx_-cM0
Message-ID: <CAPx+jO_EbGZcWCWt5FX00o5_8c-DBeBkweHpXYx9iyjvcaNt5w@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: use platform_get_irq_optional for wake IRQ
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        "open list:OMAP HS MMC SUPPORT" <linux-omap@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: A2SSBVkP75EXsY35Vm64qTv4MsfDyiQA
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a678677 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=MSWvbS7IGcdmO7bg7fYA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfX5K2lFsE+q9Mf
 6K5mIOLxL5nIhK5mo6HD5tx1y3OKrW1whfXarKAz6MSfsmlf5uFx5OhCE+mev77GHWyEm4KR2Ic
 OoM/SgeVJe0M3GstBGaERdf5K0KOMMg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfX5RUm1sObdqmH
 ePYjVtyEfJwDrRZEE5nMIGsQniEHzuHFI2kUORIRQ8pOUOgyjC4ttZBPiRAuDCwve78jz2RoQya
 zADfOqWP7+YLZ4CU0UxAdrV8F6V1B68+EN7fppav+tLN8iOb0hgZrjbY0Sr2/8+b92+iHJqY66b
 2IRxvD3XFTmtIBusgSUAT32Kt1JA9NpycW9X4201tmH1s3hxzpnjMM6GflUquQKQXiscbRY9Wam
 lDEx+BdS8jPYqzhc+7sLDC935Kju88MxQXWZ7eQTqsVlPUxlrfR4nLFuRgTw+0APWr6eEDhogzd
 wYxKeXyL8lEAXAwwPVtBZ5f3V3Kqp0IHSTnKJ7u9c4STO3f3Cc+013nV1PJ+YlFCVuS2I1WodLW
 XqCVw29fAkTLkWFpOkPlHlhdD+PeRq4GrEuzL8CopVjdqJLstJnweF+tqANeXQ74+XDyX6eibmg
 jFioWwmwTH1D/TI61Yw==
X-Proofpoint-GUID: A2SSBVkP75EXsY35Vm64qTv4MsfDyiQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270152

On Sun, Jul 26, 2026 at 11:57=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> Replace irq_of_parse_and_map() with platform_get_irq_optional() to
> get the wake IRQ. This is a more portable approach that works with
> both DT and non-DT platforms, and follows the modern platform API
> conventions for optional IRQ resources.
>
> The wake IRQ is now fetched earlier in the probe function alongside
> the main IRQ, and the -EPROBE_DEFER case is handled properly before
> the deferred probe can be triggered.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.=
c
> index 58c881f2725b..4b5589157c59 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1764,7 +1764,7 @@ static int omap_hsmmc_probe(struct platform_device =
*pdev)
>         struct mmc_host *mmc;
>         struct omap_hsmmc_host *host =3D NULL;
>         struct resource *res;
> -       int ret, irq;
> +       int ret, irq, wake_irq;
>         const struct of_device_id *match;
>         const struct omap_mmc_of_data *data;
>         void __iomem *base;
> @@ -1792,6 +1792,11 @@ static int omap_hsmmc_probe(struct platform_device=
 *pdev)
>         if (irq < 0)
>                 return irq;
>
> +       wake_irq =3D platform_get_irq_optional(pdev, 1);
> +       if (wake_irq =3D=3D -EPROBE_DEFER)
> +               return wake_irq;
> +       wake_irq =3D max(wake_irq, 0);
> +
>         base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
> @@ -1811,6 +1816,7 @@ static int omap_hsmmc_probe(struct platform_device =
*pdev)
>         host->use_dma   =3D 1;
>         host->dma_ch    =3D -1;
>         host->irq       =3D irq;
> +       host->wake_irq  =3D wake_irq;
>         host->mapbase   =3D res->start + pdata->reg_offset;
>         host->base      =3D base + pdata->reg_offset;
>         host->power_mode =3D MMC_POWER_OFF;
> @@ -1820,9 +1826,6 @@ static int omap_hsmmc_probe(struct platform_device =
*pdev)
>
>         platform_set_drvdata(pdev, host);
>
> -       if (pdev->dev.of_node)
> -               host->wake_irq =3D irq_of_parse_and_map(pdev->dev.of_node=
, 1);
> -
>         mmc->ops        =3D &omap_hsmmc_ops;
>
>         mmc->f_min =3D OMAP_MMC_MIN_CLOCK;
> --
> 2.55.0
>
