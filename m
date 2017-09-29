From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix clock resource by adding an
 optional bus clock
Date: Fri, 29 Sep 2017 11:15:50 +0200
Message-ID: <20170929111550.065e7948@windsurf.lan>
References: <20170928150520.27616-1-gregory.clement@free-electrons.com>
        <20170929103943.3a6f2509@xhacker.debian>
        <87fub5hnqb.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:44051 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbdI2JPw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Sep 2017 05:15:52 -0400
In-Reply-To: <87fub5hnqb.fsf@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Antoine Tenart <antoine.tenart@free-electrons.com>, Omri Itach <omrii@marvell.com>, Stable <stable@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Igal Liberman <igall@marvell.com>, =?UTF-8?B?TWlx?= =?UTF-8?B?dcOobA==?= Raynal <miquel.raynal@free-electrons.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastia

Hello,

On Fri, 29 Sep 2017 11:13:00 +0200, Gregory CLEMENT wrote:

> >>  - clock-names:
> >>    Array of names corresponding to clocks property.
> >>    The input clock for Xenon IP core should be named as "core".
> >> +  The input clock for the AXI bus must be named as "axi".  
> >
> > Is "bus" more suitable?  
> 
> I find bus too vague.

Actually no, I believe "bus" is more common. Indeed, you could have the
same IP, attached to a different interconnect I guess.

> >>  	/*
> >>  	 * Link Xenon specific mmc_host_ops function,
> >> @@ -491,9 +493,20 @@ static int xenon_probe(struct platform_device *pdev)
> >>  	if (err)
> >>  		goto free_pltfm;
> >>  
> >> +	priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
> >> +	if (IS_ERR(priv->axi_clk)) {

-EPROBE_DEFER handling ?

> >> +		err = PTR_ERR(priv->axi_clk);
> >> +		dev_err(&pdev->dev, "Failed to setup axi clk: %d\n", err);  
> >
> > Since the bus clock is optional, can we remove this err msg?  
> 
> I will change it in dev_info.

This clock is optional (in order to keep DT backward compatibility), so
there shouldn't be any error message, be it dev_err() or dev_info().

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
