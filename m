Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29781C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Nov 2022 20:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiKUUaZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Nov 2022 15:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiKUUaY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2022 15:30:24 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF16BD9B83
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2022 12:30:22 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w4so2846353plp.1
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2022 12:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bVM0v+ZFbdkWhjhw4PzQwqlX47LAOvDtZXVF1AVAArY=;
        b=Eoh1SHXL+0H75nrcsEodOMLd8r3CWwx8Q2Eqg7xQbCP1n8nPg0+9Dhi37dOTuNrvn6
         S3v21tgeWEG5GEn2Y8Z2GNYXaSyBC/ZR7pSRMKVbe9BziKyM2K9lVpiEcJk/l8teH6fA
         QMMQDnG7gts+LF0zT2ieNU3IFBeoPgjsGIIxskqXcfBWelITS6dq1OUxe2eZkmWEvI94
         ekW5AUALCEwQ52gzQjS8+dr/tQ3XRW57RA/SoLdxz8MAs3HoKaRGxDqoQyLsksCzzt47
         Qb1xXgZmoTycJpBM7OjdGGtvnTBy2OcgrDes24cOPqrfUxo8sirsw0+F632PNDy0EtLF
         AFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVM0v+ZFbdkWhjhw4PzQwqlX47LAOvDtZXVF1AVAArY=;
        b=uxMq8IXxvUX65r06x3T3RgXEsX2H3uz0eGT1MdmkEZyC8pom//r8fz3Y3dFOIMXruz
         wZeMALoKZZfdoo5y0CDshjQghucAVK+WDwvuX30rzUW+bmnpmVrIo2BltAH4TXx7AHVl
         fDClq2jDqCHvJ7jL0rdudqFRc9rBiT8X9kmP9sGi0FKc1GWE+uavinfOKzZf4lTFqZ2V
         vywl7O8QuIagPkwi0xh7ezd5yrLiOSKIjkxmWzblHLnRV3W1CTzTWtzVuJNEiwxcw4M1
         cJ4Vaf93m+PYhh28m15b+NbqyF/oX1J1m/Lya4LsFShPrQVgBXYZoxLddS7v+YdIidvE
         zI2w==
X-Gm-Message-State: ANoB5pkNOIc6mMZeItkKgW4rhIdloPGOQ2T9AHWrYJnjGqT8GMzhaUx6
        KjV+kKk5Vq5VPm7slvi0reF1ItiDW9/+DYSAaI7jte22DjE=
X-Google-Smtp-Source: AA0mqf6emf+E8mMghsw0Aw+34DpaCVWFW2+16u715LqUKCloumBqMoO9llCSFVmc8koRshuoYv13gS/fI8yn4LjjuJI=
X-Received: by 2002:a17:90a:7804:b0:211:2d90:321 with SMTP id
 w4-20020a17090a780400b002112d900321mr28237888pjk.84.1669062622330; Mon, 21
 Nov 2022 12:30:22 -0800 (PST)
MIME-Version: 1.0
References: <DB7PR04MB4010BC0CBF94753397A8EB9A900A9@DB7PR04MB4010.eurprd04.prod.outlook.com>
 <20221121105721.1903878-1-sebastian.falbesoner@gmail.com>
In-Reply-To: <20221121105721.1903878-1-sebastian.falbesoner@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Nov 2022 21:29:46 +0100
Message-ID: <CAPDyKFouG3m3BOOa1hQJbT1GcZ_Xu9Zb=YmpoT3Xb08qBmeXgw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: correct CQHCI exit halt state check
To:     Sebastian Falbesoner <sebastian.falbesoner@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 21 Nov 2022 at 11:57, Sebastian Falbesoner
<sebastian.falbesoner@gmail.com> wrote:
>
> With the current logic the "failed to exit halt state" error would be
> shown even if any other bit than CQHCI_HALT was set in the CQHCI_CTL
> register, since the right hand side is always true. Fix this by using
> the correct operator (bit-wise instead of logical AND) to only check for
> the halt bit flag, which was obviously intended here.
>
> Fixes: 85236d2be844 ("mmc: sdhci-esdhc-imx: clear the HALT bit when enable CQE")
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Sebastian Falbesoner <sebastian.falbesoner@gmail.com>

Applied for fixes, by adding Haibo's ack and a stable tag, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - added fix tag and ack from Adrian Hunter
>
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 31ea0a2fce35..ffeb5759830f 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1512,7 +1512,7 @@ static void esdhc_cqe_enable(struct mmc_host *mmc)
>          * system resume back.
>          */
>         cqhci_writel(cq_host, 0, CQHCI_CTL);
> -       if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT)
> +       if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
>                 dev_err(mmc_dev(host->mmc),
>                         "failed to exit halt state when enable CQE\n");
>
> --
> 2.34.1
>
