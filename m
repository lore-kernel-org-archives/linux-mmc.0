From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-omap: drop ->get_ro() implementation
Date: Wed, 16 Jan 2019 16:58:12 +0100
Message-ID: <20190116165812.1ca10804@windsurf>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
        <20190115162837.5399-3-thomas.petazzoni@bootlin.com>
        <20190116132747.GB11050@ulmo>
        <20190116154717.GQ5544@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116154717.GQ5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello,

On Wed, 16 Jan 2019 07:47:18 -0800, Tony Lindgren wrote:

> > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > 
> > Adding Tony and linux-omap for a slightly wider audience and hopefully
> > find someone to test this on. For reference, the whole series is here:
> > 
> > 	https://patchwork.kernel.org/project/linux-mmc/list/?series=66905  
> 
> Thanks Kishon can you please review and test?

I think Adrian's comment that ->get_ro() should be called first in the
core code makes sense, so I'll send a v2 with this change. Perhaps
testing should be done on the v2 instead, even though I believe it
should be functionally equivalent.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
