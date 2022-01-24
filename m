Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE46FC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Jan 2022 14:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiAXOl4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Jan 2022 09:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbiAXOlz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2022 09:41:55 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B73C061744
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jan 2022 06:41:54 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bu18so49967481lfb.5
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jan 2022 06:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZbvOPh0/0dWbRnDZOEAQomVipOBDWGGfczoZ2UW+iM=;
        b=LiGD1toO/LRPZDHp4KGkcSQgx1i3QQzKY5uftp4Po6q84BZnFekU+eNgTQl2J2iNbl
         PfXHLC8bUhSv3rrm1pxZCUnCeo3HsketKjTBBO/CX4YssEPZXAEe46RnEWkPQqZFjfu7
         7l1MOot8E6vccP0gHqa9s1eO/vSAdqqN96LuD1aBpCp388QDL7IGzYphFL1GESxEhp+A
         H49aq9XOJJxkNi2FxqDoEdtxSzVN1Jy8mkrmq+8o35KoIB8+2GtgWQdhBtyntoRiwrpn
         Ll8Sde3ixIxLl9dl2BmiNzSA5lyySP7nkuzBiOKa6YzZuEKn2Mkh7vSUV/xFqxMwTyEZ
         9v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZbvOPh0/0dWbRnDZOEAQomVipOBDWGGfczoZ2UW+iM=;
        b=bjSi/6TFgs1Wnp+Vhr+SMshpGSnZWTu3BY2SDsjs7mQGn6fOrcEp9vhsYufkeA43rC
         uLoUk+Z5mFDD2PzXq62XDVqMllUC1Fwu+Adu8MJ0HlY2OCX5Q3xRBhjKGv/lHKcrKSJS
         1uZ5aef7TYNqp/5vbdSDo45cdV5oVpbTm/GL0EBLbe3frTWKCceU2OF2U85aBaaLDxmD
         fD7oqrWLALgK2L7hORelrUV4jmhVsoSpQ2VumXCj8xYKAWJjkLBONR5LsEZTML7PgVYP
         G9GgrN0Hdw2RSNfOYEgRKwIouJpJsh5UoYbIGatddCQp6pGRGEEO1RMOOmeqsef8dXcs
         uOdQ==
X-Gm-Message-State: AOAM5304VcgCrcT1EHE1FejLIAUyKO1wtU30Yg2d6yG88l8Prvdigyfi
        mnTeUbeFtzXxy615+RQgUp9ex8UMTjfrJQGW7tOo+A==
X-Google-Smtp-Source: ABdhPJyj1IZdftQcab/AVm2rxmLvDVzarEL3T1BUfgRMmoyyexfCgCe6gHZBjqElCQU8fhDjSEVWFEO92p2qSIhU7hw=
X-Received: by 2002:a05:6512:10d2:: with SMTP id k18mr13054961lfg.167.1643035313039;
 Mon, 24 Jan 2022 06:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20220119075339.36281-1-benchuanggli@gmail.com>
In-Reply-To: <20220119075339.36281-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Jan 2022 15:41:16 +0100
Message-ID: <CAPDyKFr6CPS6uAnZc_CdCSg2iWGvZXSmoO4+cHTo6eEyfXnQDg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-pci-gli: Enable SSC at 50MHz and 100MHz
 for GL9750 and GL9755
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, greg.tu@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 19 Jan 2022 at 08:53, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Enable SSC function at 50MHz and 100MHz for GL9750 and GL9755.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 36 ++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 9ead32d73447..9de3d91283af 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -394,6 +394,20 @@ static void gl9750_set_ssc_pll_205mhz(struct sdhci_host *host)
>         gl9750_set_pll(host, 0x1, 0x246, 0x0);
>  }
>
> +static void gl9750_set_ssc_pll_100mhz(struct sdhci_host *host)
> +{
> +       /* set pll to 100MHz and enable ssc */
> +       gl9750_set_ssc(host, 0x1, 0xE, 0x51EC);
> +       gl9750_set_pll(host, 0x1, 0x244, 0x1);
> +}
> +
> +static void gl9750_set_ssc_pll_50mhz(struct sdhci_host *host)
> +{
> +       /* set pll to 50MHz and enable ssc */
> +       gl9750_set_ssc(host, 0x1, 0xE, 0x51EC);
> +       gl9750_set_pll(host, 0x1, 0x244, 0x3);
> +}
> +
>  static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct mmc_ios *ios = &host->mmc->ios;
> @@ -411,6 +425,10 @@ static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
>                 host->mmc->actual_clock = 205000000;
>                 gl9750_set_ssc_pll_205mhz(host);
> +       } else if (clock == 100000000) {
> +               gl9750_set_ssc_pll_100mhz(host);
> +       } else if (clock == 50000000) {
> +               gl9750_set_ssc_pll_50mhz(host);
>         }
>
>         sdhci_enable_clk(host, clk);
> @@ -537,6 +555,20 @@ static void gl9755_set_ssc_pll_205mhz(struct pci_dev *pdev)
>         gl9755_set_pll(pdev, 0x1, 0x246, 0x0);
>  }
>
> +static void gl9755_set_ssc_pll_100mhz(struct pci_dev *pdev)
> +{
> +       /* set pll to 100MHz and enable ssc */
> +       gl9755_set_ssc(pdev, 0x1, 0xE, 0x51EC);
> +       gl9755_set_pll(pdev, 0x1, 0x244, 0x1);
> +}
> +
> +static void gl9755_set_ssc_pll_50mhz(struct pci_dev *pdev)
> +{
> +       /* set pll to 50MHz and enable ssc */
> +       gl9755_set_ssc(pdev, 0x1, 0xE, 0x51EC);
> +       gl9755_set_pll(pdev, 0x1, 0x244, 0x3);
> +}
> +
>  static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>         struct sdhci_pci_slot *slot = sdhci_priv(host);
> @@ -557,6 +589,10 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
>                 host->mmc->actual_clock = 205000000;
>                 gl9755_set_ssc_pll_205mhz(pdev);
> +       } else if (clock == 100000000) {
> +               gl9755_set_ssc_pll_100mhz(pdev);
> +       } else if (clock == 50000000) {
> +               gl9755_set_ssc_pll_50mhz(pdev);
>         }
>
>         sdhci_enable_clk(host, clk);
> --
> 2.34.1
>
