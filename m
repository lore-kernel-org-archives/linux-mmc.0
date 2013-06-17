From: "Fernandes, Joel A" <joelagnel-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v10 1/2] ARM: davinci: move private EDMA API to arm/common
Date: Mon, 17 Jun 2013 17:55:42 +0000
Message-ID: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4E95C2@DLEE08.ent.ti.com>
References: <1371463571-2578-1-git-send-email-nsekhar@ti.com>
	<1371463571-2578-2-git-send-email-nsekhar@ti.com>
	<20130617170326.GA28497@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20130617170326.GA28497-O5ziIzlqnXUVNXGz7ipsyg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Olof,

> -----Original Message-----
> From: Olof Johansson [mailto:olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org]
> Sent: Monday, June 17, 2013 12:03 PM
> To: Nori, Sekhar
> Cc: Russell King; Vinod Koul; Chris Ball; Liam Girdwood; Mark Brown; Kevin
> Hilman; Matt Porter; Fernandes, Joel A; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org; Arnd Bergmann
> Subject: Re: [PATCH v10 1/2] ARM: davinci: move private EDMA API to
> arm/common
> 
> On Mon, Jun 17, 2013 at 03:36:10PM +0530, Sekhar Nori wrote:
> > From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> >
> > Move mach-davinci/dma.c to common/edma.c so it can be used by OMAP
> > (specifically AM33xx) as well.
> >
> > Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> > Acked-by: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org> # davinci_mmc.c
> > [nsekhar-l0cyMroinI0@public.gmane.org: dropped davinci sffsdr changes]
> > Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> 
> Acked-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> 
> Tiny nit below, no need to respin just for that.
> 
> I suppose we should take this through arm-soc.
> 
> > ---
> >  arch/arm/Kconfig                                   |    1 +
> >  arch/arm/common/Kconfig                            |    3 +
> >  arch/arm/common/Makefile                           |    1 +
> >  arch/arm/{mach-davinci/dma.c => common/edma.c}     |    2 +-
> >  arch/arm/mach-davinci/Makefile                     |    2 +-
> >  arch/arm/mach-davinci/board-tnetv107x-evm.c        |    2 +-
> >  arch/arm/mach-davinci/davinci.h                    |    2 +-
> >  arch/arm/mach-davinci/devices-tnetv107x.c          |    2 +-
> >  arch/arm/mach-davinci/devices.c                    |    6 +-
> >  arch/arm/mach-davinci/dm355.c                      |    2 +-
> >  arch/arm/mach-davinci/dm365.c                      |    2 +-
> >  arch/arm/mach-davinci/dm644x.c                     |    2 +-
> >  arch/arm/mach-davinci/dm646x.c                     |    2 +-
> >  arch/arm/mach-davinci/include/mach/da8xx.h         |    2 +-
> >  drivers/dma/edma.c                                 |    2 +-
> >  drivers/mmc/host/davinci_mmc.c                     |    1 +
> >  include/linux/mfd/davinci_voicecodec.h             |    3 +-
> >  .../mach => include/linux/platform_data}/edma.h    |   89 +-------------------
> >  include/linux/platform_data/spi-davinci.h          |    2 +-
> >  sound/soc/davinci/davinci-evm.c                    |    1 +
> >  sound/soc/davinci/davinci-pcm.c                    |    1 +
> >  sound/soc/davinci/davinci-pcm.h                    |    2 +-
> >  22 files changed, 29 insertions(+), 103 deletions(-)  rename
> > arch/arm/{mach-davinci/dma.c => common/edma.c} (99%)  rename
> > {arch/arm/mach-davinci/include/mach =>
> > include/linux/platform_data}/edma.h (59%)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig index
> > 49d993c..b1c66a4 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -840,6 +840,7 @@ config ARCH_DAVINCI
> >  	select GENERIC_IRQ_CHIP
> >  	select HAVE_IDE
> >  	select NEED_MACH_GPIO_H
> > +	select TI_PRIV_EDMA
> 
> What does PRIV here mean? Privileged? Private? I think it can be shortened to
> TI_EDMA.
> 
 [Joel] TI_EDMA already exists. It is used to build drivers/dma/edma.
I have a patch that reuses the TI_EDMA option instead of the PRIV one . I will
include that In my v11 series for EDMA (v10 was just posted) . If its ok, let us
merge Sekhar's patch as-is, and then mine will get rid of the PRIV option
(among other things).

Thanks,
Joel
