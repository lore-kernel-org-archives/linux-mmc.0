From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Tue, 5 Feb 2013 10:37:45 -0500
Message-ID: <51112749.10603@ti.com>
References: <510C2A47.1090607@mvista.com>
	<20130204203358.GX4720@opensource.wolfsonmicro.com>
	<CACRpkdbPyZt8=pLhz-5qcaSSAk6VBn61dPTNp6teU9HksBwN2w@mail.gmail.com>
	<201302042147.38407.arnd@arndb.de>
	<20130205123828.GB17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130205123828.GB17852-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan, "Nair,
	Sandeep" <sandeep_n-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Williams <djbw-b10kYP2dOMg@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sergei, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "Cousson,
	Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>LinuxLinux SPI Devel List <s>
List-Id: linux-mmc@vger.kernel.org

On 02/05/2013 07:38 AM, Russell King - ARM Linux wrote:
> On Mon, Feb 04, 2013 at 09:47:38PM +0000, Arnd Bergmann wrote:
>> On Monday 04 February 2013, Linus Walleij wrote:
>>> So I think the above concerns are moot. The callback we can
>>> set on cookies is entirely optional, and it's even implemented by
>>> each DMA engine, and some may not even support it but require
>>> polling, and then it won't even be implemented by the driver.
>>
>> Just to ensure that everybody is talking about the same thing here:
>> Is it just the callback that is optional, or also the interrupt
>> coming from the hardware?
>
> If everyone implements stuff correctly, both.  The callback most certainly
> is optional as things stand.  The interrupt - that depends on the DMA
> engine.
>
> Some DMA engines you can't avoid it because you need to reprogram the
> hardware with the next+1 transfer upon completion of an existing transfer.
> Others may allow you to chain transfers in hardware.  That's all up to
> how the DMA engine driver is implemented and how the hardware behaves.
>
> Now, there's another problem here: that is, people abuse the API.  People
> don't pass DMA_CTRL_ACK | DMA_PREP_INTERRUPT into their operations by
> default.  People like typing '0'.
>
> The intention of the "DMA_PREP_INTERRUPT" is significant here: it means
> "ask the hardware to send an interrupt upon completion of this transfer".
>
> Because soo many people like to type '0' instead in their DMA engine
> clients, it means that this flag is utterly useless today - you have to
> ignore it.  So there's _no_ way for client drivers to actually tell the
> a DMA engine driver which _doesn't_ need to signal interrupts at the end
> of every transfer not to do so.
>
> So yes, the DMA engine API supports it.  Whether the _implementations_
> themselves do is very much hit and miss (and in reality is much more
> miss than hit.)
>

Don't these assume that the driver can determine the need for an 
interrupt upfront at prep/submit time?  AFAICT, this assumption doesn't 
hold true with NAPI.

Thanks
-- Cyril.

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
