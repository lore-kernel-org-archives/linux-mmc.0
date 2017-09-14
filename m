From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-omap: Add OMAP SDHCI driver
Date: Thu, 14 Sep 2017 10:26:35 +0300
Message-ID: <cdb5251f-e725-e5ca-0c36-a3b2544ffbdc@intel.com>
References: <20170906114556.32532-1-kishon@ti.com>
 <20170906114556.32532-3-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:6421 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbdINHdQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Sep 2017 03:33:16 -0400
In-Reply-To: <20170906114556.32532-3-kishon@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 06/09/17 14:45, Kishon Vijay Abraham I wrote:
> Create a new sdhci-omap driver to configure the eMMC/SD/SDIO controller
> in TI's OMAP SoCs making use of the SDHCI core library. For OMAP specific
> configurations, populate sdhci_ops with OMAP specific callbacks and use
> SDHCI quirks.
> Enable only high speed mode for both SD and eMMC here and add other
> UHS mode support later.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
