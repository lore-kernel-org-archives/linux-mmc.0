Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BAAC3F2CE
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED0520736
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 11:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQ9uQr4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgCQL7G (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:59:06 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33269 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgCQL7F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Mar 2020 07:59:05 -0400
Received: by mail-ua1-f66.google.com with SMTP id i7so7541582uap.0
        for <linux-mmc@vger.kernel.org>; Tue, 17 Mar 2020 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wh7ihOZrHr0uDINEY47bUZz0S5JuDgUp8/LYTmyFPls=;
        b=CQ9uQr4VzuenhtmxnqOemtF20trKY7ps0De49G9M5mze54eg9wFwytlnpPcH4+gQUP
         84D74LBlLZ9lFm7Zov5k0erAFce+qJfeguSVS6LU9WyYgzmmIgXSpieigsLu3Y58sA0h
         Myv1WnrCt4ighRjrLQzmDu93lFHt/TVkFlMao30eNkuDSdUUH6RCvfNNdLBBYpx+bGe2
         jsfLq68sQ9CeBrsJcAjMOy/yqricduaLHSBJn3Z8U6xWgB1ZFXHAkiR8Mj3+to5En45b
         Wa45T4Ijwmk3nEkYaZGkQLNyyqfC9cpQ0WZ7XE5Dxfduuc2Ggs4i0HWuyT36zsJdoUCL
         JNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wh7ihOZrHr0uDINEY47bUZz0S5JuDgUp8/LYTmyFPls=;
        b=Rw0i0iDkzVguhho8/o21czqMYCb/NSTKd8P1SFoab2fkU8v6ZgSkcjKQ3PajuGv8FD
         ChKzcX8erLS8ynGHclsr3Qy3NZLAZvUxb8XCllVvq67X9HD9JqM9v+eyK+yudg//GIGA
         ie9pwKSxBo26aF6mKf42fS5GzYHb0hB1UgjdYGPHIk16XyedjoUyIMgUmGTKl3k/X69o
         nY/pVv0xpe5uwQeSUrxRY44TNwerqlEHST+g6Ao9WHTdwIim5zS1fkLjBqsTcA+1K05Q
         IC+g5A9zK5isH/cAxSqkocNEWOF7FnTCWmwjt6sK63lB1MN7sSkzHrnC/QN4lu9x6On4
         +pVQ==
X-Gm-Message-State: ANhLgQ0H+y+g/FxaDdmpY0MXnmbrKQCUklLZuI4MKtW2clsOc9w9j9St
        pkCvQVJ9ELOZBKccxR95mZq4BLPKe2xQNh+RDvrYWQ==
X-Google-Smtp-Source: ADFU+vtBchgrSI/UUqFchwa5ZB7mrY5L4bKjYb6UGQsNlEnC6RqlNEKPO53Pjj1bqK4neWVROXGd0bwp9r+bFQh0laE=
X-Received: by 2002:ab0:7381:: with SMTP id l1mr3262143uap.104.1584446344572;
 Tue, 17 Mar 2020 04:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200316184753.393458-1-hdegoede@redhat.com>
In-Reply-To: <20200316184753.393458-1-hdegoede@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Mar 2020 12:58:28 +0100
Message-ID: <CAPDyKFq1u8ndxwbTdPv_L8cygy96QB=+PG6wrcbeVwxWC3KLbw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: sdhci-acpi: Switch signal voltage back to
 3.3V on suspend on external microSD on Lenovo Miix 320
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        russianneuromancer <russianneuromancer@ya.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Mar 2020 at 19:48, Hans de Goede <hdegoede@redhat.com> wrote:
>
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

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


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
>         const struct sdhci_acpi_slot    *slot;
>         struct platform_device          *pdev;
>         bool                            use_runtime_pm;
> +       bool                            is_intel;
> +       bool                            reset_signal_volt_on_suspend;
>         unsigned long                   private[0] ____cacheline_aligned;
>  };
>
> +enum {
> +       DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP                  = BIT(0),
> +};
> +
>  static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
>  {
>         return (void *)c->private;
> @@ -391,6 +398,8 @@ static int intel_probe_slot(struct platform_device *pdev, struct acpi_device *ad
>         host->mmc_host_ops.start_signal_voltage_switch =
>                                         intel_start_signal_voltage_switch;
>
> +       c->is_intel = true;
> +
>         return 0;
>  }
>
> @@ -647,6 +656,24 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>
> +static const struct dmi_system_id sdhci_acpi_quirks[] = {
> +       {
> +               /*
> +                * The Lenovo Miix 320-10ICR has a bug in the _PS0 method of
> +                * the SHC1 ACPI device, this bug causes it to reprogram the
> +                * wrong LDO (DLDO3) to 1.8V if 1.8V modes are used and the
> +                * card is (runtime) suspended + resumed. DLDO3 is used for
> +                * the LCD and setting it to 1.8V causes the LCD to go black.
> +                */
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
> +               },
> +               .driver_data = (void *)DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP,
> +       },
> +       {} /* Terminating entry */
> +};
> +
>  static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(struct acpi_device *adev)
>  {
>         const struct sdhci_acpi_uid_slot *u;
> @@ -663,17 +690,23 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         const struct sdhci_acpi_slot *slot;
>         struct acpi_device *device, *child;
> +       const struct dmi_system_id *id;
>         struct sdhci_acpi_host *c;
>         struct sdhci_host *host;
>         struct resource *iomem;
>         resource_size_t len;
>         size_t priv_size;
> +       int quirks = 0;
>         int err;
>
>         device = ACPI_COMPANION(dev);
>         if (!device)
>                 return -ENODEV;
>
> +       id = dmi_first_match(sdhci_acpi_quirks);
> +       if (id)
> +               quirks = (long)id->driver_data;
> +
>         slot = sdhci_acpi_get_slot(device);
>
>         /* Power on the SDHCI controller and its children */
> @@ -759,6 +792,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>                         dev_warn(dev, "failed to setup card detect gpio\n");
>                         c->use_runtime_pm = false;
>                 }
> +
> +               if (quirks & DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP)
> +                       c->reset_signal_volt_on_suspend = true;
>         }
>
>         err = sdhci_setup_host(host);
> @@ -823,17 +859,39 @@ static int sdhci_acpi_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
> +       struct device *dev)
> +{
> +       struct sdhci_acpi_host *c = dev_get_drvdata(dev);
> +       struct sdhci_host *host = c->host;
> +
> +       if (c->is_intel && c->reset_signal_volt_on_suspend &&
> +           host->mmc->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_330) {
> +               struct intel_host *intel_host = sdhci_acpi_priv(c);
> +               unsigned int fn = INTEL_DSM_V33_SWITCH;
> +               u32 result = 0;
> +
> +               intel_dsm(intel_host, dev, fn, &result);
> +       }
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>
>  static int sdhci_acpi_suspend(struct device *dev)
>  {
>         struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>         struct sdhci_host *host = c->host;
> +       int ret;
>
>         if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>                 mmc_retune_needed(host->mmc);
>
> -       return sdhci_suspend_host(host);
> +       ret = sdhci_suspend_host(host);
> +       if (ret)
> +               return ret;
> +
> +       sdhci_acpi_reset_signal_voltage_if_needed(dev);
> +       return 0;
>  }
>
>  static int sdhci_acpi_resume(struct device *dev)
> @@ -853,11 +911,17 @@ static int sdhci_acpi_runtime_suspend(struct device *dev)
>  {
>         struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>         struct sdhci_host *host = c->host;
> +       int ret;
>
>         if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>                 mmc_retune_needed(host->mmc);
>
> -       return sdhci_runtime_suspend_host(host);
> +       ret = sdhci_runtime_suspend_host(host);
> +       if (ret)
> +               return ret;
> +
> +       sdhci_acpi_reset_signal_voltage_if_needed(dev);
> +       return 0;
>  }
>
>  static int sdhci_acpi_runtime_resume(struct device *dev)
> --
> 2.25.1
>
