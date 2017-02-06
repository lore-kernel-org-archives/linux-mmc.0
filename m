From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2 2/8] mmc: bcm2835: Add new driver for the sdhost
 controller.
Date: Mon, 6 Feb 2017 21:34:00 +0100 (CET)
Message-ID: <1708749883.208474.1486413240581@email.1und1.de>
References: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
 <1486123913-31705-3-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1486123913-31705-3-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, f.fainelli@gmail.com, sbranden@broadcom.com, swarren@wwwdotorg.org, rjui@broadcom.com, lee@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, eric@anholt.net, robh+dt@kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, catalin.marinas@arm.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Gerd,

first of all here my wishlist for the next round of this driver:
* compile test the series with ARM and ARM64
* add me in CC for all patches of the series
* run checkpatch.pl before submission
* apply the patch series to your cgit repo

> Gerd Hoffmann <kraxel@redhat.com> hat am 3. Februar 2017 um 13:11 geschrieben:
> 
> 
> From: Eric Anholt <eric@anholt.net>
> 
> The 2835 has two SD controllers: The Arasan sdhci controller (supported
> by the iproc driver) and a custom sdhost controller.  This patch adds a
> driver for the latter.
> 
> The sdhci controller supports both sdcard and sdio.  The sdhost
> controller supports the sdcard only, but has better performance.  Also

Sorry, for the confusion. I was wrong. According to the registers the SDHOST should also support SDIO. It's a feature we could implement later.

> note that the rpi3 has sdio wifi, so driving the sdcard with the sdhost
> controller allows to use the sdhci controller for wifi support.
> 
> The configuration is done by devicetree via pin muxing.  Both SD
> controller are available on the same pins (2 pin groups = pin 22 to 27 +
> pin 48 to 53).  So it's possible to use both SD controllers at the same
> time with different pin groups.
> 
> The code was originally written by Phil Elwell in the downstream
> Rasbperry Pi tree, and I did a major cleanup on it (+319, -707 lines
> out of the original 2055) for inclusion.

I think it would be helpful to known the downstream commit, because this commit [1]
doesn't seem to be included.

[1] - https://github.com/raspberrypi/linux/commit/ea4b1c5c2ddbb6caba43ab9b0103542a4ca7e1f0

I've found and fixed a lot of issues in this version and i think it would be better if i send you the patches for squashing them all together. Here is the preview for my patch series:

Stefan Wahren (15):
  mmc: bcm2835: Add missing include for threaded irq
  mmc: bcm2835: Remove CMD_DALLY_US
  mmc: bcm2835: Fix pio_timeout handling
  mmc: bcm2835: Remove unnecessary return in bcm2835_data_irq
  mmc: bcm2835: Handle error cases during probe
  mmc: bcm2835: Print clk_max as decimal
  mmc: bcm2835: Downrate message in case of PIO fallback
  mmc: bcm2835: Don't unveil the data pointer
  mmc: bcm2835: remove unused host members
  mmc: bcm2835: Avoid unnecessary linebreaks
  mmc: bcm2835: Add leading zero to register dumps
  mmc: bcm2835: Align struct members with tabs
  mmc: bcm2835: Rearrange bcm2835_finish_request()
  mmc: bcm2835: Rearrange bcm2835_dma_complete_work()
  mmc: bcm2835: Rename Kconfig switch

I'll send it after my tests. In the following review i will mention only the issues which aren't fixed in my patch series.

> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> new file mode 100644
> index 0000000..5ea8bd6
> --- /dev/null
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -0,0 +1,1521 @@
> +/*
> + * bcm2835 sdhost driver.
> + *
> + * The 2835 has two SD controllers: The Arasan sdhci controller
> + * (supported by the iproc driver) and a custom sdhost controller
> + * (supported by this driver).
> + *
> + * The sdhci controller supports both sdcard and sdio.  The sdhost
> + * controller supports the sdcard only, but has better performance.
> + * Also note that the rpi3 has sdio wifi, so driving the sdcard with
> + * the sdhost controller allows to use the sdhci controller for wifi
> + * support.
> + *
> + * The configuration is done by devicetree via pin muxing.  Both
> + * SD controller are available on the same pins (2 pin groups = pin 22
> + * to 27 + pin 48 to 53).  So it's possible to use both SD controllers
> + * at the same time with different pin groups.
> + *
> + * Author:      Phil Elwell <phil@raspberrypi.org>
> + *              Copyright (C) 2015-2016 Raspberry Pi (Trading) Ltd.
> + *
> + * Based on
> + *  mmc-bcm2835.c by Gellert Weisz
> + * which is, in turn, based on
> + *  sdhci-bcm2708.c by Broadcom
> + *  sdhci-bcm2835.c by Stephen Warren and Oleksandr Tymoshenko
> + *  sdhci.c and sdhci-pci.c by Pierre Ossman
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/highmem.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/scatterlist.h>
> +#include <linux/time.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>
> +
> +#define SDCMD  0x00 /* Command to SD card              - 16 R/W */
> +#define SDARG  0x04 /* Argument to SD card             - 32 R/W */
> +#define SDTOUT 0x08 /* Start value for timeout counter - 32 R/W */
> +#define SDCDIV 0x0c /* Start value for clock divider   - 11 R/W */
> +#define SDRSP0 0x10 /* SD card response (31:0)         - 32 R   */
> +#define SDRSP1 0x14 /* SD card response (63:32)        - 32 R   */
> +#define SDRSP2 0x18 /* SD card response (95:64)        - 32 R   */
> +#define SDRSP3 0x1c /* SD card response (127:96)       - 32 R   */
> +#define SDHSTS 0x20 /* SD host status                  - 11 R   */
> +#define SDVDD  0x30 /* SD card power control           -  1 R/W */
> +#define SDEDM  0x34 /* Emergency Debug Mode            - 13 R/W */
> +#define SDHCFG 0x38 /* Host configuration              -  2 R/W */
> +#define SDHBCT 0x3c /* Host byte count (debug)         - 32 R/W */
> +#define SDDATA 0x40 /* Data to/from SD card            - 32 R/W */
> +#define SDHBLC 0x50 /* Host block count (SDIO/SDHC)    -  9 R/W */
> +
> +#define SDCMD_NEW_FLAG			0x8000
> +#define SDCMD_FAIL_FLAG			0x4000
> +#define SDCMD_BUSYWAIT			0x800
> +#define SDCMD_NO_RESPONSE		0x400
> +#define SDCMD_LONG_RESPONSE		0x200
> +#define SDCMD_WRITE_CMD			0x80
> +#define SDCMD_READ_CMD			0x40
> +#define SDCMD_CMD_MASK			0x3f
> +
> +#define SDCDIV_MAX_CDIV			0x7ff
> +
> +#define SDHSTS_BUSY_IRPT		0x400
> +#define SDHSTS_BLOCK_IRPT		0x200
> +#define SDHSTS_SDIO_IRPT		0x100
> +#define SDHSTS_REW_TIME_OUT		0x80
> +#define SDHSTS_CMD_TIME_OUT		0x40
> +#define SDHSTS_CRC16_ERROR		0x20
> +#define SDHSTS_CRC7_ERROR		0x10
> +#define SDHSTS_FIFO_ERROR		0x08
> +/* Reserved */
> +/* Reserved */
> +#define SDHSTS_DATA_FLAG		0x01
> +
> +#define SDHSTS_TRANSFER_ERROR_MASK	(SDHSTS_CRC7_ERROR | \
> +					 SDHSTS_CRC16_ERROR | \
> +					 SDHSTS_REW_TIME_OUT | \
> +					 SDHSTS_FIFO_ERROR)
> +
> +#define SDHSTS_ERROR_MASK		(SDHSTS_CMD_TIME_OUT | \
> +					 SDHSTS_TRANSFER_ERROR_MASK)
> +
> +#define SDHCFG_BUSY_IRPT_EN	BIT(10)
> +#define SDHCFG_BLOCK_IRPT_EN	BIT(8)
> +#define SDHCFG_SDIO_IRPT_EN	BIT(5)
> +#define SDHCFG_DATA_IRPT_EN	BIT(4)
> +#define SDHCFG_SLOW_CARD	BIT(3)
> +#define SDHCFG_WIDE_EXT_BUS	BIT(2)
> +#define SDHCFG_WIDE_INT_BUS	BIT(1)
> +#define SDHCFG_REL_CMD_LINE	BIT(0)
> +
> +#define SDVDD_POWER_OFF		0
> +#define SDVDD_POWER_ON		1
> +
> +#define SDEDM_FORCE_DATA_MODE	BIT(19)
> +#define SDEDM_CLOCK_PULSE	BIT(20)
> +#define SDEDM_BYPASS		BIT(21)
> +
> +#define SDEDM_WRITE_THRESHOLD_SHIFT	9
> +#define SDEDM_READ_THRESHOLD_SHIFT	14
> +#define SDEDM_THRESHOLD_MASK		0x1f
> +
> +#define SDEDM_FSM_MASK		0xf
> +#define SDEDM_FSM_IDENTMODE	0x0
> +#define SDEDM_FSM_DATAMODE	0x1
> +#define SDEDM_FSM_READDATA	0x2
> +#define SDEDM_FSM_WRITEDATA	0x3
> +#define SDEDM_FSM_READWAIT	0x4
> +#define SDEDM_FSM_READCRC	0x5
> +#define SDEDM_FSM_WRITECRC	0x6
> +#define SDEDM_FSM_WRITEWAIT1	0x7
> +#define SDEDM_FSM_POWERDOWN	0x8
> +#define SDEDM_FSM_POWERUP	0x9
> +#define SDEDM_FSM_WRITESTART1	0xa
> +#define SDEDM_FSM_WRITESTART2	0xb
> +#define SDEDM_FSM_GENPULSES	0xc
> +#define SDEDM_FSM_WRITEWAIT2	0xd
> +#define SDEDM_FSM_STARTPOWDOWN	0xf
> +
> +#define SDDATA_FIFO_WORDS	16
> +
> +#define FIFO_READ_THRESHOLD	4
> +#define FIFO_WRITE_THRESHOLD	4
> +#define SDDATA_FIFO_PIO_BURST	8
> +#define CMD_DALLY_US		1
> +
> +struct bcm2835_host {
> +	spinlock_t		lock;
> +	struct mutex            mutex;

Would be nice to have a comment for the lock and mutex.

> +
> +	void __iomem		*ioaddr;
> +	u32			phys_addr;
> +
> +	struct mmc_host		*mmc;
> +	struct platform_device	*pdev;
> +
> +	u32			pio_timeout;	/* In jiffies */
> +	int			clock;		/* Current clock speed */
> +	unsigned int		max_clk;	/* Max possible freq */
> +	struct work_struct      dma_work;
> +	struct delayed_work     timeout_work;   /* Timer for timeouts */
> +	struct sg_mapping_iter	sg_miter;	/* SG state for PIO */
> +	unsigned int		blocks;		/* remaining PIO blocks */
> +	int			irq;		/* Device IRQ */
> +
> +	u32			ns_per_fifo_word;
> +
> +	/* cached registers */
> +	u32			hcfg;
> +	u32			cdiv;
> +
> +	struct mmc_request	*mrq;		/* Current request */
> +	struct mmc_command	*cmd;		/* Current command */
> +	struct mmc_data		*data;		/* Current data request */
> +	bool			data_complete:1;/* Data finished before cmd */
> +	bool			flush_fifo:1;	/* Drain the fifo when finish */
> +	bool			use_busy:1;	/* Wait for busy interrupt */
> +	bool			use_sbc:1;	/* Send CMD23 */

It would be nice to get the rid off use_busy and use_sbc. Do you see any chance for use_busy?

> +
> +	/* for threaded irq handler */
> +	bool                    irq_block;
> +	bool                    irq_busy;
> +	bool                    irq_data;
> +
> +	/* DMA part */
> +	struct dma_chan		*dma_chan_rx;
> +	struct dma_chan		*dma_chan_tx;
> +	struct dma_chan		*dma_chan;
> +	struct dma_async_tx_descriptor	*dma_desc;
> +	u32			dma_dir;
> +	u32			drain_words;
> +	struct page		*drain_page;
> +	u32			drain_offset;
> +	bool			use_dma;
> +
> +	int	max_delay;	/* maximum length of time spent waiting */
> +	u32	pio_limit;	/* Maximum block count for PIO (0 = DMA) */
> +};
> +
> +static void bcm2835_dumpcmd(struct bcm2835_host *host,
> +			    struct mmc_command *cmd,
> +			    const char *label)
> +{
> +	struct device *dev = &host->pdev->dev;
> +
> +	if (!cmd)
> +		return;
> +
> +	dev_dbg(dev, "%c%s op %d arg 0x%x flags 0x%x - resp %08x %08x %08x %08x, err %d\n",
> +		(cmd == host->cmd) ? '>' : ' ',
> +		label, cmd->opcode, cmd->arg, cmd->flags,
> +		cmd->resp[0], cmd->resp[1], cmd->resp[2], cmd->resp[3],
> +		cmd->error);
> +}
> +
> +static void bcm2835_dumpregs(struct bcm2835_host *host)
> +{
> +	struct mmc_request *mrq = host->mrq;
> +	struct device *dev = &host->pdev->dev;
> +
> +	if (mrq) {
> +		bcm2835_dumpcmd(host, mrq->sbc, "sbc");
> +		bcm2835_dumpcmd(host, mrq->cmd, "cmd");
> +		if (mrq->data) {
> +			dev_dbg(dev, "data blocks %x blksz %x - err %d\n",
> +				mrq->data->blocks,
> +				mrq->data->blksz,
> +				mrq->data->error);
> +		}
> +		bcm2835_dumpcmd(host, mrq->stop, "stop");
> +	}
> +
> +	dev_dbg(dev, "=========== REGISTER DUMP ===========\n");
> +	dev_dbg(dev, "SDCMD  0x%08x\n", readl(host->ioaddr + SDCMD));
> +	dev_dbg(dev, "SDARG  0x%08x\n", readl(host->ioaddr + SDARG));
> +	dev_dbg(dev, "SDTOUT 0x%08x\n", readl(host->ioaddr + SDTOUT));
> +	dev_dbg(dev, "SDCDIV 0x%08x\n", readl(host->ioaddr + SDCDIV));
> +	dev_dbg(dev, "SDRSP0 0x%08x\n", readl(host->ioaddr + SDRSP0));
> +	dev_dbg(dev, "SDRSP1 0x%08x\n", readl(host->ioaddr + SDRSP1));
> +	dev_dbg(dev, "SDRSP2 0x%08x\n", readl(host->ioaddr + SDRSP2));
> +	dev_dbg(dev, "SDRSP3 0x%08x\n", readl(host->ioaddr + SDRSP3));
> +	dev_dbg(dev, "SDHSTS 0x%08x\n", readl(host->ioaddr + SDHSTS));
> +	dev_dbg(dev, "SDVDD  0x%08x\n", readl(host->ioaddr + SDVDD));
> +	dev_dbg(dev, "SDEDM  0x%08x\n", readl(host->ioaddr + SDEDM));
> +	dev_dbg(dev, "SDHCFG 0x%08x\n", readl(host->ioaddr + SDHCFG));
> +	dev_dbg(dev, "SDHBCT 0x%08x\n", readl(host->ioaddr + SDHBCT));
> +	dev_dbg(dev, "SDHBLC 0x%08x\n", readl(host->ioaddr + SDHBLC));
> +	dev_dbg(dev, "===========================================\n");
> +}
> +
> +static void bcm2835_reset_internal(struct bcm2835_host *host)
> +{
> +	u32 temp;
> +
> +	writel(SDVDD_POWER_OFF, host->ioaddr + SDVDD);
> +	writel(0, host->ioaddr + SDCMD);
> +	writel(0, host->ioaddr + SDARG);
> +	writel(0xf00000, host->ioaddr + SDTOUT);
> +	writel(0, host->ioaddr + SDCDIV);
> +	writel(0x7f8, host->ioaddr + SDHSTS); /* Write 1s to clear */

Any chance to eliminate the bit magic for SDTOUT and SDHSTS?

> +	writel(0, host->ioaddr + SDHCFG);
> +	writel(0, host->ioaddr + SDHBCT);
> +	writel(0, host->ioaddr + SDHBLC);
> +
> +	/* Limit fifo usage due to silicon bug */
> +	temp = readl(host->ioaddr + SDEDM);
> +	temp &= ~((SDEDM_THRESHOLD_MASK << SDEDM_READ_THRESHOLD_SHIFT) |
> +		  (SDEDM_THRESHOLD_MASK << SDEDM_WRITE_THRESHOLD_SHIFT));
> +	temp |= (FIFO_READ_THRESHOLD << SDEDM_READ_THRESHOLD_SHIFT) |
> +		(FIFO_WRITE_THRESHOLD << SDEDM_WRITE_THRESHOLD_SHIFT);
> +	writel(temp, host->ioaddr + SDEDM);
> +	msleep(20);
> +	writel(SDVDD_POWER_ON, host->ioaddr + SDVDD);
> +	msleep(20);
> +	host->clock = 0;
> +	writel(host->hcfg, host->ioaddr + SDHCFG);
> +	writel(host->cdiv, host->ioaddr + SDCDIV);
> +}
> +
> ...
> +
> +static void bcm2835_finish_data(struct bcm2835_host *host)
> +{
> +	struct device *dev = &host->pdev->dev;
> +	struct mmc_data *data;
> +
> +	data = host->data;
> +
> +	dev_dbg(dev, "finish_data(error %d, stop %d, sbc %d)\n",
> +		data->error, data->stop ? 1 : 0,
> +		host->mrq->sbc ? 1 : 0);
> +
> +	host->hcfg &= ~(SDHCFG_DATA_IRPT_EN | SDHCFG_BLOCK_IRPT_EN);
> +	writel(host->hcfg, host->ioaddr + SDHCFG);
> +
> +	data->bytes_xfered = data->error ? 0 : (data->blksz * data->blocks);
> +
> +	host->data_complete = true;
> +
> +	if (host->cmd) {
> +		/* Data managed to finish before the
> +		 * command completed. Make sure we do
> +		 * things in the proper order.
> +		 */
> +		dev_dbg(dev, "Finished early - HSTS %x\n",
> +			readl(host->ioaddr + SDHSTS));
> +	} else {
> +		bcm2835_transfer_complete(host);
> +	}
> +}
> +
> +static void bcm2835_finish_command(struct bcm2835_host *host)
> +{
> +	struct device *dev = &host->pdev->dev;
> +	struct mmc_command *cmd = host->cmd;
> +	u32 sdcmd;
> +
> +	dev_dbg(dev, "finish_command(%x)\n", readl(host->ioaddr + SDCMD));
> +
> +	sdcmd = bcm2835_read_wait_sdcmd(host, 100, true);
> +
> +	/* Check for errors */
> +	if (sdcmd & SDCMD_NEW_FLAG) {
> +		dev_err(dev, "command never completed.\n");
> +		bcm2835_dumpregs(host);
> +		host->cmd->error = -EIO;
> +		bcm2835_finish_request(host);
> +		return;
> +	} else if (sdcmd & SDCMD_FAIL_FLAG) {
> +		u32 sdhsts = readl(host->ioaddr + SDHSTS);
> +
> +		/* Clear the errors */
> +		writel(SDHSTS_ERROR_MASK, host->ioaddr + SDHSTS);
> +
> +		if (!(sdhsts & SDHSTS_CRC7_ERROR) ||
> +		    (host->cmd->opcode != MMC_SEND_OP_COND)) {
> +			if (sdhsts & SDHSTS_CMD_TIME_OUT) {
> +				host->cmd->error = -ETIMEDOUT;
> +			} else {
> +				dev_err(dev, "unexpected command %d error\n",
> +					host->cmd->opcode);
> +				bcm2835_dumpregs(host);
> +				host->cmd->error = -EILSEQ;
> +			}
> +			bcm2835_finish_request(host);
> +			return;
> +		}
> +	}
> +
> +	if (cmd->flags & MMC_RSP_PRESENT) {
> +		if (cmd->flags & MMC_RSP_136) {
> +			int i;
> +
> +			for (i = 0; i < 4; i++) {
> +				cmd->resp[3 - i] =
> +					readl(host->ioaddr + SDRSP0 + i * 4);
> +			}
> +
> +			dev_dbg(dev, "finish_command %08x %08x %08x %08x\n",
> +				cmd->resp[0], cmd->resp[1],
> +				cmd->resp[2], cmd->resp[3]);
> +		} else {
> +			cmd->resp[0] = readl(host->ioaddr + SDRSP0);
> +			dev_dbg(dev, "finish_command %08x\n", cmd->resp[0]);
> +		}
> +	}
> +
> +	if (cmd == host->mrq->sbc) {
> +		/* Finished CMD23, now send actual command. */
> +		host->cmd = NULL;
> +		if (bcm2835_send_command(host, host->mrq->cmd)) {
> +			if (host->data && host->dma_desc)
> +				/* DMA transfer starts now, PIO starts
> +				 * after irq
> +				 */
> +				bcm2835_start_dma(host);
> +
> +			if (!host->use_busy)
> +				bcm2835_finish_command(host);

Recursion?

> +		}
> +	} else if (cmd == host->mrq->stop) {
> +		/* Finished CMD12 */
> +		bcm2835_finish_request(host);
> +	} else {
> +		/* Processed actual command. */
> +		host->cmd = NULL;
> +		if (!host->data)
> +			bcm2835_finish_request(host);
> +		else if (host->data_complete)
> +			bcm2835_transfer_complete(host);

bcm2835_finish_command() calls bcm2835_transfer_complete()
bcm2835_transfer_complete() calls bcm2835_finish_command()

This should be avoided.

> ...
> +int bcm2835_add_host(struct bcm2835_host *host)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	struct device *dev = &host->pdev->dev;
> +	struct dma_slave_config cfg;
> +	char pio_limit_string[20];
> +	int ret;
> +
> +	bcm2835_reset_internal(host);
> +
> +	mmc->f_max = host->max_clk;
> +	mmc->f_min = host->max_clk / SDCDIV_MAX_CDIV;
> +
> +	mmc->max_busy_timeout = ~0 / (mmc->f_max / 1000);
> +
> +	dev_dbg(dev, "f_max %d, f_min %d, max_busy_timeout %d\n",
> +		mmc->f_max, mmc->f_min, mmc->max_busy_timeout);
> +
> +	/* host controller capabilities */
> +	mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
> +		     MMC_CAP_NEEDS_POLL | MMC_CAP_HW_RESET | MMC_CAP_ERASE |
> +		     MMC_CAP_CMD23;
> +
> +	spin_lock_init(&host->lock);
> +	mutex_init(&host->mutex);
> +
> +	if (IS_ERR_OR_NULL(host->dma_chan_tx) ||
> +	    IS_ERR_OR_NULL(host->dma_chan_rx)) {
> +		dev_err(dev, "unable to initialise DMA channels. Falling back to PIO\n");
> +		host->use_dma = false;
> +	} else {
> +		host->use_dma = true;
> +
> +		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		cfg.slave_id = 13;		/* DREQ channel */

Is this the same value which is also defined in the DT?

Thanks
Stefan
