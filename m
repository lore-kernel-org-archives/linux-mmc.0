From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/7] mmc: sdhci-pxav3: Fix Armada 38x controller's
 caps according to erratum ERR-7878951
Date: Fri, 23 Jan 2015 11:03:03 +0000
Message-ID: <20150123110303.GD23493@leverpostej>
References: <1422010594-1735-1-git-send-email-gregory.clement@free-electrons.com>
 <1422010594-1735-3-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422010594-1735-3-git-send-email-gregory.clement@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

> +	/*
> +	 * According to erratum 'ERR-7878951' Armada 38x SDHCI
> +	 * controller has different capabilities than the ones shown
> +	 * in its registers
> +	 */
> +	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +	if (of_get_property(np, "no-1-8-v", NULL)) {

Please use of_property_read_bool(np, "no-1-8-v")

> +		host->caps &= ~SDHCI_CAN_VDD_180;
> +		host->mmc->caps &= ~MMC_CAP_1_8V_DDR;

Is SDHCI_CAN_VDD_330 always set elsewhere in this case?

> +	} else
> +		host->caps &= ~SDHCI_CAN_VDD_330;

If one branch in an if-else pair is braced, both sides should be (as
Documentation/CodingStyle says). Please brace the else case.

Thanks,
Mark.
