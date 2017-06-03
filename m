From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [RFC 2/2] mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8
 and Meson8b SoCs
Date: Sat, 3 Jun 2017 18:37:26 +0200
Message-ID: <CAFBinCD3modyyOpi3OY5XLhjX0UCuV+WPY2Z=mdvwdMCyeGoqg@mail.gmail.com>
References: <20170506171857.16492-1-martin.blumenstingl@googlemail.com>
 <20170506171857.16492-3-martin.blumenstingl@googlemail.com> <CAPDyKFrrSLCjbXO9R4VqPpabiFsbE6_RqR=U7otVF4Ncv0jHjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFrrSLCjbXO9R4VqPpabiFsbE6_RqR=U7otVF4Ncv0jHjQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

first of all: many thanks for the well-written comments - they help me
a lot understanding *why* some parts of the code are wrong!

On Mon, May 29, 2017 at 4:38 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 6 May 2017 at 19:18, Martin Blumenstingl
> <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
>> From: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
>>
>> Add a driver for the SDIO/MMC host found on the Amlogic Meson SoCs. This
>> is an MMC controller which provides an interface between the application
>> processor and various memory cards. It supports the SD specification
>> v2.0 and the eMMC specification v4.41.
>>
>> The controller provides an internal "mux" which allows connecting up to
>> three MMC devices to it. Only one device can be used at a time though
>> since the registers are shared across all devices. The driver takes care
>> of synchronizing access (similar to the dw_mmc driver).
>> The maximum supported bus-width is 4-bits.
>>
>> Amlogic's GPL kernel sources call the corresponding driver "aml_sdio" to
>> differentiate it from the other MMC controller in (at least the Meson8
>> and Meson8b) the SoCs (they call the other drivers aml_sdhc and
>> aml_sdhc_m8, which seem to support a bus-width of up to 8-bits).
>
> Would you mind to extend this change log to include some more of the
> information about which SoC this is being used on, according to our
> recent discussions. Just wanted to make sure we don't mix it up with
> any other meson mmc controller/driver.
noted - will do this

>>
>> Signed-off-by: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>> ---
>>  drivers/mmc/host/Kconfig         |  12 +
>>  drivers/mmc/host/Makefile        |   1 +
>>  drivers/mmc/host/meson-mx-sdio.c | 978 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 991 insertions(+)
>>  create mode 100644 drivers/mmc/host/meson-mx-sdio.c
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index a638cd0d80be..c557482ae327 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -343,6 +343,18 @@ config MMC_MESON_GX
>>
>>           If you have a controller with this interface, say Y here.
>>
>> +config MMC_MESON_MX_SDIO
>> +       tristate "Amlogic Meson6/Meson8/Meson8b SD/MMC Host Controller support"
>> +       depends on ARCH_MESON || COMPILE_TEST
>> +       depends on HAS_DMA
>> +       depends on OF
>> +       help
>> +         This selects support for the SD/MMC Host Controller on
>> +         Amlogic Meson6, Meson8 and Meson8b SoCs.
>> +
>> +         If you have a controller with this interface, say Y or M here.
>> +         If unsure, say N.
>> +
>>  config MMC_MOXART
>>         tristate "MOXART SD/MMC Host Controller support"
>>         depends on ARCH_MOXART && MMC
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index bc2c2e2c68c0..f9500ab2bc86 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -55,6 +55,7 @@ obj-$(CONFIG_MMC_VUB300)      += vub300.o
>>  obj-$(CONFIG_MMC_USHC)         += ushc.o
>>  obj-$(CONFIG_MMC_WMT)          += wmt-sdmmc.o
>>  obj-$(CONFIG_MMC_MESON_GX)     += meson-gx-mmc.o
>> +obj-$(CONFIG_MMC_MESON_MX_SDIO)        += meson-mx-sdio.o
>>  obj-$(CONFIG_MMC_MOXART)       += moxart-mmc.o
>>  obj-$(CONFIG_MMC_SUNXI)                += sunxi-mmc.o
>>  obj-$(CONFIG_MMC_USDHI6ROL0)   += usdhi6rol0.o
>> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
>> new file mode 100644
>> index 000000000000..2da9c5249ae7
>> --- /dev/null
>> +++ b/drivers/mmc/host/meson-mx-sdio.c
>> @@ -0,0 +1,978 @@
>> +/*
>> + * meson-mx-sdio.c - Meson6, Meson8 and Meson8b SDIO/MMC Host Controller
>> + *
>> + * Copyright (C) 2015 Endless Mobile, Inc.
>> + * Author: Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
>> + * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or (at
>> + * your option) any later version.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/ioport.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/timer.h>
>> +#include <linux/types.h>
>> +
>> +#include <linux/mmc/host.h>
>> +#include <linux/mmc/mmc.h>
>> +#include <linux/mmc/sdio.h>
>> +#include <linux/mmc/slot-gpio.h>
>> +
>> +#define MESON_MX_SDIO_ARGU                                     0x00
>> +
>> +#define MESON_MX_SDIO_SEND                                     0x04
>> +       #define MESON_MX_SDIO_SEND_COMMAND_INDEX_MASK           GENMASK(7, 0)
>> +       #define MESON_MX_SDIO_SEND_CMD_RESP_BITS_MASK           GENMASK(15, 8)
>> +       #define MESON_MX_SDIO_SEND_RESP_WITHOUT_CRC7            BIT(16)
>> +       #define MESON_MX_SDIO_SEND_RESP_HAS_DATA                BIT(17)
>> +       #define MESON_MX_SDIO_SEND_RESP_CRC7_FROM_8             BIT(18)
>> +       #define MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY              BIT(19)
>> +       #define MESON_MX_SDIO_SEND_DATA                         BIT(20)
>> +       #define MESON_MX_SDIO_SEND_USE_INT_WINDOW               BIT(21)
>> +       #define MESON_MX_SDIO_SEND_REPEAT_PACKAGE_TIMES_MASK    GENMASK(31, 24)
>> +
>> +#define MESON_MX_SDIO_CONF                                     0x08
>> +       #define MESON_MX_SDIO_CONF_CMD_CLK_DIV_SHIFT            0
>> +       #define MESON_MX_SDIO_CONF_CMD_CLK_DIV_WIDTH            10
>> +       #define MESON_MX_SDIO_CONF_CMD_DISABLE_CRC              BIT(10)
>> +       #define MESON_MX_SDIO_CONF_CMD_OUT_AT_POSITIVE_EDGE     BIT(11)
>> +       #define MESON_MX_SDIO_CONF_CMD_ARGUMENT_BITS_MASK       GENMASK(17, 12)
>> +       #define MESON_MX_SDIO_CONF_RESP_LATCH_AT_NEGATIVE_EDGE  BIT(18)
>> +       #define MESON_MX_SDIO_CONF_DATA_LATCH_AT_NEGATIVE_EDGE  BIT(19)
>> +       #define MESON_MX_SDIO_CONF_BUS_WIDTH                    BIT(20)
>> +       #define MESON_MX_SDIO_CONF_M_ENDIAN_MASK                GENMASK(22, 21)
>> +       #define MESON_MX_SDIO_CONF_WRITE_NWR_MASK               GENMASK(28, 23)
>> +       #define MESON_MX_SDIO_CONF_WRITE_CRC_OK_STATUS_MASK     GENMASK(31, 29)
>> +
>> +#define MESON_MX_SDIO_IRQS                                     0x0c
>> +       #define MESON_MX_SDIO_IRQS_STATUS_STATE_MACHINE_MASK    GENMASK(3, 0)
>> +       #define MESON_MX_SDIO_IRQS_CMD_BUSY                     BIT(4)
>> +       #define MESON_MX_SDIO_IRQS_RESP_CRC7_OK                 BIT(5)
>> +       #define MESON_MX_SDIO_IRQS_DATA_READ_CRC16_OK           BIT(6)
>> +       #define MESON_MX_SDIO_IRQS_DATA_WRITE_CRC16_OK          BIT(7)
>> +       #define MESON_MX_SDIO_IRQS_IF_INT                       BIT(8)
>> +       #define MESON_MX_SDIO_IRQS_CMD_INT                      BIT(9)
>> +       #define MESON_MX_SDIO_IRQS_STATUS_INFO_MASK             GENMASK(15, 12)
>> +       #define MESON_MX_SDIO_IRQS_TIMING_OUT_INT               BIT(16)
>> +       #define MESON_MX_SDIO_IRQS_AMRISC_TIMING_OUT_INT_EN     BIT(17)
>> +       #define MESON_MX_SDIO_IRQS_ARC_TIMING_OUT_INT_EN        BIT(18)
>> +       #define MESON_MX_SDIO_IRQS_TIMING_OUT_COUNT_MASK        GENMASK(31, 19)
>> +
>> +#define MESON_MX_SDIO_IRQC                                     0x10
>> +       #define MESON_MX_SDIO_IRQC_ARC_IF_INT_EN                BIT(3)
>> +       #define MESON_MX_SDIO_IRQC_ARC_CMD_INT_EN               BIT(4)
>> +       #define MESON_MX_SDIO_IRQC_IF_CONFIG_MASK               GENMASK(7, 6)
>> +       #define MESON_MX_SDIO_IRQC_SOFT_RESET                   BIT(15)
>> +       #define MESON_MX_SDIO_IRQC_FORCE_HALT                   BIT(30)
>> +       #define MESON_MX_SDIO_IRQC_HALT_HOLE                    BIT(31)
>> +
>> +#define MESON_MX_SDIO_MULT                                     0x14
>> +       #define MESON_MX_SDIO_MULT_PORT_SEL_MASK                GENMASK(1, 0)
>> +       #define MESON_MX_SDIO_MULT_MEMORY_STICK_ENABLE          BIT(2)
>> +       #define MESON_MX_SDIO_MULT_MEMORY_STICK_SCLK_ALWAYS     BIT(3)
>> +       #define MESON_MX_SDIO_MULT_STREAM_ENABLE                BIT(4)
>> +       #define MESON_MX_SDIO_MULT_STREAM_8BITS_MODE            BIT(5)
>> +       #define MESON_MX_SDIO_MULT_WR_RD_OUT_INDEX              BIT(8)
>> +       #define MESON_MX_SDIO_MULT_DAT0_DAT1_SWAPPED            BIT(10)
>> +       #define MESON_MX_SDIO_MULT_DAT1_DAT0_SWAPPED            BIT(11)
>> +       #define MESON_MX_SDIO_MULT_RESP_READ_INDEX_MASK         GENMASK(15, 12)
>> +
>> +#define MESON_MX_SDIO_ADDR                                     0x18
>> +
>> +#define MESON_MX_SDIO_EXT                                      0x1c
>> +       #define MESON_MX_SDIO_EXT_DATA_RW_NUMBER_MASK           GENMASK(29, 16)
>> +
>> +#define MESON_MX_SDIO_BOUNCE_REQ_SIZE                          (128 * 1024)
>> +#define MESON_MX_SDIO_RESPONSE_CRC16_BITS                      (16 - 1)
>> +#define MESON_MX_SDIO_MAX_SLOTS                                        3
>> +
>> +enum meson_mx_mmc_host_status {
>> +       MESON_MX_MMC_STATUS_IDLE,
>> +       MESON_MX_MMC_STATUS_BUSY,
>> +       MESON_MX_MMC_STATUS_SHUTTING_DOWN,
>> +};
>> +
>> +struct meson_mx_mmc_slot {
>> +       struct mmc_host                 *mmc;
>> +       struct meson_mx_mmc_host        *host;
>> +
>> +       struct mmc_request              *mrq;
>> +       struct mmc_command              *cmd;
>> +       int                             error;
>> +
>> +       unsigned int                    id;
>> +       struct list_head                queue_node;
>> +};
>> +
>> +struct meson_mx_mmc_host {
>> +       struct device                   *dev;
>> +
>> +       struct clk                      *parent_clk;
>> +       struct clk                      *core_clk;
>> +       struct clk_divider              cfg_div;
>> +       struct clk                      *cfg_div_clk;
>> +       struct clk_fixed_factor         fixed_factor;
>> +       struct clk                      *fixed_factor_clk;
>> +
>> +       void __iomem                    *base;
>> +       int                             irq;
>> +       spinlock_t                      lock;
>> +       spinlock_t                      irq_lock;
>
> Could you please explain what these locks are being used for?
>
>> +
>> +       enum meson_mx_mmc_host_status   status;
>> +       struct list_head                queue;
>> +       struct timer_list               cmd_timeout;
>> +
>> +       struct device                   slot_devices[MESON_MX_SDIO_MAX_SLOTS];
>
> Please convert to use an array of pointers instead.
I'll simply add a device pointer to meson_mx_mmc_slot so I don't have
to manage two arrays

> The cavium mmc driver uses of_platform_device_create|destroy(), seem
> like that should work in this case as well.
indeed, this makes things much easier - thanks for the hint (I didn't
know about of_platform_device_{create,destroy} yet)!

>> +       struct meson_mx_mmc_slot        *slots[MESON_MX_SDIO_MAX_SLOTS];
>> +       struct meson_mx_mmc_slot        *current_cmd_slot;
>> +       struct meson_mx_mmc_slot        *sdio_irq_slot;
>> +};
>> +
>> +static u32 meson_mx_mmc_readl(struct mmc_host *mmc, char reg)
>> +{
>> +       struct meson_mx_mmc_slot *slot = mmc_priv(mmc);
>> +
>> +       return readl(slot->host->base + reg);
>> +}
>> +
>> +static void meson_mx_mmc_writel(struct mmc_host *mmc, u32 val, char reg)
>> +{
>> +       struct meson_mx_mmc_slot *slot = mmc_priv(mmc);
>> +
>> +       writel(val, slot->host->base + reg);
>> +}
>
> Please remove these two wrapper functions, as those just make the code
> less readable.
OK, these will be gone in RFCv2

> [...]
>
>> +static void meson_mx_mmc_apply_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>> +{
>> +       struct meson_mx_mmc_slot *slot = mmc_priv(mmc);
>> +       unsigned long clk_rate = ios->clock;
>> +       int ret;
>> +
>> +       switch (ios->bus_width) {
>> +       case MMC_BUS_WIDTH_1:
>> +               meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_CONF,
>> +                                      MESON_MX_SDIO_CONF_BUS_WIDTH, 0);
>> +               break;
>> +
>> +       case MMC_BUS_WIDTH_4:
>> +               meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_CONF,
>> +                                      MESON_MX_SDIO_CONF_BUS_WIDTH,
>> +                                      MESON_MX_SDIO_CONF_BUS_WIDTH);
>> +               break;
>> +
>> +       case MMC_BUS_WIDTH_8:
>> +       default:
>> +               dev_err(mmc_dev(mmc), "unsupported bus width: %d\n",
>> +                       ios->bus_width);
>> +               slot->error = -EINVAL;
>> +               return;
>> +       }
>> +
>> +       if (clk_rate) {
>> +               if (WARN_ON(clk_rate > mmc->f_max))
>> +                       clk_rate = mmc->f_max;
>> +               else if (WARN_ON(clk_rate < mmc->f_min))
>> +                       clk_rate = mmc->f_min;
>> +
>> +               ret = clk_set_rate(slot->host->cfg_div_clk, ios->clock);
>> +               if (ret) {
>> +                       dev_warn(mmc_dev(mmc),
>> +                                "failed to set MMC clock to %lu: %d\n",
>> +                               clk_rate, ret);
>> +                       slot->error = ret;
>> +                       return;
>> +               }
>> +
>> +               mmc->actual_clock = clk_get_rate(slot->host->cfg_div_clk);
>> +       }
>
> In some cases the mmc core request the clock rate to be zero (to gate
> the clock) which is needed to for example switch to UHS speed mode. If
> you intend to support that, you need to manage this at this point.
thanks for the explanation - unfortunately the lack of a datasheet
which properly describes the clocks makes this a bit hard to
implement.
the vendor driver simply ignores any set_ios request with clock = 0
it seems that there is also no dedicated "stop clock" bit (and we only
have a clock divider). all I could find is FORCE_HALT (bit 30 in the
IRQC register), where the vendor driver explains: "Force halt SDIO by
software. Halt in this sdio host controller means stop to transmit or
receive data from sd card. and then sd card clock will be shutdown.
Software can force to halt anytime, and hardware will automatically
halt the sdio when reading fifo is full or writing fifo is empty"

should I simply remove that if (...) and try to assign 0 to the clock anyways?

>> +}
>> +
>> +static void meson_mx_mmc_start_cmd(struct mmc_host *mmc,
>> +                                  struct mmc_command *cmd)
>> +{
>> +       struct meson_mx_mmc_slot *slot = mmc_priv(mmc);
>> +       unsigned int pack_size;
>> +       unsigned long irqflags, timeout;
>> +       u32 mult, send = 0, ext = 0;
>> +
>> +       slot->cmd = cmd;
>> +
>> +       spin_lock_irqsave(&slot->host->irq_lock, irqflags);
>> +
>> +       switch (mmc_resp_type(cmd)) {
>> +       case MMC_RSP_R1:
>> +       case MMC_RSP_R1B:
>> +       case MMC_RSP_R3:
>> +               /* 7 (CMD) + 32 (response) + 7 (CRC) -1 */
>> +               send |= FIELD_PREP(MESON_MX_SDIO_SEND_CMD_RESP_BITS_MASK, 45);
>> +               break;
>> +       case MMC_RSP_R2:
>> +               /* 7 (CMD) + 120 (response) + 7 (CRC) -1 */
>> +               send |= FIELD_PREP(MESON_MX_SDIO_SEND_CMD_RESP_BITS_MASK, 133);
>> +               send |= MESON_MX_SDIO_SEND_RESP_CRC7_FROM_8;
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       if (!(cmd->flags & MMC_RSP_CRC))
>> +               send |= MESON_MX_SDIO_SEND_RESP_WITHOUT_CRC7;
>> +
>> +       if (cmd->flags & MMC_RSP_BUSY)
>> +               send |= MESON_MX_SDIO_SEND_CHECK_DAT0_BUSY;
>
> In case the controller has HW support of busy detection, please
> consider to enable MMC_CAP_WAIT_WHILE_BUSY for this driver. Then also
> assign host->max_busy_timeout a good value.
the IRQS register has bit 4 (CMD_BUSY) - but apart from that there is
no other documentation (about timeout values, etc.). the vendor driver
also neither uses MMC_CAP_WAIT_WHILE_BUSY nor host->max_busy_timeout
should I leave this as it is?

>> +
>> +       if (cmd->data) {
>> +               send |= FIELD_PREP(MESON_MX_SDIO_SEND_REPEAT_PACKAGE_TIMES_MASK,
>> +                                  (cmd->data->blocks - 1));
>> +
>> +               pack_size = cmd->data->blksz * BITS_PER_BYTE;
>> +               if (mmc->ios.bus_width == MMC_BUS_WIDTH_4)
>> +                       pack_size += MESON_MX_SDIO_RESPONSE_CRC16_BITS * 4;
>> +               else
>> +                       pack_size += MESON_MX_SDIO_RESPONSE_CRC16_BITS * 1;
>> +
>> +               ext |= FIELD_PREP(MESON_MX_SDIO_EXT_DATA_RW_NUMBER_MASK,
>> +                                 pack_size);
>> +
>> +               if (cmd->data->flags & MMC_DATA_WRITE)
>> +                       send |= MESON_MX_SDIO_SEND_DATA;
>> +               else
>> +                       send |= MESON_MX_SDIO_SEND_RESP_HAS_DATA;
>> +
>> +               cmd->data->bytes_xfered = 0;
>> +       }
>> +
>> +       send |= FIELD_PREP(MESON_MX_SDIO_SEND_COMMAND_INDEX_MASK,
>> +                          (0x40 | cmd->opcode));
>> +
>> +       /*
>> +        * soft-reset the MMC core and re-apply the IOS to make sure that these
>> +        * are correct for the slot which is selected below (as the IOS
>> +        * registers are shared across all slots).
>> +        */
>> +       meson_mx_mmc_soft_reset(slot->host);
>> +       meson_mx_mmc_apply_ios(mmc, &mmc->ios);
>
> The above function calls clk_set_rate(), which triggers the common
> clock framework to take the mutex.
>
> Doing that while disabled irqs via spin_lock_irqsave() earlier above,
> seems like a bad idea.
OK, noted - see also my comment regarding the whole locking situation below

>> +
>> +       mult = meson_mx_mmc_readl(mmc, MESON_MX_SDIO_MULT);
>> +       mult &= ~MESON_MX_SDIO_MULT_PORT_SEL_MASK;
>> +       mult |= FIELD_PREP(MESON_MX_SDIO_MULT_PORT_SEL_MASK, slot->id);
>> +       mult |= BIT(31);
>> +       meson_mx_mmc_writel(mmc, mult, MESON_MX_SDIO_MULT);
>> +
>> +       meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_IRQC,
>> +                              MESON_MX_SDIO_IRQC_ARC_CMD_INT_EN,
>> +                              MESON_MX_SDIO_IRQC_ARC_CMD_INT_EN);
>> +
>> +       /* clear pending interrupts */
>> +       meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_IRQS,
>> +                              MESON_MX_SDIO_IRQS_CMD_INT,
>> +                              MESON_MX_SDIO_IRQS_CMD_INT);
>> +
>> +       meson_mx_mmc_writel(mmc, cmd->arg, MESON_MX_SDIO_ARGU);
>> +       meson_mx_mmc_writel(mmc, ext, MESON_MX_SDIO_EXT);
>> +       meson_mx_mmc_writel(mmc, send, MESON_MX_SDIO_SEND);
>> +
>> +       spin_unlock_irqrestore(&slot->host->irq_lock, irqflags);
>> +
>> +       if (cmd->opcode == MMC_ERASE)
>> +               timeout = msecs_to_jiffies(30000);
>> +       else if (cmd->data)
>> +               timeout = msecs_to_jiffies(5000);
>> +       else
>> +               timeout = msecs_to_jiffies(1000);
>
> Please don't hard-code these timeouts. Instead make use of the
> cmd.busy_timeout, as that should contain a proper timeout value.
I successfully tested a reduced version of this, using
cmd.busy_timeout as suggested (and only fall back to a 1sec timeout if
there's no busy_timeout given): this still works fine on my hardware
(so again, thanks for the hint!)

>> +
>> +       mod_timer(&slot->host->cmd_timeout, jiffies + timeout);
>> +}
>> +
>
> [...]
>
>> +static void meson_mx_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>> +{
>> +       struct meson_mx_mmc_slot *slot = mmc_priv(mmc);
>> +
>> +       if (spin_trylock(&slot->host->lock)) {
>> +               /*
>> +                * only apply the mmc_ios if we are idle to not break any
>> +                * ongoing transfer. in case we are busy meson_mx_mmc_start_cmd
>> +                * will take care of applying the mmc_ios later on.
>> +                */
>> +               if (slot->host->status == MESON_MX_MMC_STATUS_IDLE)
>> +                       meson_mx_mmc_apply_ios(mmc, ios);
>
> No this doesn't work!
>
> In case the status != MESON_MX_MMC_STATUS_IDLE or if the attempt to
> take the lock fails, you will just silently ignore to set the new ios
> settings.
>
> The mmc core implements the mmc/sd/sdio specifications, so when you
> return from the ->set_ios() host ops, the mmc core relies on the host
> to have applied the settings to conform the the specs. You can not
> delay that to a later point.
OK, I did not know that this was part of the mmc/sd/sdio spec
the problem I (and the vendor driver) was trying to solve here is the
fact that we could end up with a call chain like this:
- slot0.set_ios(400 kHz)
- slot1.set_ios(50 MHz)
- slot0.request(cmd)
- slot1.request(cmd)
(or anything else, where the IOS change between the .set_ios and
.request invocation of the same slot)

the main problem here is that the clock divider register bits are
shared across all slots!

can I simply always apply the IOS here in .set_ios and then still
re-apply them in .request() if needed?

>> +
>> +               spin_unlock(&slot->host->lock);
>> +       }
>> +
>> +       switch (ios->power_mode) {
>> +       case MMC_POWER_OFF:
>> +               if (!IS_ERR(mmc->supply.vmmc))
>> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>> +               break;
>> +
>> +       case MMC_POWER_UP:
>> +               if (!IS_ERR(mmc->supply.vmmc))
>> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
>> +               break;
>> +       }
>> +}
>> +
>> +static void meson_mx_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>> +{
>> +       struct meson_mx_mmc_slot *slot = mmc_priv(mmc);
>> +       unsigned long irqflags;
>> +
>> +       spin_lock_irqsave(&slot->host->irq_lock, irqflags);
>> +
>> +       meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_MULT,
>> +                              MESON_MX_SDIO_MULT_PORT_SEL_MASK,
>> +                              FIELD_PREP(MESON_MX_SDIO_MULT_PORT_SEL_MASK,
>> +                                         slot->id));
>> +
>> +       /* ACK pending interrupt */
>> +       meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_IRQS,
>> +                              MESON_MX_SDIO_IRQS_IF_INT,
>> +                              MESON_MX_SDIO_IRQS_IF_INT);
>> +
>> +       meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_IRQC,
>> +                              MESON_MX_SDIO_IRQC_ARC_IF_INT_EN,
>> +                              enable ? MESON_MX_SDIO_IRQC_ARC_IF_INT_EN : 0);
>> +
>> +       if (enable)
>> +               slot->host->sdio_irq_slot = slot;
>> +       else
>> +               slot->host->sdio_irq_slot = NULL;
>
> This looks weird. You support up to three slots per host, but only one
> can do sdio_irq?
>
> BTW, what happens if there are is a ongoing data transfer on an SD
> card slot, while there is an SDIO irq raised on the SDIO card slot? Do
> you cope with this correctly?
good question indeed. I guess I'll remove SDIO interrupt support for
now as I am not sure how this is supposed to work in the vendor driver
(which just uses the last active slot to figure out if there was an
SDIO interrupt)

>> +
>> +       spin_unlock_irqrestore(&slot->host->irq_lock, irqflags);
>> +}
>> +
>
> [...]
>
>> +
>> +static void meson_mx_mmc_process_sdio_irq(struct meson_mx_mmc_slot *slot)
>> +{
>> +       /*
>> +        * ignore SDIO interrupts without corresponding slot as the SDIO
>> +        * interrupt seems to enable itself automatically - in this case we
>> +        * didn't assign a slot for this IRQ so we simply ignore it.
>> +        */
>> +       if (!slot)
>> +               return;
>> +
>> +       mmc_signal_sdio_irq(slot->mmc);
>
> Please use the new sdio_signal_irq() API and method instead. This also
> means you should implement the ->ack_sdio_irq() host ops.
I'll keep this in mind if decide that I will keep SDIO interrupt
support (see above)

> [...]
>
>> +
>> +static int meson_mx_mmc_register_slot_device(struct device_node *np,
>> +                                            unsigned int id,
>> +                                            struct meson_mx_mmc_host *host)
>> +{
>> +       struct device *dev = &host->slot_devices[id];
>> +
>> +       dev->parent = host->dev;
>> +       dev->of_node = np;
>> +       dev->release = meson_mx_mmc_slot_device_release;
>> +       dev_set_name(dev, "%s.%d", dev_name(dev->parent), id);
>> +
>> +       return device_register(dev);
>
> As stated, please try to use of_platform_device_create() instead.
>
>> +}
>> +
>> +static int meson_mx_mmc_add_slot(struct device_node *np,
>> +                                struct meson_mx_mmc_host *host)
>> +{
>> +       struct meson_mx_mmc_slot *slot;
>> +       struct mmc_host *mmc;
>> +       unsigned int id;
>> +       int ret;
>> +
>> +       if (of_property_read_u32(np, "reg", &id)) {
>> +               dev_err(host->dev, "missing 'reg' property for %s\n",
>> +                       of_node_full_name(np));
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (id >= MESON_MX_SDIO_MAX_SLOTS) {
>> +               dev_err(host->dev,
>> +                       "invalid 'reg' property value of %s\n",
>> +                       of_node_full_name(np));
>> +               return -EINVAL;
>> +       }
>> +
>> +       ret = meson_mx_mmc_register_slot_device(np, id, host);
>> +       if (ret)
>> +               return ret;
>> +
>> +       mmc = mmc_alloc_host(sizeof(*slot), &host->slot_devices[id]);
>> +       if (!mmc) {
>> +               ret = -ENOMEM;
>> +               goto error_unregister_dev;
>> +       }
>> +
>> +       slot = mmc_priv(mmc);
>> +       slot->mmc = mmc;
>> +       slot->id = id;
>> +       slot->host = host;
>> +
>> +       host->slots[id] = slot;
>> +
>> +       /* Get regulators and the supported OCR mask */
>> +       ret = mmc_regulator_get_supply(mmc);
>> +       if (ret == -EPROBE_DEFER)
>> +               goto error_free_host;
>> +
>> +       mmc->max_req_size = MESON_MX_SDIO_BOUNCE_REQ_SIZE;
>> +       mmc->max_seg_size = mmc->max_req_size;
>> +       mmc->max_blk_count =
>> +               FIELD_GET(MESON_MX_SDIO_SEND_REPEAT_PACKAGE_TIMES_MASK,
>> +                         0xffffffff);
>> +       mmc->max_blk_size = FIELD_GET(MESON_MX_SDIO_EXT_DATA_RW_NUMBER_MASK,
>> +                                     0xffffffff);
>> +       mmc->max_blk_size -= (4 * MESON_MX_SDIO_RESPONSE_CRC16_BITS);
>> +       mmc->max_blk_size /= BITS_PER_BYTE;
>> +
>> +       /* Get the min and max supported clock rates */
>> +       mmc->f_min = clk_round_rate(host->cfg_div_clk, 1);
>> +       mmc->f_max = clk_round_rate(host->cfg_div_clk,
>> +                                   clk_get_rate(host->parent_clk));
>> +
>> +       mmc->caps |= MMC_CAP_CMD23;
>> +       mmc->ops = &meson_mx_mmc_ops;
>> +
>> +       ret = mmc_of_parse(mmc);
>> +       if (ret)
>> +               goto error_free_host;
>> +
>> +       ret = mmc_add_host(mmc);
>> +       if (ret)
>> +               goto error_free_host;
>> +
>> +       return 0;
>> +
>> +error_free_host:
>> +       mmc_free_host(mmc);
>> +error_unregister_dev:
>> +       device_unregister(&host->slot_devices[id]);
>> +       return ret;
>> +}
>> +
>> +static int meson_mx_mmc_probe_slots(struct meson_mx_mmc_host *host)
>> +{
>> +       struct device_node *slot_node, *controller_node;
>> +       int num_slots, ret;
>> +
>> +       controller_node = host->dev->of_node;
>> +
>> +       num_slots = of_get_available_child_count(controller_node);
>
> According to the comment I had on the DT doc change in patch1, this
> doesn't work as we are using child nodes to describe an embedded card
> (embedded SDIO/eMMC) and SDIO func devices.
>
> You need to also search for a compatible string, "mmc-slot".
it actually works (as I described the devices as child-nodes of the
slot nodes, so the graph is: SoC > MMC controller > slot N > device).
however, that doesn't mean it's correct :)
I added a check for "mmc-slot" compatibility. I'll also mention this
in the documentation

>> +       if (num_slots > MESON_MX_SDIO_MAX_SLOTS) {
>> +               dev_err(host->dev, "more slots configured than supported\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       for_each_available_child_of_node(controller_node, slot_node) {
>> +               ret = meson_mx_mmc_add_slot(slot_node, host);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
>> +{
>> +       struct clk_init_data init;
>> +       const char *clk_div_parents[1], *clk_fixed_factor_parents[1];
>
> It seems silly to use and array of size 1. Below should work as well, right!?
>
> const char *clk_div_parents, *clk_fixed_factor_parents;
indeed, works fine as well

>> +
>> +       clk_fixed_factor_parents[0] = __clk_get_name(host->parent_clk);
>> +       init.name = devm_kasprintf(host->dev, GFP_KERNEL, "%s#fixed_factor",
>> +                                  dev_name(host->dev));
>> +       init.ops = &clk_fixed_factor_ops;
>> +       init.flags = 0;
>> +       init.parent_names = clk_fixed_factor_parents;
>> +       init.num_parents = 1;
>> +       host->fixed_factor.div = 2;
>> +       host->fixed_factor.mult = 1;
>> +       host->fixed_factor.hw.init = &init;
>> +
>> +       host->fixed_factor_clk = devm_clk_register(host->dev,
>> +                                                &host->fixed_factor.hw);
>> +       if (WARN_ON(PTR_ERR_OR_ZERO(host->fixed_factor_clk)))
>> +               return PTR_ERR(host->fixed_factor_clk);
>> +
>> +       clk_div_parents[0] = __clk_get_name(host->fixed_factor_clk);
>> +       init.name = devm_kasprintf(host->dev, GFP_KERNEL, "%s#div",
>> +                                  dev_name(host->dev));
>> +       init.ops = &clk_divider_ops;
>> +       init.flags = CLK_SET_RATE_PARENT;
>> +       init.parent_names = clk_div_parents;
>> +       init.num_parents = 1;
>> +       host->cfg_div.reg = host->base + MESON_MX_SDIO_CONF;
>> +       host->cfg_div.shift = MESON_MX_SDIO_CONF_CMD_CLK_DIV_SHIFT;
>> +       host->cfg_div.width = MESON_MX_SDIO_CONF_CMD_CLK_DIV_WIDTH;
>> +       host->cfg_div.hw.init = &init;
>> +       host->cfg_div.flags = CLK_DIVIDER_ALLOW_ZERO;
>> +
>> +       host->cfg_div_clk = devm_clk_register(host->dev, &host->cfg_div.hw);
>> +       if (WARN_ON(PTR_ERR_OR_ZERO(host->cfg_div_clk)))
>> +               return PTR_ERR(host->fixed_factor_clk);
>> +
>> +       return 0;
>> +}
>> +
>
> [...]
>
> Another overall comment, which relates to the host locking mechanism
> and the problem with ->set_ios(). Perhaps you can look into how the
> cavium mmc driver has solved the similar problems as it also manages
> several slots per host.
thank your for the hint with the cavium driver. using a semaphore to
serialize the requests of multiple slots seems a good idea too.
to avoid a "broken by design" RFC v2, can you please give me some more
details how the cavium driver code matches with the mmc/sd/sdio spec
and the mmc framework?

as I explained above the clock divider and bus-width register bits are
shared across all slots. so if one device operates in 1-bit mode while
the other uses 4-bit mode (or different clock rates, it just doesn't
matter) then we need to make sure that these settings stay the same
between .set_ios() and .request, until the request is completed
(regardless of whether that was successful or not/a timeout occurred).

from what I can read in the cavium driver (where the situation seems
to be the same), it uses acquire_bus() at the beginning of
.set_ios/.request and release_bus() at the end of it and keeping a
backup of the registers which are modified during .set_ios. once it
switches to a different slot it restores the register values for the
new slot (this can also happen in .request). this solves the problem
of keeping the correct IOS when switching slots at any point

however, what I don't understand so far is how it synchronizes the
access to the CMD response bits which are read in the interrupt. what
if slot0 sends a command, then right after that (before the the card
in slot0 replied) slot1 sends a command -> how is it going to know to
which slot the response belongs? (I am facing the same problem with
the the meson-mx-sdio driver, the solution is to allow only one
request at a time and queue all other requests -> I am not sure if
this is good solution though)


Regards,
Martin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
