From: Shyam Sundar S K <ssundark@amd.com>
Subject: Re: [PATCH] mmc: sdhci-pci-core: Tuning mode support for HS200 on AMD
 Platforms
Date: Thu, 27 Oct 2016 15:22:59 +0530
Message-ID: <8510d441-230a-9d93-222b-ba870869f094@amd.com>
References: <2ef1e2da-5913-85fe-65a7-0984ac04164d@amd.com>
 <418f99e4-18e5-38a6-0b4d-0815f3bd604f@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0047.outbound.protection.outlook.com ([104.47.42.47]:39932
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934322AbcJ0R0d (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 27 Oct 2016 13:26:33 -0400
In-Reply-To: <418f99e4-18e5-38a6-0b4d-0815f3bd604f@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>

Made changes to the earlier submission based on the comments
received from Adrian.

Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>

Also, adding patch from Adrian for handling the device specific
private data.

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Mon, 10 Oct 2016 10:04:45 +0300
Subject: [PATCH] mmc: sdhci-pci: Let devices define their own private data

Let devices define their own private data to facilitate device-specific
operations.  The size of the private structure is specified in the
sdhci_pci_fixes structure, then sdhci_pci_probe_slot() will allocate extra
space for it, and sdhci_pci_priv() can be used to get a reference to it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 181 +++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-pci.h      |   7 ++
 2 files changed, 186 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 1d9e00a..9576f82 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -817,6 +817,171 @@ enum amd_chipset_gen {
 	AMD_CHIPSET_UNKNOWN,
 };

+static const struct sdhci_ops amd_sdhci_pci_ops;
+
+struct amd_tuning_descriptor {
+	u8 tune_around;
+	bool this_tune_ok;
+	bool last_tune_ok;
+	u8 valid_front;
+	u8 valid_window_max;
+	u8 tune_low_max;
+	u8 tune_low;
+	u8 valid_window;
+	u8 tune_result;
+};
+
+static int amd_tuning_reset(struct sdhci_host *host)
+{
+	unsigned int val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	val |= SDHCI_CTRL_PRESET_VAL_ENABLE | SDHCI_CTRL_EXEC_TUNING;
+	sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
+
+	val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	val &= ~SDHCI_CTRL_EXEC_TUNING;
+	sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return 0;
+}
+
+static int amd_config_tuning_phase(struct sdhci_host *host, u8 phase)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	unsigned int val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	pci_read_config_dword(pdev, 0xb8, &val);
+	val &= ~0x1f;
+	val |= (0x10800 | (phase << 1));
+	pci_write_config_dword(pdev, 0xb8, val);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return 0;
+}
+
+static int amd_find_good_phase(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	struct amd_tuning_descriptor *td = sdhci_pci_priv(slot);
+
+	unsigned int val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (td->this_tune_ok)
+		td->valid_front += 1;
+	if ((!td->this_tune_ok && td->last_tune_ok) ||
+	    (td->tune_around == 11)) {
+		if (td->valid_window > td->valid_window_max) {
+			td->valid_window_max = td->valid_window;
+			td->tune_low_max = td->tune_low;
+		}
+	}
+	if (td->this_tune_ok && (!td->last_tune_ok))
+		td->tune_low = td->tune_around;
+	if (!td->this_tune_ok && td->last_tune_ok)
+		td->valid_window = 0;
+	else if (td->this_tune_ok)
+		td->valid_window += 1;
+
+	td->last_tune_ok = td->this_tune_ok;
+
+	if (td->tune_around == 11) {
+		if ((td->valid_front + td->valid_window) >
+						td->valid_window_max) {
+			if (td->valid_front > td->valid_window)
+				td->tune_result = ((td->valid_front -
+						td->valid_window) >> 1);
+			else
+				td->tune_result = td->tune_low +
+				((td->valid_window + td->valid_front) >> 1);
+		} else {
+			td->tune_result = td->tune_low_max +
+					(td->valid_window_max >> 1);
+		}
+
+		if (td->tune_result > 0x0b)
+			td->tune_result = 0x0b;
+
+		pci_read_config_dword(pdev, 0xb8, &val);
+		val &= ~0x1f;
+		val |= (0x10800 | (td->tune_result << 1));
+		pci_write_config_dword(pdev, 0xb8, val);
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return 0;
+}
+
+static int amd_enable_manual_tuning(struct sdhci_pci_slot *slot)
+{
+	struct pci_dev *pdev = slot->chip->pdev;
+	unsigned int val;
+
+	pci_read_config_dword(pdev, 0xd0, &val);
+	val &= 0xffffffcf;
+	val |= 0x30;
+	pci_write_config_dword(pdev, 0xd0, val);
+
+	return 0;
+}
+
+static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct amd_tuning_descriptor *td = sdhci_pci_priv(slot);
+	u8 ctrl;
+
+	amd_tuning_reset(host);
+	memset(td, 0, sizeof(struct amd_tuning_descriptor));
+
+	/*********************************************************************/
+	/* Enabling Software Tuning */
+	/********************************************************************/
+	/* 1. First switch the eMMC to HS200 Mode
+	 * 2. Prepare the registers by using the sampling clock select
+	 * 3. Send the CMD21 12 times with block length of 64 bytes
+	 * 4. Everytime change the clk phase and check for CRC error
+	 *	(CMD and DATA),if error, soft reset the CMD and DATA line
+	 * 5. Calculate the window and set the clock phase.
+	 */
+
+	for (td->tune_around = 0; td->tune_around < 12; td->tune_around++) {
+		amd_config_tuning_phase(host, td->tune_around);
+
+		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
+			td->this_tune_ok = false;
+			host->mmc->need_retune = 0;
+			mdelay(4);
+			ctrl = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
+			sdhci_writeb(host, ctrl, SDHCI_SOFTWARE_RESET);
+		} else {
+			td->this_tune_ok = true;
+		}
+
+		amd_find_good_phase(host);
+	}
+
+	host->mmc->retune_period = 0;
+
+	amd_enable_manual_tuning(slot);
+	return 0;
+}
+
 static int amd_probe(struct sdhci_pci_chip *chip)
 {
 	struct pci_dev	*smbus_dev;
@@ -841,7 +1006,6 @@ static int amd_probe(struct sdhci_pci_chip *chip)

 	if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ)) {
 		chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
-		chip->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
 	}

 	return 0;
@@ -849,6 +1013,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)

 static const struct sdhci_pci_fixes sdhci_amd = {
 	.probe		= amd_probe,
+	.ops		= &amd_sdhci_pci_ops,
 };

 static const struct pci_device_id pci_ids[] = {
@@ -1469,6 +1634,17 @@ static const struct sdhci_ops sdhci_pci_ops = {
 	.select_drive_strength	= sdhci_pci_select_drive_strength,
 };

+static const struct sdhci_ops amd_sdhci_pci_ops = {
+	.set_clock	= sdhci_set_clock,
+	.enable_dma	= sdhci_pci_enable_dma,
+	.set_bus_width	= sdhci_pci_set_bus_width,
+	.reset		= sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.hw_reset		= sdhci_pci_hw_reset,
+	.select_drive_strength	= sdhci_pci_select_drive_strength,
+	.platform_execute_tuning = amd_execute_tuning,
+};
+
 /*****************************************************************************\
  *                                                                           *
  * Suspend/resume                                                            *
@@ -1646,6 +1822,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	struct sdhci_pci_slot *slot;
 	struct sdhci_host *host;
 	int ret, bar = first_bar + slotno;
+	size_t priv_size = chip->fixes ? chip->fixes->priv_size : 0;

 	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
 		dev_err(&pdev->dev, "BAR %d is not iomem. Aborting.\n", bar);
@@ -1667,7 +1844,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 		return ERR_PTR(-ENODEV);
 	}

-	host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pci_slot));
+	host = sdhci_alloc_host(&pdev->dev, sizeof(*slot) + priv_size);
 	if (IS_ERR(host)) {
 		dev_err(&pdev->dev, "cannot allocate host\n");
 		return ERR_CAST(host);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 6bccf56..0bfd568 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -67,6 +67,7 @@ struct sdhci_pci_fixes {
 	int			(*resume) (struct sdhci_pci_chip *);

 	const struct sdhci_ops	*ops;
+	size_t			priv_size;
 };

 struct sdhci_pci_slot {
@@ -87,6 +88,7 @@ struct sdhci_pci_slot {
 				     struct mmc_card *card,
 				     unsigned int max_dtr, int host_drv,
 				     int card_drv, int *drv_type);
+	unsigned long		private[0] ____cacheline_aligned;
 };

 struct sdhci_pci_chip {
@@ -101,4 +103,9 @@ struct sdhci_pci_chip {
 	struct sdhci_pci_slot	*slots[MAX_SLOTS]; /* Pointers to host slots */
 };

+static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
+{
+	return (void *)slot->private;
+}
+
 #endif /* __SDHCI_PCI_H */
-- 
2.7.4

On 10/10/2016 1:25 PM, Adrian Hunter wrote:
> On 04/10/16 11:42, Shyam Sundar S K wrote:
>> This patch adds support for HS200 tuning mode on AMD eMMC-4.5.1
>>
>> Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
>> Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
>> Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
>> ---
>>  drivers/mmc/host/sdhci-pci-core.c | 182 +++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 180 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index 897cfd2..5893ec4 100644
>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> @@ -734,6 +734,7 @@ static const struct sdhci_pci_fixes sdhci_via = {
>>  	.probe		= via_probe,
>>  };
>>
>> +
> 
> Unnecessary blank line
> 
>>  static int rtsx_probe_slot(struct sdhci_pci_slot *slot)
>>  {
>>  	slot->host->mmc->caps2 |= MMC_CAP2_HS200;
>> @@ -755,6 +756,172 @@ enum amd_chipset_gen {
>>  	AMD_CHIPSET_UNKNOWN,
>>  };
>>
>> +struct tuning_descriptor {
> 
> It would be nicer to prefix all structure and function names by something
> specific to the device e.g. amd_...
> 
>> +	unsigned char tune_around;
>> +	bool this_tune_ok;
>> +	bool last_tune_ok;
>> +	bool valid_front_end;
>> +	unsigned char valid_front;
>> +	unsigned char valid_window_max;
>> +	unsigned char tune_low_max;
>> +	unsigned char tune_low;
>> +	unsigned char valid_window;
>> +	unsigned char tune_result;
> 
> 'unsigned char' -> 'u8'
> 
>> +};
>> +
>> +static struct sdhci_ops sdhci_pci_ops;
>> +static struct tuning_descriptor tdescriptor;
> 
> tdescriptor should not be global.  You need somewhere to put private
> data.  How about this:
> 
> 
> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Mon, 10 Oct 2016 10:04:45 +0300
> Subject: [PATCH] mmc: sdhci-pci: Let devices define their own private data
> 
> Let devices define their own private data to facilitate device-specific
> operations.  The size of the private structure is specified in the
> sdhci_pci_fixes structure, then sdhci_pci_probe_slot() will allocate extra
> space for it, and sdhci_pci_priv() can be used to get a reference to it.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
>  drivers/mmc/host/sdhci-pci.h      | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 1d9e00a00e9f..782c8d25c0c8 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1646,6 +1646,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  	struct sdhci_pci_slot *slot;
>  	struct sdhci_host *host;
>  	int ret, bar = first_bar + slotno;
> +	size_t priv_size = chip->fixes ? chip->fixes->priv_size : 0;
>  
>  	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
>  		dev_err(&pdev->dev, "BAR %d is not iomem. Aborting.\n", bar);
> @@ -1667,7 +1668,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  		return ERR_PTR(-ENODEV);
>  	}
>  
> -	host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pci_slot));
> +	host = sdhci_alloc_host(&pdev->dev, sizeof(*slot) + priv_size);
>  	if (IS_ERR(host)) {
>  		dev_err(&pdev->dev, "cannot allocate host\n");
>  		return ERR_CAST(host);
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 6bccf56bc5ff..6a1be6afe089 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -67,6 +67,7 @@ struct sdhci_pci_fixes {
>  	int			(*resume) (struct sdhci_pci_chip *);
>  
>  	const struct sdhci_ops	*ops;
> +	size_t			priv_size;
>  };
>  
>  struct sdhci_pci_slot {
> @@ -87,6 +88,8 @@ struct sdhci_pci_slot {
>  				     struct mmc_card *card,
>  				     unsigned int max_dtr, int host_drv,
>  				     int card_drv, int *drv_type);
> +
> +	unsigned long		private[0] ____cacheline_aligned;
>  };
>  
>  struct sdhci_pci_chip {
> @@ -101,4 +104,9 @@ struct sdhci_pci_chip {
>  	struct sdhci_pci_slot	*slots[MAX_SLOTS]; /* Pointers to host slots */
>  };
>  
> +static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
> +{
> +	return (void *)slot->private;
> +}
> +
>  #endif /* __SDHCI_PCI_H */
> 
