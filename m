Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793358038;
	b=2nUsEsrbCY2o307kgqYDV8Oti7QuaURDGcSdyDRjDuQXCEhTOBUh4sntTSxzU5eTGttb
	 8agfu4BAI6VMEtpXp5Ja8ADcxnrV/VsFwsrBA4YpxIwrWLUEZl4FAUehOh4js0t2J60OE
	 R+UNd6Lc537Re5zhWeQZz8Ll5Lqx80h55NtqtczxJ7NP6HYmvxk6dx81098FhBqj6iMHS
	 Zcjd7N9O/AbNQ0bfGUunjUobg98GIApmnvKGwQmqRLnVoy5sAZPLmFIXaOANdWY7NJyA1
	 EguAeZZ5OoGIEp9HNLhW0g0u2SjjeukoU5jMvOzGboa7FLSU4X+nZjNXcjijJp8az5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358038;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JcDbmSXB55pbh/pDj+0+0hVcgTy+254XVZ5pIx4rYQ0=;
	b=yRykyasziyvgXujpdGQ76+N+mRkFOEUUzk231H1LGSIj9Ei/TvVqvRK5zfrTLbmKp5EJ
	 eOK26aO39FfMlqMAPklR++nMrzf8mU/v1HvVUMmB0Ne3+/BbY9zVa6FdPq0sMl15r0OuX
	 1ZMiJPJlc6gGwXX6ytvkiUQHfUXtgCH3SyrXdvXMExEWLYduhF+3ck838zsJasw+Jnp3r
	 V6MJRhllqiCH5upGbcaQsBG/IhJ17D61pSRXedI3YTaH3oNF5+1ywWpxM6cplWGvQNvUh
	 DKSzT7ka1sHKtAkdAPtQi4QbVSpRdjKq9lmQkfR7dCxqfHBN73LgcCpDveTfZlal4Tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CsSXa91d;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dtu5MbkV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB7606D28B
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76CB7606D28B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CsSXa91d;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Dtu5MbkV
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8F7jF2683323
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JcDbmSXB55pbh/pDj+0+0hVcgTy+254XVZ5pIx4rYQ0=; b=CsSXa91dpCxyvxj2
	fCDh+DquoMmfC9cuMNT/c2dEpu9g9t17dZ844GpG1h05rpsfBunpcqRv54iiI3u6
	NimFHerF9cplX8hzp6E8RWHuhHbhNoctgXBUz/gvZlyPI3yJnM3LVnhUhW/mNKTb
	XdCDTW8g+hBvmixKT/Y7gE+BIWyUwJVumOujq/s2ALGLz+Obu5SsGdTVuOkeKRMK
	wCSfuQFpo/6F2wHBo43dPJRrt6dsHc54spYvVpjnMprPB6FjEo2PQLhzHPPhxZ8E
	zIOaKP7y6mhOEwmZ9t6cfcVU4XhrIcIKugPgBVeSVUqTjLoVHZXzYQiO2dCT2Jq9
	ZVVeXQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qjkda-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:00:37 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89e6ddd4554so421481b3a.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 04:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793358037; cv=none;
        d=google.com; s=arc-20260327;
        b=kVfwrEkNBC+wBJ0mPWsoNd3fr8SY5LXajhI5g4/EQ9Cfln8auWifDWlLDN4PLgFjE+
         BumVCSfXo7zCpMoq30eEZQFB/DpOcVOwSRF/3kVhca/MiM1tgfyITckT66QyN3qMJt7z
         uELqEiszYm7QCKQ9xqKzcKSVUN6qsSGyQkMSzYT6333r5eqUG1FWAOgNh1dW+Ywd1YSF
         YiF2HzeFZzK6gDmY53VFHKMpgW26bzGrCjzafv4WI/2hZnmh52z03/A5DqF7fB75KR2z
         ojwB48Kpn0C7WQQNsYmKbej7cu7nw2o9xUY6ZNWxczXr7WwFffpVAV+wZfar1Gum7qP/
         nyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JcDbmSXB55pbh/pDj+0+0hVcgTy+254XVZ5pIx4rYQ0=;
        fh=IgfV5Pg11sZW1cp6Fo8/QGs6XCxnI9OIIB8aK5btZik=;
        b=KZfX1lCzfOG+/svwuhiRxrX5hZWzdlMENIEha938tiWD1D+WXW7/YebBDM6lz+evDx
         ZBKviKSxL/l8/m5nWglpumDTTiIviDFbtRYo7EF2/h18jRnPIx1iM4/c9t/ZRXxtPDtj
         m2a6ebZWWGk6Xl7BLFBBDavGPP9BGC8xdmUDcJNgB7aBF/t3qPpNbFJ+lTsYEoHmT7nw
         XTdk6U6ZYUvlFF/lU0Vv34sVwut4ch4aEfGI8pWFdVkFSXlk9jc+1+gMIrC+D+Vs690Q
         zh5PrRXbT+zHxK41pykyT6bjtUEuayrWmAvID+qNExBpADRY8nbya4geLtMN21Gq0jgq
         bO1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793358037; x=1793962837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JcDbmSXB55pbh/pDj+0+0hVcgTy+254XVZ5pIx4rYQ0=;
        b=Dtu5MbkVTiJpyMbu7xuRh7K/xyHFS9RtMBWUTGtEAow9QrdaLjG5aZ6uKGMyytzIgh
         CbaJ/UU/MFd6pZDq/Tnype/mjm80rAVRARsZjFGpXCFdxjLWJbS/xMiKQYQ3sm+/Ca4S
         4Nmz5uIRxFqgyQrbqoS7AVaPsUKgNE9og449gcUqnIbypPWPw1+6mklXVvlBCgwbCds3
         5srM3tELtDH4dG53dwv3QircDFrBJbzbw4tffrsZ6l2Qc234YEwrfwTLQNzjQuvU39AV
         d82iV/BEvKgHpY9UnBhaF1Jco/6Dm4GZbvpUU4/PLbC3l48xUNKA9rzXmReUfPhoQrm6
         ibAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358037; x=1793962837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JcDbmSXB55pbh/pDj+0+0hVcgTy+254XVZ5pIx4rYQ0=;
        b=DDTgavN2pGX3yE0CxmRt/ikH36t67nY4KIoZbSmz5Q06oEGJ5vlJ+YyNlbRD8YiJ4m
         ZE8G1Nc0+omABOS/x/dKdny/+kl6S9aMXi+PKFYOVLNnFnnF6kwPEdS/CQJj4MvAfPMU
         McWT6hlTkmHBkHcYh9i7tRX9hdFTUBPZaa2eY+Bw1UXZ9uuRx4BpO9t6juVq/Ddp1jdZ
         QfACQ0uCPKVxeFVKYOxexa3xZ9ADH/uDWaKJXzA0CcwxSReIq/7MU6XEOKHcVsxzU/Zy
         eyr9VfXT2YgJ5WdUDU0FvJTylsanpn0au1KXij+kR3C6ZD7K+Fj3xQipILvyWrFQJaLm
         VSOw==
X-Forwarded-Encrypted: i=1; AKwUvByngtxNpWExnv6Uuw64ksA0AKq2FGfy8tko2L7JhQY3mvxtE73TFSTHtgVeLyvzCPj1Gte+o266Hk4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOjTDRQ421AJnj3eXllRoPFE7nfR+CBw8xW0omERpNvGgeXEMq
	CDk993DRLSat4KPu/B1tY3UP+cWHVBWJbJw20a1xv2B4p8jc0ZTKVFXotoUAdNnNA/prK5+WxXc
	f4j/okw0wfbYoxDZMiMg2K/plWfnCXrWCX12X/U6zzes4ESYzTGp09y664GsNPUwkHzEH8f9liz
	nrHi4scSgDO/8fRF7o0seLvROQEBfvaE3p0X2jRA==
X-Gm-Gg: AYBFou1rvxmbRJ3Im8c4hydvZEqZkBPu31EA7UmTr9pXgd8Yyd/NdXGEpkNviP028hA
	4DYJnwuM6O7WsK12o4V7fD4XmL7hBbTwQHLANPabKRM+VC6jEengIi4qiiblsJLQFopGOtYPk9p
	e4di8jhdbB/TmENLRFLFKPFRmyNgkD7/AO8pvcEIA5CJ9+Gk33c/Amhy6C1g==
X-Received: by 2002:a05:6a20:7343:b0:3e5:6c93:2500 with SMTP id adf61e73a8af0-3e9290799a3mr1931061637.57.1793358034427;
        Fri, 30 Oct 2026 04:00:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:7343:b0:3e5:6c93:2500 with SMTP id
 adf61e73a8af0-3e9290799a3mr1931033637.57.1793358033943; Fri, 30 Oct 2026
 04:00:33 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019143317.2222236-1-bruceli20040604@gmail.com>
In-Reply-To: <20261019143317.2222236-1-bruceli20040604@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:00:22 +0100
X-Gm-Features: AclHuK-5lepEJ6hbXHm1qJZsM8pIJhTJ4sodowpFgQQ3XyT_SGsEkcNO1TTf7hU
Message-ID: <CAPx+jO8FYgO-p4kph+p8Y0M=qHz_We=k=eVYO=Smd5KJ26xVHw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: wmt-sdmmc: release DMA descriptors after stopping
 the host
To: Guanxin Li <bruceli20040604@gmail.com>
Cc: Alexey Charkov <alchark@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulfh@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: NT_M6xY1bkimvEB8DCZ_u0uMRLzOuNbR
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae478d5 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=byypguvoXFTbGjyYA4UA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX7p+pf2UTu1Tu
 rkaOdnaq8vwyXI3jsm41XleG5SczWiXHt96m7ngN/cQpWH9+ou0KP+uf+ztMPB2qCORIEZFUWTW
 O4ke+q5byUZkHS3/Lilzu080+BYE4h1RWzS+1emG9PptJXVwtn+C/cT4TKnVT0+JZZBzgNP/T+A
 h5Wmr6pFbIVv8UQ07qQBRQUMn9+bAzh9j5n9ijYkJf6M99sUWbgYgLFIybRqEUk3MpztMvUY5Em
 ZCAqRJbGMQFzBHEThyDI8HvkbidNgKN+IdDYNSLsMGK4WRT49PO/ryKlN/ryQD0o1Gj21bd1Jrg
 rfDfE05QJ5WdUsqoUTTViz/xsT7l2iC/wmtcD+kanoY7uVsuX+k0hdtJ1SRgGnK2SLcn7ie/f9t
 0NZOaIeJkC4CBG/SCDNVHsBix5rGbPpzOWNMllyPb9RSLvokaYwZHA+AeLeWX5kQAQ7x6jVK0x3
 iI5YhUYY7Yw0KFyeVmA==
X-Proofpoint-ORIG-GUID: NT_M6xY1bkimvEB8DCZ_u0uMRLzOuNbR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfX6H7U9yLQaHv+
 EZYIm8OXEqeDeAlFi5rCBXBdKY44N6r0G3Z5D5MqNCUsV/2ohco+LOPcHihqxEUJTaiaylpJEn/
 65t67Ez0Mz2ytlyfPujj2EwVwezWYCs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300043

On Mon, Oct 19, 2026 at 4:33=E2=80=AFPM Guanxin Li <bruceli20040604@gmail.c=
om> wrote:
>
> wmt_mci_remove() currently frees the DMA descriptor buffer before
> calling mmc_remove_host() and freeing the controller IRQs. The
> controller may still be using the descriptors, and an interrupt
> handler may still access them during this window.
>
> Stop the MMC host and free both IRQs before releasing the DMA
> buffer to prevent DMA or interrupt accesses to the freed memory
> during device removal.
>
> Signed-off-by: Guanxin Li <bruceli20040604@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - Wrapped commit message lines to comply with the 72-column limit.
> - Moved the DMA buffer comment next to dma_free_coherent().
>
>  drivers/mmc/host/wmt-sdmmc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 489daee4f4fc..55675aa8d08a 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -895,15 +895,15 @@ static void wmt_mci_remove(struct platform_device *=
pdev)
>         writeb(0xFF, priv->sdmmc_base + SDMMC_STS0);
>         writeb(0xFF, priv->sdmmc_base + SDMMC_STS1);
>
> -       /* release the dma buffers */
> -       dma_free_coherent(&pdev->dev, priv->mmc->max_blk_count * 16,
> -                         priv->dma_desc_buffer, priv->dma_desc_device_ad=
dr);
> -
>         mmc_remove_host(mmc);
>
>         free_irq(priv->irq_regular, priv);
>         free_irq(priv->irq_dma, priv);
>
> +       /* release the dma buffers */
> +       dma_free_coherent(&pdev->dev, priv->mmc->max_blk_count * 16,
> +                         priv->dma_desc_buffer, priv->dma_desc_device_ad=
dr);
> +
>         iounmap(priv->sdmmc_base);
>
>         clk_disable_unprepare(priv->clk_sdmmc);
> --
> 2.43.0
>
