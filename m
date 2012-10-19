From: "Bedia, Vaibhav" <vaibhav.bedia-l0cyMroinI0@public.gmane.org>
Subject: RE: [RFC PATCH v3 00/16] DMA Engine support for AM33XX
Date: Fri, 19 Oct 2012 12:02:42 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBD2CE1@DBDE01.ent.ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
	<B5906170F1614E41A8A28DE3B8D121433EBD29FC@DBDE01.ent.ti.com>
	<20121019111558.GD25164@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121019111558.GD25164@beef>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Porter, Matt" <mporter-l0cyMroinI0@public.gmane.org>
Cc: Grant, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Williams <djbw-b10kYP2dOMg@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "Cousson,
	Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>Rob, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>Linux, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 19, 2012 at 16:45:58, Porter, Matt wrote:
> On Fri, Oct 19, 2012 at 10:26:20AM +0000, Bedia, Vaibhav wrote:
[...]
> > 
> > I didn't see all the patches that you posted on edma-dmaengine-v3
> > but I do seem them on edma-dmaengine-am33xx-v3 branch.
> 
> I see I referenced the wrong branch in the cover letter. Thanks for
> testing and noticing this. Sorry to make you hunt for the correct
> branch in that repo. ;) 
> 

No problem.

> https://github.com/ohporter/linux/tree/edma-dmaengine-am33xx-v3
> is indeed the correct branch for those wanting to pull this in or
> grab some of the not-to-be-merged drivers I used for testing.
> 
> > I added a couple of patches to enable earlyprintk and build the DTB
> > appended kernel image uImage-dtb.am335x-evm
> > 
> > Here's what i see
> > 
> > [...]
> 
> <snip>
> 
> > [    0.175354] edma: probe of 49000000.edma failed with error -16
> 
> I missed an uninitialized pdata case in the bug fixes mentioned in
> the changelog and the folks previously failing the same way didn't
> hit the case I suspect you are hitting. Can you try this and let me
> know how it works?
> 

That doesn't help :(

Looking at the original crash log, I suspect something is not correct
with the irq portion, probably in the DT or the driver. 

"genirq: Flags mismatch irq 28. 00000000 (edma) vs. 00000000 (edma)"

The warning below that is coming due to fail case in edma_probe not tracking
the request_irq status properly and but IMO that's a separate issue.

BTW, I am trying this on the EVM.

Regards,
Vaibhav

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
