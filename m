From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2] mmc: sdhci-xenon: Fix clock resource by adding an
 optional bus clock
Date: Sat, 30 Sep 2017 08:07:10 +0200
Message-ID: <20170930080710.119c0258@windsurf>
References: <20170929130435.6805-1-gregory.clement@free-electrons.com>
        <20170930104109.60853202@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170930104109.60853202@xhacker.debian>
Sender: stable-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?B?TWlxdcOo?= =?UTF-8?B?bA==?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@s>
List-Id: linux-mmc@vger.kernel.org

Hello,

On Sat, 30 Sep 2017 10:41:09 +0800, Jisheng Zhang wrote:

> > +	priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
> > +	if (IS_ERR(priv->axi_clk)) {
> > +		err = PTR_ERR(priv->axi_clk);
> > +		if (err == -EPROBE_DEFER)
> > +			goto err_clk;
> > +		priv->axi_clk = NULL;  
> 
> IMHO, this assignment could be removed. What do you think?

No, because if the clock is not present in the Device Tree,
priv->axi_clk will contain an error code encoded as a pointer, so
priv->axi_clk will not be NULL. Hence the rest of the code that will
operate on this clock will believe there is a valid clock pointed by
priv->axi_clk. So we really want to reset it to NULL when there was an
error getting the clock.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
