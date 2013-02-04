From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Mon, 04 Feb 2013 21:22:42 +0300
Message-ID: <510FFC72.2050706@mvista.com>
References: <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com> <20130201185820.GE29898@arwen.pp.htv.fi> <510C2A47.1090607@mvista.com> <20130201205600.GA31762@arwen.pp.htv.fi> <20130201213003.GW2637@n2100.arm.linux.org.uk> <20130204154153.GA18237@arwen.pp.htv.fi> <510FF1A6.403@mvista.com> <20130204164712.GB4269@arwen.pp.htv.fi> <510FF5C9.3030600@mvista.com> <20130204170216.GC4269@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130204170216.GC4269@arwen.pp.htv.fi>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Matt Porter <mporter@ti.com>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Chris Ball <cjb@laptop.org>, "Cousson, Benoit" <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Linux Documentation List <linux-doc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Vinod Koul <vinod.koul@intel.com>, Rob Landley <rob@landley.net>, Dan Williams <djbw@fb.com>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-ker>
List-Id: linux-mmc@vger.kernel.org

Hello.

On 02/04/2013 08:02 PM, Felipe Balbi wrote:

>>> On Mon, Feb 04, 2013 at 08:36:38PM +0300, Sergei Shtylyov wrote:
>>>>> opted out of it. From the top of my head we have CPPI 3.x, CPPI 4.1,
>>>>> Inventra DMA, OMAP sDMA and ux500 DMA engines supported by the driver.

>>>>> Granted, CPPI 4.1 makes some assumptions about the fact that it's
>>>>> handling USB tranfers,

>>>>    What CPPI 4.1 code makes this assumptions? MUSB DMA driver? Then it's just

>>> HW makes the asumptions

>>    Not true at all. There is a separate set of registers (at offset 0) which
>> copes with USB specifics, but CPPI 4.1 itself doesn't know about USB anything.

> CPPI 4.1 was made for USB transfers.

   Utter nonsense, CPPI 4.1 is hardware abstract DMA engine. It's used for
Ethernet transfers on out-of-tree platforms like mach-avalanche/.

>> It's just the way the driver was written that it used both sets of registers but
>> this needs to be changed into more abstacted accesses to the USB-specific part,
>> to cope with it being different on different platfroms, like AM35x. The driver
>> as it was last posted, just needs rework now.

> are you saying you will do the work ?

   My efforts stopped to be funded by MV back in 2010. Hell, I'm not even
working in MV as I used to, hanging on the verge of my current contract being
terminated.

>>>>    Don't know, I was quite content with the abstraction when writing CPPI 4.1
>>>> driver for MUSB...

>>> look closer. The whole:

>>> if (is_cppi())
>>> 	foo();
>>> else if (is_inventra())
>>> 	bar();
>>> else if (is_omap_sdma())
>>> 	baz();

>>> is bogus.

>>    That part -- yes. There were attempt to get rid of this, but without changing
>> the DMA API. It was left halfway done after my only critical comment, IIRC. Will
>> we ever see the continuation of this effort?

> patches are welcome

   There was a patch, it only needed comments addressed. I think the author was
Heikki Krogerus. As for me, my time is very limited, so be thankful even for
those scarce patches I'm sending out now -- I'm doing them in my copious free time.

WBR, Sergei

