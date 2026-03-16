Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89B3A4F46
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674177; cv=pass; b=DvtxdERT+a5dJxNjws/3gGnnxYrhZJ3rZQiwpBRERfTTqc6uKzfKK+0Qh9j3dXsJjDX1W4Dv3kxYEmNBom7fnDpaO7H37kq+VWkIx5eI59SoIU3GgZaE34QRIHDLGewQ0wKOJCHk219GF7CpjY6FQS1tt2VXSj5LeCXIfkduRZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674177; c=relaxed/simple;
	bh=anhBm3gdqY3+LNbvg44+Sh4cHy+UdLyAmxTWGOFH/gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYTrdiYMJz5w4C6B3wVTdE4DHFpIOocjtImK3dbMBzRh+aae01JGlEhbe99YadPVE6dOu2hbnbpfBYhME4Uyd/UasuNdqUcLuMHKN565ACUOHNtgTl8axf3Lm6RJA58DH9L1jTSI9QgB9vU2LTmmumQPfaICk6Bb6oALg6agqmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OMUVgUNt; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMUVgUNt"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a107b387a5so6105669e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 08:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773674174; cv=none;
        d=google.com; s=arc-20240605;
        b=IpHcLP2Fgq2CGnEt1zvjLEqdmFaLVfDfucGn2vyl2gmxXNJ0ib2oR3jH7F3yEY0F4x
         gzEuf6fzUHMSBtvmHUR2rUX/aBb1B9GAHGBCVR+b0GClzpa8At2eTHjczOn8ManOqXjG
         Ouf6mD7BsCsh7tIaP5eEY3GtMlyKd+6ChJo5EtW/dHuKrCGHbYJCtuU2FDftwNzx8oYw
         dQvao8RlvYj45ZL35BCfDrPyCJJe/dijp1njfcyOzUjAA/dHrzcvinlMCWtV0amfi1Ce
         E/0YknM1KaF68EuF1l2y7Yt+6QL0jA5oUm6j4SLJ0oYL4gohsNW9Fo7b0Feaofy/qU4Q
         8FOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pRG8t2fwa53hb2NLk5hHr7swK0mnrB3Ou8aFpV71p8Q=;
        fh=ywsUOoPPF3ZxQY2DCj3VTMkwzMlWKQoHSvg9vEliGH0=;
        b=MzK3Fz6Z1vds+QzUBbN3jRP626XjNjOh1ejCX78bzAkWfLZ5WVwoeZdmZupaHFDcPL
         ypt+hinojSYZ65U9tN9mCVc1E+leGz5+dGg76ASq0/bElYv5+ToGmrqNBGAXwgIzV6er
         MZXQLhT5f4sccT8eSc+w7YU/EHpfubH1W/AYqHKX2p64xqT93m4qF17qaVivWg4o1697
         FFCWE0jTeQ9kYQcNYO0fxRg5vpf0AZcvuH6d/9ToY0zw4jBo7vT3RjvSBZLA6eNDoMqj
         ISDeVBLJoYk0km8mGewC0w+bV0CSIFM81uRtAtyl/oVnuA6ypDi3TtrdoODtppDirFSf
         qG+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773674174; x=1774278974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pRG8t2fwa53hb2NLk5hHr7swK0mnrB3Ou8aFpV71p8Q=;
        b=OMUVgUNtfNZvJvCTB36T08tjyrGFtNQjJFYUcfKdRo3NE2t1AHB9nLo7V4xi0qs8Do
         OrBivGTuzSTmN2gy3zPHcl3TFTBJP3qvC95WYYe/IOYbGE0FhMP6N0unjTJYRlPtyZe7
         8Q1SIV9V4pbFv0oE26HVc+WimcUtldaV4yaRKu2oAoK6qFqPpUAPXbT8Avvz/51lFItH
         COkRVENgZrhr3qhnRKtMXjUNLQOvoko+V7BaZgFqeBDGnAL0puYlF/zZ/2tAXrwodNPR
         py0nLdqN8Gbc7slmPUjQ4sD1HMpx4aV+rMra+T2iQycBBUKYqWjo3TqCym/HnVO4s62r
         3liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674174; x=1774278974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRG8t2fwa53hb2NLk5hHr7swK0mnrB3Ou8aFpV71p8Q=;
        b=UQA+X6c9pP0SgFl7erjHjGmpqvBH85aoxjtFQk5r0DgWy9hqsZKwTFobzJKybc4cVd
         SWAlm4F4YSp/1IFBGvjZ3zcSNGYK4NOF7A2KaHjEyzNgd6gEuORF8oF+P8ml4FT1rlt4
         t7sTX9ixp8+bclM0La3fTFfXvwAjsZ9HXAnrfV8mWTRi9UfJT05Eos6/ZhO9GMdN01Tj
         U0Ehqq5Yjy1fNCdamp7oIllPEC5sMXxE613ulH1i18yoz3jRqOFCTEkdeRTr3cyWjJXD
         FvLuQCpeCbIUC5BAk6MbPynoIUeDZ8IJSKt8E3kJzsbxyT1HKmY+PXKJSOpzHDyOuz6f
         xSuw==
X-Forwarded-Encrypted: i=1; AJvYcCWvaJl7vFoeuRoi4fayecGnMDYBUv7cwNQScFvfnBsu4A+Vj2Xt70B0Imvr4Hvm0CqtB/3oAywKSH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydBzyl5Yh0VbtP7flwA0BcROeYiGMiyZycZA5q8CD4PCPGKDKa
	b1XYgVZyvmOz92XOZUG6JD2HdSXJYY/zr2O02g05a654VTPunpLQ/uSREviscFVf0IPZ2axUG4j
	Uo3fDg6CtOdqT0xL1MAqpas1a1DO3G2w2gIfUQNUVoA==
X-Gm-Gg: ATEYQzyGtkRdtUFUx+Som4TGOWsOV52hZ89LKMdMqZNhNZaURzREFtd7d+asVsUun9i
	VQckfI3V/fdtmH+y/OesTBo77+xSpVe2sgKXKhaZ0Ca4ugRcQqAzgsSkXEQHI0ux5+DISvUqFNC
	LBbieY/YpaZ7Nf+x3nkBs91axjb1bTA6cfwdaQkCkut8i8bxCwKhDyLphL1hEy2tFXZIWohQL9e
	s9f+XlpRAQ619qYaISj+2RuCBkK0/7KhVcAQlFseGFBUuWDsijP1TTqwPrZhJPpivXmCW4yWS5e
	8RsOAdug
X-Received: by 2002:a05:6512:3d28:b0:5a1:18ad:b55a with SMTP id
 2adb3069b0e04-5a162b14fedmr4185167e87.40.1773674174186; Mon, 16 Mar 2026
 08:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311095009.1254556-1-ziniu.wang_1@nxp.com> <20260311095009.1254556-4-ziniu.wang_1@nxp.com>
In-Reply-To: <20260311095009.1254556-4-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 16 Mar 2026 16:15:37 +0100
X-Gm-Features: AaiRm52ArtuP-ygMvRxB8MkKlR8r_NeTZwYYmgYJ41n5nYfFvCkoTG5n4kfwkpY
Message-ID: <CAPDyKFraNEd9UG8QO5PEGkgRxS_43Szt+2vwXtqAP2CBjYSCpw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mmc: sdhci-esdhc-imx: remove duplicate HS400 bus
 width validation
To: ziniu.wang_1@nxp.com
Cc: adrian.hunter@intel.com, haibo.chen@nxp.com, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	imx@lists.linux.dev, linux-mmc@vger.kernel.org, s32@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 10:48, <ziniu.wang_1@nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> mmc_validate_host_caps() already validates that HS400/HS400ES requires
> 8-bit bus width. Remove the duplicate validation.
>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index b607d4ffc562..d49069986efc 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1833,10 +1833,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>
>         sdhci_get_property(pdev);
>
> -       /* HS400/HS400ES require 8 bit bus */
> -       if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
> -               host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
> -
>         if (mmc_gpio_get_cd(host->mmc) >= 0)
>                 host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>
> --
> 2.34.1
>
