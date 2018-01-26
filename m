From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci: Add support for O2 hardware tuning
Date: Fri, 26 Jan 2018 10:00:58 +0200
Message-ID: <c544867e-7ba5-1bdf-50ae-b26b634676ed@intel.com>
References: <20180117013808.4181-1-ernest.zhang@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:61677 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751495AbeAZIBg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 26 Jan 2018 03:01:36 -0500
In-Reply-To: <20180117013808.4181-1-ernest.zhang@bayhubtech.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ernest.zhang" <ernest.zhang@bayhubtech.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: shirley.her@bayhubtech.com, yuxiang.wan@bayhubtech.com, xiaoguang.yu@bayhubtech.com

On 17/01/18 03:38, ernest.zhang wrote:
> O2 sd host controllers have a hardware tuning function. In software
> tuning mode CPU should send multiple command to host controller but in
> hardware tuning mode, CPU need send only one tuning command to sd host
> controller. It can improve the speed linux boot from eMMC.
> 
> Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>

Please use version numbers in the patch subject.  This was V3, the next is
V4. A summary of what has changed (after the --- line or in the cover email)
is also expected.

> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 193 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c             |   5 +-
>  2 files changed, 197 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 8855a416ffd4..5978ead34827 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -17,6 +17,12 @@
>   */
>  
>  #include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/fixed.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/delay.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
> @@ -57,6 +63,192 @@
>  #define O2_SD_VENDOR_SETTING2	0x1C8
>  #define O2_SD_HW_TUNING_ENABLE	BIT(4)
>  
> +static void sdhci_o2_start_tuning(struct sdhci_host *host)
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
> +	reg &= ~O2_SD_HW_TUNING_ENABLE;
> +	sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
> +}
> +
> +
> +static int sdhci_o2_send_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct mmc_command cmd = { };
> +	struct mmc_data data = { };
> +	struct scatterlist sg;
> +	struct mmc_request mrq = { };
> +	unsigned long flags;
> +	u32 b = host->sdma_boundary;
> +	int size = 64;
> +	u8 *data_buf = kzalloc(size, GFP_KERNEL);
> +
> +	if (!data_buf)
> +		return -ENOMEM;
> +
> +	cmd.opcode = opcode;
> +	cmd.flags = MMC_RSP_PRESENT | MMC_RSP_OPCODE | MMC_RSP_CRC;
> +	cmd.mrq = &mrq;
> +	cmd.data = NULL;

I am confused now.  If you set cmd.data to NULL then there is no point in
having struct mmc_data data at all.

But that also means my comment about not needing
SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD was wrong.

Please clarify.

> +	mrq.cmd = &cmd;
> +	mrq.data = &data;
> +	data.blksz = size;
> +	data.blocks = 1;
> +	data.flags = MMC_DATA_READ;
> +
> +	data.timeout_ns = 50 * NSEC_PER_MSEC;
> +
> +	data.sg = &sg;
> +	data.sg_len = 1;
> +	sg_init_one(&sg, data_buf, size);
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

So with no cmd.data then you can set the transfer mode, except that
SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD clears it again.  Doesn't
SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD also cause a problem with SD
card tuning i.e. when you call sdhci_execute_tuning() ?

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
> +	kfree(data_buf);
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
> +				   mmc_hostname(host->mmc));
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
> +	if (current_bus_width == MMC_BUS_WIDTH_8) {
> +		sdhci_set_bus_width(host, current_bus_width);
> +	}

Unnecessary {}

> +
> +	host->flags &= ~SDHCI_HS400_TUNING;
> +	return 0;
> +}
> +
>  static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
>  {
>  	u32 scratch_32;
> @@ -214,6 +406,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  			}
>  		}
>  
> +		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
>  
>  		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
>  			break;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e9290a3439d5..8ed7afc84f7a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -919,7 +919,10 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  	if (data == NULL) {
>  		if (host->quirks2 &
>  			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
> -			sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
> +			/* must not clear SDHCI_TRANSFER_MODE when tuning */
> +			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) {
> +				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
> +			}
>  		} else {
>  		/* clear Auto CMD settings for no data CMDs */
>  			mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
> 

