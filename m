Return-Path: <SRS0=Ofta=42=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B268BC10F27
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 09:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D1E2072A
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 09:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCIJ13 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:27:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:44255 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgCIJ13 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Mar 2020 05:27:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 02:27:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; 
   d="scan'208";a="235620903"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga008.jf.intel.com with ESMTP; 09 Mar 2020 02:27:25 -0700
Subject: Re: [PATCH v2 1/2] mmc: sdhci-acpi: Switch signal voltage back to
 3.3V on suspend on external microSD on Lenovo Miix 320
To:     Hans de Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
References: <20200306143100.164975-1-hdegoede@redhat.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1947780d-e2bf-1a3b-4603-a32c1b021e2f@intel.com>
Date:   Mon, 9 Mar 2020 11:26:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306143100.164975-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Thanks for doing this.  A couple of questions below.

On 6/03/20 4:30 pm, Hans de Goede wrote:
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
> And this commit then resets the signal voltage back to the original 1.8V
> from the (runtime) resume handler, which runs after the ACPI _PS0 method
> has run.

Don't sdhci_resume_host, sdhci_runtime_resume_host do that anyway?

> 
> This commit adds and uses a DMI quirk mechanism to only trigger this
> workaround on the Lenovo Miix 320 while leaving the behavior of the
> driver unchanged on other devices.
> 
> BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=111294
> BugLink: https://gitlab.freedesktop.org/drm/intel/issues/355
> Reported-by: russianneuromancer <russianneuromancer@ya.ru>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Make the quirk reset the signal voltage to 3.3V at the end of the
>   (runtime) suspend handler instead of disabling 1.8V modes
> - Drop the module option to allow overridig the quirks
> ---
>  drivers/mmc/host/sdhci-acpi.c | 87 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 9651dca6863e..d54a3592f40f 100644
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
> @@ -72,9 +73,14 @@ struct sdhci_acpi_host {
>  	const struct sdhci_acpi_slot	*slot;
>  	struct platform_device		*pdev;
>  	bool				use_runtime_pm;
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
> @@ -647,6 +653,24 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
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
> @@ -663,17 +687,23 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
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
> @@ -759,6 +789,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>  			dev_warn(dev, "failed to setup card detect gpio\n");
>  			c->use_runtime_pm = false;
>  		}
> +
> +		if (quirks & DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP)
> +			c->reset_signal_volt_on_suspend = true;
>  	}
>  
>  	err = sdhci_setup_host(host);
> @@ -823,17 +856,59 @@ static int sdhci_acpi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
> +	struct device *dev)
> +{
> +	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
> +	struct sdhci_host *host = c->host;
> +
> +	if (c->reset_signal_volt_on_suspend &&
> +	    host->mmc_host_ops.start_signal_voltage_switch ==
> +					intel_start_signal_voltage_switch &&

This creates a unexpected dependency on
host->mmc_host_ops.start_signal_voltage_switch.  Is it really necessary?

> +	    host->mmc->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_330) {
> +		struct intel_host *intel_host = sdhci_acpi_priv(c);
> +		unsigned int fn = INTEL_DSM_V33_SWITCH;
> +		u32 result = 0;
> +
> +		intel_dsm(intel_host, dev, fn, &result);
> +	}
> +}
> +
> +static void __maybe_unused sdhci_acpi_restore_signal_voltage_if_needed(
> +	struct device *dev)
> +{
> +	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
> +	struct sdhci_host *host = c->host;
> +
> +	if (c->reset_signal_volt_on_suspend &&
> +	    host->mmc_host_ops.start_signal_voltage_switch ==
> +					intel_start_signal_voltage_switch &&
> +	    host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> +		struct intel_host *intel_host = sdhci_acpi_priv(c);
> +		unsigned int fn = INTEL_DSM_V18_SWITCH;
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
> @@ -841,6 +916,7 @@ static int sdhci_acpi_resume(struct device *dev)
>  	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>  
>  	sdhci_acpi_byt_setting(&c->pdev->dev);
> +	sdhci_acpi_restore_signal_voltage_if_needed(dev);
>  
>  	return sdhci_resume_host(c->host);
>  }
> @@ -853,11 +929,17 @@ static int sdhci_acpi_runtime_suspend(struct device *dev)
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
> @@ -865,6 +947,7 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
>  	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>  
>  	sdhci_acpi_byt_setting(&c->pdev->dev);
> +	sdhci_acpi_restore_signal_voltage_if_needed(dev);
>  
>  	return sdhci_runtime_resume_host(c->host, 0);
>  }
> 

