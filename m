From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v11 2/9] mmc: cavium: Add core MMC driver for Cavium SOCs
Date: Fri, 3 Mar 2017 12:47:14 +0100
Message-ID: <CAPDyKFpZs-WZ32NQTc3zY6RdWJecZkUvbEbszAJfv4H2Rw2JCQ@mail.gmail.com>
References: <20170206133953.8390-1-jglauber@cavium.com> <20170206133953.8390-3-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36293 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbdCCMPR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Mar 2017 07:15:17 -0500
Received: by mail-qk0-f170.google.com with SMTP id 1so52775224qkl.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Mar 2017 04:15:16 -0800 (PST)
In-Reply-To: <20170206133953.8390-3-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>

On 6 February 2017 at 14:39, Jan Glauber <jglauber@cavium.com> wrote:
> This core driver will be used by a MIPS platform driver
> or by an ARM64 PCI driver. The core driver implements the
> mmc_host_ops and slot probe & remove functions.
> Callbacks are provided to allow platform specific interrupt
> enable and bus locking.
>
> The host controller supports:
> - up to 4 slots that can contain sd-cards or eMMC chips
> - 1, 4 and 8 bit bus width
> - SDR and DDR
> - transfers up to 52 Mhz (might be less when multiple slots are used)
> - DMA read/write
> - multi-block read/write (but not stream mode)
>
> Voltage is limited to 3.3v and shared for all slots.

What voltage? The I/O voltage or the voltage for the card?

VMMC or VMMCQ?

>
> A global lock for all MMC devices is required because the host
> controller is shared.
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> ---
>  drivers/mmc/host/cavium-mmc.c | 1029 +++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cavium-mmc.h |  303 ++++++++++++
>  2 files changed, 1332 insertions(+)
>  create mode 100644 drivers/mmc/host/cavium-mmc.c
>  create mode 100644 drivers/mmc/host/cavium-mmc.h
>
> diff --git a/drivers/mmc/host/cavium-mmc.c b/drivers/mmc/host/cavium-mmc.c
> new file mode 100644
> index 0000000..40aee08
> --- /dev/null
> +++ b/drivers/mmc/host/cavium-mmc.c

[...]

> +
> +static bool bad_status(union mio_emm_rsp_sts *rsp_sts)
> +{
> +       if (rsp_sts->s.rsp_bad_sts || rsp_sts->s.rsp_crc_err ||
> +           rsp_sts->s.rsp_timeout || rsp_sts->s.blk_crc_err ||
> +           rsp_sts->s.blk_timeout || rsp_sts->s.dbuf_err)
> +               return true;
> +
> +       return false;
> +}
> +
> +/* Try to clean up failed DMA. */
> +static void cleanup_dma(struct cvm_mmc_host *host,
> +                       union mio_emm_rsp_sts *rsp_sts)
> +{
> +       union mio_emm_dma emm_dma;
> +
> +       emm_dma.val = readq(host->base + MIO_EMM_DMA);
> +       emm_dma.s.dma_val = 1;
> +       emm_dma.s.dat_null = 1;
> +       emm_dma.s.bus_id = rsp_sts->s.bus_id;
> +       writeq(emm_dma.val, host->base + MIO_EMM_DMA);
> +}
> +
> +irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
> +{
> +       struct cvm_mmc_host *host = dev_id;
> +       union mio_emm_rsp_sts rsp_sts;
> +       union mio_emm_int emm_int;
> +       struct mmc_request *req;
> +       bool host_done;
> +
> +       /* Clear interrupt bits (write 1 clears ). */
> +       emm_int.val = readq(host->base + MIO_EMM_INT);
> +       writeq(emm_int.val, host->base + MIO_EMM_INT);
> +
> +       if (emm_int.s.switch_err)
> +               check_switch_errors(host);
> +
> +       req = host->current_req;
> +       if (!req)
> +               goto out;
> +
> +       rsp_sts.val = readq(host->base + MIO_EMM_RSP_STS);
> +       /*
> +        * dma_val set means DMA is still in progress. Don't touch
> +        * the request and wait for the interrupt indicating that
> +        * the DMA is finished.
> +        */
> +       if (rsp_sts.s.dma_val && host->dma_active)
> +               goto out;
> +
> +       if (!host->dma_active && emm_int.s.buf_done && req->data) {
> +               unsigned int type = (rsp_sts.val >> 7) & 3;
> +
> +               if (type == 1)
> +                       do_read(host, req, rsp_sts.s.dbuf);
> +               else if (type == 2)
> +                       do_write(req);
> +       }
> +
> +       host_done = emm_int.s.cmd_done || emm_int.s.dma_done ||
> +                   emm_int.s.cmd_err || emm_int.s.dma_err;
> +
> +       if (!(host_done && req->done))
> +               goto no_req_done;
> +
> +       if (bad_status(&rsp_sts))
> +               req->cmd->error = -EILSEQ;

I don't think you should treat all errors as -EILSEQ. Please assign a
proper error code, depending on the error.

> +       else
> +               req->cmd->error = 0;
> +
> +       if (host->dma_active && req->data)
> +               if (!finish_dma(host, req->data))
> +                       goto no_req_done;
> +
> +       set_cmd_response(host, req, &rsp_sts);
> +       if (emm_int.s.dma_err && rsp_sts.s.dma_pend)
> +               cleanup_dma(host, &rsp_sts);
> +
> +       host->current_req = NULL;
> +       req->done(req);
> +
> +no_req_done:
> +       if (host_done)
> +               host->release_bus(host);
> +out:
> +       return IRQ_RETVAL(emm_int.val != 0);
> +}
> +
> +/*
> + * Program DMA_CFG and if needed DMA_ADR.
> + * Returns 0 on error, DMA address otherwise.
> + */
> +static u64 prepare_dma_single(struct cvm_mmc_host *host, struct mmc_data *data)
> +{
> +       union mio_emm_dma_cfg dma_cfg;
> +       int count;
> +       u64 addr;
> +
> +       count = dma_map_sg(host->dev, data->sg, data->sg_len,
> +                          get_dma_dir(data));
> +       if (!count)
> +               return 0;
> +
> +       dma_cfg.val = 0;
> +       dma_cfg.s.en = 1;
> +       dma_cfg.s.rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
> +#ifdef __LITTLE_ENDIAN
> +       dma_cfg.s.endian = 1;
> +#endif
> +       dma_cfg.s.size = (sg_dma_len(&data->sg[0]) / 8) - 1;
> +
> +       addr = sg_dma_address(&data->sg[0]);
> +       dma_cfg.s.adr = addr;
> +       writeq(dma_cfg.val, host->dma_base + MIO_EMM_DMA_CFG);
> +
> +       pr_debug("[%s] sg_dma_len: %u  total sg_elem: %d\n",
> +                (dma_cfg.s.rw) ? "W" : "R", sg_dma_len(&data->sg[0]), count);
> +       return addr;
> +}
> +
> +static u64 prepare_dma(struct cvm_mmc_host *host, struct mmc_data *data)
> +{
> +       return prepare_dma_single(host, data);
> +}
> +
> +static void prepare_ext_dma(struct mmc_host *mmc, struct mmc_request *mrq,
> +                           union mio_emm_dma *emm_dma)
> +{
> +       struct cvm_mmc_slot *slot = mmc_priv(mmc);
> +
> +       /*
> +        * Our MMC host hardware does not issue single commands,
> +        * because that would require the driver and the MMC core
> +        * to do work to determine the proper sequence of commands.

I don't get this. The allowed sequence of the commands is determined
by the SD/(e)MMC/SDIO spec and much of this knowledge is the
responsibility of the mmc core.

> +        * Instead, our hardware is superior to most other MMC bus

No need to brag about your HW. Let's just describe how it works instead.

> +        * hosts. The sequence of MMC commands required to execute
> +        * a transfer are issued automatically by the bus hardware.

What does this really mean? Is this about HW support for better
dealing with data requests?

> +        *
> +        * - David Daney <ddaney@cavium.com>
> +        */
> +       emm_dma->val = 0;
> +       emm_dma->s.bus_id = slot->bus_id;
> +       emm_dma->s.dma_val = 1;
> +       emm_dma->s.sector = (mrq->data->blksz == 512) ? 1 : 0;
> +       emm_dma->s.rw = (mrq->data->flags & MMC_DATA_WRITE) ? 1 : 0;
> +       emm_dma->s.block_cnt = mrq->data->blocks;
> +       emm_dma->s.card_addr = mrq->cmd->arg;
> +       if (mmc_card_mmc(mmc->card) || (mmc_card_sd(mmc->card) &&
> +           (mmc->card->scr.cmds & SD_SCR_CMD23_SUPPORT)))
> +               emm_dma->s.multi = 1;
> +
> +       pr_debug("[%s] blocks: %u  multi: %d\n", (emm_dma->s.rw) ? "W" : "R",
> +                mrq->data->blocks, emm_dma->s.multi);
> +}
> +

[...]

> +
> +static void cvm_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct cvm_mmc_slot *slot = mmc_priv(mmc);
> +       struct cvm_mmc_host *host = slot->host;
> +       int clk_period, power_class = 10, bus_width = 0;
> +       union mio_emm_switch emm_switch;
> +       u64 clock;
> +
> +       host->acquire_bus(host);
> +       cvm_mmc_switch_to(slot);
> +
> +       /* Set the power state */
> +       switch (ios->power_mode) {
> +       case MMC_POWER_ON:
> +               break;
> +
> +       case MMC_POWER_OFF:
> +               cvm_mmc_reset_bus(slot);
> +
> +               if (host->global_pwr_gpiod)
> +                       gpiod_set_value_cansleep(host->global_pwr_gpiod, 0);
> +               else
> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +               break;
> +
> +       case MMC_POWER_UP:
> +               if (host->global_pwr_gpiod)
> +                       gpiod_set_value_cansleep(host->global_pwr_gpiod, 1);
> +               else
> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
> +               break;
> +       }
> +
> +       /* Set bus width */
> +       switch (ios->bus_width) {
> +       case MMC_BUS_WIDTH_8:
> +               bus_width = 2;
> +               break;
> +       case MMC_BUS_WIDTH_4:
> +               bus_width = 1;
> +               break;
> +       case MMC_BUS_WIDTH_1:
> +               bus_width = 0;
> +               break;
> +       }
> +
> +       slot->bus_width = bus_width;
> +
> +       if (!ios->clock)

There are cases when the core change the clock rate to 0, and then it
expects the mmc host to gate the clock. It probably a good idea for
you to do that as well.

> +               goto out;
> +
> +       /* Change the clock frequency. */
> +       clock = ios->clock;
> +       if (clock > 52000000)
> +               clock = 52000000;
> +       slot->clock = clock;
> +       clk_period = (host->sys_freq + clock - 1) / (2 * clock);
> +
> +       emm_switch.val = 0;
> +       emm_switch.s.hs_timing = (ios->timing == MMC_TIMING_MMC_HS);
> +       emm_switch.s.bus_width = bus_width;
> +       emm_switch.s.power_class = power_class;
> +       emm_switch.s.clk_hi = clk_period;
> +       emm_switch.s.clk_lo = clk_period;
> +       emm_switch.s.bus_id = slot->bus_id;
> +
> +       if (!switch_val_changed(slot, emm_switch.val))
> +               goto out;
> +
> +       set_wdog(slot, 0);
> +       do_switch(host, emm_switch.val);
> +       slot->cached_switch = emm_switch.val;
> +out:
> +       host->release_bus(host);
> +}

[...]

> +
> +static int set_bus_width(struct device *dev, struct cvm_mmc_slot *slot, u32 id)
> +{
> +       u32 bus_width;
> +       int ret;
> +
> +       /*
> +        * The "cavium,bus-max-width" property is DEPRECATED and should
> +        * not be used. We handle it here to support older firmware.
> +        * Going forward, the standard "bus-width" property is used
> +        * instead of the Cavium-specific property.
> +        */
> +       if (!(slot->mmc->caps & (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA))) {
> +               /* Try legacy "cavium,bus-max-width" property. */
> +               ret = of_property_read_u32(dev->of_node, "cavium,bus-max-width",
> +                                          &bus_width);
> +               if (ret) {
> +                       /* No bus width specified, use default. */
> +                       bus_width = 8;
> +                       dev_info(dev, "Default width 8 used for slot %u\n", id);
> +               }
> +       } else {
> +               /* Hosts capable of 8-bit transfers can also do 4 bits */
> +               bus_width = (slot->mmc->caps & MMC_CAP_8_BIT_DATA) ? 8 : 4;
> +       }

This looks a bit unnessarry complex.

I would instead suggest the following order of how to perform the OF
parsing. Bindings that get parsed later, overrides the earlier.

1. Parse deprecated bindings.
2. Parse cavium specific bindings.
3. Parse common mmc bindings.
4. Check some caps, to make sure those have valid values as to cover
cases when the OF parsing didn't find values.

The same comment applies for the other OF parsing functions below.

> +
> +       switch (bus_width) {
> +       case 8:
> +               slot->bus_width = (MMC_BUS_WIDTH_8 - 1);
> +               slot->mmc->caps = MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA;
> +               break;
> +       case 4:
> +               slot->bus_width = (MMC_BUS_WIDTH_4 - 1);
> +               slot->mmc->caps = MMC_CAP_4_BIT_DATA;
> +               break;
> +       case 1:
> +               slot->bus_width = MMC_BUS_WIDTH_1;
> +               break;
> +       default:
> +               dev_err(dev, "Invalid bus width for slot %u\n", id);
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
> +static void set_frequency(struct device *dev, struct mmc_host *mmc, u32 id)
> +{
> +       int ret;
> +
> +       /*
> +        * The "spi-max-frequency" property is DEPRECATED and should
> +        * not be used. We handle it here to support older firmware.
> +        * Going forward, the standard "max-frequency" property is
> +        * used instead of the Cavium-specific property.
> +        */
> +       if (mmc->f_max == 0) {
> +               /* Try legacy "spi-max-frequency" property. */
> +               ret = of_property_read_u32(dev->of_node, "spi-max-frequency",
> +                                          &mmc->f_max);
> +               if (ret) {
> +                       /* No frequency properties found, use default. */
> +                       mmc->f_max = 52000000;
> +                       dev_info(dev, "Default %u frequency used for slot %u\n",
> +                                mmc->f_max, id);
> +               }
> +       } else if (mmc->f_max > 52000000)
> +               mmc->f_max = 52000000;
> +
> +       /* Set minimum frequency */
> +       mmc->f_min = 400000;
> +}
> +
> +static int set_voltage(struct device *dev, struct mmc_host *mmc,
> +                      struct cvm_mmc_host *host)
> +{
> +       int ret;
> +
> +       /*
> +        * Legacy platform doesn't support regulator but enables power gpio
> +        * directly during platform probe.
> +        */
> +       if (host->global_pwr_gpiod)
> +               /* Get a sane OCR mask for other parts of the MMC subsytem. */
> +               return mmc_of_parse_voltage(dev->of_node, &mmc->ocr_avail);

Does really the legacy platforms use the mmc voltage range DT bindings!?

I would rather see that you assign a default value to mmc->ocr_avail,
than using this binding.

> +
> +       mmc->supply.vmmc = devm_regulator_get(dev, "vmmc");
> +       if (IS_ERR(mmc->supply.vmmc)) {
> +               ret = PTR_ERR(mmc->supply.vmmc);
> +       } else {
> +               ret = mmc_regulator_get_ocrmask(mmc->supply.vmmc);
> +               if (ret > 0) {
> +                       mmc->ocr_avail = ret;
> +                       ret = 0;
> +               }
> +       }

This if-else-if is a bit messy.

Why not just return when you get an error instead. That should simply the code.

Maybe you can have look and try to clean up this in the hole file
where you think it would make an improvment.

> +       return ret;
> +}
> +
> +int cvm_mmc_slot_probe(struct device *dev, struct cvm_mmc_host *host)

To reflect that OF is needed, perhaps rename function to
cvm_mmc_of_slot_probe().

> +{
> +       struct device_node *node = dev->of_node;
> +       u32 id, cmd_skew, dat_skew;
> +       struct cvm_mmc_slot *slot;
> +       struct mmc_host *mmc;
> +       u64 clock_period;
> +       int ret;
> +
> +       ret = of_property_read_u32(node, "reg", &id);
> +       if (ret) {
> +               dev_err(dev, "Missing or invalid reg property on %s\n",
> +                       of_node_full_name(node));
> +               return ret;
> +       }
> +
> +       if (id >= CAVIUM_MAX_MMC || host->slot[id]) {
> +               dev_err(dev, "Invalid reg property on %s\n",
> +                       of_node_full_name(node));
> +               return -EINVAL;
> +       }
> +
> +       mmc = mmc_alloc_host(sizeof(struct cvm_mmc_slot), dev);
> +       if (!mmc)
> +               return -ENOMEM;
> +
> +       slot = mmc_priv(mmc);
> +       slot->mmc = mmc;
> +       slot->host = host;
> +
> +       ret = mmc_of_parse(mmc);
> +       if (ret)
> +               goto error;
> +
> +       ret = set_bus_width(dev, slot, id);
> +       if (ret)
> +               goto error;
> +
> +       set_frequency(dev, mmc, id);
> +
> +       /* Octeon-specific DT properties. */
> +       ret = of_property_read_u32(node, "cavium,cmd-clk-skew", &cmd_skew);
> +       if (ret)
> +               cmd_skew = 0;
> +       ret = of_property_read_u32(node, "cavium,dat-clk-skew", &dat_skew);
> +       if (ret)
> +               dat_skew = 0;
> +
> +       ret = set_voltage(dev, mmc, host);
> +       if (ret < 0)
> +               goto error;

The functions set_bus_width(), set_freqeuncy(), set_voltage() all
performs OF parsing and there are some parsing also being done above.

I would suggest you bundle all OF parsing into one function, perhaps
name it "cvm_mmc_of_parse()" or similar. That should make the code a
lot cleaner.

> +
> +       /* Set up host parameters */
> +       mmc->ops = &cvm_mmc_ops;
> +
> +       mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> +                    MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_POWER_OFF_CARD;
> +
> +       mmc->max_segs = 1;
> +
> +       /* DMA size field can address up to 8 MB */
> +       mmc->max_seg_size = 8 * 1024 * 1024;
> +       mmc->max_req_size = mmc->max_seg_size;
> +       /* External DMA is in 512 byte blocks */
> +       mmc->max_blk_size = 512;
> +       /* DMA block count field is 15 bits */
> +       mmc->max_blk_count = 32767;
> +
> +       slot->clock = mmc->f_min;
> +       slot->sclock = host->sys_freq;
> +
> +       /* Period in picoseconds. */
> +       clock_period = 1000000000000ull / slot->sclock;
> +       slot->cmd_cnt = (cmd_skew + clock_period / 2) / clock_period;
> +       slot->dat_cnt = (dat_skew + clock_period / 2) / clock_period;
> +
> +       slot->bus_id = id;
> +       slot->cached_rca = 1;
> +
> +       host->acquire_bus(host);
> +       host->slot[id] = slot;
> +       cvm_mmc_switch_to(slot);
> +       cvm_mmc_init_lowlevel(slot);
> +       host->release_bus(host);
> +
> +       ret = mmc_add_host(mmc);
> +       if (ret) {
> +               dev_err(dev, "mmc_add_host() returned %d\n", ret);
> +               goto error;
> +       }
> +
> +       return 0;
> +
> +error:
> +       slot->host->slot[id] = NULL;
> +       mmc_free_host(slot->mmc);
> +       return ret;
> +}
> +
> +int cvm_mmc_slot_remove(struct cvm_mmc_slot *slot)
> +{
> +       mmc_remove_host(slot->mmc);
> +       slot->host->slot[slot->bus_id] = NULL;
> +       mmc_free_host(slot->mmc);
> +       return 0;
> +}
> diff --git a/drivers/mmc/host/cavium-mmc.h b/drivers/mmc/host/cavium-mmc.h
> new file mode 100644
> index 0000000..27fb02b
> --- /dev/null
> +++ b/drivers/mmc/host/cavium-mmc.h
> @@ -0,0 +1,303 @@
> +/*
> + * Driver for MMC and SSD cards for Cavium OCTEON and ThunderX SOCs.
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2012-2016 Cavium Inc.
> + */
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/mmc/host.h>
> +#include <linux/of.h>
> +#include <linux/scatterlist.h>
> +#include <linux/semaphore.h>
> +
> +#define CAVIUM_MAX_MMC         4
> +
> +struct cvm_mmc_host {
> +       struct device *dev;
> +       void __iomem *base;
> +       void __iomem *dma_base;
> +       u64 emm_cfg;
> +       int last_slot;
> +       struct clk *clk;
> +       int sys_freq;
> +
> +       struct mmc_request *current_req;
> +       struct sg_mapping_iter smi;
> +       bool dma_active;
> +
> +       struct gpio_desc *global_pwr_gpiod;
> +
> +       struct cvm_mmc_slot *slot[CAVIUM_MAX_MMC];
> +
> +       void (*acquire_bus)(struct cvm_mmc_host *);
> +       void (*release_bus)(struct cvm_mmc_host *);
> +       void (*int_enable)(struct cvm_mmc_host *, u64);
> +};
> +
> +struct cvm_mmc_slot {
> +       struct mmc_host *mmc;           /* slot-level mmc_core object */
> +       struct cvm_mmc_host *host;      /* common hw for all slots */
> +
> +       u64 clock;
> +       unsigned int sclock;
> +
> +       u64 cached_switch;
> +       u64 cached_rca;
> +
> +       unsigned int cmd_cnt;           /* sample delay */
> +       unsigned int dat_cnt;           /* sample delay */
> +
> +       int bus_width;
> +       int bus_id;
> +};
> +
> +struct cvm_mmc_cr_type {
> +       u8 ctype;
> +       u8 rtype;
> +};
> +
> +struct cvm_mmc_cr_mods {
> +       u8 ctype_xor;
> +       u8 rtype_xor;
> +};
> +
> +/* Bitfield definitions */
> +
> +union mio_emm_cmd {
> +       u64 val;
> +       struct mio_emm_cmd_s {
> +#ifdef __BIG_ENDIAN_BITFIELD

Huh. Sorry, but this is a big nack from me.

This isn't the common method for how we deal with endian issues in the
kernel. Please remove all use of the union types here and below. The
follow common patterns for how we deal with endian issues.

> +               u64 :2;
> +               u64 bus_id:2;
> +               u64 cmd_val:1;
> +               u64 :3;
> +               u64 dbuf:1;
> +               u64 offset:6;
> +               u64 :6;
> +               u64 ctype_xor:2;
> +               u64 rtype_xor:3;
> +               u64 cmd_idx:6;
> +               u64 arg:32;
> +#else
> +               u64 arg:32;
> +               u64 cmd_idx:6;
> +               u64 rtype_xor:3;
> +               u64 ctype_xor:2;
> +               u64 :6;
> +               u64 offset:6;
> +               u64 dbuf:1;
> +               u64 :3;
> +               u64 cmd_val:1;
> +               u64 bus_id:2;
> +               u64 :2;
> +#endif
> +       } s;
> +};
> +
> +union mio_emm_dma {
> +       u64 val;
> +       struct mio_emm_dma_s {
> +#ifdef __BIG_ENDIAN_BITFIELD
> +               u64 :2;
> +               u64 bus_id:2;
> +               u64 dma_val:1;
> +               u64 sector:1;
> +               u64 dat_null:1;
> +               u64 thres:6;
> +               u64 rel_wr:1;
> +               u64 rw:1;
> +               u64 multi:1;
> +               u64 block_cnt:16;
> +               u64 card_addr:32;
> +#else
> +               u64 card_addr:32;
> +               u64 block_cnt:16;
> +               u64 multi:1;
> +               u64 rw:1;
> +               u64 rel_wr:1;
> +               u64 thres:6;
> +               u64 dat_null:1;
> +               u64 sector:1;
> +               u64 dma_val:1;
> +               u64 bus_id:2;
> +               u64 :2;
> +#endif
> +       } s;
> +};
> +
> +union mio_emm_dma_cfg {
> +       u64 val;
> +       struct mio_emm_dma_cfg_s {
> +#ifdef __BIG_ENDIAN_BITFIELD
> +               u64 en:1;
> +               u64 rw:1;
> +               u64 clr:1;
> +               u64 :1;
> +               u64 swap32:1;
> +               u64 swap16:1;
> +               u64 swap8:1;
> +               u64 endian:1;
> +               u64 size:20;
> +               u64 adr:36;
> +#else
> +               u64 adr:36;
> +               u64 size:20;
> +               u64 endian:1;
> +               u64 swap8:1;
> +               u64 swap16:1;
> +               u64 swap32:1;
> +               u64 :1;
> +               u64 clr:1;
> +               u64 rw:1;
> +               u64 en:1;
> +#endif
> +       } s;
> +};
> +
> +union mio_emm_int {
> +       u64 val;
> +       struct mio_emm_int_s {
> +#ifdef __BIG_ENDIAN_BITFIELD
> +               u64 :57;
> +               u64 switch_err:1;
> +               u64 switch_done:1;
> +               u64 dma_err:1;
> +               u64 cmd_err:1;
> +               u64 dma_done:1;
> +               u64 cmd_done:1;
> +               u64 buf_done:1;
> +#else
> +               u64 buf_done:1;
> +               u64 cmd_done:1;
> +               u64 dma_done:1;
> +               u64 cmd_err:1;
> +               u64 dma_err:1;
> +               u64 switch_done:1;
> +               u64 switch_err:1;
> +               u64 :57;
> +#endif
> +       } s;
> +};
> +
> +union mio_emm_rsp_sts {
> +       u64 val;
> +       struct mio_emm_rsp_sts_s {
> +#ifdef __BIG_ENDIAN_BITFIELD
> +               u64 :2;
> +               u64 bus_id:2;
> +               u64 cmd_val:1;
> +               u64 switch_val:1;
> +               u64 dma_val:1;
> +               u64 dma_pend:1;
> +               u64 :27;
> +               u64 dbuf_err:1;
> +               u64 :4;
> +               u64 dbuf:1;
> +               u64 blk_timeout:1;
> +               u64 blk_crc_err:1;
> +               u64 rsp_busybit:1;
> +               u64 stp_timeout:1;
> +               u64 stp_crc_err:1;
> +               u64 stp_bad_sts:1;
> +               u64 stp_val:1;
> +               u64 rsp_timeout:1;
> +               u64 rsp_crc_err:1;
> +               u64 rsp_bad_sts:1;
> +               u64 rsp_val:1;
> +               u64 rsp_type:3;
> +               u64 cmd_type:2;
> +               u64 cmd_idx:6;
> +               u64 cmd_done:1;
> +#else
> +               u64 cmd_done:1;
> +               u64 cmd_idx:6;
> +               u64 cmd_type:2;
> +               u64 rsp_type:3;
> +               u64 rsp_val:1;
> +               u64 rsp_bad_sts:1;
> +               u64 rsp_crc_err:1;
> +               u64 rsp_timeout:1;
> +               u64 stp_val:1;
> +               u64 stp_bad_sts:1;
> +               u64 stp_crc_err:1;
> +               u64 stp_timeout:1;
> +               u64 rsp_busybit:1;
> +               u64 blk_crc_err:1;
> +               u64 blk_timeout:1;
> +               u64 dbuf:1;
> +               u64 :4;
> +               u64 dbuf_err:1;
> +               u64 :27;
> +               u64 dma_pend:1;
> +               u64 dma_val:1;
> +               u64 switch_val:1;
> +               u64 cmd_val:1;
> +               u64 bus_id:2;
> +               u64 :2;
> +#endif
> +       } s;
> +};
> +
> +union mio_emm_sample {
> +       u64 val;
> +       struct mio_emm_sample_s {
> +#ifdef __BIG_ENDIAN_BITFIELD
> +               u64 :38;
> +               u64 cmd_cnt:10;
> +               u64 :6;
> +               u64 dat_cnt:10;
> +#else
> +               u64 dat_cnt:10;
> +               u64 :6;
> +               u64 cmd_cnt:10;
> +               u64 :38;
> +#endif
> +       } s;
> +};
> +
> +union mio_emm_switch {
> +       u64 val;
> +       struct mio_emm_switch_s {
> +#ifdef __BIG_ENDIAN_BITFIELD
> +               u64 :2;
> +               u64 bus_id:2;
> +               u64 switch_exe:1;
> +               u64 switch_err0:1;
> +               u64 switch_err1:1;
> +               u64 switch_err2:1;
> +               u64 :7;
> +               u64 hs_timing:1;
> +               u64 :5;
> +               u64 bus_width:3;
> +               u64 :4;
> +               u64 power_class:4;
> +               u64 clk_hi:16;
> +               u64 clk_lo:16;
> +#else
> +               u64 clk_lo:16;
> +               u64 clk_hi:16;
> +               u64 power_class:4;
> +               u64 :4;
> +               u64 bus_width:3;
> +               u64 :5;
> +               u64 hs_timing:1;
> +               u64 :7;
> +               u64 switch_err2:1;
> +               u64 switch_err1:1;
> +               u64 switch_err0:1;
> +               u64 switch_exe:1;
> +               u64 bus_id:2;
> +               u64 :2;
> +#endif
> +       } s;
> +};
> +
> +/* Protoypes */
> +irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id);
> +int cvm_mmc_slot_probe(struct device *dev, struct cvm_mmc_host *host);
> +int cvm_mmc_slot_remove(struct cvm_mmc_slot *slot);

Why do you need this here? Are those intended as library functions for
the different cavium variant drivers?

> +extern const struct mmc_host_ops cvm_mmc_ops;

Why do you need this?

Kind regards
Uffe
