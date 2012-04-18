From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 6/8] mmc: omap_hsmmc: add DMA engine support
Date: Wed, 18 Apr 2012 20:09:23 +0100
Message-ID: <20120418190923.GQ25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk> <E1SKRs1-0004bP-HH@rmk-PC.arm.linux.org.uk> <20120418181112.GK21106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120418181112.GK21106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 18, 2012 at 11:11:12AM -0700, Tony Lindgren wrote:
> * Russell King <rmk+kernel@arm.linux.org.uk> [120418 03:15]:
> > Add DMA engine support to the OMAP HSMMC driver.  This supplements the
> > private DMA API implementation contained within this driver, and the
> > driver can be switched at build time between using DMA engine and the
> > private DMA API.
> 
> Glad to see this happening!
> 
> No luck here though, after a quick test I'm getting the following with MMC
> not working:

Did you enable OMAP DMA engine support?
