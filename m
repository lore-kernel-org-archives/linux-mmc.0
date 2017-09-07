From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/3] mmc: Add OMAP SDHCI driver
Date: Thu, 7 Sep 2017 09:30:13 -0700
Message-ID: <20170907163009.GQ5024@atomide.com>
References: <20170906114556.32532-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:40070 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbdIGQaR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 7 Sep 2017 12:30:17 -0400
Content-Disposition: inline
In-Reply-To: <20170906114556.32532-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [170906 04:47]:
> This is the first step in deprecating omap_hsmmc driver completely
> and moving to sdhci-omap driver which uses the sdhci library.

Looks good to me. A beverage coming your way at some conf
on me for sure for dealing with this :)

Acked-by: Tony Lindgren <tony@atomide.com>
