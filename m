From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/8] mmc: sdhci: host: add new f_sdh30
Date: Wed, 16 Jul 2014 12:10:07 +0200
Message-ID: <5526913.sJ4RMkanr6@wuerfel>
References: <1405232971-4607-1-git-send-email-mollie.wu@linaro.org> <7710458.qT0KZ5qsA6@wuerfel> <830AC58E49A426478AC39824BC0FA915D8B8FF0609@fmpitwmsex01.fmpi.sea.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:57736 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbaGPKK4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jul 2014 06:10:56 -0400
In-Reply-To: <830AC58E49A426478AC39824BC0FA915D8B8FF0609@fmpitwmsex01.fmpi.sea.css.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Vincent. Yang" <Vincent.Yang@tw.fujitsu.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mollie Wu <mollie.wu@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "anton@enomsg.org" <anton@enomsg.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>, "patches@linaro.org" <patches@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "andy.green@linaro.org" <andy.green@linaro.org>, "olof@lixom.net" <olof@lixom.net>

On Wednesday 16 July 2014 17:35:41 Vincent. Yang wrote:

> >
> >> +unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
> >> +{
> >> +     return F_SDH30_MIN_CLOCK;
> >> +}
> >> +
> >> +void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
> >> +{
> >> +     struct f_sdhost_priv *priv = sdhci_priv(host);
> >> +
> >> +     if (gpio_is_valid(priv->gpio_select_1v8))
> >> +             gpio_direction_output(priv->gpio_select_1v8, 1);
> >> +
> >> +     if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0) {
> >> +             sdhci_writew(host, 0xBC01, SDHCI_CLOCK_CONTROL);
> >> +             mmiowb();
> >> +     }
> >
> >Can you explain the mmiowb call here?
> 
> This came from the original 3.0 based driver. It's trying to be a
> write memory barrier. It wants to ensure the clock control change
> actually happened before the following code.
> I'll change it to a regular wmb in next version.

Note that with 'readw'/writew', you shouldn't need any extra barriers.
If sdhci_writew() is readw_relaxed(), wmb() is the correct barrier.

> >> +
> >> +     if (!of_property_read_u32(pdev->dev.of_node, "bus-width", &bus_width))
> >{
> >> +             switch (bus_width) {
> >> +             case 8:
> >> +                     dev_info(dev, "Applying 8 bit bus width\n");
> >> +                     host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> >> +                     break;
> >> +             case 4:
> >> +                     dev_info(dev, "Applying 4 bit bus width\n");
> >> +                     host->mmc->caps |= MMC_CAP_4_BIT_DATA;
> >> +                     break;
> >> +             case 1:
> >> +             default:
> >> +                     dev_err(dev, "Invalid bus width: %u\n", bus_width);
> >> +                     break;
> >> +             }
> >> +     }
> >
> >This should probably be done in generic sdhci code somewhere. How about
> >adding it to sdhci_get_of_property instead_
> 
> I should use generic mmc_of_parse for it. I'll update it in next version.

Ah right, I thought we had this in common code already but couldn't find
it. Using mmc_of_parse() is definitely the correct solution here.

> >> +     priv->clk_sd4 = clk_get(&pdev->dev, "sd_sd4clk");
> >> +     if (!IS_ERR(priv->clk_sd4)) {
> >> +             ret = clk_prepare_enable(priv->clk_sd4);
> >> +             if (ret < 0) {
> >> +                     dev_err(dev, "Failed to enable sd4 clock: %d\n", ret);
> >> +                     goto err_clk1;
> >> +             }
> >> +     }
> >> +     priv->clk_b = clk_get(&pdev->dev, "sd_bclk");
> >> +     if (!IS_ERR(priv->clk_b)) {
> >> +             ret = clk_prepare_enable(priv->clk_b);
> >> +             if (ret < 0) {
> >> +                     dev_err(dev, "Failed to enable clk_b clock: %d\n", ret);
> >> +                     goto err_clk2;
> >> +             }
> >> +     }
> >
> >Please pick clock names that match what some of the other drivers use.
> 
> I'll use "iface" and "core" for clock names because they match what used
> in sdhci-msm driver.

Ok, makes sense.

	Arnd
