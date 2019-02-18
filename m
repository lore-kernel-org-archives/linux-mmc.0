From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/8] Port am335 and am437 devices to sdhci-omap
Date: Mon, 18 Feb 2019 08:25:17 -0800
Message-ID: <20190218162517.GG15711@atomide.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215200244.GA15711@atomide.com>
 <0c3b5570-c5ec-46c8-2548-8049100661d3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0c3b5570-c5ec-46c8-2548-8049100661d3@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, kishon@ti.com, zhang.chunyan@linaro.org
List-Id: linux-mmc@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [190218 13:46]:
> Hi Tony,
> 
> On 16/02/19 1:32 AM, Tony Lindgren wrote:
> > * Faiz Abbas <faiz_abbas@ti.com> [190215 19:17]:
> >> The following add driver patches for porting TI's am335x and am437x
> >> devices to the sdhci-omap driver.
> >>
> >> This involves adding external DMA support to sdhci (first 3 patches from
> >> Chunyan) plus some miscellaneous patches to take care of deviations of
> >> the controllers from the sdhci model.
> > 
> > Good to see this happening :)
> > 
> > I think am437x should have also the ADMA as it's mostly
> > omap4 based? See the old omap4 ADMA series at [0] below.
> > 
> > Are you seeing any improvment in SDIO card read/write speeds
> > between external DMA and ADM BTW
> 
> am437 is using dmaengine even in the old omap_hsmmc driver. I haven't
> tried to enable ADMA in am437x.

Right, it's probably safest to keep it that way at least initially
to avoid changing multiple things at once. Then ADMA can be
configured later on if needed.

Regards,

Tony
