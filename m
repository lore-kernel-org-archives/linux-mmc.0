From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RFC PATCH v5 1/9] mmc: dw_mmc: Add external dma interface support
Date: Sat, 15 Aug 2015 00:13:49 +0200
Message-ID: <1522710.BT6Gc0L6oH@diego>
References: <1439541232-30100-1-git-send-email-shawn.lin@rock-chips.com> <1439541275-30146-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:59775 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858AbbHNWOO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 14 Aug 2015 18:14:14 -0400
In-Reply-To: <1439541275-30146-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: jh80.chung@samsung.com, ulf.hansson@linaro.org, Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>, Joachim Eastwood <manabian@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Russell King <linux@arm.linux.org.uk>, Zhangfei Gao <zhangfei.gao@linaro.org>, Jun Nie <jun.nie@linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Govindraj Raja <govindraj.raja@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, dianders@chromium.org, linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Shawn,

Am Freitag, 14. August 2015, 16:34:35 schrieb Shawn Lin:
> DesignWare MMC Controller can supports two types of DMA
> mode: external dma and internal dma. We get a RK312x platform
> integrated dw_mmc and ARM pl330 dma controller. This patch add
> edmac ops to support these platforms. I've tested it on RK312x
> platform with edmac mode and RK3288 platform with idmac mode.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

judging by your "from", I guess you're running this on some older Rockchip soc 
without the idma? Because I tried testing this on a Radxa Rock, but only got 
failures, from the start (failed to read card status register). In PIO mode 
everything works again.


I guess I overlooked just some tiny detail, but to me the dma channel ids seem 
correct after all. Maybe you have any hints what I'm doing wrong?

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 4497d28..92d7156 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -217,6 +217,8 @@
                interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
                clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
                clock-names = "biu", "ciu";
+             dmas = <&dmac2 1>;
+             dma-names = "rx-tx";
                fifo-depth = <256>;
                status = "disabled";
        };
@@ -227,6 +229,8 @@
                interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
                clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
                clock-names = "biu", "ciu";
+             dmas = <&dmac2 3>;
+             dma-names = "rx-tx";
                fifo-depth = <256>;
                status = "disabled";
        };
@@ -237,6 +241,8 @@
                interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
                clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
                clock-names = "biu", "ciu";
+             dmas = <&dmac2 4>;
+             dma-names = "rx-tx";
                fifo-depth = <256>;
                status = "disabled";
        };


[...]

> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index fcbf552..e01ead3 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2517,8 +2642,23 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot
> *slot, unsigned int id) static void dw_mci_init_dma(struct dw_mci *host)
>  {
>  	int addr_config;
> +	int trans_mode;
> +	struct device *dev = host->dev;
> +	struct device_node *np = dev->of_node;
> +
> +	/* Check tansfer mode */
> +	trans_mode = SDMMC_GET_TRANS_MODE(mci_readl(host, HCON));
> +	if (trans_mode == 0) {
> +		trans_mode = TRANS_MODE_IDMAC;
> +	} else if (trans_mode == 1 || trans_mode == 2) {
> +		trans_mode = TRANS_MODE_EDMAC;
> +	} else {
> +		trans_mode = TRANS_MODE_PIO;
> +		goto no_dma;
> +	}
> +
>  	/* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
> -	addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
> +	addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));
> 
>  	if (addr_config == 1) {
>  		/* host supports IDMAC in 64-bit address mode */

I guess the idmac address size checking block

        /* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
        addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));

        if (addr_config == 1) {
                /* host supports IDMAC in 64-bit address mode */
                host->dma_64bit_address = 1;
                dev_info(host->dev, "IDMAC supports 64-bit address mode.\n");
                if (!dma_set_mask(host->dev, DMA_BIT_MASK(64)))
                        dma_set_coherent_mask(host->dev, DMA_BIT_MASK(64));
        } else {
                /* host supports IDMAC in 32-bit address mode */
                host->dma_64bit_address = 0;
                dev_info(host->dev, "IDMAC supports 32-bit address mode.\n");
        }

could either live inside the trans_mode == 0 conditional above or get its own
if (trans_mode == 0) conditional. Either way I guess it should not talk about 
idmac when either pio or extdmac are used.


Thanks
Heiko
