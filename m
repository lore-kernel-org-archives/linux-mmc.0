From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sh_mobile_sdhi: remove sh_mobile_sdhi_info v2
Date: Mon, 16 Mar 2015 17:34:50 +0100
Message-ID: <45205978.mSO6RfbDSy@wuerfel>
References: <201503141650.GfUoPRK3%fengguang.wu@intel.com> <87lhixiat4.wl%kuninori.morimoto.gx@renesas.com> <87k2yhiaro.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87k2yhiaro.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, arm@kernel.org, kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Monday 16 March 2015 08:53:40 Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> 84f11d5b1f2abc0e22895b7e12e037f0ec03caeb
> (mmc: sh_mobile_sdhi: remove sh_mobile_sdhi_info)
> replaced sh_mobile_sdhi_info to tmio_mmc_data, but it was missing
> to replace board-ape6evm / board-mackerel.
> Kernel build will be failed without this patch.
> 
>         >> arch/arm/mach-shmobile/board-ape6evm.c:176:21: error: \
>                 variable 'sdhi0_pdata' has initializer but incomplete type
>         static const struct sh_mobile_sdhi_info sdhi0_pdata __initconst = {
>                             ^
>         >> arch/arm/mach-shmobile/board-ape6evm.c:177:2: error: \
>                 unknown field 'tmio_flags' specified in initializer
>         .tmio_flags = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
>         ^
>         ...
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
