From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to
 arm/common
Date: Tue, 5 Feb 2013 10:28:49 -0800
Message-ID: <20130205182848.GJ25185@atomide.com>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
 <20130201184915.GP2244@beef>
 <510C1D0E.6030401@mvista.com>
 <20130201185820.GE29898@arwen.pp.htv.fi>
 <510C2A47.1090607@mvista.com>
 <20130201205600.GA31762@arwen.pp.htv.fi>
 <20130201213003.GW2637@n2100.arm.linux.org.uk>
 <20130204154153.GA18237@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130204154153.GA18237@arwen.pp.htv.fi>
Sender: linux-doc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sergei Shtylyov <sshtylyov@mvista.com>, Matt Porter <mporter@ti.com>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Chris Ball <cjb@laptop.org>, "Cousson, Benoit" <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Linux Documentation List <linux-doc@vger.kernel.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Vinod Koul <vinod.koul@intel.com>, Rob Landley <rob@landley.net>, Dan Williams <djbw@fb.com>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-a>
List-Id: linux-mmc@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [130204 07:46]:
> 
> Current DMA abstraction is quite poor, for example there's no way to
> compile support for multiple DMA engines. Code also makes certain, IMO
> unnecessary, assumptions about the underlying DMA engine (abstraction is
> poor, as said above but it we could follow MUSB's programming guide when
> it comes to programming DMA transfers).
> 
> Considering all of the above, it's far better to use DMA engine and get
> rid of all the mess.

How about just disable MUSB DMA support if ARCH_MULTIPLATFORM for now?
That way MUSB can be fixed up first to support ARCH_MULTIPLATFORM
using PIO while sorting out the DMA related issues.

Regards,

Tony
