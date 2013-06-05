From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 1/9] ARM: davinci: move private EDMA API to arm/common
Date: Wed, 5 Jun 2013 14:24:38 +0530
Message-ID: <51AEFCCE.4040608@ti.com>
References: <1362586540-10393-1-git-send-email-mporter@ti.com>
	<1362586540-10393-2-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1362586540-10393-2-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm->
List-Id: linux-mmc@vger.kernel.org

Hi Russell,

On 3/6/2013 9:45 PM, Matt Porter wrote:
> Move mach-davinci/dma.c to common/edma.c so it can be used
> by OMAP (specifically AM33xx) as well.
> 
> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

Can you please ack this movement of davinci private EDMA implementation
to arch/arm/common? I would like to take this patch through davinci tree
for v3.11.

Thanks,
Sekhar

> ---
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/common/Kconfig                            |    3 +
>  arch/arm/common/Makefile                           |    1 +
>  arch/arm/{mach-davinci/dma.c => common/edma.c}     |    2 +-
>  arch/arm/mach-davinci/Makefile                     |    2 +-
>  arch/arm/mach-davinci/board-tnetv107x-evm.c        |    2 +-
>  arch/arm/mach-davinci/davinci.h                    |    2 +-
>  arch/arm/mach-davinci/devices-tnetv107x.c          |    2 +-
>  arch/arm/mach-davinci/devices.c                    |    6 +-
>  arch/arm/mach-davinci/dm355.c                      |    2 +-
>  arch/arm/mach-davinci/dm365.c                      |    2 +-
>  arch/arm/mach-davinci/dm644x.c                     |    2 +-
>  arch/arm/mach-davinci/dm646x.c                     |    2 +-
>  arch/arm/mach-davinci/include/mach/da8xx.h         |    2 +-
>  drivers/dma/edma.c                                 |    2 +-
>  drivers/mmc/host/davinci_mmc.c                     |    1 +
>  include/linux/mfd/davinci_voicecodec.h             |    3 +-
>  .../mach => include/linux/platform_data}/edma.h    |   89 +-------------------
>  include/linux/platform_data/spi-davinci.h          |    2 +-
>  sound/soc/davinci/davinci-evm.c                    |    1 +
>  sound/soc/davinci/davinci-pcm.c                    |    1 +
>  sound/soc/davinci/davinci-pcm.h                    |    2 +-
>  sound/soc/davinci/davinci-sffsdr.c                 |    5 +-
>  23 files changed, 33 insertions(+), 104 deletions(-)
>  rename arch/arm/{mach-davinci/dma.c => common/edma.c} (99%)
>  rename {arch/arm/mach-davinci/include/mach => include/linux/platform_data}/edma.h (59%)
> 
