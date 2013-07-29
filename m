From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] dmaengine: add dma_get_slave_sg_limits()
Date: Mon, 29 Jul 2013 12:14:15 +0530
Message-ID: <20130729064415.GF29095@intel.com>
References: <1374166001-31340-1-git-send-email-joelf@ti.com>
 <1374166001-31340-2-git-send-email-joelf@ti.com>
 <20130718170825.GZ21614@n2100.arm.linux.org.uk>
 <51E83A9D.5020008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51E83A9D.5020008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Matt Porter <matt@ohporter.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@linaro.org>, Benoit Cousson <benoit.cousson@linaro.org>, Balaji TK <balajitk@ti.com>, Gururaja Hebbar <gururaja.hebbar@ti.com>, Chris Ball <cjb@laptop.org>, Jason Kridner <jkridner@beagleboard.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.ker>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 18, 2013 at 01:57:33PM -0500, Joel Fernandes wrote:
> On 07/18/2013 12:08 PM, Russell King - ARM Linux wrote:
> > As for the maximum number of scatterlist entries, really that's a bug in
> > the DMA engine implementations if they can't accept arbitary lengths.
> > I've created DMA engine drivers for implementations where you have to
> > program each segment individually, ones which can have the current and
> > next segments, as well as those which can walk a list.  Provided you get
> > informed of a transfer being completed, there really is no reason for a
> > DMA engine driver to limit the number of scatterlist entries that it
> > will accept.
> 
> Sure, that makes sense. Can you point to such a typical example
> implementation to get some ideas?
MXS MMC driver uses this: drivers/mmc/host/mxs-mmc.c
And dma engine driver for this is mxs-dma.c

~Vinod
-- 
