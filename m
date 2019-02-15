From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/8] Port am335 and am437 devices to sdhci-omap
Date: Fri, 15 Feb 2019 12:02:44 -0800
Message-ID: <20190215200244.GA15711@atomide.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190215192033.24203-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, kishon@ti.com, zhang.chunyan@linaro.org
List-Id: linux-mmc@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [190215 19:17]:
> The following add driver patches for porting TI's am335x and am437x
> devices to the sdhci-omap driver.
> 
> This involves adding external DMA support to sdhci (first 3 patches from
> Chunyan) plus some miscellaneous patches to take care of deviations of
> the controllers from the sdhci model.

Good to see this happening :)

I think am437x should have also the ADMA as it's mostly
omap4 based? See the old omap4 ADMA series at [0] below.

Are you seeing any improvment in SDIO card read/write speeds
between external DMA and ADM BTW?

Regards,

Tony

[0] https://linux-omap.vger.kernel.narkive.com/H4EbLW96/patch-0-4-omap4-hsmmc-adding-adma-support
