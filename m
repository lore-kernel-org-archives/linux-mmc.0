From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 00/14] DMA Engine support for AM33XX
Date: Thu, 24 Jan 2013 10:44:13 +0530
Message-ID: <5100C325.6020102@ti.com>
References: <1358281974-8411-1-git-send-email-mporter@ti.com>
 <50FEB6B2.5020303@ti.com> <20130123022133.GA5727@opensource.wolfsonmicro.com>
 <20130123213736.GC5256@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130123213736.GC5256@beef>
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
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Matt,

On 1/24/2013 3:07 AM, Matt Porter wrote:
> On Wed, Jan 23, 2013 at 10:21:42AM +0800, Mark Brown wrote:
>> On Tue, Jan 22, 2013 at 09:26:34PM +0530, Sekhar Nori wrote:
>>> On 1/16/2013 2:02 AM, Matt Porter wrote:
>>
>>>> This series adds DMA Engine support for AM33xx, which uses
>>>> an EDMA DMAC. The EDMA DMAC has been previously supported by only
>>>> a private API implementation (much like the situation with OMAP
>>>> DMA) found on the DaVinci family of SoCs.
>>
>>> Will you take this series through the OMAP tree? Only 1/14 touches
>>> mach-davinci and I am mostly okay with it except some changes I just
>>> requested Matt to make in another thread.
>>
>> Is this series somewhere near actually getting merged then? It seemed
>> like there was lots of stuff going on.
> 
> The issues raised by Sekhar and Santosh were reasonably minor and will
> be addressed. My major concern is that the dependency on some api to
> fetch dmaengine driver SG limitations is not resolved. That's being
> discussed in https://lkml.org/lkml/2013/1/10/432

It might be worth posting the patches which don't have dependencies and
are ready for acceptance as a separate series. That way at least some of
these patches have a good chance of getting into v3.9 if not the entire
series.

Thanks,
Sekhar
