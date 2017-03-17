From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v12 4/9] mmc: cavium: Work-around hardware bug on cn6xxx
 and cnf7xxx
Date: Fri, 17 Mar 2017 15:13:10 +0100
Message-ID: <CAPDyKFrbAUoYk7h8XmYdwiyr8QZXA0WTyFVw3EVFQ8UK71cwOw@mail.gmail.com>
References: <20170310132507.32025-1-jglauber@cavium.com> <20170310132507.32025-5-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170310132507.32025-5-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>
List-Id: linux-mmc@vger.kernel.org

On 10 March 2017 at 14:25, Jan Glauber <jglauber@cavium.com> wrote:
> Prevent data corruption on cn6xxx and cnf7xxx.
> Due to an imperfection in the design of the MMC bus hardware,
> the 2nd to last cache block of a DMA read must be locked into the L2
> cache.
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> ---
>  arch/mips/cavium-octeon/Makefile         |  1 +
>  arch/mips/cavium-octeon/octeon-mmc-l2c.c | 98 ++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cavium-mmc.c            |  5 ++
>  drivers/mmc/host/cavium-mmc.h            |  5 ++
>  drivers/mmc/host/cavium-pltfm-octeon.c   | 30 ++++++++++
>  5 files changed, 139 insertions(+)
>  create mode 100644 arch/mips/cavium-octeon/octeon-mmc-l2c.c
>
> diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
> index 7c02e54..3329a89 100644
> --- a/arch/mips/cavium-octeon/Makefile
> +++ b/arch/mips/cavium-octeon/Makefile
> @@ -19,3 +19,4 @@ obj-$(CONFIG_MTD)                   += flash_setup.o
>  obj-$(CONFIG_SMP)                    += smp.o
>  obj-$(CONFIG_OCTEON_ILM)             += oct_ilm.o
>  obj-$(CONFIG_USB)                    += octeon-usb.o
> +obj-$(CONFIG_MMC_CAVIUM_OCTEON)              += octeon-mmc-l2c.o
> diff --git a/arch/mips/cavium-octeon/octeon-mmc-l2c.c b/arch/mips/cavium-octeon/octeon-mmc-l2c.c
> new file mode 100644
> index 0000000..6aaaf73
> --- /dev/null
> +++ b/arch/mips/cavium-octeon/octeon-mmc-l2c.c
> @@ -0,0 +1,98 @@
> +/*
> + * Driver for MMC and SSD cards for Cavium OCTEON SOCs.
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2012-2016 Cavium Inc.
> + */
> +#include <linux/export.h>
> +#include <asm/octeon/octeon.h>
> +
> +/*
> + * The functions below are used for the EMMC-17978 workaround.
> + *
> + * Due to an imperfection in the design of the MMC bus hardware,
> + * the 2nd to last cache block of a DMA read must be locked into the L2 Cache.
> + * Otherwise, data corruption may occur.
> + */
> +
> +static inline void *phys_to_ptr(u64 address)
> +{
> +       return (void *)(address | (1ull << 63)); /* XKPHYS */
> +}
> +
> +/**
> + * Lock a single line into L2. The line is zeroed before locking
> + * to make sure no dram accesses are made.
> + *
> + * @addr   Physical address to lock
> + */
> +static void l2c_lock_line(u64 addr)
> +{
> +       char *addr_ptr = phys_to_ptr(addr);
> +
> +       asm volatile (
> +               "cache 31, %[line]"     /* Unlock the line */
> +               :: [line] "m" (*addr_ptr));
> +}
> +
> +/**
> + * Unlock a single line in the L2 cache.
> + *
> + * @addr       Physical address to unlock
> + *
> + * Return Zero on success
> + */
> +static void l2c_unlock_line(u64 addr)
> +{
> +       char *addr_ptr = phys_to_ptr(addr);
> +
> +       asm volatile (
> +               "cache 23, %[line]"     /* Unlock the line */
> +               :: [line] "m" (*addr_ptr));
> +}
> +
> +/**
> + * Locks a memory region in the L2 cache
> + *
> + * @start - start address to begin locking
> + * @len - length in bytes to lock
> + */
> +void l2c_lock_mem_region(u64 start, u64 len)
> +{
> +       u64 end;
> +
> +       /* Round start/end to cache line boundaries */
> +       end = ALIGN(start + len - 1, CVMX_CACHE_LINE_SIZE);
> +       start = ALIGN(start, CVMX_CACHE_LINE_SIZE);
> +
> +       while (start <= end) {
> +               l2c_lock_line(start);
> +               start += CVMX_CACHE_LINE_SIZE;
> +       }
> +       asm volatile("sync");
> +}
> +EXPORT_SYMBOL_GPL(l2c_lock_mem_region);
> +
> +/**
> + * Unlock a memory region in the L2 cache
> + *
> + * @start - start address to unlock
> + * @len - length to unlock in bytes
> + */
> +void l2c_unlock_mem_region(u64 start, u64 len)
> +{
> +       u64 end;
> +
> +       /* Round start/end to cache line boundaries */
> +       end = ALIGN(start + len - 1, CVMX_CACHE_LINE_SIZE);
> +       start = ALIGN(start, CVMX_CACHE_LINE_SIZE);
> +
> +       while (start <= end) {
> +               l2c_unlock_line(start);
> +               start += CVMX_CACHE_LINE_SIZE;
> +       }
> +}
> +EXPORT_SYMBOL_GPL(l2c_unlock_mem_region);

It seems like we should be able to implement these functions in the
octeon mmc driver, instead of having to export some SoC specific APIs.
You only need to figure out how to find the correct CACHE_LINE_SIZE,
but that should be possible to fix.

My point is really that we should avoid exporting SoC specific APIs
which shall be called from drivers. This is old fashion.

> diff --git a/drivers/mmc/host/cavium-mmc.c b/drivers/mmc/host/cavium-mmc.c
> index 11fdcfb..c1d3c65 100644
> --- a/drivers/mmc/host/cavium-mmc.c
> +++ b/drivers/mmc/host/cavium-mmc.c
> @@ -468,6 +468,8 @@ irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id)
>         req->done(req);
>
>  no_req_done:
> +       if (host->dmar_fixup_done)
> +               host->dmar_fixup_done(host);
>         if (host_done)
>                 host->release_bus(host);
>  out:
> @@ -572,6 +574,9 @@ static void cvm_mmc_dma_request(struct mmc_host *mmc,
>         host->int_enable(host, MIO_EMM_INT_CMD_ERR | MIO_EMM_INT_DMA_DONE |
>                          MIO_EMM_INT_DMA_ERR);
>
> +       if (host->dmar_fixup)
> +               host->dmar_fixup(host, mrq->cmd, data, addr);
> +
>         /*
>          * If we have a valid SD card in the slot, we set the response
>          * bit mask to check for CRC errors and timeouts only.
> diff --git a/drivers/mmc/host/cavium-mmc.h b/drivers/mmc/host/cavium-mmc.h
> index c3843448..3ee6dae 100644
> --- a/drivers/mmc/host/cavium-mmc.h
> +++ b/drivers/mmc/host/cavium-mmc.h
> @@ -48,6 +48,7 @@ struct cvm_mmc_host {
>         int reg_off;
>         int reg_off_dma;
>         u64 emm_cfg;
> +       u64 n_minus_one;        /* OCTEON II workaround location */
>         int last_slot;
>         struct clk *clk;
>         int sys_freq;
> @@ -63,6 +64,10 @@ struct cvm_mmc_host {
>         void (*acquire_bus)(struct cvm_mmc_host *);
>         void (*release_bus)(struct cvm_mmc_host *);
>         void (*int_enable)(struct cvm_mmc_host *, u64);
> +       /* required on some MIPS models */
> +       void (*dmar_fixup)(struct cvm_mmc_host *, struct mmc_command *,
> +                          struct mmc_data *, u64);
> +       void (*dmar_fixup_done)(struct cvm_mmc_host *);
>  };
>
>  struct cvm_mmc_slot {
> diff --git a/drivers/mmc/host/cavium-pltfm-octeon.c b/drivers/mmc/host/cavium-pltfm-octeon.c
> index e83d143..9dabfa4 100644
> --- a/drivers/mmc/host/cavium-pltfm-octeon.c
> +++ b/drivers/mmc/host/cavium-pltfm-octeon.c
> @@ -18,6 +18,9 @@
>
>  #define CVMX_MIO_BOOT_CTL CVMX_ADD_IO_SEG(0x00011800000000D0ull)
>
> +extern void l2c_lock_mem_region(u64 start, u64 len);
> +extern void l2c_unlock_mem_region(u64 start, u64 len);
> +
>  static void octeon_mmc_acquire_bus(struct cvm_mmc_host *host)
>  {
>         /* Switch the MMC controller onto the bus. */
> @@ -36,6 +39,28 @@ static void octeon_mmc_int_enable(struct cvm_mmc_host *host, u64 val)
>         writeq(val, host->base + MIO_EMM_INT_EN(host));
>  }
>
> +static void octeon_mmc_dmar_fixup(struct cvm_mmc_host *host,
> +                                 struct mmc_command *cmd,
> +                                 struct mmc_data *data,
> +                                 u64 addr)
> +{
> +       if (cmd->opcode != MMC_WRITE_MULTIPLE_BLOCK)
> +               return;
> +       if (data->blksz * data->blocks <= 1024)
> +               return;
> +
> +       host->n_minus_one = addr + (data->blksz * data->blocks) - 1024;
> +       l2c_lock_mem_region(host->n_minus_one, 512);
> +}
> +
> +static void octeon_mmc_dmar_fixup_done(struct cvm_mmc_host *host)
> +{
> +       if (!host->n_minus_one)
> +               return;
> +       l2c_unlock_mem_region(host->n_minus_one, 512);
> +       host->n_minus_one = 0;
> +}
> +
>  static int octeon_mmc_probe(struct platform_device *pdev)
>  {
>         struct device_node *cn, *node = pdev->dev.of_node;
> @@ -54,6 +79,11 @@ static int octeon_mmc_probe(struct platform_device *pdev)
>         host->acquire_bus = octeon_mmc_acquire_bus;
>         host->release_bus = octeon_mmc_release_bus;
>         host->int_enable = octeon_mmc_int_enable;
> +       if (OCTEON_IS_MODEL(OCTEON_CN6XXX) ||
> +           OCTEON_IS_MODEL(OCTEON_CNF7XXX)) {

I understand these macros are already being used for other octeon
drivers. I really don't like it, as it's better solved through device
tree instead using SoC specific APIs.

Moreover we recently added the soc_device_match() API (by Arnd) to
deal with cases exactly like this. In the long run, I recommend you to
convert to this approach.

That said, because we already have other users of these macros, we are
not making it much more worse, so I am going to look through my
fingers this time.

> +               host->dmar_fixup = octeon_mmc_dmar_fixup;
> +               host->dmar_fixup_done = octeon_mmc_dmar_fixup_done;
> +       }
>
>         host->sys_freq = octeon_get_io_clock_rate();
>
> --
> 2.9.0.rc0.21.g7777322
>

Kind regards
Uffe
