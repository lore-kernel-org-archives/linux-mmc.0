From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 2/3] mmc: sdhci: Add support for O2 hardware tuning
Date: Wed, 16 May 2018 10:32:10 +0300
Message-ID: <4d6d75ef-2e6a-e397-3148-7a9d8de7ad1f@intel.com>
References: <20180420163812.9868-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420163812.9868-1-ernest.zhang@bayhubtech.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "ernest.zhang" <ernest.zhang@bayhubtech.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Xiaoguang Yu <xiaoguang.yu@bayhubtech.com>, Shirley Her <shirley.her@bayhubtech.com>, Yuxiang Wan <yuxiang.wan@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

On 20/04/18 19:38, ernest.zhang wrote:
> Add hardware tuning function instead of software tuning because O2/Bayhub
> SD host controller support hardware tuning.
> 
> Changes in V5:

The change log goes below the --- line or in a separate cover email.

> 	In function sdhci_o2_send_tuning, mrq.data should set to NULL for
> 	cmd.data has been set to NULL.
> 
> Changes in V4:
> 	Patch V3 delete register SDHCI_TRANSFER_MODE write operation before
> 	send hardware tuning command in function sdhci_o2_send_tuning. This
> 	is a mistake. The write operation is essential for tuning command.
> 	Add it back.
> 
> Changes in V3:
> 	Rebase the patch on the mmc tree 'next' branch.
> 
> Changes in V2:
> 	Modify code format, and delete unused code path.
> 
> Changes in V1:
> 	Add many functions to execute hardware tuning for eMMC 1.8V HS200
> 	mode, the hardware tuning procedure is based on O2/Bayhub hardware
> 	tuning spec.
> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 175 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c             |   5 +-
>  2 files changed, 179 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index ba59db6a..96adaae 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -17,6 +17,9 @@
>   */
>  
>  #include <linux/pci.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/delay.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
> @@ -55,6 +58,176 @@
>  
>  #define O2_SD_VENDOR_SETTING	0x110
>  #define O2_SD_VENDOR_SETTING2	0x1C8
> +#define O2_SD_HW_TUNING_DISABLE	BIT(4)
> +
> +static void sdhci_o2_start_tuning(struct sdhci_host *host)

This is the same as sdhci_start_tuning() so please export and use that instead.

> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl |= SDHCI_CTRL_EXEC_TUNING;
> +	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +	/*
> +	 * As per the Host Controller spec v3.00, tuning command
> +	 * generates Buffer Read Ready interrupt, so enable that.
> +	 *
> +	 * Note: The spec clearly says that when tuning sequence
> +	 * is being performed, the controller does not generate
> +	 * interrupts other than Buffer Read Ready interrupt. But
> +	 * to make sure we don't hit a controller bug, we _only_
> +	 * enable Buffer Read Ready interrupt here.
> +	 */
> +	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE);
> +}
> +
> +static void sdhci_o2_end_tuning(struct sdhci_host *host)

This is the same as sdhci_end_tuning() so please export and use that instead.

> +{
> +	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +}
> +
> +static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
> +{
> +	return cmd->data || cmd->flags & MMC_RSP_BUSY;
> +}
> +
> +static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
> +{
> +	if (sdhci_data_line_cmd(mrq->cmd))
> +		del_timer(&host->data_timer);
> +	else
> +		del_timer(&host->timer);
> +}
> +
> +static void sdhci_o2_set_tuning_mode(struct sdhci_host *host)
> +{
> +	u16 reg;
> +
> +	/* enable hardware tuning */
> +	reg = sdhci_readw(host, O2_SD_VENDOR_SETTING);
> +	reg &= ~O2_SD_HW_TUNING_DISABLE;
> +	sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
> +}
> +
> +static int sdhci_o2_send_tuning(struct sdhci_host *host, u32 opcode)

This is the same as sdhci_send_tuning() except for the cmd.flags.
Please export sdhci_send_tuning() and use that instead.  If you really need
different cmd.flags then add them as a parameter.

> +{
> +	struct mmc_command cmd = { };
> +	struct mmc_request mrq = { };
> +	unsigned long flags;
> +	u32 b = host->sdma_boundary;
> +
> +	cmd.opcode = opcode;
> +	cmd.flags = MMC_RSP_PRESENT | MMC_RSP_OPCODE | MMC_RSP_CRC;
> +	cmd.mrq = &mrq;
> +	cmd.data = NULL;
> +	mrq.cmd = &cmd;
> +	mrq.data = NULL;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	sdhci_writew(host, SDHCI_MAKE_BLKSZ(b, 64), SDHCI_BLOCK_SIZE);
> +
> +	/*
> +	 * The tuning block is sent by the card to the host controller.
> +	 * So we set the TRNS_READ bit in the Transfer Mode register.
> +	 * This also takes care of setting DMA Enable and Multi Block
> +	 * Select in the same register to 0.
> +	 */
> +	sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
> +
> +	sdhci_send_command(host, &cmd);
> +
> +	host->cmd = NULL;
> +
> +	sdhci_del_timer(host, &mrq);
> +
> +	host->tuning_done = 0;
> +
> +	mmiowb();
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	/* Wait for Buffer Read Ready interrupt */
> +	wait_event_timeout(host->buf_ready_int, (host->tuning_done == 1),
> +			   msecs_to_jiffies(50));
> +	return 0;
> +}
> +
> +static void sdhci_o2_reset_tuning(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
> +	ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
> +	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +}
> +
> +static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	int i;
> +
> +	sdhci_o2_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
> +
> +	for (i = 0; i < 150; i++) {
> +		u16 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +
> +		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
> +			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
> +				host->tuning_done = true;
> +				return;
> +			}
> +			pr_warn("%s: HW tuning failed !\n",
> +				mmc_hostname(host->mmc));
> +			break;
> +		}
> +
> +		mdelay(1);
> +	}
> +
> +	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
> +		mmc_hostname(host->mmc));
> +	sdhci_o2_reset_tuning(host);
> +}
> +
> +static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int current_bus_width = 0;
> +
> +	/*
> +	 * This handler only implements the eMMC tuning that is specific to
> +	 * this controller.  Fall back to the standard method for other TIMING.
> +	 */
> +	if (host->timing != MMC_TIMING_MMC_HS200)
> +		return sdhci_execute_tuning(mmc, opcode);
> +
> +	if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
> +		return -EINVAL;
> +
> +	/*
> +	 * o2 sdhci host didn't support 8bit emmc tuning
> +	 */
> +	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
> +		current_bus_width = mmc->ios.bus_width;
> +		sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
> +	}
> +
> +	sdhci_o2_set_tuning_mode(host);
> +
> +	sdhci_o2_start_tuning(host);
> +
> +	__sdhci_o2_execute_tuning(host, opcode);
> +
> +	sdhci_o2_end_tuning(host);
> +
> +	if (current_bus_width == MMC_BUS_WIDTH_8)
> +		sdhci_set_bus_width(host, current_bus_width);
> +
> +	host->flags &= ~SDHCI_HS400_TUNING;
> +	return 0;
> +}
>  
>  static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
>  {
> @@ -215,6 +388,8 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  			}
>  		}
>  
> +		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
> +
>  		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
>  			break;
>  		/* set dll watch dog timer */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2ededa7..3bf6117 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -955,7 +955,10 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  	if (data == NULL) {
>  		if (host->quirks2 &
>  			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
> -			sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
> +			/* must not clear SDHCI_TRANSFER_MODE when tuning */
> +			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) {
> +				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
> +			}

Unnecessary {}

>  		} else {
>  		/* clear Auto CMD settings for no data CMDs */
>  			mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
> 
