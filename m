From: Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH v13 2/2] ARM: sunxi: Add driver for SD/MMC hosts found
 on Allwinner sunxi SoCs
Date: Mon, 12 May 2014 15:00:01 +0200
Message-ID: <5370C5D1.2070901@broadcom.com>
References: <1399896288-5826-1-git-send-email-hdegoede@redhat.com> <1399896288-5826-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:11914 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172AbaELNAH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 May 2014 09:00:07 -0400
In-Reply-To: <1399896288-5826-3-git-send-email-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mike Turquette <mturquette@linaro.org>, devicetree <devicetree@vger.kernel.org>, Emilio Lopez <emilio@elopez.com.ar>, linux-mmc@vger.kernel.org, linux-sunxi@googlegroups.com, =?UTF-8?B?RGF2aQ==?= =?UTF-8?B?ZCBMYW56ZW5kw7ZyZmVy?= <david.lanzendoerfer@o2s.ch>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On 05/12/2014 02:04 PM, Hans de Goede wrote:
> From: David Lanzend=C3=B6rfer<david.lanzendoerfer@o2s.ch>
>
> The Allwinner sunxi mmc host uses dma in bus-master mode using a buil=
t-in
> designware idmac controller, which is identical to the one found in t=
he mmc-dw
> hosts. However the rest of the host is not identical to mmc-dw, it de=
als with
> sending stop commands in hardware which makes it significantly differ=
ent
> from the mmc-dw devices.
>
> HdG: Various cleanups and fixes.

Just nitpicking, but usually the above line should be added below the=20
original signoff, so:

> Signed-off-by: David Lanzend=C3=B6rfer<david.lanzendoerfer@o2s.ch>
[hdegoede@redhat.com: various cleanups and fixes]
> Signed-off-by: Hans de Goede<hdegoede@redhat.com>

As is documented in SubmittingPatches.

Gr. AvS

> ---
>   .../devicetree/bindings/mmc/sunxi-mmc.txt          |   43 +
>   drivers/mmc/host/Kconfig                           |    7 +
>   drivers/mmc/host/Makefile                          |    2 +
>   drivers/mmc/host/sunxi-mmc.c                       | 1049 +++++++++=
+++++++++++
>   4 files changed, 1101 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mmc/sunxi-mmc.=
txt
>   create mode 100644 drivers/mmc/host/sunxi-mmc.c
>
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Do=
cumentation/devicetree/bindings/mmc/sunxi-mmc.txt
> new file mode 100644
> index 0000000..91b3a34
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> @@ -0,0 +1,43 @@
> +* Allwinner sunxi MMC controller
> +
> +The highspeed MMC host controller on Allwinner SoCs provides an inte=
rface
> +for MMC, SD and SDIO types of memory cards.
> +
> +Supported maximum speeds are the ones of the eMMC standard 4.5 as we=
ll
> +as the speed of SD standard 3.0.
> +Absolute maximum transfer rate is 200MB/s
> +
> +Required properties:
> + - compatible : "allwinner,sun4i-a10-mmc" or "allwinner,sun5i-a13-mm=
c"
> + - reg : mmc controller base registers
> + - clocks : a list with 2 phandle + clock specifier pairs
> + - clock-names : must contain "ahb" and "mmc"
> + - interrupts : mmc controller interrupt
> +
> +Optional properties:
> + - resets : phandle + reset specifier pair
> + - reset-names : must contain "ahb"
> + - for cd, bus-width and additional generic mmc parameters
> +   please refer to mmc.txt within this directory
> +
> +Examples:
> +	- Within .dtsi:
> +	mmc0: mmc@01c0f000 {
> +		compatible =3D "allwinner,sun5i-a13-mmc";
> +		reg =3D<0x01c0f000 0x1000>;
> +		clocks =3D<&ahb_gates 8>,<&mmc0_clk>;
> +		clock-names =3D "ahb", "mod";
> +		interrupts =3D<0 32 4>;
> +		status =3D "disabled";
> +	};
> +
> +	- Within dts:
> +	mmc0: mmc@01c0f000 {
> +		pinctrl-names =3D "default", "default";
> +		pinctrl-0 =3D<&mmc0_pins_a>;
> +		pinctrl-1 =3D<&mmc0_cd_pin_reference_design>;
> +		bus-width =3D<4>;
> +		cd-gpios =3D<&pio 7 1 0>; /* PH1 */
> +		cd-inverted;
> +		status =3D "okay";
> +	};
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8aaf8c1..d50ac1c 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -694,3 +694,10 @@ config MMC_REALTEK_PCI
>   	help
>   	  Say Y here to include driver code to support SD/MMC card interfa=
ce
>   	  of Realtek PCI-E card reader
> +
> +config MMC_SUNXI
> +	tristate "Allwinner sunxi SD/MMC Host Controller support"
> +	depends on ARCH_SUNXI
> +	help
> +	  This selects support for the SD/MMC Host Controller on
> +	  Allwinner sunxi SoCs.
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 0c8aa5e..c706c0f 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -53,6 +53,8 @@ obj-$(CONFIG_MMC_WMT)		+=3D wmt-sdmmc.o
>
>   obj-$(CONFIG_MMC_REALTEK_PCI)	+=3D rtsx_pci_sdmmc.o
>
> +obj-$(CONFIG_MMC_SUNXI)		+=3D sunxi-mmc.o
> +
>   obj-$(CONFIG_MMC_SDHCI_PLTFM)		+=3D sdhci-pltfm.o
>   obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+=3D sdhci-cns3xxx.o
>   obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+=3D sdhci-esdhc-imx.o
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mm=
c.c
> new file mode 100644
> index 0000000..11bd48f
> --- /dev/null
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -0,0 +1,1049 @@
> +/*
> + * Driver for sunxi SD/MMC host controllers
> + * (C) Copyright 2007-2011 Reuuimlla Technology Co., Ltd.
> + * (C) Copyright 2007-2011 Aaron Maoye<leafy.myeh@reuuimllatech.com>
> + * (C) Copyright 2013-2014 O2S GmbH<www.o2s.ch>
> + * (C) Copyright 2013-2014 David Lanzend=EF=BF=BDrfer<david.lanzendo=
erfer@o2s.ch>
> + * (C) Copyright 2013-2014 Hans de Goede<hdegoede@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#include<linux/kernel.h>
> +#include<linux/module.h>
> +#include<linux/io.h>
> +#include<linux/device.h>
> +#include<linux/interrupt.h>
> +#include<linux/delay.h>
> +#include<linux/err.h>
> +
> +#include<linux/clk.h>
> +#include<linux/clk-private.h>
> +#include<linux/clk/sunxi.h>
> +
> +#include<linux/gpio.h>
> +#include<linux/platform_device.h>
> +#include<linux/spinlock.h>
> +#include<linux/scatterlist.h>
> +#include<linux/dma-mapping.h>
> +#include<linux/slab.h>
> +#include<linux/reset.h>
> +
> +#include<linux/of_address.h>
> +#include<linux/of_gpio.h>
> +#include<linux/of_platform.h>
> +
> +#include<linux/mmc/host.h>
> +#include<linux/mmc/sd.h>
> +#include<linux/mmc/sdio.h>
> +#include<linux/mmc/mmc.h>
> +#include<linux/mmc/core.h>
> +#include<linux/mmc/card.h>
> +#include<linux/mmc/slot-gpio.h>
> +
> +/* register offset definitions */
> +#define SDXC_REG_GCTRL	(0x00) /* SMC Global Control Register */
> +#define SDXC_REG_CLKCR	(0x04) /* SMC Clock Control Register */
> +#define SDXC_REG_TMOUT	(0x08) /* SMC Time Out Register */
> +#define SDXC_REG_WIDTH	(0x0C) /* SMC Bus Width Register */
> +#define SDXC_REG_BLKSZ	(0x10) /* SMC Block Size Register */
> +#define SDXC_REG_BCNTR	(0x14) /* SMC Byte Count Register */
> +#define SDXC_REG_CMDR	(0x18) /* SMC Command Register */
> +#define SDXC_REG_CARG	(0x1C) /* SMC Argument Register */
> +#define SDXC_REG_RESP0	(0x20) /* SMC Response Register 0 */
> +#define SDXC_REG_RESP1	(0x24) /* SMC Response Register 1 */
> +#define SDXC_REG_RESP2	(0x28) /* SMC Response Register 2 */
> +#define SDXC_REG_RESP3	(0x2C) /* SMC Response Register 3 */
> +#define SDXC_REG_IMASK	(0x30) /* SMC Interrupt Mask Register */
> +#define SDXC_REG_MISTA	(0x34) /* SMC Masked Interrupt Status Registe=
r */
> +#define SDXC_REG_RINTR	(0x38) /* SMC Raw Interrupt Status Register *=
/
> +#define SDXC_REG_STAS	(0x3C) /* SMC Status Register */
> +#define SDXC_REG_FTRGL	(0x40) /* SMC FIFO Threshold Watermark Regist=
e */
> +#define SDXC_REG_FUNS	(0x44) /* SMC Function Select Register */
> +#define SDXC_REG_CBCR	(0x48) /* SMC CIU Byte Count Register */
> +#define SDXC_REG_BBCR	(0x4C) /* SMC BIU Byte Count Register */
> +#define SDXC_REG_DBGC	(0x50) /* SMC Debug Enable Register */
> +#define SDXC_REG_HWRST	(0x78) /* SMC Card Hardware Reset for Registe=
r */
> +#define SDXC_REG_DMAC	(0x80) /* SMC IDMAC Control Register */
> +#define SDXC_REG_DLBA	(0x84) /* SMC IDMAC Descriptor List Base Addre=
 */
> +#define SDXC_REG_IDST	(0x88) /* SMC IDMAC Status Register */
> +#define SDXC_REG_IDIE	(0x8C) /* SMC IDMAC Interrupt Enable Register =
*/
> +#define SDXC_REG_CHDA	(0x90)
> +#define SDXC_REG_CBDA	(0x94)
> +
> +#define mmc_readl(host, reg) \
> +	readl((host)->reg_base + SDXC_##reg)
> +#define mmc_writel(host, reg, value) \
> +	writel((value), (host)->reg_base + SDXC_##reg)
> +
> +/* global control register bits */
> +#define SDXC_SOFT_RESET			BIT(0)
> +#define SDXC_FIFO_RESET			BIT(1)
> +#define SDXC_DMA_RESET			BIT(2)
> +#define SDXC_INTERRUPT_ENABLE_BIT	BIT(4)
> +#define SDXC_DMA_ENABLE_BIT		BIT(5)
> +#define SDXC_DEBOUNCE_ENABLE_BIT	BIT(8)
> +#define SDXC_POSEDGE_LATCH_DATA		BIT(9)
> +#define SDXC_DDR_MODE			BIT(10)
> +#define SDXC_MEMORY_ACCESS_DONE		BIT(29)
> +#define SDXC_ACCESS_DONE_DIRECT		BIT(30)
> +#define SDXC_ACCESS_BY_AHB		BIT(31)
> +#define SDXC_ACCESS_BY_DMA		(0<<  31)
> +#define SDXC_HARDWARE_RESET \
> +	(SDXC_SOFT_RESET | SDXC_FIFO_RESET | SDXC_DMA_RESET)
> +
> +/* clock control bits */
> +#define SDXC_CARD_CLOCK_ON		BIT(16)
> +#define SDXC_LOW_POWER_ON		BIT(17)
> +
> +/* bus width */
> +#define SDXC_WIDTH1			0
> +#define SDXC_WIDTH4			1
> +#define SDXC_WIDTH8			2
> +
> +/* smc command bits */
> +#define SDXC_RESP_EXPIRE		BIT(6)
> +#define SDXC_LONG_RESPONSE		BIT(7)
> +#define SDXC_CHECK_RESPONSE_CRC		BIT(8)
> +#define SDXC_DATA_EXPIRE		BIT(9)
> +#define SDXC_WRITE			BIT(10)
> +#define SDXC_SEQUENCE_MODE		BIT(11)
> +#define SDXC_SEND_AUTO_STOP		BIT(12)
> +#define SDXC_WAIT_PRE_OVER		BIT(13)
> +#define SDXC_STOP_ABORT_CMD		BIT(14)
> +#define SDXC_SEND_INIT_SEQUENCE		BIT(15)
> +#define SDXC_UPCLK_ONLY			BIT(21)
> +#define SDXC_READ_CEATA_DEV		BIT(22)
> +#define SDXC_CCS_EXPIRE			BIT(23)
> +#define SDXC_ENABLE_BIT_BOOT		BIT(24)
> +#define SDXC_ALT_BOOT_OPTIONS		BIT(25)
> +#define SDXC_BOOT_ACK_EXPIRE		BIT(26)
> +#define SDXC_BOOT_ABORT			BIT(27)
> +#define SDXC_VOLTAGE_SWITCH	        BIT(28)
> +#define SDXC_USE_HOLD_REGISTER	        BIT(29)
> +#define SDXC_START			BIT(31)
> +
> +/* interrupt bits */
> +#define SDXC_RESP_ERROR			BIT(1)
> +#define SDXC_COMMAND_DONE		BIT(2)
> +#define SDXC_DATA_OVER			BIT(3)
> +#define SDXC_TX_DATA_REQUEST		BIT(4)
> +#define SDXC_RX_DATA_REQUEST		BIT(5)
> +#define SDXC_RESP_CRC_ERROR		BIT(6)
> +#define SDXC_DATA_CRC_ERROR		BIT(7)
> +#define SDXC_RESP_TIMEOUT		BIT(8)
> +#define SDXC_DATA_TIMEOUT		BIT(9)
> +#define SDXC_VOLTAGE_CHANGE_DONE	BIT(10)
> +#define SDXC_FIFO_RUN_ERROR		BIT(11)
> +#define SDXC_HARD_WARE_LOCKED		BIT(12)
> +#define SDXC_START_BIT_ERROR		BIT(13)
> +#define SDXC_AUTO_COMMAND_DONE		BIT(14)
> +#define SDXC_END_BIT_ERROR		BIT(15)
> +#define SDXC_SDIO_INTERRUPT		BIT(16)
> +#define SDXC_CARD_INSERT		BIT(30)
> +#define SDXC_CARD_REMOVE		BIT(31)
> +#define SDXC_INTERRUPT_ERROR_BIT \
> +	(SDXC_RESP_ERROR | SDXC_RESP_CRC_ERROR | SDXC_DATA_CRC_ERROR | \
> +	 SDXC_RESP_TIMEOUT | SDXC_DATA_TIMEOUT | SDXC_FIFO_RUN_ERROR | \
> +	 SDXC_HARD_WARE_LOCKED | SDXC_START_BIT_ERROR | SDXC_END_BIT_ERROR)
> +#define SDXC_INTERRUPT_DONE_BIT \
> +	(SDXC_AUTO_COMMAND_DONE | SDXC_DATA_OVER | \
> +	 SDXC_COMMAND_DONE | SDXC_VOLTAGE_CHANGE_DONE)
> +
> +/* status */
> +#define SDXC_RXWL_FLAG			BIT(0)
> +#define SDXC_TXWL_FLAG			BIT(1)
> +#define SDXC_FIFO_EMPTY			BIT(2)
> +#define SDXC_FIFO_FULL			BIT(3)
> +#define SDXC_CARD_PRESENT		BIT(8)
> +#define SDXC_CARD_DATA_BUSY		BIT(9)
> +#define SDXC_DATA_FSM_BUSY		BIT(10)
> +#define SDXC_DMA_REQUEST		BIT(31)
> +#define SDXC_FIFO_SIZE			16
> +
> +/* Function select */
> +#define SDXC_CEATA_ON			(0xceaa<<  16)
> +#define SDXC_SEND_IRQ_RESPONSE		BIT(0)
> +#define SDXC_SDIO_READ_WAIT		BIT(1)
> +#define SDXC_ABORT_READ_DATA		BIT(2)
> +#define SDXC_SEND_CCSD			BIT(8)
> +#define SDXC_SEND_AUTO_STOPCCSD		BIT(9)
> +#define SDXC_CEATA_DEV_IRQ_ENABLE	BIT(10)
> +
> +/* IDMA controller bus mod bit field */
> +#define SDXC_IDMAC_SOFT_RESET		BIT(0)
> +#define SDXC_IDMAC_FIX_BURST		BIT(1)
> +#define SDXC_IDMAC_IDMA_ON		BIT(7)
> +#define SDXC_IDMAC_REFETCH_DES		BIT(31)
> +
> +/* IDMA status bit field */
> +#define SDXC_IDMAC_TRANSMIT_INTERRUPT		BIT(0)
> +#define SDXC_IDMAC_RECEIVE_INTERRUPT		BIT(1)
> +#define SDXC_IDMAC_FATAL_BUS_ERROR		BIT(2)
> +#define SDXC_IDMAC_DESTINATION_INVALID		BIT(4)
> +#define SDXC_IDMAC_CARD_ERROR_SUM		BIT(5)
> +#define SDXC_IDMAC_NORMAL_INTERRUPT_SUM		BIT(8)
> +#define SDXC_IDMAC_ABNORMAL_INTERRUPT_SUM	BIT(9)
> +#define SDXC_IDMAC_HOST_ABORT_INTERRUPT		BIT(10)
> +#define SDXC_IDMAC_IDLE				(0<<  13)
> +#define SDXC_IDMAC_SUSPEND			(1<<  13)
> +#define SDXC_IDMAC_DESC_READ			(2<<  13)
> +#define SDXC_IDMAC_DESC_CHECK			(3<<  13)
> +#define SDXC_IDMAC_READ_REQUEST_WAIT		(4<<  13)
> +#define SDXC_IDMAC_WRITE_REQUEST_WAIT		(5<<  13)
> +#define SDXC_IDMAC_READ				(6<<  13)
> +#define SDXC_IDMAC_WRITE			(7<<  13)
> +#define SDXC_IDMAC_DESC_CLOSE			(8<<  13)
> +
> +/*
> +* If the idma-des-size-bits of property is ie 13, bufsize bits are:
> +*  Bits  0-12: buf1 size
> +*  Bits 13-25: buf2 size
> +*  Bits 26-31: not used
> +* Since we only ever set buf1 size, we can simply store it directly.
> +*/
> +#define SDXC_IDMAC_DES0_DIC	BIT(1)  /* disable interrupt on completi=
on */
> +#define SDXC_IDMAC_DES0_LD	BIT(2)  /* last descriptor */
> +#define SDXC_IDMAC_DES0_FD	BIT(3)  /* first descriptor */
> +#define SDXC_IDMAC_DES0_CH	BIT(4)  /* chain mode */
> +#define SDXC_IDMAC_DES0_ER	BIT(5)  /* end of ring */
> +#define SDXC_IDMAC_DES0_CES	BIT(30) /* card error summary */
> +#define SDXC_IDMAC_DES0_OWN	BIT(31) /* 1-idma owns it, 0-host owns i=
t */
> +
> +struct sunxi_idma_des {
> +	u32	config;
> +	u32	buf_size;
> +	u32	buf_addr_ptr1;
> +	u32	buf_addr_ptr2;
> +};
> +
> +struct sunxi_mmc_host {
> +	struct mmc_host	*mmc;
> +	struct reset_control *reset;
> +
> +	/* IO mapping base */
> +	void __iomem	*reg_base;
> +
> +	/* clock management */
> +	struct clk	*clk_ahb;
> +	struct clk	*clk_mmc;
> +
> +	/* irq */
> +	spinlock_t	lock;
> +	int		irq;
> +	u32		int_sum;
> +	u32		sdio_imask;
> +
> +	/* dma */
> +	u32		idma_des_size_bits;
> +	dma_addr_t	sg_dma;
> +	void		*sg_cpu;
> +	bool		wait_dma;
> +
> +	struct mmc_request *mrq;
> +	struct mmc_request *manual_stop_mrq;
> +	int		ferror;
> +};
> +
> +static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
> +{
> +	unsigned long expire =3D jiffies + msecs_to_jiffies(250);
> +	u32 rval;
> +
> +	mmc_writel(host, REG_CMDR, SDXC_HARDWARE_RESET);
> +	do {
> +		rval =3D mmc_readl(host, REG_GCTRL);
> +	} while (time_before(jiffies, expire)&&  (rval&  SDXC_HARDWARE_RESE=
T));
> +
> +	if (rval&  SDXC_HARDWARE_RESET) {
> +		dev_err(mmc_dev(host->mmc), "fatal err reset timeout\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sunxi_mmc_init_host(struct mmc_host *mmc)
> +{
> +	u32 rval;
> +	struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> +
> +	if (sunxi_mmc_reset_host(host))
> +		return -EIO;
> +
> +	mmc_writel(host, REG_FTRGL, 0x20070008);
> +	mmc_writel(host, REG_TMOUT, 0xffffffff);
> +	mmc_writel(host, REG_IMASK, host->sdio_imask);
> +	mmc_writel(host, REG_RINTR, 0xffffffff);
> +	mmc_writel(host, REG_DBGC, 0xdeb);
> +	mmc_writel(host, REG_FUNS, SDXC_CEATA_ON);
> +	mmc_writel(host, REG_DLBA, host->sg_dma);
> +
> +	rval =3D mmc_readl(host, REG_GCTRL);
> +	rval |=3D SDXC_INTERRUPT_ENABLE_BIT;
> +	rval&=3D ~SDXC_ACCESS_DONE_DIRECT;
> +	mmc_writel(host, REG_GCTRL, rval);
> +
> +	return 0;
> +}
> +
> +static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
> +				    struct mmc_data *data)
> +{
> +	struct sunxi_idma_des *pdes =3D (struct sunxi_idma_des *)host->sg_c=
pu;
> +	struct sunxi_idma_des *pdes_pa =3D (struct sunxi_idma_des *)host->s=
g_dma;
> +	int i, max_len =3D (1<<  host->idma_des_size_bits);
> +
> +	for (i =3D 0; i<  data->sg_len; i++) {
> +		pdes[i].config =3D SDXC_IDMAC_DES0_CH | SDXC_IDMAC_DES0_OWN |
> +				 SDXC_IDMAC_DES0_DIC;
> +
> +		if (data->sg[i].length =3D=3D max_len)
> +			pdes[i].buf_size =3D 0; /* 0 =3D=3D max_len */
> +		else
> +			pdes[i].buf_size =3D data->sg[i].length;
> +
> +		pdes[i].buf_addr_ptr1 =3D sg_dma_address(&data->sg[i]);
> +		pdes[i].buf_addr_ptr2 =3D (u32)&pdes_pa[i + 1];
> +	}
> +
> +	pdes[0].config |=3D SDXC_IDMAC_DES0_FD;
> +	pdes[i - 1].config =3D SDXC_IDMAC_DES0_OWN | SDXC_IDMAC_DES0_LD;
> +
> +	/*
> +	 * Avoid the io-store starting the idmac hitting io-mem before the
> +	 * descriptors hit the main-mem.
> +	 */
> +	wmb();
> +}
> +
> +static enum dma_data_direction sunxi_mmc_get_dma_dir(struct mmc_data=
 *data)
> +{
> +	if (data->flags&  MMC_DATA_WRITE)
> +		return DMA_TO_DEVICE;
> +	else
> +		return DMA_FROM_DEVICE;
> +}
> +
> +static int sunxi_mmc_map_dma(struct sunxi_mmc_host *host,
> +			     struct mmc_data *data)
> +{
> +	u32 i, dma_len;
> +	struct scatterlist *sg;
> +
> +	dma_len =3D dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +			     sunxi_mmc_get_dma_dir(data));
> +	if (dma_len =3D=3D 0) {
> +		dev_err(mmc_dev(host->mmc), "dma_map_sg failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	for_each_sg(data->sg, sg, data->sg_len, i) {
> +		if (sg->offset&  3 || sg->length&  3) {
> +			dev_err(mmc_dev(host->mmc),
> +				"unaligned scatterlist: os %x length %d\n",
> +				sg->offset, sg->length);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void sunxi_mmc_start_dma(struct sunxi_mmc_host *host,
> +				struct mmc_data *data)
> +{
> +	u32 rval;
> +
> +	sunxi_mmc_init_idma_des(host, data);
> +
> +	rval =3D mmc_readl(host, REG_GCTRL);
> +	rval |=3D SDXC_DMA_ENABLE_BIT;
> +	mmc_writel(host, REG_GCTRL, rval);
> +	rval |=3D SDXC_DMA_RESET;
> +	mmc_writel(host, REG_GCTRL, rval);
> +
> +	mmc_writel(host, REG_DMAC, SDXC_IDMAC_SOFT_RESET);
> +
> +	if (!(data->flags&  MMC_DATA_WRITE))
> +		mmc_writel(host, REG_IDIE, SDXC_IDMAC_RECEIVE_INTERRUPT);
> +
> +	mmc_writel(host, REG_DMAC,
> +		   SDXC_IDMAC_FIX_BURST | SDXC_IDMAC_IDMA_ON);
> +}
> +
> +static void sunxi_mmc_send_manual_stop(struct sunxi_mmc_host *host,
> +				       struct mmc_request *req)
> +{
> +	u32 arg, cmd_val, ri;
> +	unsigned long expire =3D jiffies + msecs_to_jiffies(1000);
> +
> +	cmd_val =3D SDXC_START | SDXC_RESP_EXPIRE |
> +		  SDXC_STOP_ABORT_CMD | SDXC_CHECK_RESPONSE_CRC;
> +
> +	if (req->cmd->opcode =3D=3D SD_IO_RW_EXTENDED) {
> +		cmd_val |=3D SD_IO_RW_DIRECT;
> +		arg =3D (1<<  31) | (0<<  28) | (SDIO_CCCR_ABORT<<  9) |
> +		      ((req->cmd->arg>>  28)&  0x7);
> +	} else {
> +		cmd_val |=3D MMC_STOP_TRANSMISSION;
> +		arg =3D 0;
> +	}
> +
> +	mmc_writel(host, REG_CARG, arg);
> +	mmc_writel(host, REG_CMDR, cmd_val);
> +
> +	do {
> +		ri =3D mmc_readl(host, REG_RINTR);
> +	} while (!(ri&  (SDXC_COMMAND_DONE | SDXC_INTERRUPT_ERROR_BIT))&&
> +		 time_before(jiffies, expire));
> +
> +	if (!(ri&  SDXC_COMMAND_DONE) || (ri&  SDXC_INTERRUPT_ERROR_BIT)) {
> +		dev_err(mmc_dev(host->mmc), "send stop command failed\n");
> +		if (req->stop)
> +			req->stop->resp[0] =3D -ETIMEDOUT;
> +	} else {
> +		if (req->stop)
> +			req->stop->resp[0] =3D mmc_readl(host, REG_RESP0);
> +	}
> +
> +	mmc_writel(host, REG_RINTR, 0xffff);
> +}
> +
> +static void sunxi_mmc_dump_errinfo(struct sunxi_mmc_host *host)
> +{
> +	struct mmc_command *cmd =3D host->mrq->cmd;
> +	struct mmc_data *data =3D host->mrq->data;
> +
> +	/* For some cmds timeout is normal with sd/mmc cards */
> +	if ((host->int_sum&  SDXC_INTERRUPT_ERROR_BIT) =3D=3D
> +		SDXC_RESP_TIMEOUT&&  (cmd->opcode =3D=3D SD_IO_SEND_OP_COND ||
> +				      cmd->opcode =3D=3D SD_IO_RW_DIRECT))
> +		return;
> +
> +	dev_err(mmc_dev(host->mmc),
> +		"smc %d err, cmd %d,%s%s%s%s%s%s%s%s%s%s !!\n",
> +		host->mmc->index, cmd->opcode,
> +		data ? (data->flags&  MMC_DATA_WRITE ? " WR" : " RD") : "",
> +		host->int_sum&  SDXC_RESP_ERROR     ? " RE"     : "",
> +		host->int_sum&  SDXC_RESP_CRC_ERROR  ? " RCE"    : "",
> +		host->int_sum&  SDXC_DATA_CRC_ERROR  ? " DCE"    : "",
> +		host->int_sum&  SDXC_RESP_TIMEOUT ? " RTO"    : "",
> +		host->int_sum&  SDXC_DATA_TIMEOUT ? " DTO"    : "",
> +		host->int_sum&  SDXC_FIFO_RUN_ERROR  ? " FE"     : "",
> +		host->int_sum&  SDXC_HARD_WARE_LOCKED ? " HL"     : "",
> +		host->int_sum&  SDXC_START_BIT_ERROR ? " SBE"    : "",
> +		host->int_sum&  SDXC_END_BIT_ERROR   ? " EBE"    : ""
> +		);
> +}
> +
> +/* Called in interrupt context! */
> +static irqreturn_t sunxi_mmc_finalize_request(struct sunxi_mmc_host =
*host)
> +{
> +	struct mmc_request *mrq =3D host->mrq;
> +	struct mmc_data *data =3D mrq->data;
> +	u32 rval;
> +
> +	mmc_writel(host, REG_IMASK, host->sdio_imask);
> +	mmc_writel(host, REG_IDIE, 0);
> +
> +	if (host->int_sum&  SDXC_INTERRUPT_ERROR_BIT) {
> +		sunxi_mmc_dump_errinfo(host);
> +		mrq->cmd->error =3D -ETIMEDOUT;
> +
> +		if (data) {
> +			data->error =3D -ETIMEDOUT;
> +			host->manual_stop_mrq =3D mrq;
> +		}
> +
> +		if (mrq->stop)
> +			mrq->stop->error =3D -ETIMEDOUT;
> +	} else {
> +		if (mrq->cmd->flags&  MMC_RSP_136) {
> +			mrq->cmd->resp[0] =3D mmc_readl(host, REG_RESP3);
> +			mrq->cmd->resp[1] =3D mmc_readl(host, REG_RESP2);
> +			mrq->cmd->resp[2] =3D mmc_readl(host, REG_RESP1);
> +			mrq->cmd->resp[3] =3D mmc_readl(host, REG_RESP0);
> +		} else {
> +			mrq->cmd->resp[0] =3D mmc_readl(host, REG_RESP0);
> +		}
> +
> +		if (data)
> +			data->bytes_xfered =3D data->blocks * data->blksz;
> +	}
> +
> +	if (data) {
> +		mmc_writel(host, REG_IDST, 0x337);
> +		mmc_writel(host, REG_DMAC, 0);
> +		rval =3D mmc_readl(host, REG_GCTRL);
> +		rval |=3D SDXC_DMA_RESET;
> +		mmc_writel(host, REG_GCTRL, rval);
> +		rval&=3D ~SDXC_DMA_ENABLE_BIT;
> +		mmc_writel(host, REG_GCTRL, rval);
> +		rval |=3D SDXC_FIFO_RESET;
> +		mmc_writel(host, REG_GCTRL, rval);
> +		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +				     sunxi_mmc_get_dma_dir(data));
> +	}
> +
> +	mmc_writel(host, REG_RINTR, 0xffff);
> +
> +	host->mrq =3D NULL;
> +	host->int_sum =3D 0;
> +	host->wait_dma =3D false;
> +
> +	return host->manual_stop_mrq ? IRQ_WAKE_THREAD : IRQ_HANDLED;
> +}
> +
> +static irqreturn_t sunxi_mmc_irq(int irq, void *dev_id)
> +{
> +	struct sunxi_mmc_host *host =3D dev_id;
> +	struct mmc_request *mrq;
> +	u32 msk_int, idma_int;
> +	bool finalize =3D false;
> +	bool sdio_int =3D false;
> +	irqreturn_t ret =3D IRQ_HANDLED;
> +
> +	spin_lock(&host->lock);
> +
> +	idma_int  =3D mmc_readl(host, REG_IDST);
> +	msk_int   =3D mmc_readl(host, REG_MISTA);
> +
> +	dev_dbg(mmc_dev(host->mmc), "irq: rq %p mi %08x idi %08x\n",
> +		host->mrq, msk_int, idma_int);
> +
> +	mrq =3D host->mrq;
> +	if (mrq) {
> +		if (idma_int&  SDXC_IDMAC_RECEIVE_INTERRUPT)
> +			host->wait_dma =3D false;
> +
> +		host->int_sum |=3D msk_int;
> +
> +		/* Wait for COMMAND_DONE on RESPONSE_TIMEOUT before finalize */
> +		if ((host->int_sum&  SDXC_RESP_TIMEOUT)&&
> +				!(host->int_sum&  SDXC_COMMAND_DONE))
> +			mmc_writel(host, REG_IMASK,
> +				   host->sdio_imask | SDXC_COMMAND_DONE);
> +		/* Don't wait for dma on error */
> +		else if (host->int_sum&  SDXC_INTERRUPT_ERROR_BIT)
> +			finalize =3D true;
> +		else if ((host->int_sum&  SDXC_INTERRUPT_DONE_BIT)&&
> +				!host->wait_dma)
> +			finalize =3D true;
> +	}
> +
> +	if (msk_int&  SDXC_SDIO_INTERRUPT)
> +		sdio_int =3D true;
> +
> +	mmc_writel(host, REG_RINTR, msk_int);
> +	mmc_writel(host, REG_IDST, idma_int);
> +
> +	if (finalize)
> +		ret =3D sunxi_mmc_finalize_request(host);
> +
> +	spin_unlock(&host->lock);
> +
> +	if (finalize&&  ret =3D=3D IRQ_HANDLED)
> +		mmc_request_done(host->mmc, mrq);
> +
> +	if (sdio_int)
> +		mmc_signal_sdio_irq(host->mmc);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t sunxi_mmc_handle_manual_stop(int irq, void *dev_i=
d)
> +{
> +	struct sunxi_mmc_host *host =3D dev_id;
> +	struct mmc_request *mrq;
> +	unsigned long iflags;
> +
> +	spin_lock_irqsave(&host->lock, iflags);
> +	mrq =3D host->manual_stop_mrq;
> +	spin_unlock_irqrestore(&host->lock, iflags);
> +
> +	if (!mrq) {
> +		dev_err(mmc_dev(host->mmc), "no request for manual stop\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	dev_err(mmc_dev(host->mmc), "data error, sending stop command\n");
> +	sunxi_mmc_send_manual_stop(host, mrq);
> +
> +	spin_lock_irqsave(&host->lock, iflags);
> +	host->manual_stop_mrq =3D NULL;
> +	spin_unlock_irqrestore(&host->lock, iflags);
> +
> +	mmc_request_done(host->mmc, mrq);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 ocl=
k_en)
> +{
> +	unsigned long expire =3D jiffies + msecs_to_jiffies(250);
> +	u32 rval;
> +
> +	rval =3D mmc_readl(host, REG_CLKCR);
> +	rval&=3D ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON);
> +
> +	if (oclk_en)
> +		rval |=3D SDXC_CARD_CLOCK_ON;
> +
> +	mmc_writel(host, REG_CLKCR, rval);
> +
> +	rval =3D SDXC_START | SDXC_UPCLK_ONLY | SDXC_WAIT_PRE_OVER;
> +	mmc_writel(host, REG_CMDR, rval);
> +
> +	do {
> +		rval =3D mmc_readl(host, REG_CMDR);
> +	} while (time_before(jiffies, expire)&&  (rval&  SDXC_START));
> +
> +	/* clear irq status bits set by the command */
> +	mmc_writel(host, REG_RINTR,
> +		   mmc_readl(host, REG_RINTR)&  ~SDXC_SDIO_INTERRUPT);
> +
> +	if (rval&  SDXC_START) {
> +		dev_err(mmc_dev(host->mmc), "fatal err update clk timeout\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
> +				  struct mmc_ios *ios)
> +{
> +	u32 rate, oclk_dly, rval, sclk_dly, src_clk;
> +	int ret;
> +
> +	rate =3D clk_round_rate(host->clk_mmc, ios->clock);
> +	dev_dbg(mmc_dev(host->mmc), "setting clk to %d, rounded %d\n",
> +		ios->clock, rate);
> +
> +	/* setting clock rate */
> +	ret =3D clk_set_rate(host->clk_mmc, rate);
> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc), "error setting clk to %d: %d\n",
> +			rate, ret);
> +		return ret;
> +	}
> +
> +	ret =3D sunxi_mmc_oclk_onoff(host, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* clear internal divider */
> +	rval =3D mmc_readl(host, REG_CLKCR);
> +	rval&=3D ~0xff;
> +	mmc_writel(host, REG_CLKCR, rval);
> +
> +	/* determine delays */
> +	if (rate<=3D 400000) {
> +		oclk_dly =3D 0;
> +		sclk_dly =3D 7;
> +	} else if (rate<=3D 25000000) {
> +		oclk_dly =3D 0;
> +		sclk_dly =3D 5;
> +	} else if (rate<=3D 50000000) {
> +		if (ios->timing =3D=3D MMC_TIMING_UHS_DDR50) {
> +			oclk_dly =3D 2;
> +			sclk_dly =3D 4;
> +		} else {
> +			oclk_dly =3D 3;
> +			sclk_dly =3D 5;
> +		}
> +	} else {
> +		/* rate>  50000000 */
> +		oclk_dly =3D 2;
> +		sclk_dly =3D 4;
> +	}
> +
> +	src_clk =3D clk_get_rate(clk_get_parent(host->clk_mmc));
> +	if (src_clk>=3D 300000000&&  src_clk<=3D 400000000) {
> +		if (oclk_dly)
> +			oclk_dly--;
> +		if (sclk_dly)
> +			sclk_dly--;
> +	}
> +
> +	clk_sunxi_mmc_phase_control(host->clk_mmc, sclk_dly, oclk_dly);
> +
> +	return sunxi_mmc_oclk_onoff(host, 1);
> +}
> +
> +static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *=
ios)
> +{
> +	struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> +	u32 rval;
> +
> +	/* Set the power state */
> +	switch (ios->power_mode) {
> +	case MMC_POWER_ON:
> +		break;
> +
> +	case MMC_POWER_UP:
> +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
> +
> +		host->ferror =3D sunxi_mmc_init_host(mmc);
> +		if (host->ferror)
> +			return;
> +
> +		dev_dbg(mmc_dev(mmc), "power on!\n");
> +		break;
> +
> +	case MMC_POWER_OFF:
> +		dev_dbg(mmc_dev(mmc), "power off!\n");
> +		sunxi_mmc_reset_host(host);
> +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +		break;
> +	}
> +
> +	/* set bus width */
> +	switch (ios->bus_width) {
> +	case MMC_BUS_WIDTH_1:
> +		mmc_writel(host, REG_WIDTH, SDXC_WIDTH1);
> +		break;
> +	case MMC_BUS_WIDTH_4:
> +		mmc_writel(host, REG_WIDTH, SDXC_WIDTH4);
> +		break;
> +	case MMC_BUS_WIDTH_8:
> +		mmc_writel(host, REG_WIDTH, SDXC_WIDTH8);
> +		break;
> +	}
> +
> +	/* set ddr mode */
> +	rval =3D mmc_readl(host, REG_GCTRL);
> +	if (ios->timing =3D=3D MMC_TIMING_UHS_DDR50)
> +		rval |=3D SDXC_DDR_MODE;
> +	else
> +		rval&=3D ~SDXC_DDR_MODE;
> +	mmc_writel(host, REG_GCTRL, rval);
> +
> +	/* set up clock */
> +	if (ios->clock&&  ios->power_mode) {
> +		host->ferror =3D sunxi_mmc_clk_set_rate(host, ios);
> +		/* Android code had a usleep_range(50000, 55000); here */
> +	}
> +}
> +
> +static void sunxi_mmc_enable_sdio_irq(struct mmc_host *mmc, int enab=
le)
> +{
> +	struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> +	unsigned long flags;
> +	u32 imask;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	imask =3D mmc_readl(host, REG_IMASK);
> +	if (enable) {
> +		host->sdio_imask =3D SDXC_SDIO_INTERRUPT;
> +		imask |=3D SDXC_SDIO_INTERRUPT;
> +	} else {
> +		host->sdio_imask =3D 0;
> +		imask&=3D ~SDXC_SDIO_INTERRUPT;
> +	}
> +	mmc_writel(host, REG_IMASK, imask);
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +static void sunxi_mmc_hw_reset(struct mmc_host *mmc)
> +{
> +	struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> +	mmc_writel(host, REG_HWRST, 0);
> +	udelay(10);
> +	mmc_writel(host, REG_HWRST, 1);
> +	udelay(300);
> +}
> +
> +static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_reque=
st *mrq)
> +{
> +	struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> +	struct mmc_command *cmd =3D mrq->cmd;
> +	struct mmc_data *data =3D mrq->data;
> +	unsigned long iflags;
> +	u32 imask =3D SDXC_INTERRUPT_ERROR_BIT;
> +	u32 cmd_val =3D SDXC_START | (cmd->opcode&  0x3f);
> +	int ret;
> +
> +	/* Check for set_ios errors (should never happen) */
> +	if (host->ferror) {
> +		mrq->cmd->error =3D host->ferror;
> +		mmc_request_done(mmc, mrq);
> +		return;
> +	}
> +
> +	if (data) {
> +		ret =3D sunxi_mmc_map_dma(host, data);
> +		if (ret<  0) {
> +			dev_err(mmc_dev(mmc), "map DMA failed\n");
> +			cmd->error =3D ret;
> +			data->error =3D ret;
> +			mmc_request_done(mmc, mrq);
> +			return;
> +		}
> +	}
> +
> +	if (cmd->opcode =3D=3D MMC_GO_IDLE_STATE) {
> +		cmd_val |=3D SDXC_SEND_INIT_SEQUENCE;
> +		imask |=3D SDXC_COMMAND_DONE;
> +	}
> +
> +	if (cmd->flags&  MMC_RSP_PRESENT) {
> +		cmd_val |=3D SDXC_RESP_EXPIRE;
> +		if (cmd->flags&  MMC_RSP_136)
> +			cmd_val |=3D SDXC_LONG_RESPONSE;
> +		if (cmd->flags&  MMC_RSP_CRC)
> +			cmd_val |=3D SDXC_CHECK_RESPONSE_CRC;
> +
> +		if ((cmd->flags&  MMC_CMD_MASK) =3D=3D MMC_CMD_ADTC) {
> +			cmd_val |=3D SDXC_DATA_EXPIRE | SDXC_WAIT_PRE_OVER;
> +			if (cmd->data->flags&  MMC_DATA_STREAM) {
> +				imask |=3D SDXC_AUTO_COMMAND_DONE;
> +				cmd_val |=3D SDXC_SEQUENCE_MODE |
> +					   SDXC_SEND_AUTO_STOP;
> +			}
> +
> +			if (cmd->data->stop) {
> +				imask |=3D SDXC_AUTO_COMMAND_DONE;
> +				cmd_val |=3D SDXC_SEND_AUTO_STOP;
> +			} else {
> +				imask |=3D SDXC_DATA_OVER;
> +			}
> +
> +			if (cmd->data->flags&  MMC_DATA_WRITE)
> +				cmd_val |=3D SDXC_WRITE;
> +			else
> +				host->wait_dma =3D true;
> +		} else {
> +			imask |=3D SDXC_COMMAND_DONE;
> +		}
> +	} else {
> +		imask |=3D SDXC_COMMAND_DONE;
> +	}
> +
> +	dev_dbg(mmc_dev(mmc), "cmd %d(%08x) arg %x ie 0x%08x len %d\n",
> +		cmd_val&  0x3f, cmd_val, cmd->arg, imask,
> +		mrq->data ? mrq->data->blksz * mrq->data->blocks : 0);
> +
> +	spin_lock_irqsave(&host->lock, iflags);
> +
> +	if (host->mrq || host->manual_stop_mrq) {
> +		spin_unlock_irqrestore(&host->lock, iflags);
> +
> +		if (data)
> +			dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
> +				     sunxi_mmc_get_dma_dir(data));
> +
> +		dev_err(mmc_dev(mmc), "request already pending\n");
> +		mrq->cmd->error =3D -EBUSY;
> +		mmc_request_done(mmc, mrq);
> +		return;
> +	}
> +
> +	if (data) {
> +		mmc_writel(host, REG_BLKSZ, data->blksz);
> +		mmc_writel(host, REG_BCNTR, data->blksz * data->blocks);
> +		sunxi_mmc_start_dma(host, data);
> +	}
> +
> +	host->mrq =3D mrq;
> +	mmc_writel(host, REG_IMASK, host->sdio_imask | imask);
> +	mmc_writel(host, REG_CARG, cmd->arg);
> +	mmc_writel(host, REG_CMDR, cmd_val);
> +
> +	spin_unlock_irqrestore(&host->lock, iflags);
> +}
> +
> +static const struct of_device_id sunxi_mmc_of_match[] =3D {
> +	{ .compatible =3D "allwinner,sun4i-a10-mmc", },
> +	{ .compatible =3D "allwinner,sun5i-a13-mmc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
> +
> +static struct mmc_host_ops sunxi_mmc_ops =3D {
> +	.request	 =3D sunxi_mmc_request,
> +	.set_ios	 =3D sunxi_mmc_set_ios,
> +	.get_ro		 =3D mmc_gpio_get_ro,
> +	.get_cd		 =3D mmc_gpio_get_cd,
> +	.enable_sdio_irq =3D sunxi_mmc_enable_sdio_irq,
> +	.hw_reset	 =3D sunxi_mmc_hw_reset,
> +};
> +
> +static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
> +				      struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	int ret;
> +
> +	if (of_device_is_compatible(np, "allwinner,sun4i-a10-mmc"))
> +		host->idma_des_size_bits =3D 13;
> +	else
> +		host->idma_des_size_bits =3D 16;
> +
> +	ret =3D mmc_regulator_get_supply(host->mmc);
> +	if (ret) {
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Could not get vmmc supply\n");
> +		return ret;
> +	}
> +
> +	host->reg_base =3D devm_ioremap_resource(&pdev->dev,
> +			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
> +	if (IS_ERR(host->reg_base))
> +		return PTR_ERR(host->reg_base);
> +
> +	host->clk_ahb =3D devm_clk_get(&pdev->dev, "ahb");
> +	if (IS_ERR(host->clk_ahb)) {
> +		dev_err(&pdev->dev, "Could not get ahb clock\n");
> +		return PTR_ERR(host->clk_ahb);
> +	}
> +
> +	host->clk_mmc =3D devm_clk_get(&pdev->dev, "mmc");
> +	if (IS_ERR(host->clk_mmc)) {
> +		dev_err(&pdev->dev, "Could not get mmc clock\n");
> +		return PTR_ERR(host->clk_mmc);
> +	}
> +
> +	host->reset =3D devm_reset_control_get(&pdev->dev, "ahb");
> +
> +	ret =3D clk_prepare_enable(host->clk_ahb);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Enable ahb clk err %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D clk_prepare_enable(host->clk_mmc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Enable mmc clk err %d\n", ret);
> +		goto error_disable_clk_ahb;
> +	}
> +
> +	if (!IS_ERR(host->reset)) {
> +		ret =3D reset_control_deassert(host->reset);
> +		if (ret) {
> +			dev_err(&pdev->dev, "reset err %d\n", ret);
> +			goto error_disable_clk_mmc;
> +		}
> +	}
> +
> +	/*
> +	 * Sometimes the controller asserts the irq on boot for some reason=
,
> +	 * make sure the controller is in a sane state before enabling irqs=
=2E
> +	 */
> +	ret =3D sunxi_mmc_reset_host(host);
> +	if (ret)
> +		goto error_assert_reset;
> +
> +	host->irq =3D platform_get_irq(pdev, 0);
> +	return devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc_i=
rq,
> +			sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", host);
> +
> +error_assert_reset:
> +	if (!IS_ERR(host->reset))
> +		reset_control_assert(host->reset);
> +error_disable_clk_mmc:
> +	clk_disable_unprepare(host->clk_mmc);
> +error_disable_clk_ahb:
> +	clk_disable_unprepare(host->clk_ahb);
> +	return ret;
> +}
> +
> +static int sunxi_mmc_probe(struct platform_device *pdev)
> +{
> +	struct sunxi_mmc_host *host;
> +	struct mmc_host *mmc;
> +	int ret;
> +
> +	mmc =3D mmc_alloc_host(sizeof(struct sunxi_mmc_host),&pdev->dev);
> +	if (!mmc) {
> +		dev_err(&pdev->dev, "mmc alloc host failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	host =3D mmc_priv(mmc);
> +	host->mmc =3D mmc;
> +	spin_lock_init(&host->lock);
> +
> +	ret =3D sunxi_mmc_resource_request(host, pdev);
> +	if (ret)
> +		goto error_free_host;
> +
> +	host->sg_cpu =3D dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
> +					&host->sg_dma, GFP_KERNEL);
> +	if (!host->sg_cpu) {
> +		dev_err(&pdev->dev, "Failed to allocate DMA descriptor mem\n");
> +		ret =3D -ENOMEM;
> +		goto error_free_host;
> +	}
> +
> +	mmc->ops		=3D&sunxi_mmc_ops;
> +	mmc->max_blk_count	=3D 8192;
> +	mmc->max_blk_size	=3D 4096;
> +	mmc->max_segs		=3D PAGE_SIZE / sizeof(struct sunxi_idma_des);
> +	mmc->max_seg_size	=3D (1<<  host->idma_des_size_bits);
> +	mmc->max_req_size	=3D mmc->max_seg_size * mmc->max_segs;
> +	/* 400kHz ~ 50MHz */
> +	mmc->f_min		=3D   400000;
> +	mmc->f_max		=3D 50000000;
> +	mmc->caps	       |=3D MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
> +
> +	ret =3D mmc_of_parse(mmc);
> +	if (ret)
> +		goto error_free_dma;
> +
> +	ret =3D mmc_add_host(mmc);
> +	if (ret)
> +		goto error_free_dma;
> +
> +	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->ir=
q);
> +	platform_set_drvdata(pdev, mmc);
> +	return 0;
> +
> +error_free_dma:
> +	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma=
);
> +error_free_host:
> +	mmc_free_host(mmc);
> +	return ret;
> +}
> +
> +static int sunxi_mmc_remove(struct platform_device *pdev)
> +{
> +	struct mmc_host	*mmc =3D platform_get_drvdata(pdev);
> +	struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> +
> +	mmc_remove_host(mmc);
> +	disable_irq(host->irq);
> +	sunxi_mmc_reset_host(host);
> +
> +	if (!IS_ERR(host->reset))
> +		reset_control_assert(host->reset);
> +
> +	clk_disable_unprepare(host->clk_mmc);
> +	clk_disable_unprepare(host->clk_ahb);
> +
> +	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma=
);
> +	mmc_free_host(mmc);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sunxi_mmc_driver =3D {
> +	.driver =3D {
> +		.name	=3D "sunxi-mmc",
> +		.owner	=3D THIS_MODULE,
> +		.of_match_table =3D of_match_ptr(sunxi_mmc_of_match),
> +	},
> +	.probe		=3D sunxi_mmc_probe,
> +	.remove		=3D sunxi_mmc_remove,
> +};
> +module_platform_driver(sunxi_mmc_driver);
> +
> +MODULE_DESCRIPTION("Allwinner's SD/MMC Card Controller Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("David Lanzend=EF=BF=BDrfer<david.lanzendoerfer@o2s.ch=
>");
> +MODULE_ALIAS("platform:sunxi-mmc");
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

