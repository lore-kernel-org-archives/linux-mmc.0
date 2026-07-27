Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4463612EC
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169516; cv=pass; b=sNdI0e4vABCKod4T/OEttd2hJbPhZZu9HBwgsXJW5uT/+vJZPC6EvAdlqN9mW+1dswZl63Y4mVBUawFsP6l6uH3f6zplkoDGpgg/P0WQkTxkEl97QxsLLzGj8DWFUsNL6xFpRHaxJA/buMi8NhsY3FwCMHj+1Nx+oyBf2DEtCG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169516; c=relaxed/simple;
	bh=4uzvo+bFYxakkdeclpr3u49Wg5tNvIr0lCX6tf7orSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taxhLv9PkI4QdbSIGbwKhJbX9DS0iSvINGkEaYxfsIzpvsuAyfQIWgdNJ9E0i90EN2K8qNEAIhu7GOrAGovUbqObQ2Yu38bXzK4/tIFPpnYR0JNUh+7RlIAIu6PBJumxvgfn1sqTpP2VxZc1Rz+DBdsDYf0id3n0ZakUafrmnWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dA3/8qQb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XxOMt0NE; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dA3/8qQb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XxOMt0NE"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlsUW3787481
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8UmwPFdZqcBS6XeoAjDE7OzL4Jwi9egEhXg4C5h1XHw=; b=dA3/8qQbFZLPYKV4
	upzFD2CZL4QFwUTRDk5NnQdoSIXJ0GRZNNwBZXfu+SV6AhH4jQlDU6LDAzopRZXg
	lWSCNGpe2bjfcddxCHD5ktK+UA8KEy1B140DRTj0ousdcYSnhnAN0JjwtQ/kPo9L
	CLr0xZ8+3vKM6/5athIjm96UQ7rye7M0EqxkiXhQqayAidtElubN7SatsMklwlRK
	oZl4n5O1dVr5z0ZnbyLx+LJLOZ40MuCibFiGzAQTY2hGtZnN2Y/KMa4aYqto8Yxr
	G2SilhxAOf/Y8Ijh2ggksqgz977uHruA6lQkLAhRQg8oEhIIRFk5Gb2b9uNsFbn4
	XffEGQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2hxgq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:25:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92ef31cd429so294633585a.3
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 09:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169512; cv=none;
        d=google.com; s=arc-20260327;
        b=k13/y00YwPYADKS13ZsnJqD2tNWPMFglbfXsbipp0ncoPQV1Idwbgu9O7BR2jUA1Ey
         lWA+23eBHQaTkGZL+nMeS+eovImaZS58hHXe6TKBvbNu+cgGg94beublSkBgMboJt2px
         7NRxnEAmtakA05SuRsLJ49+Hz2wc0yHMxojLFXNYoC4mOpAOf2I+8BeH4yDvIgwZAhRe
         NUWziAQlWAU33nvjVMqxYONSpRZNO5SbP/ePtYWxFCmk4QatwfMPs1doO5nBL0btYRBy
         ZPOdhcryrjKKyqmUr4r2CyXyBDUa/VJNNq1DvvYCvG6f0SK1dHLHfMSVtLLKDvYhkN5Q
         Qh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8UmwPFdZqcBS6XeoAjDE7OzL4Jwi9egEhXg4C5h1XHw=;
        fh=EB6ULqvQ6kOewyVZt/2Adt/j6dWlLBbjhVsfFnlNJ4M=;
        b=P5mKMvSNZ1Ulh8kJUz56MYGwqNWqFuBRQcVztliMXrGGcM7UeGSOFPi0m2mzYQmxcn
         HuXWUlPUo4VoMiAQfWKAUHUsVsffhmimFkKTVFIGuMi/EIzn99TWnxwNKmKYwDClo4zn
         5l1+HnnUb17qTjZJOkXfb+N7CFHLJJyokx7sazlgFxFiwRQ+SL/10P19CJBPcts3xzTV
         Mf4ajs7FKP+Y781u4cYu8f7slITTrZ6+SmvZgYKob3/diPNQhlT9Nzcj1tLABN6JE49R
         SKjF+IHlHUkPOFZju61hnV04NQryax9prOuia7nZXwb1UU+CBYnC7qpDZR3MkwTVnNW2
         +Kig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785169512; x=1785774312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8UmwPFdZqcBS6XeoAjDE7OzL4Jwi9egEhXg4C5h1XHw=;
        b=XxOMt0NELMTlK8Wzac0IRu0mwrAF72RrMWs0G28g9anReSAfBMDdOUgkClBI8xDqct
         SfvRyr5bRgfYpImEuvX7QAwciRhovWWLJuLsp7hlebdtRb+pHG4A7sXAck5M3FZZ/Aag
         DSSYpiGOAVh9CDs7LICQEXjHKMQLoHNdw/OlyqpvLmJT99gR2KEOICDVPDTEgIJfnDCT
         QroeQebgZCUS6Q9S0G8y9CWHth73JwuXCY+y1g2to+AXPbqHq4pTBMC3WBj3HqvJilOL
         8CDHseAepcD+lNJhHBeyMJkfLB/aChghaEZ3QDoB8QjEy25N0/D5XeVd7FBtUvgRJtsu
         A5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169512; x=1785774312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8UmwPFdZqcBS6XeoAjDE7OzL4Jwi9egEhXg4C5h1XHw=;
        b=KBL57oX2q6IPFWTRD9P1ANiTxKarX9rF1jHdR5q+ZhR9l8U6I6GIm5uZzAIqY+hrnI
         lN3g9xIM2Y+oF+Nr+M/4OQokOdKH5LH5NLrM9BrjikofjFr/NVidJl3gbHXX3RoGh+oQ
         gGbtWXzosTHItDpPhpqWwg5Iq/tIFSc2D9qHgm/lkjc7Sf9dZSrN+O2fDQ04C6HvSeO0
         SeL+21sRMbpALQxRdD4LmZWfZnWrsmVljKHD3MbZplcK/Bw481lef/nha6F2fihRmfgH
         Pr5+9qFfTEM1VQmWMa97NHrcEtjmu6VNiBdnboIlkdgpTwOfXG4633apOMx0NCR5BO90
         fYTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rot3xI9ASKg3dMBV5dMUQN34o5aOVWUq2R4Ovz5XdojxS31FDDf65MYZNpAD68kfnfh+jJKoGfppSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbMg7x+cE91g8UwvYDPF0/svYmM2Y4XHHoyH4m+R4I6SyqDjkz
	NVGSAezm560gPfJonP+lqxe4ram1EZzG5nF9y6Y/GiSQeqC+Sze6XAbpVsGWNisJ2XiWfTwIyLq
	NDyynTJlO4S/MGP1pZaq9Jqby0x+fFg76+MqLPwwaMNj7CMU/xdkG3QkshOIsLfaSUuc6NqbI7y
	alCecs0pHF22dVZc5m1oBfAeAMT+JSR5HYyKs/XQ==
X-Gm-Gg: AR+sD10up46VZZYL2GPBUOkS3VMUDY1LyWTL39UeznvS+CsetU/X3QZhiVhqsIicwfL
	whlXuiQEYq1s3lsCtcFelfHJnI0fwfMmxvUndpPPUCc0Lmhs7BCLjXyWvXFcpYvnTYFAxAmMg4g
	Ol6i62Jbnr6+IWZNyDzUcJPKvmR3Sfr/EBnHlTu+jk9U2flfH6SCC+rse8uA==
X-Received: by 2002:a05:620a:630f:10b0:92e:70e9:6865 with SMTP id af79cd13be357-932df6f5721mr719208885a.59.1785169511739;
        Mon, 27 Jul 2026 09:25:11 -0700 (PDT)
X-Received: by 2002:a05:620a:630f:10b0:92e:70e9:6865 with SMTP id
 af79cd13be357-932df6f5721mr719204585a.59.1785169511268; Mon, 27 Jul 2026
 09:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717101508.635969-1-panchuang@vivo.com>
In-Reply-To: <20260717101508.635969-1-panchuang@vivo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 18:25:00 +0200
X-Gm-Features: AUfX_mypfPWM-amzHbSs1D-8MroCYJxvNGLX8PscRYAazVsoNMy_QxZjvylnM7A
Message-ID: <CAPx+jO_fcijCoA0UEPS359EZKgzEtjP3EYKt48r7ryOz6RT12A@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: Remove redundant dev_err()/dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Robert Richter <rric@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Thomas Fourier <fourier.thomas@gmail.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>,
        "open list:OMAP HS MMC SUPPORT" <linux-omap@vger.kernel.org>,
        "moderated list:ARM/ACTIONS SEMI ARCHITECTURE" <linux-actions@lists.infradead.org>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfX0clgrVJFFCaK
 HGcmwK4YxxCaz8PLG1k25L3v2h3KXhJocHIA7KTnLbkZUiOngugAwXTQmOFEP0cr3KUV2FKMBAk
 jPIOwWuX036k9D4lkuXUOxMNR/e+TDE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MiBTYWx0ZWRfXxIVP8Q+N3eXh
 f/QEnIPA+KkHmO5y8onkXqQUI94YzA8h5K+7//R0PmRKoqqrlF77ybpdeETb1sqJOzUT8/5ZDOw
 vnc01T5mEHLkM5f/5ckGNRtRJVkvf4Sh2N+zqMkhAJUBFvobwMoJf4GgYTai7H/YcLpMJJGaOVh
 0yKse1h5Kd/qhwmarJnNs5Uyb9TGs1snke1OcToHbaO712sZT01QWTU+KxioUkimpcb6v5Qm6dC
 AoEL2rhOkH3AGy0YrCSRA6S+n7gN30d8xLvZ6YSmRODlXJX9hLkT70bcxg/3NY7icemA3DRpvjo
 NeLp0b4cBWHqYkg0ynlS1vLjNdVUKPkVXiN8v8ns/6oHOGxtoZPaQJp6OGeP6EJ8kBhqaH5WLE/
 42XhTr06ZKXKrnrc2VkcXj6g9vS+PNBv++a/4ySQlKkUu6NGYbgW71ghn6FYq094SXrJWyZzSGR
 FqoTKIWrb/s/Q3cYDSw==
X-Proofpoint-GUID: 0MW6i4vkqRFsGIRz_ljDur7QDhUN7A4a
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a678668 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=1WtWmnkvAAAA:8 a=TYD399XWoFAa3X5oXMIA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 0MW6i4vkqRFsGIRz_ljDur7QDhUN7A4a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270152

On Fri, Jul 17, 2026 at 12:17=E2=80=AFPM Pan Chuang <panchuang@vivo.com> wr=
ote:
>
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq(=
)
> automatically log detailed error messages on failure. Remove the
> now-redundant driver-specific dev_err() and dev_err_probe() calls.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/alcor.c         |  3 +--
>  drivers/mmc/host/cavium-octeon.c | 10 ++--------
>  drivers/mmc/host/meson-mx-sdio.c |  5 +----
>  drivers/mmc/host/mvsdio.c        |  4 +---
>  drivers/mmc/host/omap_hsmmc.c    |  4 +---
>  drivers/mmc/host/owl-mmc.c       |  5 +----
>  drivers/mmc/host/sdhci-msm.c     |  4 +---
>  drivers/mmc/host/sh_mmcif.c      |  8 ++------
>  8 files changed, 10 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
> index 721db54739c1..45528909a758 100644
> --- a/drivers/mmc/host/alcor.c
> +++ b/drivers/mmc/host/alcor.c
> @@ -1103,8 +1103,7 @@ static int alcor_pci_sdmmc_drv_probe(struct platfor=
m_device *pdev)
>                         alcor_irq, alcor_irq_thread, IRQF_SHARED,
>                         DRV_NAME_ALCOR_PCI_SDMMC, host);
>         if (ret)
> -               return dev_err_probe(&pdev->dev, ret,
> -                                    "Failed to get irq for data line\n")=
;
> +               return ret;
>
>         mutex_init(&host->cmd_mutex);
>         INIT_DELAYED_WORK(&host->timeout_work, alcor_timeout_timer);
> diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-o=
cteon.c
> index 8a0daddd9200..1bfc1a4f9fe9 100644
> --- a/drivers/mmc/host/cavium-octeon.c
> +++ b/drivers/mmc/host/cavium-octeon.c
> @@ -240,21 +240,15 @@ static int octeon_mmc_probe(struct platform_device =
*pdev)
>                         ret =3D devm_request_irq(&pdev->dev, mmc_irq[i],
>                                                cvm_mmc_interrupt,
>                                                0, cvm_mmc_irq_names[i], h=
ost);
> -                       if (ret < 0) {
> -                               dev_err(&pdev->dev, "Error: devm_request_=
irq %d\n",
> -                                       mmc_irq[i]);
> +                       if (ret < 0)
>                                 return ret;
> -                       }
>                 }
>         } else {
>                 ret =3D devm_request_irq(&pdev->dev, mmc_irq[0],
>                                        cvm_mmc_interrupt, 0, KBUILD_MODNA=
ME,
>                                        host);
> -               if (ret < 0) {
> -                       dev_err(&pdev->dev, "Error: devm_request_irq %d\n=
",
> -                               mmc_irq[0]);
> +               if (ret < 0)
>                         return ret;
> -               }
>         }
>
>         host->global_pwr_gpiod =3D devm_gpiod_get_optional(&pdev->dev,
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx=
-sdio.c
> index 5921e2cb2180..bef5e843f449 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -683,11 +683,8 @@ static int meson_mx_mmc_probe(struct platform_device=
 *pdev)
>                                         meson_mx_mmc_irq,
>                                         meson_mx_mmc_irq_thread, IRQF_ONE=
SHOT,
>                                         NULL, host);
> -       if (ret) {
> -               dev_err_probe(host->controller_dev, ret,
> -                             "Failed to request IRQ\n");
> +       if (ret)
>                 goto error_unregister_slot_pdev;
> -       }
>
>         core_clk =3D devm_clk_get_enabled(host->controller_dev, "core");
>         if (IS_ERR(core_clk)) {
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index 79df2fa89a3f..cf705b265e21 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -764,10 +764,8 @@ static int mvsd_probe(struct platform_device *pdev)
>         mvsd_power_down(host);
>
>         ret =3D devm_request_irq(&pdev->dev, irq, mvsd_irq, 0, DRIVER_NAM=
E, host);
> -       if (ret) {
> -               dev_err(&pdev->dev, "cannot assign irq %d\n", irq);
> +       if (ret)
>                 goto out;
> -       }
>
>         timer_setup(&host->timer, mvsd_timeout_timer, 0);
>         platform_set_drvdata(pdev, mmc);
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.=
c
> index 58c881f2725b..63a9fb970975 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1915,10 +1915,8 @@ static int omap_hsmmc_probe(struct platform_device=
 *pdev)
>         /* Request IRQ for MMC operations */
>         ret =3D devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0=
,
>                         mmc_hostname(mmc), host);
> -       if (ret) {
> -               dev_err(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ\n")=
;
> +       if (ret)
>                 goto err_irq;
> -       }
>
>         ret =3D omap_hsmmc_reg_get(host);
>         if (ret)
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index 349082d76a99..d5b8a110267b 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -635,11 +635,8 @@ static int owl_mmc_probe(struct platform_device *pde=
v)
>
>         ret =3D devm_request_irq(&pdev->dev, owl_host->irq, owl_irq_handl=
er,
>                                0, dev_name(&pdev->dev), owl_host);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Failed to request irq %d\n",
> -                       owl_host->irq);
> +       if (ret)
>                 goto err_release_channel;
> -       }
>
>         ret =3D mmc_add_host(mmc);
>         if (ret) {
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index ceed47ccfda8..4aff965f0e2e 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2864,10 +2864,8 @@ static int sdhci_msm_probe(struct platform_device =
*pdev)
>         ret =3D devm_request_threaded_irq(&pdev->dev, msm_host->pwr_irq, =
NULL,
>                                         sdhci_msm_pwr_irq, IRQF_ONESHOT,
>                                         dev_name(&pdev->dev), host);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Request IRQ failed (%d)\n", ret);
> +       if (ret)
>                 goto clk_disable;
> -       }
>
>         msm_host->mmc->caps |=3D MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_R=
SP_BUSY;
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 9831956de1c8..7706d01b149e 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1505,18 +1505,14 @@ static int sh_mmcif_probe(struct platform_device =
*pdev)
>         name =3D irq[1] < 0 ? dev_name(dev) : "sh_mmc:error";
>         ret =3D devm_request_threaded_irq(dev, irq[0], sh_mmcif_intr,
>                                         sh_mmcif_irqt, 0, name, host);
> -       if (ret) {
> -               dev_err(dev, "request_irq error (%s)\n", name);
> +       if (ret)
>                 goto err_clk;
> -       }
>         if (irq[1] >=3D 0) {
>                 ret =3D devm_request_threaded_irq(dev, irq[1],
>                                                 sh_mmcif_intr, sh_mmcif_i=
rqt,
>                                                 0, "sh_mmc:int", host);
> -               if (ret) {
> -                       dev_err(dev, "request_irq error (sh_mmc:int)\n");
> +               if (ret)
>                         goto err_clk;
> -               }
>         }
>
>         mutex_init(&host->thread_lock);
> --
> 2.34.1
>
