Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C87CC28D13
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Aug 2022 07:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiHVHEd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Aug 2022 03:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiHVHEc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2022 03:04:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99079BE11
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2022 00:04:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oQ1T7-0002ow-Hs; Mon, 22 Aug 2022 09:03:29 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oQ1T1-001Flh-DM; Mon, 22 Aug 2022 09:03:23 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oQ1T0-0002CG-NV; Mon, 22 Aug 2022 09:03:22 +0200
Message-ID: <e4f16bcd11db29869c08f920d2bd9480fcdc076d.camel@pengutronix.de>
Subject: Re: [PATCH v6 17/17] mmc: sdhci-cadence: Support mmc hardware reset
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Date:   Mon, 22 Aug 2022 09:03:22 +0200
In-Reply-To: <20220820195750.70861-18-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
         <20220820195750.70861-18-brad@pensando.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Brad,

On Sa, 2022-08-20 at 12:57 -0700, Brad Larson wrote:
[...]
> +static void sdhci_mmc_hw_reset(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +
> +	dev_info(mmc_dev(host->mmc), "emmc hardware reset\n");
> +
> +	reset_control_assert(priv->rst_hw);
> +	/* For eMMC, minimum is 1us but give it 9us for good measure */
> +	udelay(9);

At a glance, this seems excessive. Is there a reason 9 us is better
than, say, 2 or 3?

[...]
> @@ -520,6 +538,17 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free;
>  
> 
> 
> 
> +	if (host->mmc->caps & MMC_CAP_HW_RESET) {
> +		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, "hw");

This should be described in cdns,sdhci.yaml first.

regards
Philipp
