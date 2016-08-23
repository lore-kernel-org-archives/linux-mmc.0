From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH V8 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller.
Date: Tue, 23 Aug 2016 10:41:30 -0700
Message-ID: <57BC8ACA.1040506@caviumnetworks.com>
References: <57853474.9050108@cavium.com> <CAPDyKFqaGLWxkG+CqViqDfPqeffKE5rutgR0gduuGs9F0DX+zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <CAPDyKFqaGLWxkG+CqViqDfPqeffKE5rutgR0gduuGs9F0DX+zg@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Steven J. Hill" <steven.hill@cavium.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-mmc@vger.kernel.org

On 08/23/2016 07:53 AM, Ulf Hansson wrote:
> On 12 July 2016 at 20:18, Steven J. Hill <steven.hill@cavium.com> wrote:
[...]

>> +#include <asm/byteorder.h>
>> +#include <asm/octeon/octeon.h>
>

OK, we will duplicate any needed definitions from octeon.h into the 
driver source file.


> We shouldn't include SoC specific headers in a generic mmc driver.

It is not really a generic MMC driver.  It is a driver for an MMC host 
found only on two families of Cavium SoCs.

>
> If there are dependencies to perform SoC specific operations, then you
> should use platform callbacks. Or better, if those operations can be
> made through generic interfaces.
>

This means that code for this device will be spread across two files. 
One for things deemed SoC specific, somewhere in arch/mips, everything 
else (which is really SoS specific too, but deemed to be generic) in 
this file.

>> +
>> +#define DRV_NAME       "octeon_mmc"
>> +
>> +#define OCTEON_MAX_MMC                 4
>> +
>> +#define OCT_MIO_NDF_DMA_CFG            0x00
>> +#define OCT_MIO_EMM_DMA_ADR            0x08
>> +
>> +#define OCT_MIO_EMM_CFG                        0x00
>> +#define OCT_MIO_EMM_SWITCH             0x48
>> +#define OCT_MIO_EMM_DMA                        0x50
>> +#define OCT_MIO_EMM_CMD                        0x58
>> +#define OCT_MIO_EMM_RSP_STS            0x60
>> +#define OCT_MIO_EMM_RSP_LO             0x68
>> +#define OCT_MIO_EMM_RSP_HI             0x70
>> +#define OCT_MIO_EMM_INT                        0x78
>> +#define OCT_MIO_EMM_INT_EN             0x80
>> +#define OCT_MIO_EMM_WDOG               0x88
>> +#define OCT_MIO_EMM_SAMPLE             0x90
>> +#define OCT_MIO_EMM_STS_MASK           0x98
>> +#define OCT_MIO_EMM_RCA                        0xa0
>> +#define OCT_MIO_EMM_BUF_IDX            0xe0
>> +#define OCT_MIO_EMM_BUF_DAT            0xe8
>> +
>> +#define CVMX_MIO_BOOT_CTL      CVMX_ADD_IO_SEG(0x00011800000000D0ull)
>> +
>> +struct octeon_mmc_host {
>> +       void __iomem    *base;
>> +       void __iomem    *ndf_base;
>> +       u64     emm_cfg;
>> +       u64     n_minus_one;  /* OCTEON II workaround location */
>> +       int     last_slot;
>> +
>> +       struct semaphore mmc_serializer;
>> +       struct mmc_request      *current_req;
>> +       unsigned int            linear_buf_size;
>> +       void                    *linear_buf;
>> +       struct sg_mapping_iter smi;
>> +       int sg_idx;
>> +       bool dma_active;
>> +
>> +       struct platform_device  *pdev;
>> +       struct gpio_desc *global_pwr_gpiod;
>> +       bool dma_err_pending;
>> +       bool need_bootbus_lock;
>> +       bool big_dma_addr;
>> +       bool need_irq_handler_lock;
>> +       spinlock_t irq_handler_lock;
>> +       bool has_ciu3;
>> +
>> +       struct octeon_mmc_slot  *slot[OCTEON_MAX_MMC];
>> +};
>> +
>> +struct octeon_mmc_slot {
>> +       struct mmc_host         *mmc;   /* slot-level mmc_core object */
>> +       struct octeon_mmc_host  *host;  /* common hw for all 4 slots */
>> +
>> +       unsigned int            clock;
>> +       unsigned int            sclock;
>> +
>> +       u64                     cached_switch;
>> +       u64                     cached_rca;
>> +
>> +       unsigned int            cmd_cnt; /* sample delay */
>> +       unsigned int            dat_cnt; /* sample delay */
>> +
>> +       int                     bus_width;
>> +       int                     bus_id;
>> +
>> +       /* Legacy property - in future mmc->supply.vmmc should be used */
>> +       struct gpio_desc        *pwr_gpiod;
>> +};
>> +
>> +static int bb_size = 1 << 18;
>> +module_param(bb_size, int, S_IRUGO);
>> +MODULE_PARM_DESC(bb_size,
>> +                "Size of DMA linearizing buffer (max transfer size).");
>> +

bb_size, is a performance tuning parameter.  We can just hard code it to 
some size and not allow it to be changed.


>> +static int ddr = 2;
>> +module_param(ddr, int, S_IRUGO);
>> +MODULE_PARM_DESC(ddr,
>> +                "enable DoubleDataRate clocking: 0=no, 1=always, 2=at spi-max-frequency/2");
>
> The module params here seem like a leftover from a debugging exercise.
> Please remove them.

Yes, this "ddr" thing must be removed.


>
>> +
>> +static void octeon_mmc_acquire_bus(struct octeon_mmc_host *host)
>> +{
>> +       if (host->need_bootbus_lock) {
>> +               down(&octeon_bootbus_sem);
>> +               /* On cn70XX switch the mmc unit onto the bus. */
>> +               if (OCTEON_IS_MODEL(OCTEON_CN70XX))
>
> According to my upper comment about SoC specific code, please move
> this code out of the driver.
>
> You may use a DT compatible string to perform specific operations for
> some versions of the IP/SoC, although not to call SoC specific code
> directly.
>
> This comment applies to other places for $subject patch as well,
> although I am not going to comment on each of them. I leave that to
> you to figure out.
>
>> +                       writeq(0, (void __iomem *)CVMX_MIO_BOOT_CTL);
>> +       } else {
>> +               down(&host->mmc_serializer);
>> +       }
>> +}
>> +
>

I guess we will put it in arch/mips/cavium-octeon/octeon-mmc-platform.c 
or something.

> [...]
>
>> +
>> +/*
>> + * The functions below are used for the EMMC-17978 workaround.
>> + *
>> + * Due to an imperfection in the design of the MMC bus hardware,
>> + * the 2nd to last cache block of a DMA read must be locked into the L2 Cache.
>> + * Otherwise, data corruption may occur.
>> + */
>
> Isn't these operations also depending on the SoC/Arch? If so, perhaps
> you need a set of platform callbacks even for these.
>
>> +
>> +static inline void *phys_to_ptr(u64 address)
>> +{
>> +       return (void *)(address | (1ull<<63)); /* XKPHYS */
>> +}
>> +
>> +/**
>> + * Lock a single line into L2. The line is zeroed before locking
>> + * to make sure no dram accesses are made.
>> + *
>> + * @addr   Physical address to lock
>> + */
>> +static void l2c_lock_line(u64 addr)
>> +{
>> +       char *addr_ptr = phys_to_ptr(addr);
>> +       asm volatile (
>> +               "cache 31, %[line]"     /* Unlock the line */
>> +               :: [line] "m" (*addr_ptr));
>> +}
>> +
>> +/**
>> + * Locks a memory region in the L2 cache
>> + *
>> + * @start - start address to begin locking
>> + * @len - length in bytes to lock
>> + */
>> +static void l2c_lock_mem_region(u64 start, u64 len)
>> +{
>> +       u64 end;
>> +
>> +       /* Round start/end to cache line boundaries */
>> +       end = ALIGN(start + len - 1, CVMX_CACHE_LINE_SIZE);
>> +       start = ALIGN(start, CVMX_CACHE_LINE_SIZE);
>> +
>> +       while (start <= end) {
>> +               l2c_lock_line(start);
>> +               start += CVMX_CACHE_LINE_SIZE;
>> +       }
>> +       asm volatile("sync");
>> +}
>> +
>> +/**
>> + * Unlock a single line in the L2 cache.
>> + *
>> + * @addr       Physical address to unlock
>> + *
>> + * Return Zero on success
>> + */
>> +static void l2c_unlock_line(u64 addr)
>> +{
>> +       char *addr_ptr = phys_to_ptr(addr);
>> +       asm volatile (
>> +               "cache 23, %[line]"     /* Unlock the line */
>> +               :: [line] "m" (*addr_ptr));
>> +}
>> +
>> +/**
>> + * Unlock a memory region in the L2 cache
>> + *
>> + * @start - start address to unlock
>> + * @len - length to unlock in bytes
>> + */
>> +static void l2c_unlock_mem_region(u64 start, u64 len)
>> +{
>> +       u64 end;
>> +
>> +       /* Round start/end to cache line boundaries */
>> +       end = ALIGN(start + len - 1, CVMX_CACHE_LINE_SIZE);
>> +       start = ALIGN(start, CVMX_CACHE_LINE_SIZE);
>> +
>> +       while (start <= end) {
>> +               l2c_unlock_line(start);
>> +               start += CVMX_CACHE_LINE_SIZE;
>> +       }
>> +}
>> +
>
> [...]

I guess we move this code too.

>
>> +
>> +static void octeon_mmc_dma_request(struct mmc_host *mmc,
>> +                                  struct mmc_request *mrq)
>> +{
>> +       struct octeon_mmc_slot  *slot;
>> +       struct octeon_mmc_host  *host;
>> +       struct mmc_command *cmd;
>> +       struct mmc_data *data;
>> +       union cvmx_mio_emm_int emm_int;
>> +       union cvmx_mio_emm_dma emm_dma;
>> +       union cvmx_mio_ndf_dma_cfg dma_cfg;
>> +
>> +       cmd = mrq->cmd;
>> +       if (mrq->data == NULL || mrq->data->sg == NULL || !mrq->data->sg_len ||
>> +           mrq->stop == NULL || mrq->stop->opcode != MMC_STOP_TRANSMISSION) {
>> +               dev_err(&mmc->card->dev,
>> +                       "Error: octeon_mmc_dma_request no data\n");
>> +               cmd->error = -EINVAL;
>> +               if (mrq->done)
>> +                       mrq->done(mrq);
>> +               return;
>> +       }
>> +
>> +       slot = mmc_priv(mmc);
>> +       host = slot->host;
>> +
>> +       /* Only a single user of the bootbus at a time. */
>> +       octeon_mmc_acquire_bus(host);
>> +
>> +       octeon_mmc_switch_to(slot);
>> +
>> +       data = mrq->data;
>> +
>> +       if (data->timeout_ns)
>> +               writeq(octeon_mmc_timeout_to_wdog(slot, data->timeout_ns),
>> +                      host->base + OCT_MIO_EMM_WDOG);
>> +
>> +       WARN_ON(host->current_req);
>> +       host->current_req = mrq;
>> +
>> +       host->sg_idx = 0;
>> +
>> +       WARN_ON(data->blksz * data->blocks > host->linear_buf_size);
>> +
>> +       if ((data->flags & MMC_DATA_WRITE) && data->sg_len > 1) {
>> +               size_t r = sg_copy_to_buffer(data->sg, data->sg_len,
>> +                        host->linear_buf, data->blksz * data->blocks);
>> +               WARN_ON(data->blksz * data->blocks != r);
>> +       }
>> +
>> +       dma_cfg.u64 = 0;
>> +       dma_cfg.s.en = 1;
>> +       dma_cfg.s.rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
>> +#ifdef __LITTLE_ENDIAN
>> +       dma_cfg.s.endian = 1;
>> +#endif
>> +       dma_cfg.s.size = ((data->blksz * data->blocks) / 8) - 1;
>> +       if (!host->big_dma_addr) {
>> +               if (data->sg_len > 1)
>> +                       dma_cfg.s.adr = virt_to_phys(host->linear_buf);
>> +               else
>> +                       dma_cfg.s.adr = sg_phys(data->sg);
>> +       }
>> +       writeq(dma_cfg.u64, host->ndf_base + OCT_MIO_NDF_DMA_CFG);
>> +       if (host->big_dma_addr) {
>> +               u64 addr;
>> +
>> +               if (data->sg_len > 1)
>> +                       addr = virt_to_phys(host->linear_buf);
>> +               else
>> +                       addr = sg_phys(data->sg);
>> +               writeq(addr, host->ndf_base + OCT_MIO_EMM_DMA_ADR);
>> +       }
>> +
>> +       emm_dma.u64 = 0;
>> +       emm_dma.s.bus_id = slot->bus_id;
>> +       emm_dma.s.dma_val = 1;
>> +       emm_dma.s.sector = mmc_card_blockaddr(mmc->card) ? 1 : 0;
>> +       emm_dma.s.rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
>> +       if (mmc_card_mmc(mmc->card) ||
>> +           (mmc_card_sd(mmc->card) &&
>> +               (mmc->card->scr.cmds & SD_SCR_CMD23_SUPPORT)))
>> +               emm_dma.s.multi = 1;
>
> Could you elaborate on exactly what you are doing here. I don't
> understand why you need to check whether the card supports CMD23.


The MMC host hardware doesn't issue single commands, because that would 
require the driver and OS MMC core to do work to determine the proper 
sequence of commands.  Instead, this hardware is superior to most other 
MMC bus hosts, the sequence of MMC command required to execute a 
transfer are issued automatically by the bus hardware.

Because the interface expected by the Linux MMC core is at a lower level 
than what the OCTEON MMC host can accept we need to examine the the 
mmc_request and card capabilities to determine which operations most 
closely match what is being requested.

In the case of emm_dma.s.multi above, the bus hardware will 
automatically issue CMD23 when this bit is set, so we only set it if we 
think it is a valid thing to do.


>
> Moreover you must not access mmc->card unless you make sure there is a
> valid pointer for it.

OK, it has never been found to be invalid in the wild.  When a transfer 
is requested, it always targets some card, but we can add a check at the 
top to return an error code if the card is somehow NULL.


>
>> +       emm_dma.s.block_cnt = data->blocks;
>> +       emm_dma.s.card_addr = cmd->arg;
>> +
>> +       emm_int.u64 = 0;
>> +       emm_int.s.dma_done = 1;
>> +       emm_int.s.cmd_err = 1;
>> +       emm_int.s.dma_err = 1;
>> +       /* Clear the bit. */
>> +       writeq(emm_int.u64, host->base + OCT_MIO_EMM_INT);
>> +       if (!host->has_ciu3)
>> +               writeq(emm_int.u64, host->base + OCT_MIO_EMM_INT_EN);
>> +       host->dma_active = true;
>> +
>> +       if ((OCTEON_IS_MODEL(OCTEON_CN6XXX) ||
>> +               OCTEON_IS_MODEL(OCTEON_CNF7XXX)) &&
>> +           cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK &&
>> +           (data->blksz * data->blocks) > 1024) {
>> +               host->n_minus_one = dma_cfg.s.adr +
>> +                       (data->blksz * data->blocks) - 1024;
>> +               l2c_lock_mem_region(host->n_minus_one, 512);
>> +       }
>> +
>> +       if (mmc->card && mmc_card_sd(mmc->card))
>> +               writeq(0x00b00000ull, host->base + OCT_MIO_EMM_STS_MASK);
>> +       else
>> +               writeq(0xe4f90080ull, host->base + OCT_MIO_EMM_STS_MASK);
>
> Some explanation of what goes on here would be nice. You are writing
> some magic mask depending on whether it SD or MMC.
>
> Does that also mean this controller don't support SDIO? If so, you may
> enable MMC_CAP2_NO_SDIO.
>

See comment above about how magical the controller is.  We have to 
analyze the request and tell the controller which bits in the card 
status to consider when detecting errors in the command sequencing.

We will add a comment about this.


>> +       writeq(emm_dma.u64, host->base + OCT_MIO_EMM_DMA);
>> +}
>> +
>> +static void octeon_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>> +{
>> +       struct octeon_mmc_slot  *slot;
>> +       struct octeon_mmc_host  *host;
>> +       struct mmc_command *cmd;
>> +       union cvmx_mio_emm_int emm_int;
>> +       union cvmx_mio_emm_cmd emm_cmd;
>> +       struct octeon_mmc_cr_mods mods;
>> +
>> +       cmd = mrq->cmd;
>> +
>> +       if (cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
>> +               cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK) {
>
> Instead of checking the opcode, perhaps you should check the number
> blocks/bytes that is about to be transfers.
>
> Or is there a particular reason to why multiblock transfers are required?

See comment above about the magical command sequencing.  We have to 
analyze the request to see if it makes sense to try to run it with using 
the command sequences that use DMA.


>
>> +               octeon_mmc_dma_request(mmc, mrq);
>> +               return;
>> +       }
>> +
>> +       mods = octeon_mmc_get_cr_mods(cmd);
>> +
>> +       slot = mmc_priv(mmc);
>> +       host = slot->host;
>
> [...]
>
>> +
>> +static void octeon_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>> +{
>> +       struct octeon_mmc_slot  *slot;
>> +       struct octeon_mmc_host  *host;
>> +       int bus_width;
>> +       int clock;
>> +       bool ddr_clock;
>> +       int hs_timing;
>> +       int power_class = 10;
>> +       int clk_period;
>> +       int timeout = 2000;
>> +       union cvmx_mio_emm_switch emm_switch;
>> +       union cvmx_mio_emm_rsp_sts emm_sts;
>> +
>> +       slot = mmc_priv(mmc);
>> +       host = slot->host;
>> +
>> +       /* Only a single user of the bootbus at a time. */
>> +       octeon_mmc_acquire_bus(host);
>> +
>> +       octeon_mmc_switch_to(slot);
>> +
>> +       /*
>> +        * Reset the chip on each power off
>> +        */
>> +       if (ios->power_mode == MMC_POWER_OFF) {
>> +               octeon_mmc_reset_bus(slot);
>> +               if (!IS_ERR(mmc->supply.vmmc))
>> +                       regulator_disable(mmc->supply.vmmc);
>
> You shouldn't access this regulator directly, as it's controlled by
> the mmc core. Instead use mmc_regulator_set_ocr()
>
>> +               else /* Legacy power GPIO */
>> +                       gpiod_set_value_cansleep(slot->pwr_gpiod, 0);
>> +       } else {
>> +               if (!IS_ERR(mmc->supply.vmmc))
>> +                       regulator_enable(mmc->supply.vmmc);
>
> Similar comment as above. Use mmc_regulator_set_ocr().
>
>> +               else /* Legacy power GPIO */
>> +                       gpiod_set_value_cansleep(slot->pwr_gpiod, 1);
>> +       }
>> +
>> +       switch (ios->bus_width) {
>> +       case MMC_BUS_WIDTH_8:
>> +               bus_width = 2;
>> +               break;
>> +       case MMC_BUS_WIDTH_4:
>> +               bus_width = 1;
>> +               break;
>> +       case MMC_BUS_WIDTH_1:
>> +               bus_width = 0;
>> +               break;
>> +       default:
>> +               bus_width = 0;
>> +               break;
>> +       }
>
> [...]
>
>> +static const struct mmc_host_ops octeon_mmc_ops = {
>> +       .request        = octeon_mmc_request,
>> +       .set_ios        = octeon_mmc_set_ios,
>> +       .get_ro         = mmc_gpio_get_ro,
>> +       .get_cd         = mmc_gpio_get_cd,
>> +};
>> +
>> +static void octeon_mmc_set_clock(struct octeon_mmc_slot *slot,
>> +                                unsigned int clock)
>> +{
>> +       struct mmc_host *mmc = slot->mmc;
>> +
>> +       clock = min(clock, mmc->f_max);
>> +       clock = max(clock, mmc->f_min);
>> +       slot->clock = clock;
>> +}
>> +
>> +static int octeon_mmc_initlowlevel(struct octeon_mmc_slot *slot,
>> +                                  int bus_width)
>> +{
>> +       union cvmx_mio_emm_switch emm_switch;
>> +       struct octeon_mmc_host *host = slot->host;
>> +
>> +       host->emm_cfg |= 1ull << slot->bus_id;
>> +       writeq(host->emm_cfg, slot->host->base + OCT_MIO_EMM_CFG);
>> +       octeon_mmc_set_clock(slot, 400000);
>> +
>> +       /* Program initial clock speed and power */
>> +       emm_switch.u64 = 0;
>> +       emm_switch.s.power_class = 10;
>> +       emm_switch.s.clk_hi = (slot->sclock / slot->clock) / 2;
>> +       emm_switch.s.clk_lo = (slot->sclock / slot->clock) / 2;
>> +
>> +       writeq(emm_switch.u64, host->base + OCT_MIO_EMM_SWITCH);
>> +       emm_switch.s.bus_id = slot->bus_id;
>> +       writeq(emm_switch.u64, host->base + OCT_MIO_EMM_SWITCH);
>> +       slot->cached_switch = emm_switch.u64;
>> +
>> +       writeq(((u64)slot->clock * 850ull) / 1000ull,
>> +              host->base + OCT_MIO_EMM_WDOG);
>> +       writeq(0xe4f90080ull, host->base + OCT_MIO_EMM_STS_MASK);
>> +       writeq(1, host->base + OCT_MIO_EMM_RCA);
>
> Perhaps some comments explaining what goes on.
>
>> +       return 0;
>> +}
>> +
>> +static int octeon_mmc_slot_probe(struct platform_device *slot_pdev,
>> +                                struct octeon_mmc_host *host)
>> +{
>> +       struct mmc_host *mmc;
>> +       struct octeon_mmc_slot *slot;
>> +       struct device *dev = &slot_pdev->dev;
>> +       struct device_node *node = slot_pdev->dev.of_node;
>> +       u32 id, bus_width, max_freq, cmd_skew, dat_skew;
>> +       u64 clock_period;
>> +       int ret;
>> +
>> +       ret = of_property_read_u32(node, "reg", &id);
>> +       if (ret) {
>> +               dev_err(dev, "Missing or invalid reg property on %s\n",
>> +                       of_node_full_name(node));
>> +               return ret;
>> +       }
>> +
>> +       if (id >= OCTEON_MAX_MMC || host->slot[id]) {
>> +               dev_err(dev, "Invalid reg property on %s\n",
>> +                       of_node_full_name(node));
>> +               return -EINVAL;
>> +       }
>> +
>> +       mmc = mmc_alloc_host(sizeof(struct octeon_mmc_slot), dev);
>> +       if (!mmc) {
>> +               dev_err(dev, "alloc host failed\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       slot = mmc_priv(mmc);
>> +       slot->mmc = mmc;
>> +       slot->host = host;
>> +
>> +       /*
>> +        * The "cavium,bus-max-width" property is DEPRECATED and should
>> +        * not be used. We handle it here to support older firmware.
>> +        * Going forward, the standard "bus-width" property is used
>> +        * instead of the Cavium-specific property.
>> +        */
>
> I think you should call mmc_of_parse() as it will parse for the common
> mmc DT properties.
>
> After that, you should parse for the deprecated mmc cavium DT
> properties and when such is found, update the corresponding values for
> bus width and max freq.
>
> Perhaps you also need a default value for max freq, so you need to
> check that as the final thing.
>
>> +       ret = of_property_read_u32(node, "bus-width", &bus_width);
>> +       if (ret) {
>> +               /* Try legacy "cavium,bus-max-width" property. */
>> +               ret = of_property_read_u32(node, "cavium,bus-max-width",
>> +                                          &bus_width);
>> +               if (ret) {
>> +                       /* No bus width specified, use default. */
>> +                       bus_width = 8;
>> +                       dev_info(dev, "Default bus width %u used for slot %u\n",
>> +                                bus_width, id);
>> +               }
>> +       }
>> +
>> +
>> +       switch (bus_width) {
>> +       case 1:
>> +       case 4:
>> +       case 8:
>> +               break;
>> +       default:
>> +               dev_err(dev, "Invalid bus width for slot %u\n", id);
>> +               ret = -EINVAL;
>> +               goto err;
>> +       }
>> +
>> +       /*
>> +        * The "spi-max-frequency" property is DEPRECATED and should
>> +        * not be used. We handle it here to support older firmware.
>> +        * Going forward, the standard "max-frequency" property is
>> +        * used instead.
>> +        */
>> +       ret = of_property_read_u32(node, "max-frequency", &max_freq);
>> +       if (ret) {
>> +               /* Try legacy "spi-max-frequency" property. */
>> +               ret = of_property_read_u32(node, "spi-max-frequency",
>> +                                          &max_freq);
>> +               if (ret) {
>> +                       /* No frequency properties found, use default. */
>> +                       max_freq = 52000000;
>> +                       dev_info(dev, "Default %u frequency used for slot %u\n",
>> +                                id, max_freq);
>> +               }
>> +       }
>> +
>> +       /* Get regulators and the supported OCR mask */
>> +       ret = mmc_regulator_get_supply(mmc);
>> +       if (ret == -EPROBE_DEFER)
>> +               goto err;
>> +
>> +       /* Alternatively a GPIO may be specified to control slot power */
>> +       slot->pwr_gpiod = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
>
> No, I am not happy with this as we discussed earlier. You need to
> parse the DTB from SoC specifc code and manage the power GPIO from
> there.
>
> Ideally you should register the power GPIO as a GPIO regulator for the
> cavium mmc slot device.

What do we do if the GPIO doensn't really control power to the card, but 
rather is just a bus isolator on the data bus lines?  The device tree 
will still have a property called "power" (as that is a legacy binding 
that cannot be changed), but no power control is done.

In this case, is it still appropiate to use the  regulator framework?

I don't see what is gained.  This is an SoC specific MMC controller that 
is connected in a manner that doesn't really match the Linux regulator 
framework.  Is it really cleaner to put 100 lines of ugly hacks in the 
platform code instead of a couple of lines here in the driver?  What is 
achieved?  We arn't creating an elegant framework, but instead jumping 
through hoops to make an archectual mismatch between various Linux 
driver frameworks be bent to fit as a matter of principle.

If that is what you require to merge the driver we will do it.


>
> In that way you will get the calculated OCR mask just by calling
> mmc_regulator_get_supply() and you don't need to use the GPIO API to
> deal with powers.
>
>> +
>> +       /* Octeon specific DT properties */
>> +       ret = of_property_read_u32(node, "cavium,cmd-clk-skew", &cmd_skew);
>> +       if (ret)
>> +               cmd_skew = 0;
>> +
>> +       ret = of_property_read_u32(node, "cavium,dat-clk-skew", &dat_skew);
>> +       if (ret)
>> +               dat_skew = 0;
>> +
>> +       /*
>> +        * Set up host parameters.
>> +        */
>> +       mmc->ops = &octeon_mmc_ops;
>> +       mmc->f_min = 400000;
>> +       mmc->f_max = max_freq;
>> +       mmc->caps = MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>> +                   MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA |
>
> The MMC_CAP_8_BIT_DATA and MMC_CAP_4_BIT_DATA is supposed to be
> assigned depending on the configuration in DTS, not hardcoded like
> this.
>
> There's actually also DT bindings parses by mmc_of_parse() for
> MMC_CAP_MMC_HIGHSPEED and MMC_CAP_SD_HIGHSPEED, although if you know
> that your HW always supports these modes, it's fine to enabled them
> like this.
>

We will fix these up.

>> +                   MMC_CAP_ERASE;
>
> To use MMC_CAP_ERASE, it's recomended to notify the mmc core about
> your used request busy timeout.
>
> So please assign the mmc->max_busy_timeout to its correct value.
>
>> +       mmc->ocr_avail = MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 |
>> +                        MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 |
>> +                        MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36;
>
> This you need to explain. I thought your power GPIO only supported on
> and off. In other words it's a fixed regulator, no?
>
> Anyway, when you converted to GPIO regulators you will get this mask
> assigned by calling mmc_regulator_get_supply(), so you don't need any
> of this at all.
>
>> +
>> +       /* post-sdk23 caps */
>> +       mmc->caps |=
>> +               ((mmc->f_max >= 12000000) * MMC_CAP_UHS_SDR12) |
>> +               ((mmc->f_max >= 25000000) * MMC_CAP_UHS_SDR25) |
>> +               ((mmc->f_max >= 50000000) * MMC_CAP_UHS_SDR50) |
>> +               MMC_CAP_CMD23;
>
> Supporting UHS mode requires you to be able to switch the I/O voltage
> level from ~3.3 V to 1.8 V.
>
> How do you manage that without implementing the following host ops?
> ->start_signal_voltage_switch()
> ->card_busy()
>
> Also note that we have common mmc DT bindings for MMC_CAP_UHS*, which
> is parsed via mmc_of_parse().

We will sort this out too.

>
>> +
>> +       if ((!IS_ERR(mmc->supply.vmmc)) || (slot->pwr_gpiod))
>> +               mmc->caps |= MMC_CAP_POWER_OFF_CARD;
>
> This cap is used only for SDIO scenarios. I don't think you need it!?
>
>> +
>> +       /* "1.8v" capability is actually 1.8-or-3.3v */
>
> Yes, there is a lacking capablity for eMMC 3.3 V, although I don't
> think you need to care here...
>
>> +       if (ddr)
>> +               mmc->caps |= MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR;
>
> ... I assume it's safe to enable MMC_CAP_1_8V_DDR as that applies to
> eMMCs. Or you HW only supports 3.3V I/O voltage for eMMCs?
>
> Although, because of the upper comment about UHS modes, you should
> probably not enable MMC_CAP_UHS_DDR50 at all.

Agreed.
