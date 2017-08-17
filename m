From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 5/7] dt-bindings: ti-omap-hsmmc: Document new
 compatible for sdhci omap
Date: Thu, 17 Aug 2017 09:05:37 -0700
Message-ID: <20170817160537.GL8569@atomide.com>
References: <20170807160142.12134-1-kishon@ti.com>
 <20170807160142.12134-6-kishon@ti.com>
 <20170809221222.GK3934@atomide.com>
 <2cdf9bbe-b98b-8811-7587-268b7ef4ac66@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:36808 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751561AbdHQQFm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 17 Aug 2017 12:05:42 -0400
Content-Disposition: inline
In-Reply-To: <2cdf9bbe-b98b-8811-7587-268b7ef4ac66@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [170816 22:44]:
> Hi Tony,
> 
> On Thursday 10 August 2017 03:42 AM, Tony Lindgren wrote:
> > * Kishon Vijay Abraham I <kishon@ti.com> [170807 09:03]:
> >> Document the new compatible string "ti,dra7-sdhci" to be used for
> >> MMC controllers in DRA7 and DRA72 SoCs.
> > 
> > I wonder if this should really be documented for sdhci
> > instead of ti-omap-hsmmc.txt?
> 
> hmm.. yeah, having a separate binding document for sdhci would make the binding
> really clean and we also don't have to carry legacy binding code. But we'll be
> never able to remove omap-hsmmc driver then and end up maintaining 2 drivers
> for the same controller.

Well I think it's best to be able to enable sdhci one board at
a time after testing. Then eventually when fully supported, we
can just have sdhci also parse the legacy omap binding and just
drop the omap-hsmmc driver.

Regards,

Tony
