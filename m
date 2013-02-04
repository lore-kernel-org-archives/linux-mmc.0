From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Mon, 4 Feb 2013 14:22:26 -0500
Message-ID: <51100A72.6030909@ti.com>
References: <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
 <20130201185820.GE29898@arwen.pp.htv.fi> <510C2A47.1090607@mvista.com>
 <20130201205600.GA31762@arwen.pp.htv.fi>
 <20130201213003.GW2637@n2100.arm.linux.org.uk>
 <20130204154153.GA18237@arwen.pp.htv.fi> <510FF1A6.403@mvista.com>
 <20130204164712.GB4269@arwen.pp.htv.fi> <510FF5C9.3030600@mvista.com>
 <20130204170216.GC4269@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130204170216.GC4269-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Nair, Sandeep" <sandeep_n-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 02/04/2013 12:02 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, Feb 04, 2013 at 08:54:17PM +0300, Sergei Shtylyov wrote:
>>> On Mon, Feb 04, 2013 at 08:36:38PM +0300, Sergei Shtylyov wrote:
>>>>> opted out of it. From the top of my head we have CPPI 3.x, CPPI 4.1,
>>>>> Inventra DMA, OMAP sDMA and ux500 DMA engines supported by the driver.
>>
>>>>> Granted, CPPI 4.1 makes some assumptions about the fact that it's
>>>>> handling USB tranfers,
>>
>>>>     What CPPI 4.1 code makes this assumptions? MUSB DMA driver? Then it's just
>>
>>> HW makes the asumptions
>>
>>     Not true at all. There is a separate set of registers (at offset 0) which
>> copes with USB specifics, but CPPI 4.1 itself doesn't know about USB anything.
>
> CPPI 4.1 was made for USB transfers.
>

I have been dealing with CPPI hardware on KeyStone platforms (CPPI 4.2). 
  Our experiences with this DMA hardware may help with CPPI 4.1 on 
earlier generations.

CPPI 4.2 serves as a truly common interface to a number of hardware 
blocks on KeyStone SoCs - including Ethernet, RapidIO, Crypto 
accelerators, and a bunch of other accelerator thingies.  Given the 
commonality across subsystems, we've built a shared CPPI 4.2 DMA-Engine 
implementation.  You can take a sneak peek at this implementation at [1].

Based on our experience with fitting multiple subsystems on top of this 
DMA-Engine driver, I must say that the DMA-Engine interface has proven 
to be a less than ideal fit for the network driver use case.

The first problem is that the DMA-Engine interface expects to "push" 
completed traffic up into the upper layer as a part of its callback. 
This doesn't fit cleanly with NAPI, which expects to "pull" completed 
traffic from below in the NAPI poll.  We've somehow kludged together a 
solution around this, but it isn't very elegant.

The second problem is one of binding fixed DMA resources to fixed users. 
  AFAICT, the stock DMA-Engine mechanism works best when one DMA 
resource is as good as any other.  To get over this problem, we've added 
support for named channels, and drivers specifically request for a DMA 
resource by name.  Again, this is less than ideal.

We found that virtio devices offer a more elegant solution to this 
problem.  First, the virtqueue interface is a much better fit into NAPI 
(callback --> napi schedule, napi poll --> get_buf), and this eliminates 
the need for aforementioned kludges in the code.  Second, the virtio 
device infrastructure nicely uses the device model to solve the problem 
of binding DMA users to specific DMA resources.

These patches haven't (yet) been posted on the MLs, but you can peek at 
[2].  While we are on the topic, I'd certainly appreciate feedback on 
the concept of using virtqueues as an interface to peripheral 
independent packet oriented DMA hardware. :-)

Cheers
-- Cyril

[1] - 
http://arago-project.org/git/projects/?p=linux-keystone.git;a=shortlog;h=refs/heads/rebuild/23-drivers-dmaengine
[2] - 
http://arago-project.org/git/projects/?p=linux-keystone.git;a=shortlog;h=refs/heads/rebuild/21-drivers-virtio
