From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH 4/8] mmc: sdhci-pxav3: enable proper resuming on Armada
 38x SoC
Date: Fri, 9 Oct 2015 11:48:34 +0200
Message-ID: <CAPv3WKfB=5Xz+f=BMiPTD1EYZifX41g0BK0kwX5rNFjG3PQ3ig@mail.gmail.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
	<1444094562-31165-5-git-send-email-mw@semihalf.com>
	<20151009090902.3b5b9bc8@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:32786 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756990AbbJIJsf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Oct 2015 05:48:35 -0400
Received: by oiar126 with SMTP id r126so1822117oia.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Oct 2015 02:48:35 -0700 (PDT)
In-Reply-To: <20151009090902.3b5b9bc8@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>, nadavh@marvell.com, Lior Amsalem <alior@marvell.com>, =?UTF-8?Q?Gregory_Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi Jisheng,


>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mbus");
>> +     pxa->mbus_win_regs = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(pxa->mbus_win_regs)) {
>> +             dev_err(mmc_dev(host->mmc),
>> +                     "failed to obtain MBus windows register base\n");
>
> devm_ioremap_resource() has warned us if it fails, so is it better to remove
> this dev_err() here?
>

Indeed, I'll remove this excessive verbosity.

>>       struct sdhci_host *host = dev_get_drvdata(dev);
>> +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +     struct sdhci_pxa *pxa = pltfm_host->priv;
>> +     struct device_node *np = dev->of_node;
>> +
>> +     if (of_device_is_compatible(np, "marvell,armada-380-sdhci"))
>
> this would increase resume time especially those non armada-380-sdhci host
> although it's trivial. Is it better to check "if (pxa->mbus_win_regs)"?
>

Already implemented in v2.

Thanks for the comments,
Marcin
