Return-Path: <SRS0=zEeD=26=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8EFC32771
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 07:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5750A2072A
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 07:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgAIHUQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:20:16 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:11888 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgAIHUQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2020 02:20:16 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ludovic.Desroches@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="Ludovic.Desroches@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ludovic.Desroches@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Ludovic.Desroches@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: XApj5t7O5edYgiMFJDljHPwaCcM4R8PaRAwffEM3P4EXaw94LsjF6t5TZotfFmsNiq5T7+IE2O
 8XlEUEFRYu6UJGa/Ozp9Esj+ba15nJdJjlYKwZr/9m6Lemhern/ig0H8K5nvEvOseBrG25G98B
 AKFM57wimRJ5pQyDFAWtgTagzlHQ1nWzwuo1phtBpeP5rMszw2+LjhJ8A+gZCzMz8dF5+olvy7
 74TjKXydBhwZoqMJwB9v+VloZbP5wiqk1ZuR7oMCpv6DOpGf1/Ii87/SAdXx0iPvTFrpNOspmA
 2w8=
X-IronPort-AV: E=Sophos;i="5.69,413,1571727600"; 
   d="scan'208";a="62068783"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jan 2020 00:20:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 9 Jan 2020 00:20:14 -0700
Received: from localhost (10.10.85.251) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 9 Jan 2020 00:20:13 -0700
Date:   Thu, 9 Jan 2020 08:19:45 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix memleak on clk_get failure
Message-ID: <20200109071945.6iabyp5ohevztene@M43218.corp.atmel.com>
Mail-Followup-To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
References: <b2a44d5be2e06ff075f32477e466598bb0f07b36.1577961679.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2a44d5be2e06ff075f32477e466598bb0f07b36.1577961679.git.mirq-linux@rere.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 02, 2020 at 11:42:16AM +0100, Michał Mirosław wrote:
> sdhci_alloc_host() does its work not using managed infrastructure, so
> needs explicit free on error path. Add it where needed.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index b2a8c45c9c23..ab2bd314a390 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -345,20 +345,23 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>                         priv->mainck = NULL;
>                 } else {
>                         dev_err(&pdev->dev, "failed to get baseclk\n");
> -                       return PTR_ERR(priv->mainck);
> +                       ret = PTR_ERR(priv->mainck);
> +                       goto sdhci_pltfm_free;
>                 }
>         }
> 
>         priv->hclock = devm_clk_get(&pdev->dev, "hclock");
>         if (IS_ERR(priv->hclock)) {
>                 dev_err(&pdev->dev, "failed to get hclock\n");
> -               return PTR_ERR(priv->hclock);
> +               ret = PTR_ERR(priv->hclock);
> +               goto sdhci_pltfm_free;
>         }
> 
>         priv->gck = devm_clk_get(&pdev->dev, "multclk");
>         if (IS_ERR(priv->gck)) {
>                 dev_err(&pdev->dev, "failed to get multclk\n");
> -               return PTR_ERR(priv->gck);
> +               ret = PTR_ERR(priv->gck);
> +               goto sdhci_pltfm_free;
>         }
> 
>         ret = sdhci_at91_set_clks_presets(&pdev->dev);
> --
> 2.20.1
> 
