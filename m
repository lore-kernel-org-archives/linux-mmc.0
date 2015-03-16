From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: sh_mobile_sdhi: remove sh_mobile_sdhi_info v2
Date: Tue, 17 Mar 2015 06:34:20 +0900
Message-ID: <20150316213420.GA1086@verge.net.au>
References: <201503141650.GfUoPRK3%fengguang.wu@intel.com>
 <87lhixiat4.wl%kuninori.morimoto.gx@renesas.com>
 <87k2yhiaro.wl%kuninori.morimoto.gx@renesas.com>
 <45205978.mSO6RfbDSy@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45205978.mSO6RfbDSy@wuerfel>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vinod.koul@intel.com>, Linux-SH <linux-sh@vger.kernel.org>, arm@kernel.org, kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Mar 16, 2015 at 05:34:50PM +0100, Arnd Bergmann wrote:
> On Monday 16 March 2015 08:53:40 Kuninori Morimoto wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > 84f11d5b1f2abc0e22895b7e12e037f0ec03caeb
> > (mmc: sh_mobile_sdhi: remove sh_mobile_sdhi_info)
> > replaced sh_mobile_sdhi_info to tmio_mmc_data, but it was missing
> > to replace board-ape6evm / board-mackerel.
> > Kernel build will be failed without this patch.
> > 
> >         >> arch/arm/mach-shmobile/board-ape6evm.c:176:21: error: \
> >                 variable 'sdhi0_pdata' has initializer but incomplete type
> >         static const struct sh_mobile_sdhi_info sdhi0_pdata __initconst = {
> >                             ^
> >         >> arch/arm/mach-shmobile/board-ape6evm.c:177:2: error: \
> >                 unknown field 'tmio_flags' specified in initializer
> >         .tmio_flags = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
> >         ^
> >         ...
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

