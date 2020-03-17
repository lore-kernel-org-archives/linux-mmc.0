Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5F3C10F29
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 07:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A5920674
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 07:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgCQHmp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:42:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:19147 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgCQHmp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Mar 2020 03:42:45 -0400
IronPort-SDR: 8ssllRdw8rql745GmASXDNLhW8RmSEjnkOHQVBL+KBoplaIrsbvRSnxZotNN1l/JKjpPInMvpQ
 0byvMSVEfzRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 00:42:44 -0700
IronPort-SDR: ZWOxj/1v17GDvoVmW8yDS21r0RKdTP3BYcibzN+8zSouF4rO5RhZMtbFRuG/cjB7qI2Qg7vZBs
 cT85qj23oU6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="443663235"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga005.fm.intel.com with ESMTP; 17 Mar 2020 00:42:43 -0700
Subject: Re: [PATCH v3 1/2] mmc: sdhci-acpi: Switch signal voltage back to
 3.3V on suspend on external microSD on Lenovo Miix 320
To:     Hans de Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        russianneuromancer <russianneuromancer@ya.ru>
References: <20200316184753.393458-1-hdegoede@redhat.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <12984ede-4115-9986-e704-33ca19b1bccd@intel.com>
Date:   Tue, 17 Mar 2020 09:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316184753.393458-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/03/20 8:47 pm, Hans de Goede wrote:
> Based on a sample of 7 DSDTs from Cherry Trail devices using an AXP288
> PMIC depending on the design one of 2 possible LDOs on the PMIC is used
> for the MMC signalling voltage, either DLDO3 or GPIO1LDO (GPIO1 pin in
> low noise LDO mode).
> 
> The Lenovo Miix 320-10ICR uses GPIO1LDO in the SHC1 ACPI device's DSM
> methods to set 3.3 or 1.8 signalling voltage and this appears to work
> as advertised, so presumably the device is actually using GPIO1LDO for
> the external microSD signalling voltage.
> 
> But this device has a bug in the _PS0 method of the SHC1 ACPI device,
> the DSM remembers the last set signalling voltage and the _PS0 restores
> this after a (runtime) suspend-resume cycle, but it "restores" the voltage
> on DLDO3 instead of setting it on GPIO1LDO as the DSM method does. DLDO3
> is used for the LCD and setting it to 1.8V causes the LCD to go black.
> 
> This commit works around this issue by calling the Intel DSM to reset the
> signal voltage to 3.3V after the host has been runtime suspended.
> This will make the _PS0 method reprogram the DLDO3 voltage to 3.3V, which
> leaves it at its original setting fixing the LCD going black.
> 
> This commit adds and uses a DMI quirk mechanism to only trigger this
> workaround on the Lenovo Miix 320 while leaving the behavior of the
> driver unchanged on other devices.
> 
> BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=111294
> BugLink: https://gitlab.freedesktop.org/drm/intel/issues/355
> Reported-by: russianneuromancer <russianneuromancer@ya.ru>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v3:
> - Drop code to restore 1.8 signal voltage on suspend, this is not necessary
> - Add an is_intel bool to sdhci_acpi_host instead of checking for:
>   mmc_host_ops.start_signal_voltage_switch == intel_start_signal_voltage_switch
> 
> Changes in v2:
> - Make the quirk reset the signal voltage to 3.3V at the end of the
>   (runtime) suspend handler instead of disabling 1.8V modes
> - Drop the module option to allow overridig the quirks
> ---
>  drivers/mmc/host/sdhci-acpi.c | 68 +++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 9651dca6863e..b4c1b2367066 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -23,6 +23,7 @@
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/delay.h>
> +#include <linux/dmi.h>
>  
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/pm.h>
> @@ -72,9 +73,15 @@ struct sdhci_acpi_host {
>  	const struct sdhci_acpi_slot	*slot;
>  	struct platform_device		*pdev;
>  	bool				use_runtime_pm;
> +	bool				is_intel;
> +	bool				reset_signal_volt_on_suspend;
>  	unsigned long			private[0] ____cacheline_aligned;
>  };
>  
> +enum {
> +	DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP			= BIT(0),
> +};
> +
>  static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
>  {
>  	return (void *)c->private;
> @@ -391,6 +398,8 @@ static int intel_probe_slot(struct platform_device *pdev, struct acpi_device *ad
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  					intel_start_signal_voltage_switch;
>  
> +	c->is_intel = true;
> +
>  	return 0;
>  }
>  
> @@ -647,6 +656,24 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>  
> +static const struct dmi_system_id sdhci_acpi_quirks[] = {
> +	{
> +		/*
> +		 * The Lenovo Miix 320-10ICR has a bug in the _PS0 method of
> +		 * the SHC1 ACPI device, this bug causes it to reprogram the
> +		 * wrong LDO (DLDO3) to 1.8V if 1.8V modes are used and the
> +		 * card is (runtime) suspended + resumed. DLDO3 is used for
> +		 * the LCD and setting it to 1.8V causes the LCD to go black.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
> +		},
> +		.driver_data = (void *)DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP,
> +	},
> +	{} /* Terminating entry */
> +};
> +
>  static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(struct acpi_device *adev)
>  {
>  	const struct sdhci_acpi_uid_slot *u;
> @@ -663,17 +690,23 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	const struct sdhci_acpi_slot *slot;
>  	struct acpi_device *device, *child;
> +	const struct dmi_system_id *id;
>  	struct sdhci_acpi_host *c;
>  	struct sdhci_host *host;
>  	struct resource *iomem;
>  	resource_size_t len;
>  	size_t priv_size;
> +	int quirks = 0;
>  	int err;
>  
>  	device = ACPI_COMPANION(dev);
>  	if (!device)
>  		return -ENODEV;
>  
> +	id = dmi_first_match(sdhci_acpi_quirks);
> +	if (id)
> +		quirks = (long)id->driver_data;
> +
>  	slot = sdhci_acpi_get_slot(device);
>  
>  	/* Power on the SDHCI controller and its children */
> @@ -759,6 +792,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  			dev_warn(dev, "failed to setup card detect gpio\n");
>  			c->use_runtime_pm = false;
>  		}
> +
> +		if (quirks & DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP)
> +			c->reset_signal_volt_on_suspend = true;
>  	}
>  
>  	err = sdhci_setup_host(host);
> @@ -823,17 +859,39 @@ static int sdhci_acpi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
> +	struct device *dev)
> +{
> +	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
> +	struct sdhci_host *host = c->host;
> +
> +	if (c->is_intel && c->reset_signal_volt_on_suspend &&
> +	    host->mmc->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_330) {
> +		struct intel_host *intel_host = sdhci_acpi_priv(c);
> +		unsigned int fn = INTEL_DSM_V33_SWITCH;
> +		u32 result = 0;
> +
> +		intel_dsm(intel_host, dev, fn, &result);
> +	}
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  
>  static int sdhci_acpi_suspend(struct device *dev)
>  {
>  	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>  	struct sdhci_host *host = c->host;
> +	int ret;
>  
>  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>  		mmc_retune_needed(host->mmc);
>  
> -	return sdhci_suspend_host(host);
> +	ret = sdhci_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	sdhci_acpi_reset_signal_voltage_if_needed(dev);
> +	return 0;
>  }
>  
>  static int sdhci_acpi_resume(struct device *dev)
> @@ -853,11 +911,17 @@ static int sdhci_acpi_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>  	struct sdhci_host *host = c->host;
> +	int ret;
>  
>  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>  		mmc_retune_needed(host->mmc);
>  
> -	return sdhci_runtime_suspend_host(host);
> +	ret = sdhci_runtime_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	sdhci_acpi_reset_signal_voltage_if_needed(dev);
> +	return 0;
>  }
>  
>  static int sdhci_acpi_runtime_resume(struct device *dev)
> 

