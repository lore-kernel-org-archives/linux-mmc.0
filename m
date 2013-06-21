From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v12 05/11] edma: config: Enable config options for EDMA
Date: Fri, 21 Jun 2013 16:32:12 +0200
Message-ID: <201306211632.12577.arnd@arndb.de>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <201306211600.04986.arnd@arndb.de>
 <CAD=GYpZ_5Lp1La=f+2BQfmuj+sc3FgygZRD4gfj4JGGZ0Do=_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAD=GYpZ_5Lp1La=f+2BQfmuj+sc3FgygZRD4gfj4JGGZ0Do=_Q@mail.gmail.com>
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
To: Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Friday 21 June 2013, Joel A Fernandes wrote:
> I haven't come across this problem but- are you saying there is a
> shortcoming in Kbuild/Kconfig that selects an option even if its
> dependency is not met?

Well, the shortcoming is that it lets you specify impossible
contraints. You get a warning from Kconfig when building
such a configuration, but then it continues.

> The problem with defconfig is also too many options I feel for a common case.
> CONFIG_DMADEVICES=y
> CONFIG_TI_EDMA=y
> 
> Most if not all future OMAPs from will use EDMA. Why not we can be
> explicit about it and just built it in anyway. If ARCH_OMAP and
> DMADEVICES are selected, then we can just build EDMA in by default.

It's just not how we do things. Kconfig is a mess because we are
not consistent in the way this is done.

> I agree maybe the option can be dropped from Davinci but I suggest
> let's keep it for OMAP. Is that ok?

No, I would still like you to not add it to either one. I'm spending
a lot of my time tracking down incorrect 'select' statements and I'd
rather spend it in a different way. I've had to a number of 'select'
statements from OMAP in the past, please don't add any new ones
unless there is a strict build dependency (which normally should not
exist).

	Arnd
