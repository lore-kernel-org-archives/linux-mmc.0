From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to
	arm/common
Date: Tue, 5 Feb 2013 12:38:28 +0000
Message-ID: <20130205123828.GB17852@n2100.arm.linux.org.uk>
References: <510C2A47.1090607@mvista.com> <20130204203358.GX4720@opensource.wolfsonmicro.com> <CACRpkdbPyZt8=pLhz-5qcaSSAk6VBn61dPTNp6teU9HksBwN2w@mail.gmail.com> <201302042147.38407.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201302042147.38407.arnd@arndb.de>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, Cyril Chemparathy <cyril@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, balbi@ti.com, Sergei Shtylyov <sshtylyov@mvista.com>, Linux Documentation List <linux-doc@vger.kernel.org>, Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, "Nair, Sandeep" <sandeep_n@ti.com>, Chris Ball <cjb@laptop.org>, Matt Porter <mporter@ti.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Linux OMAP List <linux-omap@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, "Cousson, Benoit" <b-cousson@ti.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Landley <rob@landley.net>, Dan Williams <djbw@fb.com>Linux
List-Id: linux-mmc@vger.kernel.org

On Mon, Feb 04, 2013 at 09:47:38PM +0000, Arnd Bergmann wrote:
> On Monday 04 February 2013, Linus Walleij wrote:
> > So I think the above concerns are moot. The callback we can
> > set on cookies is entirely optional, and it's even implemented by
> > each DMA engine, and some may not even support it but require
> > polling, and then it won't even be implemented by the driver.
> 
> Just to ensure that everybody is talking about the same thing here:
> Is it just the callback that is optional, or also the interrupt
> coming from the hardware?

If everyone implements stuff correctly, both.  The callback most certainly
is optional as things stand.  The interrupt - that depends on the DMA
engine.

Some DMA engines you can't avoid it because you need to reprogram the
hardware with the next+1 transfer upon completion of an existing transfer.
Others may allow you to chain transfers in hardware.  That's all up to
how the DMA engine driver is implemented and how the hardware behaves.

Now, there's another problem here: that is, people abuse the API.  People
don't pass DMA_CTRL_ACK | DMA_PREP_INTERRUPT into their operations by
default.  People like typing '0'.

The intention of the "DMA_PREP_INTERRUPT" is significant here: it means
"ask the hardware to send an interrupt upon completion of this transfer".

Because soo many people like to type '0' instead in their DMA engine
clients, it means that this flag is utterly useless today - you have to
ignore it.  So there's _no_ way for client drivers to actually tell the
a DMA engine driver which _doesn't_ need to signal interrupts at the end
of every transfer not to do so.

So yes, the DMA engine API supports it.  Whether the _implementations_
themselves do is very much hit and miss (and in reality is much more
miss than hit.)
