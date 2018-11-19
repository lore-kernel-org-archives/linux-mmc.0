From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5912/OMAP310
Date: Mon, 19 Nov 2018 11:58:32 +0200
Message-ID: <ffdad271-943c-f4e7-8ec9-2af5769798a4@ti.com>
References: <20181118201919.14401-1-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181118201919.14401-1-aaro.koskinen@iki.fi>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Ladislav Michl <ladis@linux-mips.org>, linux-mmc@vger.kernel.org
Cc: Andrzej Zaborowski <balrogg@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Aaro,

On 2018-11-18 22:19, Aaro Koskinen wrote:
> Since v2.6.22 or so there has been reports [1] about OMAP MMC being
> broken on OMAP15XX based hardware (OMAP5912 and OMAP310). The breakage
> seems to have been caused by commit 46a6730e3ff9 ("mmc-omap: Fix
> omap to use MMC_POWER_ON") that changed clock enabling to be done
> on MMC_POWER_ON. This can happen multiple times in a row, and on 15XX
> the hardware doesn't seem to like it and the MMC just stops responding.
> Fix by memorizing the power mode and do the init only when necessary.
> 
> Before the patch (on Palm TE):
> 
> 	mmc0: new SD card at address b368
> 	mmcblk0: mmc0:b368 SDC   977 MiB
> 	mmci-omap mmci-omap.0: command timeout (CMD18)
> 	mmci-omap mmci-omap.0: command timeout (CMD13)
> 	mmci-omap mmci-omap.0: command timeout (CMD13)
> 	mmci-omap mmci-omap.0: command timeout (CMD12) [x 6]
> 	mmci-omap mmci-omap.0: command timeout (CMD13) [x 6]
> 	mmcblk0: error -110 requesting status
> 	mmci-omap mmci-omap.0: command timeout (CMD8)
> 	mmci-omap mmci-omap.0: command timeout (CMD18)
> 	mmci-omap mmci-omap.0: command timeout (CMD13)
> 	mmci-omap mmci-omap.0: command timeout (CMD13)
> 	mmci-omap mmci-omap.0: command timeout (CMD12) [x 6]
> 	mmci-omap mmci-omap.0: command timeout (CMD13) [x 6]
> 	mmcblk0: error -110 requesting status
> 	mmcblk0: recovery failed!
> 	print_req_error: I/O error, dev mmcblk0, sector 0
> 	Buffer I/O error on dev mmcblk0, logical block 0, async page read
> 	 mmcblk0: unable to read partition table
> 
> After the patch:
> 
> 	mmc0: new SD card at address b368
> 	mmcblk0: mmc0:b368 SDC   977 MiB
> 	 mmcblk0: p1
> 
> The patch is based on a fix and analysis done by Ladislav Michl.
> 
> Tested on OMAP15XX/OMAP310 (Palm TE), OMAP1710 (Nokia 770)
> and OMAP2420 (Nokia N810).

Do you know if the DMA is enabled for the MMC? It might not work via
DMAengine.

> [1] https://marc.info/?t=123175197000003&r=1&w=2
> 
> Fixes: 46a6730e3ff9 ("mmc-omap: Fix omap to use MMC_POWER_ON")
> Reported-by: Ladislav Michl <ladis@linux-mips.org>
> Reported-by: Andrzej Zaborowski <balrogg@gmail.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/mmc/host/omap.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index adf32682f27a..c60a7625b1fa 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -104,6 +104,7 @@ struct mmc_omap_slot {
>  	unsigned int		vdd;
>  	u16			saved_con;
>  	u16			bus_mode;
> +	u16			power_mode;
>  	unsigned int		fclk_freq;
>  
>  	struct tasklet_struct	cover_tasklet;
> @@ -1157,7 +1158,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	struct mmc_omap_slot *slot = mmc_priv(mmc);
>  	struct mmc_omap_host *host = slot->host;
>  	int i, dsor;
> -	int clk_enabled;
> +	int clk_enabled, init_stream;
>  
>  	mmc_omap_select_slot(slot, 0);
>  
> @@ -1167,6 +1168,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		slot->vdd = ios->vdd;
>  
>  	clk_enabled = 0;
> +	init_stream = 0;
>  	switch (ios->power_mode) {
>  	case MMC_POWER_OFF:
>  		mmc_omap_set_power(slot, 0, ios->vdd);
> @@ -1174,13 +1176,17 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	case MMC_POWER_UP:
>  		/* Cannot touch dsor yet, just power up MMC */
>  		mmc_omap_set_power(slot, 1, ios->vdd);
> +		slot->power_mode = ios->power_mode;
>  		goto exit;
>  	case MMC_POWER_ON:
>  		mmc_omap_fclk_enable(host, 1);
>  		clk_enabled = 1;
>  		dsor |= 1 << 11;
> +		if (slot->power_mode != MMC_POWER_ON)
> +			init_stream = 1;
>  		break;
>  	}
> +	slot->power_mode = ios->power_mode;
>  
>  	if (slot->bus_mode != ios->bus_mode) {
>  		if (slot->pdata->set_bus_mode != NULL)
> @@ -1196,7 +1202,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	for (i = 0; i < 2; i++)
>  		OMAP_MMC_WRITE(host, CON, dsor);
>  	slot->saved_con = dsor;
> -	if (ios->power_mode == MMC_POWER_ON) {
> +	if (init_stream) {
>  		/* worst case at 400kHz, 80 cycles makes 200 microsecs */
>  		int usecs = 250;
>  
> @@ -1234,6 +1240,7 @@ static int mmc_omap_new_slot(struct mmc_omap_host *host, int id)
>  	slot->host = host;
>  	slot->mmc = mmc;
>  	slot->id = id;
> +	slot->power_mode = MMC_POWER_UNDEFINED;
>  	slot->pdata = &host->pdata->slots[id];
>  
>  	host->slots[id] = slot;
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
