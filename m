From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-pci-core: Tuning mode support for HS200 on AMD
 Platforms
Date: Mon, 10 Oct 2016 10:55:41 +0300
Message-ID: <418f99e4-18e5-38a6-0b4d-0815f3bd604f@intel.com>
References: <2ef1e2da-5913-85fe-65a7-0984ac04164d@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55902 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752262AbcJJIAn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 Oct 2016 04:00:43 -0400
In-Reply-To: <2ef1e2da-5913-85fe-65a7-0984ac04164d@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shyam Sundar S K <ssundark@amd.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>

On 04/10/16 11:42, Shyam Sundar S K wrote:
> This patch adds support for HS200 tuning mode on AMD eMMC-4.5.1
> 
> Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
> Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
> Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 182 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 180 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 897cfd2..5893ec4 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -734,6 +734,7 @@ static const struct sdhci_pci_fixes sdhci_via = {
>  	.probe		= via_probe,
>  };
> 
> +

Unnecessary blank line

>  static int rtsx_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	slot->host->mmc->caps2 |= MMC_CAP2_HS200;
> @@ -755,6 +756,172 @@ enum amd_chipset_gen {
>  	AMD_CHIPSET_UNKNOWN,
>  };
> 
> +struct tuning_descriptor {

It would be nicer to prefix all structure and function names by something
specific to the device e.g. amd_...

> +	unsigned char tune_around;
> +	bool this_tune_ok;
> +	bool last_tune_ok;
> +	bool valid_front_end;
> +	unsigned char valid_front;
> +	unsigned char valid_window_max;
> +	unsigned char tune_low_max;
> +	unsigned char tune_low;
> +	unsigned char valid_window;
> +	unsigned char tune_result;

'unsigned char' -> 'u8'

> +};
> +
> +static struct sdhci_ops sdhci_pci_ops;
> +static struct tuning_descriptor tdescriptor;

tdescriptor should not be global.  You need somewhere to put private
data.  How about this:


From: Adrian Hunter <adrian.hunter@intel.com>
Date: Mon, 10 Oct 2016 10:04:45 +0300
Subject: [PATCH] mmc: sdhci-pci: Let devices define their own private data

Let devices define their own private data to facilitate device-specific
operations.  The size of the private structure is specified in the
sdhci_pci_fixes structure, then sdhci_pci_probe_slot() will allocate extra
space for it, and sdhci_pci_priv() can be used to get a reference to it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 3 ++-
 drivers/mmc/host/sdhci-pci.h      | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 1d9e00a00e9f..782c8d25c0c8 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1646,6 +1646,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	struct sdhci_pci_slot *slot;
 	struct sdhci_host *host;
 	int ret, bar = first_bar + slotno;
+	size_t priv_size = chip->fixes ? chip->fixes->priv_size : 0;
 
 	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
 		dev_err(&pdev->dev, "BAR %d is not iomem. Aborting.\n", bar);
@@ -1667,7 +1668,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 		return ERR_PTR(-ENODEV);
 	}
 
-	host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pci_slot));
+	host = sdhci_alloc_host(&pdev->dev, sizeof(*slot) + priv_size);
 	if (IS_ERR(host)) {
 		dev_err(&pdev->dev, "cannot allocate host\n");
 		return ERR_CAST(host);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 6bccf56bc5ff..6a1be6afe089 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -67,6 +67,7 @@ struct sdhci_pci_fixes {
 	int			(*resume) (struct sdhci_pci_chip *);
 
 	const struct sdhci_ops	*ops;
+	size_t			priv_size;
 };
 
 struct sdhci_pci_slot {
@@ -87,6 +88,8 @@ struct sdhci_pci_slot {
 				     struct mmc_card *card,
 				     unsigned int max_dtr, int host_drv,
 				     int card_drv, int *drv_type);
+
+	unsigned long		private[0] ____cacheline_aligned;
 };
 
 struct sdhci_pci_chip {
@@ -101,4 +104,9 @@ struct sdhci_pci_chip {
 	struct sdhci_pci_slot	*slots[MAX_SLOTS]; /* Pointers to host slots */
 };
 
+static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
+{
+	return (void *)slot->private;
+}
+
 #endif /* __SDHCI_PCI_H */
-- 
1.9.1




> +
> +static int tuning_reset(struct sdhci_host *host)
> +{
> +	unsigned int val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	val |= SDHCI_CTRL_PRESET_VAL_ENABLE | SDHCI_CTRL_EXEC_TUNING;
> +	sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
> +
> +	val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	val &= ~SDHCI_CTRL_EXEC_TUNING;
> +	sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int config_tuning_phase(struct sdhci_host *host, unsigned char phase)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	unsigned int val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	pci_read_config_dword(pdev, 0xb8, &val);
> +	val &= ~0x1f;
> +	val |= (0x10800 | (phase << 1));
> +	pci_write_config_dword(pdev, 0xb8, val);
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int find_good_phase(struct sdhci_host *host)
> +{
> +	struct tuning_descriptor *td = &tdescriptor;
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	unsigned int val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	if (td->this_tune_ok == false)
> +		td->valid_front_end = 1;
> +
> +	if (td->valid_front_end)
> +		td->valid_front = td->valid_front;

Assigning 'td->valid_front' to itself?

> +	else if (td->this_tune_ok)
> +		td->valid_front = td->valid_front + 1;

Use '+= 1'

> +
> +	if ((!td->this_tune_ok && td->last_tune_ok) ||
> +					(td->tune_around == 11)) {
> +
> +		if (td->valid_window > td->valid_window_max) {
> +			td->valid_window_max = td->valid_window;
> +			td->tune_low_max = td->tune_low;
> +		}
> +	}
> +
> +	if (td->this_tune_ok && (!td->last_tune_ok))
> +		td->tune_low = td->tune_around;
> +	if (!td->this_tune_ok && td->last_tune_ok)
> +		td->valid_window = 0x0;

Just use 0 not 0x0.

> +	else if (td->this_tune_ok)
> +		td->valid_window = td->valid_window + 1;

Use '+= 1'

> +
> +	td->last_tune_ok = td->this_tune_ok;
> +
> +	if (td->tune_around == 11) {
> +		if ((td->valid_front + td->valid_window) >
> +						td->valid_window_max) {
> +			if (td->valid_front > td->valid_window)
> +				td->tune_result = ((td->valid_front -
> +						td->valid_window) >> 1);
> +			else
> +				td->tune_result = td->tune_low +
> +				((td->valid_window + td->valid_front) >> 1);
> +		} else {
> +			td->tune_result = td->tune_low_max +
> +					(td->valid_window_max>>1);
> +		}
> +
> +
> +		if (td->tune_result > 0x0b)
> +			td->tune_result = 0x0b;
> +
> +		pci_read_config_dword(pdev, 0xb8, &val);
> +		val &= ~0x1f;
> +		val |= (0x10800 | (td->tune_result<<1));
> +		pci_write_config_dword(pdev, 0xb8, val);
> +	}
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct tuning_descriptor *td = &tdescriptor;
> +	u8 ctrl;
> +
> +	tuning_reset(host);
> +	memset(td, 0x0, sizeof(struct tuning_descriptor));
> +
> +	if (host->quirks2 & SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD)
> +		opcode = MMC_SEND_TUNING_BLOCK_HS200;

Why change the opcode?

> +
> +	for (td->tune_around = 0; td->tune_around < 12; td->tune_around++) {
> +
> +		config_tuning_phase(host, td->tune_around);
> +
> +		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
> +			td->this_tune_ok = false;
> +			host->mmc->need_retune = 0;
> +			mdelay(4);
> +			ctrl = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> +			sdhci_writeb(host, ctrl, SDHCI_SOFTWARE_RESET);
> +		} else {
> +			td->this_tune_ok = true;
> +		}
> +
> +		find_good_phase(host);

It looks like tune_around is a temporary that should be passed as a parameter
to find_good_phase()

> +	}
> +
> +	host->mmc->retune_period = 0;
> +
> +	return 0;
> +}
> +
> +static int amd_enable_manual_tuning(struct sdhci_pci_slot *slot)
> +{
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	unsigned int val;
> +
> +	pci_read_config_dword(pdev, 0xd0, &val);
> +	val &= 0xffffffcf;
> +	val |= 0x30;
> +	pci_write_config_dword(pdev, 0xd0, val);
> +
> +	return 0;
> +}
> +
>  static int amd_probe(struct sdhci_pci_chip *chip)
>  {
>  	struct pci_dev	*smbus_dev;
> @@ -779,14 +946,25 @@ static int amd_probe(struct sdhci_pci_chip *chip)
> 
>  	if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ)) {
>  		chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
> -		chip->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>  	}
> 
>  	return 0;
>  }
> 
> +static int amd_probe_slot(struct sdhci_pci_slot *slot)
> +{
> +	struct sdhci_host *host = slot->host;
> +
> +	if (host->quirks2 & SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {

Please don't use a quirk to identify the chip.

> +		sdhci_pci_ops.platform_execute_tuning = amd_execute_tuning;

You can't do that because sdhci_pci_ops is shared with every PCI SDHCI host
controller not just AMD.

Have a look at:

	https://marc.info/?l=linux-mmc&m=147565902811041&w=2

and re-base on top of that series.

> +		amd_enable_manual_tuning(slot);
> +	}
> +	return 0;
> +}
> +
>  static const struct sdhci_pci_fixes sdhci_amd = {
>  	.probe		= amd_probe,
> +	.probe_slot	= amd_probe_slot,
>  };
> 
>  static const struct pci_device_id pci_ids[] = {
> @@ -1397,7 +1575,7 @@ static int sdhci_pci_select_drive_strength(struct sdhci_host *host,
>  					   card_drv, drv_type);
>  }
> 
> -static const struct sdhci_ops sdhci_pci_ops = {
> +static struct sdhci_ops sdhci_pci_ops = {
>  	.set_clock	= sdhci_set_clock,
>  	.enable_dma	= sdhci_pci_enable_dma,
>  	.set_bus_width	= sdhci_pci_set_bus_width,
> 

Please run checkpatch --strict and consider it suggestions.

Please consider adding some explanation of the tuning algorithm
and defining some of the constants.

