From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Tue, 5 Feb 2013 19:33:42 +0100
Message-ID: <CACRpkdbruBRH8TJb8kkopYEZrpX+h73HT=1VDa=tOWPKg-sGJw@mail.gmail.com>
References: <510FF1A6.403@mvista.com> <20130204164712.GB4269@arwen.pp.htv.fi>
	<510FF5C9.3030600@mvista.com>
	<20130204170216.GC4269@arwen.pp.htv.fi> <51100A72.6030909@ti.com>
	<CACRpkdZihnp3_Df==QRWxQupgi7W_YXZxc-MxkusVH6J+Vx56A@mail.gmail.com>
	<20130204203358.GX4720@opensource.wolfsonmicro.com>
	<CACRpkdbPyZt8=pLhz-5qcaSSAk6VBn61dPTNp6teU9HksBwN2w@mail.gmail.com>
	<51102E25.8040107@ti.com>
	<CACRpkdaUQ60W8Vmg3MpvP5uV+3jD3y4+9V2et4Ni+z-7k=aFTg@mail.gmail.com>
	<20130205171451.GE17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130205171451.GE17852-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Nair, Sandeep" <sandeep_n-l0cyMroinI0@public.gmane.org>, Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "Cousson,
	Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-d>
List-Id: linux-mmc@vger.kernel.org

On Tue, Feb 5, 2013 at 6:14 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Tue, Feb 05, 2013 at 04:30:45PM +0100, Linus Walleij wrote:

>> So put them on a wait list? Surely you will have a list of pending
>> cookies and pick from the front of the queue if there isn't a hole on
>> queue position 0.
>
> Not quite.  The key is the cookie system DMA engine employs to indicate
> when a cookie is complete.
>
> Cookies between the "issued sequence" and "completed sequence" are defined
> to be in progress, everything else is defined to be completed.
>
> This means that if "completed sequence" is 1, and "issued sequence" is 5,
> then cookies with values 2, 3, 4, 5 are in progress.  You can't mark
> sequence 4 as being complete until 2 and 3 have completed.

Yes that is true. DMA transfers on a certain channel are defined
as progressing linearly per-cookie. I wonder if that is a problem
in this case though (actually it seems the reverse, this helps
in Cyril's case.)

> If we need out-of-order completion, then that's a problem for the DMA
> engine API, because you'd need to radically change the way "completion"
> is marked.

True. I wonder if this usecase is ever going to be applicable
however. It could maybe be useful in some instances of
memcpy() I could dream up, whereas for device transfers it
seems unlikely to me.

Yours,
Linus Walleij

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
