From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v4 2/5] mmc: support sdhci-pxav2.c
Date: Mon, 13 Jun 2011 14:35:26 -0700
Message-ID: <0059AEB1-3536-4540-924A-A95C7F3AD21A@marvell.com>
References: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com>
 <1307526121-12059-3-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:45708 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753516Ab1FMVfn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Jun 2011 17:35:43 -0400
In-Reply-To: <1307526121-12059-3-git-send-email-zhangfei.gao@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Zhangfei Gao <zgao6@marvell.com>


On Jun 8, 2011, at 2:41 AM, Zhangfei Gao wrote:

> 	SDHCI driver for PXAV2 SoCs, such as pxa910, the driver based on sdhci-pltfm to handle resource etc.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> Signed-off-by: Jun Nie <njun@marvell.com>
> Signed-off-by: Qiming Wu <wuqm@marvell.com>
> ---

> +++ b/drivers/mmc/host/sdhci-pxav2.c
> +
> +#define SD_FIFO_PARAM		0xe0
> +#define DIS_PAD_SD_CLK_GATE	0x0400 /* Turn on/off Dynamic SD Clock Gating */
> +#define CLK_GATE_ON		0x0200 /* Disable/enable Clock Gate */
> +#define CLK_GATE_CTL		0x0100 /* Clock Gate Control */
> +#define CLK_GATE_SETTING_BITS	(DIS_PAD_SD_CLK_GATE | \
> +		CLK_GATE_ON | CLK_GATE_CTL)
> +
> +#define SD_CLOCK_BURST_SIZE_SETUP	0xe6
> +#define SDCLK_SEL_SHIFT		8
> +#define SDCLK_SEL_MASK		0x3
> +#define SDCLK_DELAY_SHIFT	10
> +#define SDCLK_DELAY_MASK	0x3c
> +
> +#define SD_CE_ATA_2		0xea
> +#define MMC_CARD		0x1000
> +#define MMC_WIDTH		0x0100
> +
> +static void pxav2_set_private_registers(struct sdhci_host *host, u8 mask)
> +{
> +	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
> +	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
> +
> +	if (mask == SDHCI_RESET_ALL) {
> +		u16 tmp = 0;
> +
> +		/*
> +		 * tune timing of read data/command when crc error happen
> +		 * no performance impact
> +		 */
> +		if (pdata->clk_delay_sel == 1) {
> +			tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
> +
> +			tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
> +			tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
> +				<< SDCLK_DELAY_SHIFT;
> +			tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
> +			tmp |= (1 & SDCLK_SEL_MASK) << SDCLK_SEL_SHIFT;
> +
> +			writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
> +		}

There are 3 possible value for clk_delay_sel.

0  == do not use clk_delay_cycles
1 == use programmed clk_delay_cycles value (the code above)
all other values use the sd_clk which was used to drive the output

The code about only handles 2 of the 3 cases

suggest

	(if (pdata->clk_delay_sel) {
> +		if (pdata->clk_delay_sel == 1) {
> +			tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
> +
> +			tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
> +			tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
> +				<< SDCLK_DELAY_SHIFT;
> +			tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
> +			tmp |= 1 << SDCLK_SEL_SHIFT;
> +
> +			writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
> +		} else {

> +			tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
> +			tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
> +			tmp |= 2  << SDCLK_SEL_SHIFT;
> +			writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
	           }
         }

Philip and Mark
> 
