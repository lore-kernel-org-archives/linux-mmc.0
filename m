From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v12 05/11] edma: config: Enable config options for EDMA
Date: Fri, 21 Jun 2013 16:00:04 +0200
Message-ID: <201306211600.04986.arnd@arndb.de>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
	<51C427E1.2000800@ti.com>
	<CAD=GYpb54bitcg0gnfhzxbvig3etRPY6fs=FOQu5nYkio5NRZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <CAD=GYpb54bitcg0gnfhzxbvig3etRPY6fs=FOQu5nYkio5NRZw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel@>
List-Id: linux-mmc@vger.kernel.org

On Friday 21 June 2013, Joel A Fernandes wrote:
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index b1c66a4..7d58cd9 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -841,6 +841,7 @@ config ARCH_DAVINCI
> >>       select HAVE_IDE
> >>       select NEED_MACH_GPIO_H
> >>       select TI_PRIV_EDMA
> >> +     select DMADEVICES
> >
> > It is generally a bad idea to force select on something that can be
> > enabled using menuconfig. Unless used carefully, select causes "unmet
> > direct dependency" warnings which folks are already fighting hard to
> > fix. This leads to what Russell referred in the past as "select madness" [1]
> 
> Are you concerned with bloat issues? I know your point of view but the idea
> was to build these options by default for these platforms even though
> in some cases
> it might not be used. I have seen folks including myself select the wrong
> option. Having the build system automatically select the correct option for the
> most common cases can be very useful I feel and not require manual
> configuration.

For defaults, you should use the defconfig, not 'select' in Kconfig.

A lot of the 'select' statements are actually wrong because they
do not take dependencies into account where A selects B but not C,
and B depends on C, which leads to broken builds when C is disabled
by a user (or randconfig).

You should only ever use 'select' from platforms on silent options
that are not themselves user selectable like the above 'HAVE_IDE'
and 'NEED_MACH_GPIO_H'.

	Arnd
