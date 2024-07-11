Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A801216C859
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jul 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713370; cv=none; b=cNUKX9cXEI6/1o1QeD+O9JrUrz70zC/l7uIVY1WCftEB8HWvCL5olBiy6FNCj1h1FB93hZGtufvuyzMYNQF0BFJ6c4ge31VsF4nLS8NqQpx6d0c4DPrLFZUEx3PQ+AQRCChnNyoEe5Qt45mhO1Lhfm/OFz9kQ60cvF5D8JaL4sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713370; c=relaxed/simple;
	bh=fK93rdN7UPAjzzNdY9a2W7zpHlmO1W+0cPnbEmcEXTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbdFaCr3CJZbTyJFSs+n8eLjzkaASSzwKviY9sgdQSDACWMA5DSHH9WM7YRpjPRJU2MoQuiyE8AKnIppLZyV9OB84PxQyKCr6AAQ3Gd9CZil5V3gK7FKDmYpct1/QPVyfxHIBY2OHiuq4f9IyDKY1PIcuO+PdpT86dv347Yyk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XNWNLECw; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNWNLECw"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e057bdc936fso986721276.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jul 2024 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720713367; x=1721318167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o9NK8vbwSl6fVYipiYD+K+b1VqL0LZzXwcN17mQG4N4=;
        b=XNWNLECwCeqYN2s8mXpun7H5BoRAbK3P8xAtol1uqw1cP2DWYnc7Vg5cKAxEpyEbn3
         ROwCxaMsYrwpAEO+WJel+fWtNWRlZ259Do37x7xNp+Ba3l4EYfJXlMeQIIzPzdK706kL
         2aCadurOtzdadzyZnK/O74GN4K9zKX0DDX73QPVyJ2WdR9Sm/NyhqrrykeXuGmpIQAcT
         2X1OLou1BCwgpiyGJKqVEAovIGDfJ0ROYOSRRzVMtiapETt0+uSMrHXZuIucDBQSUzuR
         bv4wZJW0kaCfDO2qWGQM6wkrkLhtcbR9wfpGFVyIUDjmn9GSUg2K3UN3RcR9zwGU1Wx3
         qmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713367; x=1721318167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9NK8vbwSl6fVYipiYD+K+b1VqL0LZzXwcN17mQG4N4=;
        b=VEmbwplzRW4I8FQUUAtWq7a7W513bmyO+gNsfn8MkbLumUqtIQI7cn8f0o/HAv2zyB
         vA0JRma1+l6x5CzkgDCfEhzrLBIOuSrHyTUTeio1R5psrlrXtcPHGrIz/aXIIKDhBrGg
         WB9SnQfvIJU/sW6nnsFFv8YDmLb6w+zAQwsgfjwqlwhLgBSbH7FJidkjqD5BNZIRuykL
         TKibkyL6HSat5qlkWaifBH/uwsQ9+woCPRR9v966SL3PT0X3jrSs1QKkCz/u++LbC4kn
         O12mGpW+kMGfZClbnovCvGtg4C5brBNvoYBnXDeYEMEta62GHCTr5KNL/AHlwzANlBhX
         wafg==
X-Forwarded-Encrypted: i=1; AJvYcCWCs3UDFucS/mZJF5anBG1OiiMmEAAW0F6ZW8MkZZiGQP32xa2cdTaWf43wE+rZqkaSF5gsbHDoBAcYzcd5Bcpi2PbPEC7slA6v
X-Gm-Message-State: AOJu0YyR8BRpqvSrrClTbdYStPJJ04gCcs77GOPfLPOTLIldPVDFWVl5
	dviepEb3ZYFmWWGBOUL82suLWz7H+kTaUaO3kpfBPwk+V2tLlkX7t2ymHXxoqhHr/E8kGUiWA4Y
	//pU7a3GE7+vUvXiBVSmFJ4EYxlNHu0bWRg9mSQ==
X-Google-Smtp-Source: AGHT+IFkr/j+VnCO+Vl5QVu0QsqTKrqy4owjYSW/qtao35IwLP4Q3jMZYHSbiM4nmMtUoEAIPyhT561j44bWpNjvOPg=
X-Received: by 2002:a25:868b:0:b0:e03:5dd4:ec1a with SMTP id
 3f1490d57ef6-e041b03c277mr10295295276.4.1720713367555; Thu, 11 Jul 2024
 08:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
 <20240708121018.246476-2-ciprianmarian.costea@oss.nxp.com>
 <6a577d6c-04ad-4c12-bfad-815e811deee3@intel.com> <123ce7e1-1981-4a41-a131-168f4f7b5417@oss.nxp.com>
In-Reply-To: <123ce7e1-1981-4a41-a131-168f4f7b5417@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 17:55:31 +0200
Message-ID: <CAPDyKFoHmvZLogUY=-WXM2G+g1h=fbaakySHCJh7MSaFMYuCXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-esdhc-imx: disable card detect wake for
 S32G based platforms
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, s32@nxp.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 16:26, Ciprian Marian Costea
<ciprianmarian.costea@oss.nxp.com> wrote:
>
> On 7/10/2024 3:34 PM, Adrian Hunter wrote:
> > On 8/07/24 15:10, Ciprian Costea wrote:
> >> In case of S32G based platforms, GPIO CD used for card detect
> >> wake mechanism is not available.
> >>
> >> For this scenario the newly introduced flag
> >> 'ESDHC_FLAG_SKIP_CD_WAKE' is used.
> >>
> >> Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
> >
> > Should have:
> >
> >   - put the patch set version number (v2) in the subject e.g.
> >     [PATCH v2 1/3] mmc: sdhci-esdhc-imx: disable card detect wake for S32G based platforms
> >
> >   - added Haibo Chen's Reviewed-by tag
> >
> > Anyway:
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
>
> Hello Adrian,
>
> Sorry for bothering you with this question, but should I send a new
> patchset adding the new version or what is the process after this step ?
> For example, should I send this patchset again with V3 adding all the
> ACKs & Reviewed-by tags to each commit from the patchset ?

No need to send a new version this time, I can add Haibo's tag when
applying. Although I prefer an ack from him for patch3 before I merge
this.

Kind regards
Uffe

>
> Best Regards,
> Ciprian
>
> >
> >> ---
> >>   drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++++--
> >>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> >> index 40a6e2f8145a..21d984a77be8 100644
> >> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> >> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> >> @@ -201,6 +201,9 @@
> >>   /* ERR004536 is not applicable for the IP  */
> >>   #define ESDHC_FLAG_SKIP_ERR004536  BIT(17)
> >>
> >> +/* The IP does not have GPIO CD wake capabilities */
> >> +#define ESDHC_FLAG_SKIP_CD_WAKE             BIT(18)
> >> +
> >>   enum wp_types {
> >>      ESDHC_WP_NONE,          /* no WP, neither controller nor gpio */
> >>      ESDHC_WP_CONTROLLER,    /* mmc controller internal WP */
> >> @@ -298,7 +301,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
> >>      .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
> >>                      | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> >>                      | ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
> >> -                    | ESDHC_FLAG_SKIP_ERR004536,
> >> +                    | ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
> >>   };
> >>
> >>   static struct esdhc_soc_data usdhc_imx7ulp_data = {
> >> @@ -1726,7 +1729,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
> >>              host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
> >>
> >>              /* GPIO CD can be set as a wakeup source */
> >> -            host->mmc->caps |= MMC_CAP_CD_WAKE;
> >> +            if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_CD_WAKE))
> >> +                    host->mmc->caps |= MMC_CAP_CD_WAKE;
> >>
> >>              if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
> >>                      host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
> >
>
