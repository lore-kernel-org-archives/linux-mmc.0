Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCC3453A3C
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514912; cv=pass; b=nM8dcZdXQ1mEh7cHHn27phrGkYTUFLyr/XTvBG0Z0NaAgNA4MjUTAT+ZrFpcnBfHlLz0BNhtJEEFzumpab1suYa59mRy9AQo3LxKEAHL6DFZpTkVQkn4L/rkHHw+2a8K3mXlaFbTZ0f4xOuZiA871XNL+8aePbbHhyiatB9Ud+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514912; c=relaxed/simple;
	bh=OwvhlOjXczwQM8RF6iBwIfWZpHB3GYOgRcW1D4QzHwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxoF981tsjswke7VPs9pEvnZIlD/SodJdR7TD2fUl8iTmhEMhnsVOqbz6ajOSiPUVSBlspfaRUrCEn/MdQeY5umiohYygIcuvgiM7lVmxnaavcCeVm7BHHw0gYkxH9XPYzwTFVkWMam7a0D3SBsp7KJ3IrPDFiy2mGowS+tvjBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cwgdt3ls; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XdgKwmKJ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cwgdt3ls";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XdgKwmKJ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mX852838284
	for <linux-mmc@vger.kernel.org>; Fri, 4 Sep 2026 09:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ToSiV1+7MY1z7Ikbo8sLpHqhAbQ0/fiRGaaoDkNbxbs=; b=Cwgdt3lsRogaaeNz
	iaJkGKKDHJiLBE+Wju7ec6VThgHosPQuqjtKuikylPsv237qJp+G5Bt97WKWJSsU
	XKPKtW0EfKpWdVM4Sr1Tbjw3HdS5CHP1VCia2B4jqN1tGmQDtZpNxrcf359vakDt
	H+E1tTbFJeMY/iSgp1QC2USZ3DfcO8I2snx4mIvcgDHVIxKpBjSWh+dFWg9raD6W
	+nm5fTCSRimnjzXCEIMV1pQSwNQVt8DAUmVl2YxgO7RE43JG625yF1Wl1pkm/KXm
	UhVUU/fHaGyuH0xd0nkSLZe3PmDeVHTYWbv4QLliXaC7EZsE98Ipvk/nCe1Hl0WK
	wWyG9Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqtrtqr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 09:41:49 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbedbd182f5so793255a12.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 02:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514908; cv=none;
        d=google.com; s=arc-20260327;
        b=G84k0IANEt3+lVb6uC46tIO5cQTOqPTmTlMOn/3ZkIMey1A+ATd+R+ot06OKXvhLlZ
         lOrs/h7C2OzM5T0DJrgJX9zzsYLiKO31OIhQhkUWNQNuWv8J5FQJwUDu5A8GgqHPl8BF
         plZrYzmB4UMAZ4ziO3qmUzjoR/cDyWNFihH7y2kfVQZl1DmEs62baArjdTD/a4K7en/C
         5BkRq38nQJnKz5hsGiIHbyWbooE75nm4+a3Ic0JH8URTnLOqdihnZbNL2oCQBtTR4xi7
         8N+HhiBUmF4CEnK2Dc9ZaF3LmmUIhJ7EuIAfPaWF5wzkov1vkvQCefVkEw8Z3hLxY2Et
         y2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ToSiV1+7MY1z7Ikbo8sLpHqhAbQ0/fiRGaaoDkNbxbs=;
        fh=A6LSWIZ0s2Ln/OmQirM7LpiKGtJBZ4y7bLSe3Ah8dsA=;
        b=Ryre0vo+XEcS/3hPDuvIw8t/F2Z4+vt3pCvL3OBO4gqk+80G0GX2D/QcFNcRulYC9Q
         2gWdvWNw9ovKLKvOTtWcXpDVW2aBw1SPcoZOV2mumE6bNVXPSHnHok9I/ad8h0PFEsNt
         Xw1M7667nGRzNdVBaQQZNYBvtE77YPJh5Wa8t4Ssa/G6xK7F1Srgm5iG826/oizXUtNB
         zTREAFF0Nkxaf08AodutFWt409gSjLI9dA9MbL4DBnihj+vFQlI/OrPFv7UB3PoiGtQm
         t7slYFoE99i/5vgBPrpHzt8Tist1M+ZCC6nl/A5n1pro/W+Ba6O9dTNHy7Ig9BF/aE5L
         il5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788514908; x=1789119708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ToSiV1+7MY1z7Ikbo8sLpHqhAbQ0/fiRGaaoDkNbxbs=;
        b=XdgKwmKJMB8b2KLKvJe5w61F45uLBGHQJW6IB6FhRWN8uVOLPl/4d982Cm3liUp5MU
         Wu5PPBJ25/OLkxvyhhqVgeBIcYq7BfK2C9Xd30RrForSHJv3v65sATkIcnLhLYY0jkrE
         B9ShQ/CsYdhdBEe6zZCwwmKbYTuKkB/zNcsblcg6UvutlzFdhYneRhfdcHFCUy7+yi6c
         PuTyyDTUI4tO0SW3KCHZ38b7j+7iXw6+244hFzUrGDJ1EebQsPAebcKIRkIkuupx5FQE
         bbnBXHIdKkOU1pmbdcVH4vK8JEbz6Q2zJPnTMk7LSuJGgIX47hyKM/f43Ds/8lOLTgVO
         PwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788514908; x=1789119708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ToSiV1+7MY1z7Ikbo8sLpHqhAbQ0/fiRGaaoDkNbxbs=;
        b=pszxtCE49dYD/M+2M91zAr0Tz648B91NaldUnzldbQdNfkdsPhwPi1s4hfHyQcXcAB
         IHUW7eQaG/qpYYvsAq4oxSw0oHTjFvBvvdf7NctRSwnvKH5wqxh3NU7nLkdxwXbMnSdX
         v/P7PthGUW8FN5KCstosGxWOJYhcMvywudeoZChgE46yKdWOKndDYgjTQDqjpauMoR7C
         fK4p3bgLNav8/D9vfDYwwVp1dDOge2Sy99XhPZjyZaYqDcVbWxyEPdHVkmXczpRwHj8L
         ChnCzzw10giwjYCaNUkItwASVQzvqphu6qvArz7rD1p9TGRtRWfavqGki+mG3e0iyaNL
         T98A==
X-Forwarded-Encrypted: i=1; AKwUvBzSIJiUJWMtU20EYXgm8JSoedK8AyFcNj0034U6yanlFcxhK/JAvgFurMm4jQ+3G0pRr7Qxi5anvLc=@vger.kernel.org
X-Gm-Message-State: AFuF++mnFfNytCuUolyW4iBlmUYKwYvg+TLVc1o+a0dBdw2jL68UeiBK
	DicJaGiabLKyPhzGCU2lS058SFGvEjkcn0kbocLn0xZrwvGeqoR6zI4o7E2ZWLrlT9NBhrWMtEj
	DrGIsN8I9IABnoolSka7XkmhBDdO+1ebboNV7WDNswUGKwinUjAEJLKiM+Gt9K380egYzTdQ2J/
	fMiJpwjUiqz3aoOo7XCrTKhyqvkvIw1erK3IXabA==
X-Gm-Gg: AYBFou1if2aDNcE1fbUUsHRgg6ry25XYpEAjAStutoUMO3Co1i1+izNWCB6NeziJ6Rn
	CacWrqclVTLUAjDVwc5mlz9TESUgb4YGuVNSLY5pLTlMETAyO/7Q1VJHRzNKR6QikWSdLSzRVSd
	3LMAbnKOHS7Bz7P4fsoQRaVBo83pmX1VbO2uYRQdN7WzIBinrubOM6e6DhSg==
X-Received: by 2002:a05:6a21:3292:b0:3d3:aed2:6f20 with SMTP id adf61e73a8af0-3da216016b2mr11449363637.20.1788514908011;
        Fri, 04 Sep 2026 02:41:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:3292:b0:3d3:aed2:6f20 with SMTP id
 adf61e73a8af0-3da216016b2mr11449326637.20.1788514907606; Fri, 04 Sep 2026
 02:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807032654.4744-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260807032654.4744-1-fanwu01@zju.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:41:36 +0200
X-Gm-Features: AcwNN1XHSJTzWjsBXzcbHP-mMf0ZbkIiNc8q1-QyzFYKHrlJIK9-0ga-DRScoJs
Message-ID: <CAPx+jO-y_QmwAefsqKe9rTebyxcXPV=KidDKiFOXgsykksja-A@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxcmmc: cancel data work and watchdog on remove
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a9a925d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=_goTqDE6Cbb-XUK3vmYA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: v2U0gHc2aFnPE9fuP_oueerKgR0g7zMW
X-Proofpoint-GUID: v2U0gHc2aFnPE9fuP_oueerKgR0g7zMW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX+T6ctwot7D9B
 ogJJOEkax4Ypm2a4jIwhsfaZe+CZArUl45qm5oycpdMmAI52sYpf6KkxGlWgZQheJt3/xD/CfrH
 NgPab+yfhZPfaE4h+vBlnxHejpHC7uU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4OCBTYWx0ZWRfX6+0y+8uEl/86
 Ygkv0RuGX4xtMkx8j0zcUn+EDilvc0pXIuBGDdL5FwSf4HKDTfvZRo3RiOQoQ8xA2Bc7s9atd5S
 au5MkEdzDq8YNoW5WDxumQnz0bIEt0ZqM/qc4NugzfWe3kZDoDm4g3hQEDCce9RW4k/Ntvs9Yls
 rnQKpNjlzvX94kO1Ql5zEuf2mY081X95X7vU2YpwIUJ7lgNiaoifUKtglznUFFWKX2ctIeo/1nn
 VuMZYuD1dwsSqpVp9vg6nCtZ7aodoxsj4GzU1Du1nC6mF6SmD8a2TRToDHjbWEk5/SQDJH88fEU
 wDq0nDtYFekX1Cr22ZlRNeh2jaSln/hNnQ9PJW7Y8V4/fqRQjxJfc3OO9XAJaXZd2iaOXfdS7PW
 qlfrZR5iWfcHl5+MCmfvq7PEOce+QyXFjx5MV9BHVIb7n2q0g0j0HvCrNd/3V1YksM3WDRCdnm4
 U4+Y9dU+iCv6cIPSE1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040088

On Fri, Aug 7, 2026 at 5:26=E2=80=AFAM Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> mxcmci_remove() frees the host through the devm tail, but neither it nor
> mmc_remove_host() drains the driver's own asynchronous state.
> host->watchdog, a 10 s timer armed on the DMA path in mxcmci_setup_data()=
,
> is deleted only by the DMA- and IRQ-complete paths, which the remove path
> does not explicitly drain; it can therefore fire after the host is freed
> and dereference it in mxcmci_watchdog().  host->datawork, armed from the
> IRQ handler on the PIO path, is not cancelled by the remove path either.
>
> Free the devm-registered IRQ, then cancel datawork and delete the watchdo=
g
> in mxcmci_remove(), before dma_release_channel().  Freeing the IRQ first
> keeps a trailing handler from re-arming datawork between the cancel and
> the host free.  Both callbacks are non-self-rearming.
>
> This issue was found by an in-house static analysis tool.
>
> Fixes: f6ad0a481342 ("mmc: mxcmmc: fix bug that may block a data transfer=
 forever")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxcmmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index c405cfb8b269..097498a3f8ff 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1173,6 +1173,10 @@ static void mxcmci_remove(struct platform_device *=
pdev)
>
>         mmc_remove_host(mmc);
>
> +       devm_free_irq(&pdev->dev, platform_get_irq(pdev, 0), host);
> +       cancel_work_sync(&host->datawork);
> +       timer_delete_sync(&host->watchdog);
> +
>         if (host->pdata && host->pdata->exit)
>                 host->pdata->exit(&pdev->dev, mmc);
>
> --
> 2.34.1
