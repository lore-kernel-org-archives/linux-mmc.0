Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A423C38C
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750305787; cv=none; b=O9bDff1bpsWiwMmmRSAt0AAUvUOWufWg2ENYoav7WcySpfcPh8cwOz0PR9Ng+2c+u9gR5hSCEBlO1MBnPFm7aRFKPCvqt/Y9BA2iJ22UOpyR7il1KCV6UJhDCmMwC5oLtfF1tOSN+eINWbqpM3BZtrdkdfb0NV83ueJgs9GuG/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750305787; c=relaxed/simple;
	bh=loUnQF53qfGF7MsdhyTLn1kcjupP/F4gx+N1Dqges4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilN19mrlYKkeUMrkjOSqJetTqhgH19c0SEfQ68WisjnmU45EHvunEBMRvu0s7FGUuMJjXeY6W/CdK6SPnYg085P4cgKrJkH2O4fYJBhES5q/zNByOaw/jO1yaxTQK1Cfodh/3ltlT2shDbNlp+ar1aUqVi1Y73VanFXdvxbxHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rg8gRdDH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rg8gRdDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7820C4CEEF
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 04:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750305787;
	bh=loUnQF53qfGF7MsdhyTLn1kcjupP/F4gx+N1Dqges4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rg8gRdDHA04AwAtEbLLe8mePZDgTj/PwbLI3jYi8f+27WO3iB9ZgHt8/gMvastjpK
	 jiv78Mr7d6ZaD64AsjHQOStsVD0A/031df1fNGDjB4M3VXDMtAcaA6sykc5I0xnadq
	 9VA1bb6ppTEJ7VkRWM05sCj0AcTkTWY1Clvdk2U0NmTvuMmF6jAMB19tJPv2fu3OBF
	 E6sk8Yk5DrjLI3cLwhmSo9vQZU3Cld3Nfe31A/NrNkV2Os7ZPNNxskSAqEpjyXtyXD
	 QwbzpI9eX2Ecleo7s3Fe4Rpm2/S737pQT/PP+5rksC8n+P8X7EtnLLXrfKZHNX26Er
	 TXSCtGRnpfBLw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60780d74bbaso567030a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jun 2025 21:03:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUk9So5SVt+ZpwFynOx6ZnLBAPZr+VyOBz0PJZF6aTx2U/PVRIXrMC8EIabmigqF7ZMpXGK+sSHbKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7O1/rxc/Yyi31zrSswEc7sNwAYdVXayt/F9MpSd7jBgspnL6
	r7DGhM+KrexE/sKp2iq/52D8ufEusaJgdD7/r77PbhSxHUW9QO8JwwrV+CPSkY5a1ONZTrDh3UP
	XmFOjAFRFD43Ds8Y0Z0zyjicoizulZR0=
X-Google-Smtp-Source: AGHT+IFJwTcaWmIAHNMyMUMVxV0KU1PyRuGDe19nqKuUWH9Ros9wHWqKYhCKtn2a3pokrogWr4anrq4hziOC+kL76TQ=
X-Received: by 2002:a05:6402:848:b0:602:7de0:b30f with SMTP id
 4fb4d7f45d1cf-609e406ad68mr1671607a12.16.1750305784954; Wed, 18 Jun 2025
 21:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750216134.git.zhoubinbin@loongson.cn> <abfe54473135df478db14b5ef0e1773326455f21.1750216134.git.zhoubinbin@loongson.cn>
In-Reply-To: <abfe54473135df478db14b5ef0e1773326455f21.1750216134.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 19 Jun 2025 12:02:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H46_tmyUbWV_i1YnjyK5xLw_yXd7YXxduk8-MaTsdquSA@mail.gmail.com>
X-Gm-Features: AX0GCFvvMjpQzocgDqmRkeG1ejoJdEDB8V5kPYHDNIhDFtdjpAYodgDV6tczlh4
Message-ID: <CAAhV-H46_tmyUbWV_i1YnjyK5xLw_yXd7YXxduk8-MaTsdquSA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mmc: loongson2: Add Loongson-2K SD/SDIO controller driver
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-mmc@vger.kernel.org, wanghongliang@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Binbin,

On Wed, Jun 18, 2025 at 4:08=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> The MMC controllers on the Loongson-2K series CPUs are similar,
> except for the interface characteristics and the use of DMA controllers.
>
> This patch describes the MMC controllers on the Loongson-2K0500/2K1000,
> with the distinguishing feature being the use of an externally shared
> APBDMA engine.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  MAINTAINERS                      |   1 +
>  drivers/mmc/host/Kconfig         |  13 +
>  drivers/mmc/host/Makefile        |   1 +
>  drivers/mmc/host/loongson2-mmc.c | 820 +++++++++++++++++++++++++++++++
>  4 files changed, 835 insertions(+)
>  create mode 100644 drivers/mmc/host/loongson2-mmc.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d1cdd2cfc2b..4a4892613c66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14180,6 +14180,7 @@ M:      Binbin Zhou <zhoubinbin@loongson.cn>
>  L:     linux-mmc@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
> +F:     drivers/mmc/host/loongson2-mmc.c
>
>  LOONGSON-2 SOC SERIES PM DRIVER
>  M:     Yinbo Zhu <zhuyinbo@loongson.cn>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index c3f0f41a426d..7232de1c0688 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1111,6 +1111,19 @@ config MMC_OWL
>           This selects support for the SD/MMC Host Controller on
>           Actions Semi Owl SoCs.
>
> +config MMC_LOONGSON2
> +       tristate "Loongson-2K SD/SDIO/eMMC Host Interface support"
> +       depends on LOONGARCH || COMPILE_TEST
> +       depends on HAS_DMA
> +       help
> +         This selects support for the SD/SDIO/eMMC Host Controller on
> +         Loongson-2K series CPUs.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called mmc_loongson2.
> +
> +         If unsure, say N.
> +
>  config MMC_SDHCI_EXTERNAL_DMA
>         bool
>
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 75bafc7b162b..5057fea8afb6 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_MMC_USDHI6ROL0)  +=3D usdhi6rol0.o
>  obj-$(CONFIG_MMC_TOSHIBA_PCI)  +=3D toshsd.o
>  obj-$(CONFIG_MMC_BCM2835)      +=3D bcm2835.o
>  obj-$(CONFIG_MMC_OWL)          +=3D owl-mmc.o
> +obj-$(CONFIG_MMC_LOONGSON2)    +=3D loongson2-mmc.o
>
>  obj-$(CONFIG_MMC_REALTEK_PCI)  +=3D rtsx_pci_sdmmc.o
>  obj-$(CONFIG_MMC_REALTEK_USB)  +=3D rtsx_usb_sdmmc.o
> diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson=
2-mmc.c
> new file mode 100644
> index 000000000000..872f5dc21b21
> --- /dev/null
> +++ b/drivers/mmc/host/loongson2-mmc.c
> @@ -0,0 +1,820 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Loongson-2K MMC/SDIO controller driver
> + *
> + * Copyright (C) 2018-2025 Loongson Technology Corporation Limited.
> + *
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitrev.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/mmc/core.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>
> +#include <linux/mmc/sdio.h>
> +#include <linux/mmc/slot-gpio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define LOONGSON2_MMC_REG_CTL          0x00 /* Control Register */
> +#define LOONGSON2_MMC_REG_PRE          0x04 /* Prescaler Register */
> +#define LOONGSON2_MMC_REG_CARG         0x08 /* Command Register */
> +#define LOONGSON2_MMC_REG_CCTL         0x0c /* Command Control Register =
*/
> +#define LOONGSON2_MMC_REG_CSTS         0x10 /* Command Status Register *=
/
> +#define LOONGSON2_MMC_REG_RSP0         0x14 /* Command Response Register=
 0 */
> +#define LOONGSON2_MMC_REG_RSP1         0x18 /* Command Response Register=
 1 */
> +#define LOONGSON2_MMC_REG_RSP2         0x1c /* Command Response Register=
 2 */
> +#define LOONGSON2_MMC_REG_RSP3         0x20 /* Command Response Register=
 3 */
> +#define LOONGSON2_MMC_REG_TIMER                0x24 /* Data Timeout Regi=
ster */
> +#define LOONGSON2_MMC_REG_BSIZE                0x28 /* Block Size Regist=
er */
> +#define LOONGSON2_MMC_REG_DCTL         0x2c /* Data Control Register */
> +#define LOONGSON2_MMC_REG_DCNT         0x30 /* Data Counter Register */
> +#define LOONGSON2_MMC_REG_DSTS         0x34 /* Data Status Register */
> +#define LOONGSON2_MMC_REG_FSTS         0x38 /* FIFO Status Register */
> +#define LOONGSON2_MMC_REG_INT          0x3c /* Interrupt Register */
> +#define LOONGSON2_MMC_REG_DATA         0x40 /* Data Register */
> +#define LOONGSON2_MMC_REG_IEN          0x64 /* Interrupt Enable Register=
 */
> +
> +/* Bitfields of control register */
> +#define LOONGSON2_MMC_CTL_ENCLK                BIT(0)
> +#define LOONGSON2_MMC_CTL_EXTCLK       BIT(1)
> +#define LOONGSON2_MMC_CTL_RESET                BIT(8)
> +
> +/* Bitfields of prescaler register */
> +#define LOONGSON2_MMC_PRE              GENMASK(9, 0)
> +#define LOONGSON2_MMC_PRE_EN           BIT(31)
> +
> +/* Bitfields of command control register */
> +#define LOONGSON2_MMC_CCTL_INDEX       GENMASK(5, 0)
> +#define LOONGSON2_MMC_CCTL_HOST                BIT(6)
> +#define LOONGSON2_MMC_CCTL_START       BIT(8)
> +#define LOONGSON2_MMC_CCTL_WAIT_RSP    BIT(9)
> +#define LOONGSON2_MMC_CCTL_LONG_RSP    BIT(10)
> +#define LOONGSON2_MMC_CCTL_ABORT       BIT(12)
> +#define LOONGSON2_MMC_CCTL_CHECK       BIT(13)
> +#define LOONGSON2_MMC_CCTL_SDIO                BIT(14)
> +#define LOONGSON2_MMC_CCTL_CMD6                BIT(18)
> +
> +/* Bitfields of command status register */
> +#define LOONGSON2_MMC_CSTS_INDEX       GENMASK(7, 0)
> +#define LOONGSON2_MMC_CSTS_ON          BIT(8)
> +#define LOONGSON2_MMC_CSTS_RSP         BIT(9)
> +#define LOONGSON2_MMC_CSTS_TIMEOUT     BIT(10)
> +#define LOONGSON2_MMC_CSTS_END         BIT(11)
> +#define LOONGSON2_MMC_CSTS_CRC_ERR     BIT(12)
> +#define LOONGSON2_MMC_CSTS_AUTO_STOP   BIT(13)
> +#define LOONGSON2_MMC_CSTS_FIN         BIT(14)
> +
> +/* Bitfields of data timeout register */
> +#define LOONGSON2_MMC_DTIMR            GENMASK(23, 0)
> +
> +/* Bitfields of block size register */
> +#define LOONGSON2_MMC_BSIZE            GENMASK(11, 0)
> +
> +/* Bitfields of data control register */
> +#define LOONGSON2_MMC_DCTL_BNUM                GENMASK(11, 0)
> +#define LOONGSON2_MMC_DCTL_START       BIT(14)
> +#define LOONGSON2_MMC_DCTL_ENDMA       BIT(15)
> +#define LOONGSON2_MMC_DCTL_WIDE                BIT(16)
> +#define LOONGSON2_MMC_DCTL_RWAIT       BIT(17)
> +#define LOONGSON2_MMC_DCTL_IO_SUSPEND  BIT(18)
> +#define LOONGSON2_MMC_DCTL_IO_RESUME   BIT(19)
> +#define LOONGSON2_MMC_DCTL_RW_RESUME   BIT(20)
> +#define LOONGSON2_MMC_DCTL_8BIT_BUS    BIT(26)
> +
> +/* Bitfields of sata counter register */
> +#define LOONGSON2_MMC_DCNT_BNUM                GENMASK(11, 0)
> +#define LOONGSON2_MMC_DCNT_BYTE                GENMASK(23, 12)
> +
> +/* Bitfields of command status register */
> +#define LOONGSON2_MMC_DSTS_RXON                BIT(0)
> +#define LOONGSON2_MMC_DSTS_TXON                BIT(1)
> +#define LOONGSON2_MMC_DSTS_SBITERR     BIT(2)
> +#define LOONGSON2_MMC_DSTS_BUSYFIN     BIT(3)
> +#define LOONGSON2_MMC_DSTS_XFERFIN     BIT(4)
> +#define LOONGSON2_MMC_DSTS_DTIMEOUT    BIT(5)
> +#define LOONGSON2_MMC_DSTS_RXCRC       BIT(6)
> +#define LOONGSON2_MMC_DSTS_TXCRC       BIT(7)
> +#define LOONGSON2_MMC_DSTS_IRQ         BIT(8)
> +#define LOONGSON2_MMC_DSTS_START       BIT(13)
> +#define LOONGSON2_MMC_DSTS_RESUME      BIT(15)
> +#define LOONGSON2_MMC_DSTS_SUSPEND     BIT(16)
> +
> +/* Bitfields of interrupt register */
> +#define LOONGSON2_MMC_INT_DFIN         BIT(0)
> +#define LOONGSON2_MMC_INT_DTIMEOUT     BIT(1)
> +#define LOONGSON2_MMC_INT_RXCRC                BIT(2)
> +#define LOONGSON2_MMC_INT_TXCRC                BIT(3)
> +#define LOONGSON2_MMC_INT_PROGERR      BIT(4)
> +#define LOONGSON2_MMC_INT_SDIOIRQ      BIT(5)
> +#define LOONGSON2_MMC_INT_CSENT                BIT(6)
> +#define LOONGSON2_MMC_INT_CTIMEOUT     BIT(7)
> +#define LOONGSON2_MMC_INT_RESPCRC      BIT(8)
> +#define LOONGSON2_MMC_INT_BUSYEND      BIT(9)
> +
> +/* Bitfields of interrupt enable register */
> +#define LOONGSON2_MMC_IEN_DFIN         BIT(0)
> +#define LOONGSON2_MMC_IEN_DTIMEOUT     BIT(1)
> +#define LOONGSON2_MMC_IEN_RXCRC                BIT(2)
> +#define LOONGSON2_MMC_IEN_TXCRC                BIT(3)
> +#define LOONGSON2_MMC_IEN_PROGERR      BIT(4)
> +#define LOONGSON2_MMC_IEN_SDIOIRQ      BIT(5)
> +#define LOONGSON2_MMC_IEN_CSENT                BIT(6)
> +#define LOONGSON2_MMC_IEN_CTIMEOUT     BIT(7)
> +#define LOONGSON2_MMC_IEN_RESPCRC      BIT(8)
> +#define LOONGSON2_MMC_IEN_BUSYEND      BIT(9)
> +
> +#define LOONGSON2_MMC_IEN_ALL          GENMASK(9, 0)
> +#define LOONGSON2_MMC_INT_CLEAR                GENMASK(9, 0)
> +
> +/* Loongson-2K1000 SDIO2 DMA routing register */
> +#define LS2K1000_SDIO_DMA_MASK         GENMASK(17, 15)
> +#define LS2K1000_DMA0_CONF             0x0
> +#define LS2K1000_DMA1_CONF             0x1
> +#define LS2K1000_DMA2_CONF             0x2
> +#define LS2K1000_DMA3_CONF             0x3
> +#define LS2K1000_DMA4_CONF             0x4
> +
> +/* Loongson-2K0500 SDIO2 DMA routing register */
> +#define LS2K0500_SDIO_DMA_MASK         GENMASK(15, 14)
> +#define LS2K0500_DMA0_CONF             0x1
> +#define LS2K0500_DMA1_CONF             0x2
> +#define LS2K0500_DMA2_CONF             0x3
> +
> +enum loongson2_mmc_state {
> +       STATE_NONE,
> +       STATE_FINALIZE,
> +       STATE_CMDSENT,
> +       STATE_RSPFIN,
> +       STATE_XFERFINISH,
> +       STATE_XFERFINISH_RSPFIN,
> +};
> +
> +struct loongson2_dma_desc {
> +       u32 ndesc_addr;
> +       u32 mem_addr;
> +       u32 apb_addr;
> +       u32 len;
> +       u32 step_len;
> +       u32 step_times;
> +       u32 cmd;
> +       u32 stats;
> +       u32 high_ndesc_addr;
> +       u32 high_mem_addr;
> +       u32 reserved[2];
> +} __packed;
> +
> +struct loongson2_mmc_host {
> +       struct device *dev;
> +       struct mmc_request *mrq;
> +       struct regmap *regmap;
> +       struct resource *res;
> +       struct clk *clk;
> +       u64 rate;
> +       int dma_complete;
> +       struct dma_chan *chan;
> +       int cmd_is_stop;
> +       int bus_width;
> +       spinlock_t lock; /* Prevent races with irq handler */
> +       enum loongson2_mmc_state state;
> +       const struct loongson2_mmc_pdata *pdata;
> +};
> +
> +struct loongson2_mmc_pdata {
> +       const struct regmap_config *regmap_config;
> +       void (*reorder_cmd_data)(struct loongson2_mmc_host *host, struct =
mmc_command *cmd);
> +       int (*setting_dma)(struct loongson2_mmc_host *host, struct platfo=
rm_device *pdev);
> +       int (*prepare_dma)(struct loongson2_mmc_host *host, struct mmc_da=
ta *data);
> +       void (*release_dma)(struct loongson2_mmc_host *host, struct devic=
e *dev);
> +};
> +
> +static void loongson2_mmc_send_command(struct loongson2_mmc_host *host,
> +                                      struct mmc_command *cmd)
> +{
> +       u32 cctrl;
> +
> +       if (cmd->data)
> +               host->state =3D STATE_XFERFINISH_RSPFIN;
> +       else if (cmd->flags & MMC_RSP_PRESENT)
> +               host->state =3D STATE_RSPFIN;
> +       else
> +               host->state =3D STATE_CMDSENT;
> +
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_CARG, cmd->arg);
> +
> +       cctrl =3D FIELD_PREP(LOONGSON2_MMC_CCTL_INDEX, cmd->opcode);
> +       cctrl |=3D LOONGSON2_MMC_CCTL_HOST | LOONGSON2_MMC_CCTL_START;
> +
> +       if (cmd->opcode =3D=3D SD_SWITCH && cmd->data)
> +               cctrl |=3D LOONGSON2_MMC_CCTL_CMD6;
> +
> +       if (cmd->flags & MMC_RSP_PRESENT)
> +               cctrl |=3D LOONGSON2_MMC_CCTL_WAIT_RSP;
> +
> +       if (cmd->flags & MMC_RSP_136)
> +               cctrl |=3D LOONGSON2_MMC_CCTL_LONG_RSP;
> +
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_CCTL, cctrl);
> +}
> +
> +static int loongson2_mmc_setup_data(struct loongson2_mmc_host *host,
> +                                   struct mmc_data *data)
> +{
> +       u32 dctrl;
> +
> +       if ((data->blksz & 3) !=3D 0)
> +               return -EINVAL;
> +
> +       dctrl =3D FIELD_PREP(LOONGSON2_MMC_DCTL_BNUM, data->blocks);
> +       dctrl |=3D LOONGSON2_MMC_DCTL_START | LOONGSON2_MMC_DCTL_ENDMA;
> +
> +       if (host->bus_width =3D=3D MMC_BUS_WIDTH_4)
> +               dctrl |=3D LOONGSON2_MMC_DCTL_WIDE;
> +       else if (host->bus_width =3D=3D MMC_BUS_WIDTH_8)
> +               dctrl |=3D LOONGSON2_MMC_DCTL_8BIT_BUS;
> +
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_DCTL, dctrl);
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_BSIZE, data->blksz);
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_TIMER, U32_MAX);
> +
> +       return 0;
> +}
> +
> +static int loongson2_mmc_prepare_dma(struct loongson2_mmc_host *host,
> +                                    struct mmc_data *data)
> +{
> +       int ret;
> +
> +       if (!data)
> +               return 0;
> +
> +       ret =3D loongson2_mmc_setup_data(host, data);
> +       if (ret)
> +               return ret;
> +
> +       host->dma_complete =3D 0;
> +
> +       return host->pdata->prepare_dma(host, data);
> +}
> +
> +static void loongson2_mmc_send_request(struct mmc_host *mmc)
> +{
> +       int ret;
> +       struct loongson2_mmc_host *host =3D mmc_priv(mmc);
> +       struct mmc_request *mrq =3D host->mrq;
> +       struct mmc_command *cmd =3D host->cmd_is_stop ? mrq->stop : mrq->=
cmd;
> +
> +       ret =3D loongson2_mmc_prepare_dma(host, cmd->data);
> +       if (ret) {
> +               dev_err(host->dev, "DMA data prepared failed with %d\n", =
ret);
> +               cmd->error =3D ret;
> +               cmd->data->error =3D ret;
> +               mmc_request_done(mmc, mrq);
> +               return;
> +       }
> +
> +       loongson2_mmc_send_command(host, cmd);
> +
> +       /* Fix deselect card */
> +       if (cmd->opcode =3D=3D MMC_SELECT_CARD && cmd->arg =3D=3D 0) {
> +               cmd->error =3D 0;
> +               mmc_request_done(mmc, mrq);
> +       }
> +}
> +
> +static irqreturn_t loongson2_mmc_irq_worker(int irq, void *devid)
> +{
> +       struct loongson2_mmc_host *host =3D (struct loongson2_mmc_host *)=
devid;
> +       struct mmc_host *mmc =3D mmc_from_priv(host);
> +       struct mmc_request *mrq =3D host->mrq;
> +       struct mmc_command *cmd =3D host->cmd_is_stop ? mrq->stop : mrq->=
cmd;
> +
> +       if (cmd->data)
> +               dma_unmap_sg(mmc_dev(mmc), cmd->data->sg, cmd->data->sg_l=
en,
> +                            mmc_get_dma_dir(cmd->data));
> +
> +       if (cmd->data && !cmd->error &&
> +           !cmd->data->error && !host->dma_complete)
> +               return IRQ_HANDLED;
> +
> +       /* Read response from controller. */
> +       regmap_read(host->regmap, LOONGSON2_MMC_REG_RSP0, &cmd->resp[0]);
> +       regmap_read(host->regmap, LOONGSON2_MMC_REG_RSP1, &cmd->resp[1]);
> +       regmap_read(host->regmap, LOONGSON2_MMC_REG_RSP2, &cmd->resp[2]);
> +       regmap_read(host->regmap, LOONGSON2_MMC_REG_RSP3, &cmd->resp[3]);
> +
> +       /* Cleanup controller */
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_CARG, 0);
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_CCTL, 0);
> +
> +       if (cmd->data && cmd->error)
> +               cmd->data->error =3D cmd->error;
> +
> +       if (cmd->data && cmd->data->stop && !host->cmd_is_stop) {
> +               host->cmd_is_stop =3D 1;
> +               loongson2_mmc_send_request(mmc);
> +               return IRQ_HANDLED;
> +       }
> +
> +       /* If we have no data transfer we are finished here */
> +       if (!mrq->data)
> +               goto request_done;
> +
> +       /* Calculate the amount of bytes transfer if there was no error *=
/
> +       if (mrq->data->error =3D=3D 0) {
> +               mrq->data->bytes_xfered =3D
> +                       (mrq->data->blocks * mrq->data->blksz);
> +       } else {
> +               mrq->data->bytes_xfered =3D 0;
> +       }
> +
> +request_done:
> +       host->state =3D STATE_NONE;
> +       host->mrq =3D NULL;
> +       mmc_request_done(mmc, mrq);
> +       return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t loongson2_mmc_irq(int irq, void *devid)
> +{
> +       struct loongson2_mmc_host *host =3D (struct loongson2_mmc_host *)=
devid;
> +       struct mmc_host *mmc =3D mmc_from_priv(host);
> +       struct mmc_command *cmd;
> +       unsigned long iflags;
> +       u32 dsts, imsk;
> +
> +       regmap_read(host->regmap, LOONGSON2_MMC_REG_INT, &imsk);
> +       regmap_read(host->regmap, LOONGSON2_MMC_REG_DSTS, &dsts);
> +
> +       if ((dsts & LOONGSON2_MMC_DSTS_IRQ) &&
> +           (imsk & LOONGSON2_MMC_INT_SDIOIRQ)) {
> +               regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_INT,
> +                                  LOONGSON2_MMC_INT_SDIOIRQ,
> +                                  LOONGSON2_MMC_INT_SDIOIRQ);
The last two lines can be combined.

> +
> +               sdio_signal_irq(mmc);
> +               return IRQ_HANDLED;
> +       }
> +
> +       spin_lock_irqsave(&host->lock, iflags);
> +
> +       if (host->state =3D=3D STATE_NONE || host->state =3D=3D STATE_FIN=
ALIZE ||
> +           !host->mrq)
The if condition can be put  in one line here.

> +               goto irq_out;
> +
> +       cmd =3D host->cmd_is_stop ? host->mrq->stop : host->mrq->cmd;
> +       if (!cmd)
> +               goto irq_out;
> +
> +       cmd->error =3D 0;
> +
> +       if (imsk & LOONGSON2_MMC_INT_CTIMEOUT) {
> +               cmd->error =3D -ETIMEDOUT;
> +               goto close_transfer;
> +       }
> +
> +       if (imsk & LOONGSON2_MMC_INT_CSENT) {
> +               if (host->state =3D=3D STATE_RSPFIN || host->state =3D=3D=
 STATE_CMDSENT)
> +                       goto close_transfer;
> +
> +               if (host->state =3D=3D STATE_XFERFINISH_RSPFIN)
> +                       host->state =3D STATE_XFERFINISH;
> +       }
> +
> +       if (!cmd->data)
> +               goto irq_out;
> +
> +       if (imsk & (LOONGSON2_MMC_INT_RXCRC | LOONGSON2_MMC_INT_TXCRC)) {
> +               cmd->data->error =3D -EILSEQ;
> +               goto close_transfer;
> +       }
> +
> +       if (imsk & LOONGSON2_MMC_INT_DTIMEOUT) {
> +               cmd->data->error =3D -ETIMEDOUT;
> +               goto close_transfer;
> +       }
> +
> +       if (imsk & LOONGSON2_MMC_INT_DFIN) {
> +               if (host->state =3D=3D STATE_XFERFINISH) {
> +                       host->dma_complete =3D 1;
> +                       goto close_transfer;
> +               }
> +
> +               if (host->state =3D=3D STATE_XFERFINISH_RSPFIN)
> +                       host->state =3D STATE_RSPFIN;
> +       }
> +
> +irq_out:
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_INT, imsk);
> +       spin_unlock_irqrestore(&host->lock, iflags);
> +       return IRQ_HANDLED;
> +
> +close_transfer:
> +       host->state =3D STATE_FINALIZE;
> +       host->pdata->reorder_cmd_data(host, cmd);
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_INT, imsk);
> +       spin_unlock_irqrestore(&host->lock, iflags);
> +       return IRQ_WAKE_THREAD;
> +}
> +
> +static void loongson2_mmc_set_clk(struct loongson2_mmc_host *host, struc=
t mmc_ios *ios)
> +{
> +       u32 pre;
> +
> +       pre =3D DIV_ROUND_UP(host->rate, ios->clock);
> +       if (pre > 255)
> +               pre =3D 255;
> +
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_PRE, pre | LOONGSON2=
_MMC_PRE_EN);
> +
> +       regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_CTL,
> +                          LOONGSON2_MMC_CTL_ENCLK, LOONGSON2_MMC_CTL_ENC=
LK);
> +}
> +
> +static void loongson2_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *=
ios)
> +{
> +       struct loongson2_mmc_host *host =3D mmc_priv(mmc);
> +       int ret;
> +
> +       if (ios->power_mode =3D=3D MMC_POWER_UP) {
> +               if (!IS_ERR(mmc->supply.vmmc)) {
> +                       ret =3D mmc_regulator_set_ocr(mmc, mmc->supply.vm=
mc, ios->vdd);
> +                       if (ret) {
> +                               dev_err(host->dev, "failed to enable vmmc=
 regulator\n");
> +                               /*return, if failed turn on vmmc*/
There should be spaces between /**/ and the comments, and the whole
comments can be put after the "return;" statement.

> +                               return;
> +                       }
> +               }
> +               regmap_write(host->regmap, LOONGSON2_MMC_REG_CTL, LOONGSO=
N2_MMC_CTL_RESET);
> +               mdelay(10);
> +               regmap_write(host->regmap, LOONGSON2_MMC_REG_CTL, LOONGSO=
N2_MMC_CTL_EXTCLK);
> +               regmap_write(host->regmap, LOONGSON2_MMC_REG_INT, LOONGSO=
N2_MMC_IEN_ALL);
> +               regmap_write(host->regmap, LOONGSON2_MMC_REG_IEN, LOONGSO=
N2_MMC_INT_CLEAR);
> +       } else if (ios->power_mode =3D=3D MMC_POWER_OFF) {
> +               regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_CTL,
> +                                  LOONGSON2_MMC_CTL_RESET, LOONGSON2_MMC=
_CTL_RESET);
> +               if (!IS_ERR(mmc->supply.vmmc))
> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +               return;
> +       }
> +
> +       loongson2_mmc_set_clk(host, ios);
> +
> +       host->bus_width =3D ios->bus_width;
> +}
> +
> +static void loongson2_mmc_request(struct mmc_host *mmc, struct mmc_reque=
st *mrq)
> +{
> +       struct loongson2_mmc_host *host =3D mmc_priv(mmc);
> +
> +       host->cmd_is_stop =3D 0;
> +       host->mrq =3D mrq;
> +       loongson2_mmc_send_request(mmc);
> +}
> +
> +static void loongson2_mmc_enable_sdio_irq(struct mmc_host *mmc, int enab=
le)
> +{
> +       struct loongson2_mmc_host *host =3D mmc_priv(mmc);
> +
> +       regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_IEN,
> +                          LOONGSON2_MMC_INT_SDIOIRQ, enable);
The statement can be put  in one line here, too.

> +}
> +
> +static void loongson2_mmc_ack_sdio_irq(struct mmc_host *mmc)
> +{
> +       loongson2_mmc_enable_sdio_irq(mmc, 1);
> +}
> +
> +static struct mmc_host_ops loongson2_mmc_ops =3D {
> +       .request        =3D loongson2_mmc_request,
> +       .set_ios        =3D loongson2_mmc_set_ios,
> +       .get_ro         =3D mmc_gpio_get_ro,
> +       .get_cd         =3D mmc_gpio_get_cd,
> +       .enable_sdio_irq =3D loongson2_mmc_enable_sdio_irq,
> +       .ack_sdio_irq   =3D loongson2_mmc_ack_sdio_irq,
> +};
> +
> +static const struct regmap_config ls2k1000_mmc_regmap_config =3D {
> +       .reg_bits =3D 32,
> +       .val_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .max_register =3D LOONGSON2_MMC_REG_IEN,
> +};
> +
> +static int loongson2_reorder_cmd_list[] =3D { SD_APP_SEND_SCR, SD_APP_SE=
ND_NUM_WR_BLKS,
> +                                           SD_APP_SD_STATUS, MMC_SEND_WR=
ITE_PROT,
> +                                           SD_SWITCH };
The last two lines can be combined.

> +
> +/*
> + * According to SD spec, ACMD13, ACMD22, ACMD51 and CMD30
> + * response datas has different byte order with usual data packets.
> + * However sdio controller will send these datas in usual data format,
> + * so we need to adjust these datas to a protocol consistent byte order.
> + */
> +static void loongson2_mmc_reorder_cmd_data(struct loongson2_mmc_host *ho=
st,
> +                                          struct mmc_command *cmd)
> +{
> +       struct scatterlist *sg;
> +       u32 *data;
> +       int i, j;
> +
> +       if (mmc_cmd_type(cmd) !=3D MMC_CMD_ADTC)
> +               return;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(loongson2_reorder_cmd_list); i++)
> +               if (cmd->opcode =3D=3D loongson2_reorder_cmd_list[i])
> +                       break;
> +
> +       if (i =3D=3D ARRAY_SIZE(loongson2_reorder_cmd_list))
> +               return;
> +
> +       for_each_sg(cmd->data->sg, sg, cmd->data->sg_len, i) {
> +               data =3D sg_virt(&sg[i]);
> +               for (j =3D 0; j < (sg_dma_len(&sg[i]) / 4); j++)
> +                       if (cmd->opcode =3D=3D SD_SWITCH)
> +                               data[j] =3D bitrev8x4(data[j]);
> +                       else
> +                               data[j] =3D (__force u32)cpu_to_be32(data=
[j]);
> +       }
> +}
> +
> +static int loongson2_mmc_prepare_external_dma(struct loongson2_mmc_host =
*host,
> +                                             struct mmc_data *data)
> +{
> +       struct mmc_host *mmc =3D mmc_from_priv(host);
> +       struct dma_slave_config dma_conf =3D { };
> +       struct dma_async_tx_descriptor *desc;
> +       int ret;
> +
> +       ret =3D dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len,
> +                        mmc_get_dma_dir(data));
The statement can be put  in one line here, too.

> +       if (!ret)
> +               return -ENOMEM;
> +
> +       dma_conf.src_addr =3D host->res->start + LOONGSON2_MMC_REG_DATA,
> +       dma_conf.dst_addr =3D host->res->start + LOONGSON2_MMC_REG_DATA,
> +       dma_conf.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES,
> +       dma_conf.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES,
> +       dma_conf.direction =3D !(data->flags & MMC_DATA_WRITE) ?
> +                            DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
The statement can be put  in one line here, too.

> +
> +       dmaengine_slave_config(host->chan, &dma_conf);
> +       desc =3D dmaengine_prep_slave_sg(host->chan, data->sg, data->sg_l=
en,
> +                                      dma_conf.direction,
> +                                      DMA_CTRL_ACK | DMA_PREP_INTERRUPT)=
;
> +       if (!desc)
> +               goto unmap_exit;
> +
> +       dmaengine_submit(desc);
> +       dma_async_issue_pending(host->chan);
> +
> +       return 0;
> +
> +unmap_exit:
> +       dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
> +                    mmc_get_dma_dir(data));
The statement can be put  in one line here, too.

> +       return -ENOMEM;
> +}
> +
> +static void loongson2_mmc_release_external_dma(struct loongson2_mmc_host=
 *host,
> +                                              struct device *dev)
> +{
> +       dma_release_channel(host->chan);
> +}
> +
> +static int ls2k0500_mmc_set_external_dma(struct loongson2_mmc_host *host=
,
> +                                        struct platform_device *pdev)
> +{
> +       int ret, val;
> +       void __iomem *regs;
> +
> +       regs =3D devm_platform_ioremap_resource(pdev, 1);
> +       if (IS_ERR(regs))
> +               return PTR_ERR(regs);
> +
> +       val =3D readl(regs);
> +       val |=3D FIELD_PREP(LS2K0500_SDIO_DMA_MASK, LS2K0500_DMA2_CONF);
> +       writel(val, regs);
> +
> +       host->chan =3D dma_request_chan(&pdev->dev, "rx-tx");
> +       ret =3D PTR_ERR_OR_ZERO(host->chan);
> +       if (ret) {
> +               dev_err(&pdev->dev, "cannot get DMA channel.\n");
> +               return  ret;
Too many spaces here.

> +       }
> +
> +       return 0;
> +}
> +
> +static struct loongson2_mmc_pdata ls2k0500_mmc_pdata =3D {
> +       .regmap_config          =3D &ls2k1000_mmc_regmap_config,
> +       .reorder_cmd_data       =3D loongson2_mmc_reorder_cmd_data,
> +       .setting_dma            =3D ls2k0500_mmc_set_external_dma,
> +       .prepare_dma            =3D loongson2_mmc_prepare_external_dma,
> +       .release_dma            =3D loongson2_mmc_release_external_dma,
> +};
> +
> +static int ls2k1000_mmc_set_external_dma(struct loongson2_mmc_host *host=
,
> +                                        struct platform_device *pdev)
> +{
> +       int ret, val;
> +       void __iomem *regs;
> +
> +       regs =3D devm_platform_ioremap_resource(pdev, 1);
> +       if (IS_ERR(regs))
> +               return PTR_ERR(regs);
> +
> +       val =3D readl(regs);
> +       val |=3D FIELD_PREP(LS2K1000_SDIO_DMA_MASK, LS2K1000_DMA1_CONF);
> +       writel(val, regs);
> +
> +       host->chan =3D dma_request_chan(&pdev->dev, "rx-tx");
> +       ret =3D PTR_ERR_OR_ZERO(host->chan);
> +       if (ret) {
> +               dev_err(&pdev->dev, "cannot get DMA channel.\n");
> +               return  ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static struct loongson2_mmc_pdata ls2k1000_mmc_pdata =3D {
> +       .regmap_config          =3D &ls2k1000_mmc_regmap_config,
> +       .reorder_cmd_data       =3D loongson2_mmc_reorder_cmd_data,
> +       .setting_dma            =3D ls2k1000_mmc_set_external_dma,
> +       .prepare_dma            =3D loongson2_mmc_prepare_external_dma,
> +       .release_dma            =3D loongson2_mmc_release_external_dma,
> +};
> +
> +static int loongson2_mmc_resource_request(struct platform_device *pdev,
> +                                         struct loongson2_mmc_host *host=
)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       void __iomem *base;
> +       int ret, irq;
> +
> +       base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &host->r=
es);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       host->regmap =3D devm_regmap_init_mmio(dev, base, host->pdata->re=
gmap_config);
> +       if (IS_ERR(host->regmap))
> +               return PTR_ERR(host->regmap);
> +
> +       host->clk =3D devm_clk_get_optional_enabled(dev, NULL);
> +       if (IS_ERR(host->clk))
> +               return PTR_ERR(host->clk);
> +
> +       if (host->clk) {
> +               ret =3D devm_clk_rate_exclusive_get(dev, host->clk);
> +               if (ret)
> +                       return PTR_ERR(host->clk);
> +
> +               host->rate =3D clk_get_rate(host->clk);
> +       } else {
> +               /* For ACPI, we get rate through clock-frequency attribut=
e */
> +               device_property_read_u64(dev, "clock-frequency", &host->r=
ate);
> +       }
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return irq;
> +
> +       ret =3D devm_request_threaded_irq(dev, irq, loongson2_mmc_irq,
> +                                       loongson2_mmc_irq_worker,
> +                                       IRQF_ONESHOT, "loongson2-mmc", ho=
st);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +       if (ret)
> +               return ret;
> +
> +       return host->pdata->setting_dma(host, pdev);
> +}
> +
> +static int loongson2_mmc_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct loongson2_mmc_host *host;
> +       struct mmc_host *mmc;
> +       int ret;
> +
> +       mmc =3D devm_mmc_alloc_host(dev, sizeof(*host));
> +       if (!mmc)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, mmc);
> +
> +       host =3D mmc_priv(mmc);
> +       host->state =3D STATE_NONE;
> +       spin_lock_init(&host->lock);
> +
> +       host->pdata =3D device_get_match_data(dev);
> +       if (!host->pdata)
> +               return dev_err_probe(dev, -EINVAL, "Failed to get match d=
ata\n");
> +
> +       ret =3D loongson2_mmc_resource_request(pdev, host);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to request resourc=
e\n");
> +
> +       mmc->ops =3D &loongson2_mmc_ops;
> +       mmc->f_min =3D DIV_ROUND_UP(host->rate, 256);
> +       mmc->f_max =3D host->rate;
> +       mmc->max_blk_count =3D 4095;
> +       mmc->max_blk_size =3D 4095;
> +       mmc->max_req_size =3D mmc->max_blk_count * mmc->max_blk_size;
> +       mmc->max_segs =3D 1;
> +       mmc->max_seg_size =3D mmc->max_req_size;
> +
> +       /* Process SDIO IRQs through the sdio_irq_work. */
> +       if (mmc->caps & MMC_CAP_SDIO_IRQ)
> +               mmc->caps2 |=3D MMC_CAP2_SDIO_IRQ_NOTHREAD;
> +
> +       ret =3D mmc_regulator_get_supply(mmc);
> +       if (ret || mmc->ocr_avail =3D=3D 0) {
> +               dev_warn(dev, "Can't get voltage, defaulting to 3.3V\n");
> +               mmc->ocr_avail =3D MMC_VDD_32_33 | MMC_VDD_33_34;
> +       }
> +
> +       ret =3D mmc_of_parse(mmc);
> +       if (ret) {
> +               dev_err(dev, "Failed to parse device node\n");
> +               goto free_dma;
> +       }
> +
> +       ret =3D mmc_add_host(mmc);
> +       if (ret) {
> +               dev_err(dev, "Failed to add mmc host\n");
> +               goto free_dma;
> +       }
> +
> +       return 0;
> +
> +free_dma:
> +       host->pdata->release_dma(host, dev);
> +       return ret;
> +}
> +
> +static void loongson2_mmc_remove(struct platform_device *pdev)
> +{
> +       struct mmc_host *mmc  =3D platform_get_drvdata(pdev);
> +       struct loongson2_mmc_host *host =3D mmc_priv(mmc);
> +
> +       mmc_remove_host(mmc);
> +       host->pdata->release_dma(host, &pdev->dev);
> +}
> +
> +static const struct of_device_id loongson2_mmc_of_ids[] =3D {
> +       { .compatible =3D "loongson,ls2k0500-mmc", .data =3D &ls2k0500_mm=
c_pdata },
> +       { .compatible =3D "loongson,ls2k1000-mmc", .data =3D &ls2k1000_mm=
c_pdata },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, loongson2_mmc_of_ids);
> +
> +static int loongson2_mmc_suspend(struct device *dev)
> +{
> +       struct mmc_host *mmc  =3D dev_get_drvdata(dev);
Too many spaces here.

> +       struct loongson2_mmc_host *host =3D mmc_priv(mmc);
> +
> +       clk_disable_unprepare(host->clk);
> +
> +       return 0;
> +}
> +
> +static int loongson2_mmc_resume(struct device *dev)
> +{
> +       struct mmc_host *mmc  =3D dev_get_drvdata(dev);
Too many spaces here.

> +       struct loongson2_mmc_host *host =3D mmc_priv(mmc);
> +
> +       return clk_prepare_enable(host->clk);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(loongson2_mmc_pm_ops, loongson2_mmc_susp=
end,
> +                               loongson2_mmc_resume);
The statement can be put  in one line here, too.


Huacai

> +
> +static struct platform_driver loongson2_mmc_driver =3D {
> +       .driver =3D {
> +               .name =3D "loongson2-mmc",
> +               .of_match_table =3D loongson2_mmc_of_ids,
> +               .pm =3D pm_ptr(&loongson2_mmc_pm_ops),
> +               .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +       },
> +       .probe =3D loongson2_mmc_probe,
> +       .remove =3D loongson2_mmc_remove,
> +};
> +
> +module_platform_driver(loongson2_mmc_driver);
> +
> +MODULE_DESCRIPTION("Loongson-2K SD/SDIO/eMMC Interface driver");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> +MODULE_LICENSE("GPL");
> --
> 2.47.1
>
