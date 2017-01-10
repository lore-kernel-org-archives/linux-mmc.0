From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH v8 6/6] mmc: sh_mobile_sdhi: Add tuning support
Date: Tue, 10 Jan 2017 22:08:48 +0100
Message-ID: <20170110210848.GA25542@bigcity.dyn.berto.se>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
 <1478182564-18762-7-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478182564-18762-7-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

I started to se errors when I was testing DMAC+IPMMU patches on top of 
v4.10-rc1 on Koelsch.

[    2.247490] [drm] Device feb00000.display probed
[    2.254407] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.259535] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    2.473871] sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 max clock rate 195 MHz
[    2.484048] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.489175] sh_mobile_sdhi ee140000.sd: Got WP GPIO
[    2.703850] sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 max clock rate 97 MHz
[    2.714083] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    2.911847] ipmmu-vmsa e6740000.mmu: Unhandled fault: status 0x00002101 iova 0x40002000
[    2.925838] sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 max clock rate 97 MHz
[    2.938057] ipmmu-vmsa e6740000.mmu: Unhandled fault: status 0x00002101 iova 0x40002000
[    2.938342] asoc-simple-card sound: ak4642-hifi <-> ec500000.sound mapping ok
[    2.954859] mmc0: new ultra high speed SDR50 SDHC card at address aaaa
[    2.962604] mmcblk0: mmc0:aaaa SU04G 3.69 GiB 
[    2.971149] input: keyboard as /devices/platform/keyboard/input/input0
[    2.980044] da9063-rtc da9063-rtc: setting system clock to 2017-01-10 20:15:43 UTC (1484079343)
[    2.989814]  mmcblk0: p1
[    3.106206] Micrel KSZ8041RNLI ee700000.etherne:01: attached PHY driver [Micrel KSZ8041RNLI] (mii_bus:phy_addr=ee700000.etherne:01, irq=405)

If I boot the system without a SD card inserted the warnings are not 
printed, however when I insert the SD card they are immediately printed.  
Multiple removal/insertion of a card do not trigger additional warnings, 
only at the first insertion.

Oddly enough the error are only printed when I insert the SD card in the 
mmc0 slot. I can insert/eject the card multiple times in mmc1 and no 
error but the first insertion in mmc0 and boom. Only difference I can 
see are the clock speed between mmc0 and mmc1.

[  125.681585] ipmmu-vmsa e6740000.mmu: Unhandled fault: status 0x00002101 iova 0x40002000
[  125.698839] ipmmu-vmsa e6740000.mmu: Unhandled fault: status 0x00002101 iova 0x40002000
[  125.708228] mmc0: new ultra high speed SDR50 SDHC card at address aaaa
[  125.716394] mmcblk0: mmc0:aaaa SU04G 3.69 GiB 
[  125.737443]  mmcblk0: p1
[  305.365862] mmc0: card aaaa removed
[  307.933518] mmc0: new ultra high speed SDR50 SDHC card at address aaaa
[  307.941948] mmcblk0: mmc0:aaaa SU04G 3.69 GiB 
[  307.964353]  mmcblk0: p1
[  310.965794] mmc0: card aaaa removed
[  317.335789] mmc1: new ultra high speed SDR50 SDHC card at address aaaa
[  317.343172] mmcblk1: mmc1:aaaa SU04G 3.69 GiB 
[  317.364223]  mmcblk1: p1

Sometimes the error is reported 3 times but in most cases only 2.

I can interact fine with the card (I tried checksumming a large file and 
compared with a known good) so it's not broken. I can also interact with 
other devices using the DMAC+IPMMU without similar warnings being 
printed at all, I tested with i2c6.

If i revert this patch 06f438dd389a699d ("mmc: sh_mobile_sdhi: Add 
tuning support") the warnings go away. I have not been able to figure 
out what in the patch triggers the warnings, and I'm not sure the 
problem are with sh_mobile_sdhi. I know to little about the DMAC and 
IPMMU to rule them out as the true source. Do you have any idea what 
might cause this? I'm happy to run more tests or help out in other ways 
if I can.

To reproduce start on v4.10-rc1 and use shmobile_defconfig with a few 
additions:

CONFIG_ARM_LPAE=y
CONFIG_IPMMU_VMSA=y

And I enable IPMMU for DMAC in DT:

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 87214668d70f..d4500d79db1d 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -325,6 +325,21 @@
                power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
                #dma-cells = <1>;
                dma-channels = <15>;
+               iommus = <&ipmmu_ds 0>,
+                        <&ipmmu_ds 1>,
+                        <&ipmmu_ds 2>,
+                        <&ipmmu_ds 3>,
+                        <&ipmmu_ds 4>,
+                        <&ipmmu_ds 5>,
+                        <&ipmmu_ds 6>,
+                        <&ipmmu_ds 7>,
+                        <&ipmmu_ds 8>,
+                        <&ipmmu_ds 9>,
+                        <&ipmmu_ds 10>,
+                        <&ipmmu_ds 11>,
+                        <&ipmmu_ds 12>,
+                        <&ipmmu_ds 13>,
+                        <&ipmmu_ds 14>;
        };
 
        dmac1: dma-controller@e6720000 {
@@ -356,6 +371,21 @@
                power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
                #dma-cells = <1>;
                dma-channels = <15>;
+               iommus = <&ipmmu_ds 15>,
+                        <&ipmmu_ds 16>,
+                        <&ipmmu_ds 17>,
+                        <&ipmmu_ds 18>,
+                        <&ipmmu_ds 19>,
+                        <&ipmmu_ds 20>,
+                        <&ipmmu_ds 21>,
+                        <&ipmmu_ds 22>,
+                        <&ipmmu_ds 23>,
+                        <&ipmmu_ds 24>,
+                        <&ipmmu_ds 25>,
+                        <&ipmmu_ds 26>,
+                        <&ipmmu_ds 27>,
+                        <&ipmmu_ds 28>,
+                        <&ipmmu_ds 29>;
        };
 
        audma0: dma-controller@ec700000 {
@@ -1688,7 +1718,7 @@
                interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
                             <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
                #iommu-cells = <1>;
-               status = "disabled";
+               status = "okay";
        };
 
        ipmmu_mp: mmu@ec680000 {

On 2016-11-03 15:16:04 +0100, Simon Horman wrote:
> Add tuning support for use with SDR104 mode
> This includes adding support for the sampling clock controller (SCC).
> 
> Based on work by Ai Kyuse.
> 
> Cc: Ai Kyuse <ai.kyuse.uw@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> v8 [Simon Horman]
> * Correct inverted logic in sh_mobile_sdhi_hw_reset
> * Correct value of SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN
> 
> v7 [Simon Horman]
> * No change
> 
> v6 [Simon Horman]
> * Rebase to use host->taps
> 
> v5 [Simon Horman]
> * As suggested by Ulf Hansson
>   - Use more descriptive name for callback to check for SSC error
> * Reinstate Gen3 tuning support
> 
> v4 [Simon Horman]
> As suggested by Geert Uytterhoeven:
> * guard SDR104 specific portion of probe with host->mmc->caps &
>   MMC_CAP_UHS_SDR104
> * As suggested by Wolfram Sang:
>   - Pass priv to sd_scc_{read,write}32 to save host_to_priv access
>     for each call
>   - Use 0x0 instead of other representations of 0 in hex
>   - Use CLK_CTL_SCLKEN
>   - Do not add unused SH_MOBILE_SDHI_MAX_TAP
>   - Use ternary operator in sh_mobile_sdhi_select_tuning
>   - Do include as yet unsupported HS200 in error string
> * Reintroduce retuning support: This was removed in v3.
> * Revert to algorithm in v1 patchset, on further reading of the documentation
>   it appears to be correct.
> 
> v3 [Simon Horman]
> * As suggested by Kuninori Morimoto:
>   - Do not add unused retuning callback to struct tmio_mmc_host
>   - Change return type of prepare_tuning callback to void
>   - Add tap_size parameter to select_tuning callback
> 
> v2 [Simon Horman]
> * As suggested by Kuninori Morimoto
>   - Use host->mmc->caps & MMC_CAP_UHS_SDR104 instead of
>     pdata->flags & TMIO_MMC_HAS_UHS_SCC to avoid needing the
>     MMC_CAP_UHS_SDR104 flag at all.
>     N.B: Morimoto-san suggested using but this flag is not actually
>     set there in by current probe come.
>   - Simplify logic in sh_mobile_sdhi_inquiry_tuning
> * As suggested by Wolfram Sang
>   - Use clk_rate instead of clk for field in struct sh_mobile_sdhi_scc
>   - Remove inquiry_tuning callback which is now unnecessary as calling
>     of tuning is handled by the core
>   - Removed unused sh_mobile_sdhi_set_clk_div callback
>   - Save sci_base address rather than calculating it on each read and write
> * Update selection logic in sh_mobile_sdhi_select_tuning to match spec
> * Use bool instead of long for taps parameter of
>   sh_mobile_sdhi_select_tuning()
> * Return 0 from sh_mobile_sdhi_init_tuning() if the
>   SDR104 capability is not set and thus tuning should not
>   be performed because it is not supported by the hardware
> 
> v1 [Simon Horman]
> * Rebase
> * Always use value of 0x8 for TAPNUM field of DTCNTL register
>   rather than reading value from DT property. There does not
>   seem to be a need to expose this in DT at this point.
> * Do not include tmio_mmc_start_signal_voltage_switch changes which
>   are already in mainline in a different form
> * Do not add renesas,clk-rate property as the max-frequency property, which
>   is now present in mainline, seems to provide the needed rate
> * Omit Gen3 specific changes
> * Do not provide renesas,mmc-scc-tappos DT property.
>   Instead, always use taps provided in driver.
> * Do not parse sd-uhs-sdr50 and sd-uhs-sdr104 properties.
>   This is handled by the core.
> 
> v0 [Ai Kyuse]
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 265 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 264 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 49edff7fee49..15c77bc6e4ee 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -47,6 +47,11 @@
>  
>  #define host_to_priv(host) container_of((host)->pdata, struct sh_mobile_sdhi, mmc_data)
>  
> +struct sh_mobile_sdhi_scc {
> +	unsigned long clk_rate;	/* clock rate for SDR104 */
> +	u32 tap;		/* sampling clock position for SDR104 */
> +};
> +
>  struct sh_mobile_sdhi_of_data {
>  	unsigned long tmio_flags;
>  	unsigned long capabilities;
> @@ -54,6 +59,9 @@ struct sh_mobile_sdhi_of_data {
>  	enum dma_slave_buswidth dma_buswidth;
>  	dma_addr_t dma_rx_offset;
>  	unsigned bus_shift;
> +	int scc_offset;
> +	struct sh_mobile_sdhi_scc *taps;
> +	int taps_num;
>  };
>  
>  static const struct sh_mobile_sdhi_of_data of_default_cfg = {
> @@ -66,12 +74,35 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen1_compatible = {
>  	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
>  };
>  
> +/* Definitions for sampling clocks */
> +static struct sh_mobile_sdhi_scc rcar_gen2_scc_taps[] = {
> +	{
> +		.clk_rate = 156000000,
> +		.tap = 0x00000703,
> +	},
> +	{
> +		.clk_rate = 0,
> +		.tap = 0x00000300,
> +	},
> +};
> +
>  static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
>  			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
>  	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
>  	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
>  	.dma_rx_offset	= 0x2000,
> +	.scc_offset	= 0x0300,
> +	.taps		= rcar_gen2_scc_taps,
> +	.taps_num	= ARRAY_SIZE(rcar_gen2_scc_taps),
> +};
> +
> +/* Definitions for sampling clocks */
> +static struct sh_mobile_sdhi_scc rcar_gen3_scc_taps[] = {
> +	{
> +		.clk_rate = 0,
> +		.tap = 0x00000300,
> +	},
>  };
>  
>  static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
> @@ -79,6 +110,9 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
>  			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
>  	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
>  	.bus_shift	= 2,
> +	.scc_offset	= 0x1000,
> +	.taps		= rcar_gen3_scc_taps,
> +	.taps_num	= ARRAY_SIZE(rcar_gen3_scc_taps),
>  };
>  
>  static const struct of_device_id sh_mobile_sdhi_of_match[] = {
> @@ -105,6 +139,7 @@ struct sh_mobile_sdhi {
>  	struct tmio_mmc_dma dma_priv;
>  	struct pinctrl *pinctrl;
>  	struct pinctrl_state *pins_default, *pins_uhs;
> +	void __iomem *scc_ctl;
>  };
>  
>  static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
> @@ -255,6 +290,201 @@ static int sh_mobile_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
>  	return pinctrl_select_state(priv->pinctrl, pin_state);
>  }
>  
> +/* SCC registers */
> +#define SH_MOBILE_SDHI_SCC_DTCNTL	0x000
> +#define SH_MOBILE_SDHI_SCC_TAPSET	0x002
> +#define SH_MOBILE_SDHI_SCC_DT2FF	0x004
> +#define SH_MOBILE_SDHI_SCC_CKSEL	0x006
> +#define SH_MOBILE_SDHI_SCC_RVSCNTL	0x008
> +#define SH_MOBILE_SDHI_SCC_RVSREQ	0x00A
> +
> +/* Definitions for values the SH_MOBILE_SDHI_SCC_DTCNTL register */
> +#define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
> +#define SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT	16
> +#define SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_MASK	0xff
> +
> +/* Definitions for values the SH_MOBILE_SDHI_SCC_CKSEL register */
> +#define SH_MOBILE_SDHI_SCC_CKSEL_DTSEL		BIT(0)
> +/* Definitions for values the SH_MOBILE_SDHI_SCC_RVSCNTL register */
> +#define SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN	BIT(0)
> +/* Definitions for values the SH_MOBILE_SDHI_SCC_RVSREQ register */
> +#define SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR	BIT(2)
> +
> +static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
> +				struct sh_mobile_sdhi *priv, int addr)
> +{
> +	return readl(priv->scc_ctl + (addr << host->bus_shift));
> +}
> +
> +static inline void sd_scc_write32(struct tmio_mmc_host *host,
> +				  struct sh_mobile_sdhi *priv,
> +				  int addr, u32 val)
> +{
> +	writel(val, priv->scc_ctl + (addr << host->bus_shift));
> +}
> +
> +static unsigned int sh_mobile_sdhi_init_tuning(struct tmio_mmc_host *host)
> +{
> +	struct sh_mobile_sdhi *priv;
> +
> +	if (!(host->mmc->caps & MMC_CAP_UHS_SDR104))
> +		return 0;
> +
> +	priv = host_to_priv(host);
> +
> +	/* set sampling clock selection range */
> +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
> +		       0x8 << SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT);
> +
> +	/* Initialize SCC */
> +	sd_ctrl_write32_as_16_and_16(host, CTL_STATUS, 0x0);
> +
> +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
> +		       SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
> +		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL));
> +
> +	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
> +			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> +
> +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL,
> +		       SH_MOBILE_SDHI_SCC_CKSEL_DTSEL |
> +		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL));
> +
> +	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
> +			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> +
> +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
> +		       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
> +		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
> +
> +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, host->scc_tappos);
> +
> +	/* Read TAPNUM */
> +	return (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL) >>
> +		SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT) &
> +		SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_MASK;
> +}
> +
> +static void sh_mobile_sdhi_prepare_tuning(struct tmio_mmc_host *host,
> +					 unsigned long tap)
> +{
> +	struct sh_mobile_sdhi *priv = host_to_priv(host);
> +
> +	/* Set sampling clock position */
> +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, tap);
> +}
> +
> +#define SH_MOBILE_SDHI_MAX_TAP 3
> +
> +static int sh_mobile_sdhi_select_tuning(struct tmio_mmc_host *host)
> +{
> +	struct sh_mobile_sdhi *priv = host_to_priv(host);
> +	unsigned long tap_cnt;  /* counter of tuning success */
> +	unsigned long tap_set;  /* tap position */
> +	unsigned long tap_start;/* start position of tuning success */
> +	unsigned long tap_end;  /* end position of tuning success */
> +	unsigned long ntap;     /* temporary counter of tuning success */
> +	unsigned long i;
> +
> +	/* Clear SCC_RVSREQ */
> +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
> +
> +	/*
> +	 * Find the longest consecutive run of successful probes.  If that
> +	 * is more than SH_MOBILE_SDHI_MAX_TAP probes long then use the
> +	 * center index as the tap.
> +	 */
> +	tap_cnt = 0;
> +	ntap = 0;
> +	tap_start = 0;
> +	tap_end = 0;
> +	for (i = 0; i < host->tap_num * 2; i++) {
> +		if (test_bit(i, host->taps))
> +			ntap++;
> +		else {
> +			if (ntap > tap_cnt) {
> +				tap_start = i - ntap;
> +				tap_end = i - 1;
> +				tap_cnt = ntap;
> +			}
> +			ntap = 0;
> +		}
> +	}
> +
> +	if (ntap > tap_cnt) {
> +		tap_start = i - ntap;
> +		tap_end = i - 1;
> +		tap_cnt = ntap;
> +	}
> +
> +	if (tap_cnt >= SH_MOBILE_SDHI_MAX_TAP)
> +		tap_set = (tap_start + tap_end) / 2 % host->tap_num;
> +	else
> +		return -EIO;
> +
> +	/* Set SCC */
> +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, tap_set);
> +
> +	/* Enable auto re-tuning */
> +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
> +		       SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN |
> +		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
> +
> +	return 0;
> +}
> +
> +
> +static bool sh_mobile_sdhi_check_scc_error(struct tmio_mmc_host *host)
> +{
> +	struct sh_mobile_sdhi *priv;
> +
> +	if (!(host->mmc->caps & MMC_CAP_UHS_SDR104))
> +		return 0;
> +
> +	priv = host_to_priv(host);
> +
> +	/* Check SCC error */
> +	if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL) &
> +	    SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &&
> +	    sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ) &
> +	    SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR) {
> +		/* Clear SCC error */
> +		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void sh_mobile_sdhi_hw_reset(struct tmio_mmc_host *host)
> +{
> +	struct sh_mobile_sdhi *priv;
> +
> +	if (!(host->mmc->caps & MMC_CAP_UHS_SDR104))
> +		return;
> +
> +	priv = host_to_priv(host);
> +
> +	/* Reset SCC */
> +	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
> +			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> +
> +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL,
> +		       ~SH_MOBILE_SDHI_SCC_CKSEL_DTSEL &
> +		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL));
> +
> +	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
> +			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> +
> +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
> +		       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
> +		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
> +
> +	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
> +		       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
> +		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
> +}
> +
>  static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
>  {
>  	int timeout = 1000;
> @@ -325,7 +555,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>  	struct tmio_mmc_data *mmd = pdev->dev.platform_data;
>  	struct tmio_mmc_host *host;
>  	struct resource *res;
> -	int irq, ret, i = 0;
> +	int irq, ret, i;
>  	struct tmio_mmc_dma *dma_priv;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -384,6 +614,11 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>  		host->card_busy	= sh_mobile_sdhi_card_busy;
>  		host->start_signal_voltage_switch =
>  			sh_mobile_sdhi_start_signal_voltage_switch;
> +		host->init_tuning	= sh_mobile_sdhi_init_tuning;
> +		host->prepare_tuning	= sh_mobile_sdhi_prepare_tuning;
> +		host->select_tuning	= sh_mobile_sdhi_select_tuning;
> +		host->check_scc_error	= sh_mobile_sdhi_check_scc_error;
> +		host->hw_reset		= sh_mobile_sdhi_hw_reset;
>  	}
>  
>  	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
> @@ -424,6 +659,34 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto efree;
>  
> +	if (host->mmc->caps & MMC_CAP_UHS_SDR104) {
> +		host->mmc->caps |= MMC_CAP_HW_RESET;
> +
> +		if (of_id && of_id->data) {
> +			const struct sh_mobile_sdhi_of_data *of_data;
> +			const struct sh_mobile_sdhi_scc *taps;
> +			bool hit = false;
> +
> +			of_data = of_id->data;
> +			taps = of_data->taps;
> +
> +			for (i = 0; i < of_data->taps_num; i++) {
> +				if (taps[i].clk_rate == 0 ||
> +				    taps[i].clk_rate == host->mmc->f_max) {
> +					host->scc_tappos = taps->tap;
> +					hit = true;
> +					break;
> +				}
> +			}
> +
> +			if (!hit)
> +				dev_warn(&host->pdev->dev, "Unknown clock rate for SDR104\n");
> +
> +			priv->scc_ctl = host->ctl + of_data->scc_offset;
> +		}
> +	}
> +
> +	i = 0;
>  	while (1) {
>  		irq = platform_get_irq(pdev, i);
>  		if (irq < 0)
> -- 
> 2.7.0.rc3.207.g0ac5344
> 
> 

-- 
Regards,
Niklas Söderlund
