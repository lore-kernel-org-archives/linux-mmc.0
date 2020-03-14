Return-Path: <SRS0=Qble=5A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243FAC1975A
	for <linux-mmc@archiver.kernel.org>; Sun, 15 Mar 2020 02:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA40B2051A
	for <linux-mmc@archiver.kernel.org>; Sun, 15 Mar 2020 02:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8/qyMRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCOCEG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:04:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47815 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgCOCEG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Mar 2020 22:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584237845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28eFvQYlhg3RvwPu91PVPeT2PayscbT9/y7o4iBKBOQ=;
        b=P8/qyMRyaE5XB0IAME02JpwYZirT3xD9NQYcfNJSvFMUkNb9KFZ2YOnUzwYyZ97EM/9UKI
        fWIB/wI3KeyBwjVdzKybQF4X07iGiy7k4v+d/Qtdh1J/9lksWIhXGomhCd/zep2Y54iZuS
        ri8uV8SkchQzruDxVAo7lqriuuLtK2w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-qFtpxGVAOQe37CgeeUVSpw-1; Sat, 14 Mar 2020 09:59:38 -0400
X-MC-Unique: qFtpxGVAOQe37CgeeUVSpw-1
Received: by mail-wr1-f72.google.com with SMTP id n11so5492075wrs.13
        for <linux-mmc@vger.kernel.org>; Sat, 14 Mar 2020 06:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=28eFvQYlhg3RvwPu91PVPeT2PayscbT9/y7o4iBKBOQ=;
        b=CeJiuSlAy5L1fno8pjoIvC+ShMCajhtNX/EI3eDkogMgGoVm6vsx7JPkxqOWKbqqtO
         VRg4vrVEK5TL5EAW0tVxgzX2UMLjpdRW5Dah46wMew5bdbD3VXYxYUawBVUTcp3AbPt7
         JRSFtZCMjmb+MttNGJJaWR5NkzrB2jaBeXEFukwwK0BUEziKj5Fcwn5Z6UAXXVGSUwxE
         pN5TkOg2PUHV6RBai01s6tm97N6Yl++l6c51AavERqxCmgXzG94mJOEcbrY+pTL9tYAP
         mFq+mf4oe9W1KJpAcHP1vYM6MWTwH1t2l/TMZ7Py64yIst+BJeJsscmvATQjOQrm3S1i
         q+Vg==
X-Gm-Message-State: ANhLgQ0Pju9o7cyq2zzXy7mXr0e5uugLAJmCpgXtwOQ2lTB/7w68/QMr
        cQaAarRxOPi7Q2tSskFlX2df/vb32q2P+r9boAURN9DR3gdO+Wq9zwdeqaL368OK97/cwM+aIxu
        4S5T3atv0wOnxXToRUdws
X-Received: by 2002:a1c:5505:: with SMTP id j5mr6420095wmb.170.1584194377123;
        Sat, 14 Mar 2020 06:59:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtPrQvmPHCeBeKW94Jdu7kdO+0opdC8nTfZoQHKQ0VA0FTn/hUCxVTJDFgb8LSKAeYWTSh/Pw==
X-Received: by 2002:a1c:5505:: with SMTP id j5mr6420071wmb.170.1584194376760;
        Sat, 14 Mar 2020 06:59:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id i10sm79044040wrn.53.2020.03.14.06.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 06:59:35 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] mmc: sdhci-acpi: Switch signal voltage back to
 3.3V on suspend on external microSD on Lenovo Miix 320
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
References: <20200306143100.164975-1-hdegoede@redhat.com>
 <1947780d-e2bf-1a3b-4603-a32c1b021e2f@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ddeaf983-3ca9-c808-5623-7e29dbd948a5@redhat.com>
Date:   Sat, 14 Mar 2020 14:59:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1947780d-e2bf-1a3b-4603-a32c1b021e2f@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 3/9/20 10:26 AM, Adrian Hunter wrote:
> Thanks for doing this.  A couple of questions below.
> 
> On 6/03/20 4:30 pm, Hans de Goede wrote:
>> Based on a sample of 7 DSDTs from Cherry Trail devices using an AXP288
>> PMIC depending on the design one of 2 possible LDOs on the PMIC is used
>> for the MMC signalling voltage, either DLDO3 or GPIO1LDO (GPIO1 pin in
>> low noise LDO mode).
>>
>> The Lenovo Miix 320-10ICR uses GPIO1LDO in the SHC1 ACPI device's DSM
>> methods to set 3.3 or 1.8 signalling voltage and this appears to work
>> as advertised, so presumably the device is actually using GPIO1LDO for
>> the external microSD signalling voltage.
>>
>> But this device has a bug in the _PS0 method of the SHC1 ACPI device,
>> the DSM remembers the last set signalling voltage and the _PS0 restores
>> this after a (runtime) suspend-resume cycle, but it "restores" the voltage
>> on DLDO3 instead of setting it on GPIO1LDO as the DSM method does. DLDO3
>> is used for the LCD and setting it to 1.8V causes the LCD to go black.
>>
>> This commit works around this issue by calling the Intel DSM to reset the
>> signal voltage to 3.3V after the host has been runtime suspended.
>> This will make the _PS0 method reprogram the DLDO3 voltage to 3.3V, which
>> leaves it at its original setting fixing the LCD going black.
>>
>> And this commit then resets the signal voltage back to the original 1.8V
>> from the (runtime) resume handler, which runs after the ACPI _PS0 method
>> has run.
> 
> Don't sdhci_resume_host, sdhci_runtime_resume_host do that anyway?

It does not look like that, I've added the following debugging patch:

--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -147,6 +147,10 @@ static int intel_dsm(struct intel_host *intel_host, struct device *dev,
  	if (fn > 31 || !(intel_host->dsm_fns & (1 << fn)))
  		return -EOPNOTSUPP;

+	if (fn == INTEL_DSM_V18_SWITCH || fn == INTEL_DSM_V33_SWITCH)
+		pr_err("Intel DSM switching to %s volt\n",
+			(fn == INTEL_DSM_V18_SWITCH) ? "1.8" : "3.3");
+
  	return __intel_dsm(intel_host, dev, fn, result);
  }

@@ -903,8 +907,9 @@ static void __maybe_unused sdhci_acpi_restore_signal_voltage_if_needed(
  		struct intel_host *intel_host = sdhci_acpi_priv(c);
  		unsigned int fn = INTEL_DSM_V18_SWITCH;
  		u32 result = 0;
-
+		pr_err("Calling Intel DSM from %s\n", __func__);
  		intel_dsm(intel_host, dev, fn, &result);
+		pr_err("Calling Intel DSM from %s done\n", __func__);
  	}
  }


And this gives the following output:

[  368.079932] Intel DSM switching to 3.3 volt
[  368.414832] Intel DSM switching to 1.8 volt
[  371.989717] Intel DSM switching to 3.3 volt
[  407.176050] Calling Intel DSM from sdhci_acpi_restore_signal_voltage_if_needed
[  407.176052] Intel DSM switching to 1.8 volt
[  407.200276] Calling Intel DSM from sdhci_acpi_restore_signal_voltage_if_needed done
[  407.205846] Intel DSM switching to 3.3 volt
[  407.527003] Intel DSM switching to 1.8 volt
[  407.571991] Intel DSM switching to 3.3 volt
[  407.893990] Intel DSM switching to 1.8 volt

[  412.242658] Intel DSM switching to 1.8 volt
[  412.289387] Intel DSM switching to 3.3 volt
[  412.606210] Intel DSM switching to 1.8 volt
[  423.292135] Intel DSM switching to 3.3 volt
[  424.520057] Calling Intel DSM from sdhci_acpi_restore_signal_voltage_if_needed
[  424.520065] Intel DSM switching to 1.8 volt
[  424.546960] Calling Intel DSM from sdhci_acpi_restore_signal_voltage_if_needed done
[  424.552940] Intel DSM switching to 3.3 volt
[  424.890483] Intel DSM switching to 1.8 volt

Notice how the switch to 1.8 volt is not repeated.

It looks almost as if the voltage is being reset
to 3.3 volt by some higher level code, but only
after the sdhci_acpi_runtime_resume(), rather then
before the sdhci_acpi_runtime_suspend() completes.

If that is indeed the case then indeed we might not
need the sdhci_acpi_restore_signal_voltage_if_needed()
function, since the first call to set the signal
voltage to 3.3V on resume would just be a no-op
because with the quirk we already do that on suspend.

And then the second call to switch to 1.8 volt would
take care of switching to 1.8V for us.

But if this is indeed what is happening, then wouldn't
it make more sense to switch back to 3.3V from somewhere
in higher-level code before sdhci_runtime_suspend_host()
completes, replacing the current switch-back done just
after resume?  If we move that switch-back to 3.3V
done just after resume to suspend time then this entire
model-specific patch will likely become unnecessary ?

Note one more answer to some of your review remarks below.

>> This commit adds and uses a DMI quirk mechanism to only trigger this
>> workaround on the Lenovo Miix 320 while leaving the behavior of the
>> driver unchanged on other devices.
>>
>> BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=111294
>> BugLink: https://gitlab.freedesktop.org/drm/intel/issues/355
>> Reported-by: russianneuromancer <russianneuromancer@ya.ru>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> - Make the quirk reset the signal voltage to 3.3V at the end of the
>>    (runtime) suspend handler instead of disabling 1.8V modes
>> - Drop the module option to allow overridig the quirks
>> ---
>>   drivers/mmc/host/sdhci-acpi.c | 87 ++++++++++++++++++++++++++++++++++-
>>   1 file changed, 85 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index 9651dca6863e..d54a3592f40f 100644
>> --- a/drivers/mmc/host/sdhci-acpi.c
>> +++ b/drivers/mmc/host/sdhci-acpi.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/pm.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/delay.h>
>> +#include <linux/dmi.h>
>>   
>>   #include <linux/mmc/host.h>
>>   #include <linux/mmc/pm.h>
>> @@ -72,9 +73,14 @@ struct sdhci_acpi_host {
>>   	const struct sdhci_acpi_slot	*slot;
>>   	struct platform_device		*pdev;
>>   	bool				use_runtime_pm;
>> +	bool				reset_signal_volt_on_suspend;
>>   	unsigned long			private[0] ____cacheline_aligned;
>>   };
>>   
>> +enum {
>> +	DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP			= BIT(0),
>> +};
>> +
>>   static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
>>   {
>>   	return (void *)c->private;
>> @@ -647,6 +653,24 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>>   };
>>   MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>>   
>> +static const struct dmi_system_id sdhci_acpi_quirks[] = {
>> +	{
>> +		/*
>> +		 * The Lenovo Miix 320-10ICR has a bug in the _PS0 method of
>> +		 * the SHC1 ACPI device, this bug causes it to reprogram the
>> +		 * wrong LDO (DLDO3) to 1.8V if 1.8V modes are used and the
>> +		 * card is (runtime) suspended + resumed. DLDO3 is used for
>> +		 * the LCD and setting it to 1.8V causes the LCD to go black.
>> +		 */
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo MIIX 320-10ICR"),
>> +		},
>> +		.driver_data = (void *)DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP,
>> +	},
>> +	{} /* Terminating entry */
>> +};
>> +
>>   static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(struct acpi_device *adev)
>>   {
>>   	const struct sdhci_acpi_uid_slot *u;
>> @@ -663,17 +687,23 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>   	struct device *dev = &pdev->dev;
>>   	const struct sdhci_acpi_slot *slot;
>>   	struct acpi_device *device, *child;
>> +	const struct dmi_system_id *id;
>>   	struct sdhci_acpi_host *c;
>>   	struct sdhci_host *host;
>>   	struct resource *iomem;
>>   	resource_size_t len;
>>   	size_t priv_size;
>> +	int quirks = 0;
>>   	int err;
>>   
>>   	device = ACPI_COMPANION(dev);
>>   	if (!device)
>>   		return -ENODEV;
>>   
>> +	id = dmi_first_match(sdhci_acpi_quirks);
>> +	if (id)
>> +		quirks = (long)id->driver_data;
>> +
>>   	slot = sdhci_acpi_get_slot(device);
>>   
>>   	/* Power on the SDHCI controller and its children */
>> @@ -759,6 +789,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>>   			dev_warn(dev, "failed to setup card detect gpio\n");
>>   			c->use_runtime_pm = false;
>>   		}
>> +
>> +		if (quirks & DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP)
>> +			c->reset_signal_volt_on_suspend = true;
>>   	}
>>   
>>   	err = sdhci_setup_host(host);
>> @@ -823,17 +856,59 @@ static int sdhci_acpi_remove(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> +static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
>> +	struct device *dev)
>> +{
>> +	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>> +	struct sdhci_host *host = c->host;
>> +
>> +	if (c->reset_signal_volt_on_suspend &&
>> +	    host->mmc_host_ops.start_signal_voltage_switch ==
>> +					intel_start_signal_voltage_switch &&
> 
> This creates a unexpected dependency on
> host->mmc_host_ops.start_signal_voltage_switch.  Is it really necessary?

Well we are directly invoking the intel_dsm here, although the
DMI match should only happen on a system which is using an
Intel SDHCI controller, I thought it would be better to check for
that rather then just assuming it.

Also see the:

+		struct intel_host *intel_host = sdhci_acpi_priv(c);

Line, doing this on a non Intel SDHCI ACPI controller would be bad.

Regards,

Hans


> 
>> +	    host->mmc->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_330) {
>> +		struct intel_host *intel_host = sdhci_acpi_priv(c);
>> +		unsigned int fn = INTEL_DSM_V33_SWITCH;
>> +		u32 result = 0;
>> +
>> +		intel_dsm(intel_host, dev, fn, &result);
>> +	}
>> +}
>> +
>> +static void __maybe_unused sdhci_acpi_restore_signal_voltage_if_needed(
>> +	struct device *dev)
>> +{
>> +	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>> +	struct sdhci_host *host = c->host;
>> +
>> +	if (c->reset_signal_volt_on_suspend &&
>> +	    host->mmc_host_ops.start_signal_voltage_switch ==
>> +					intel_start_signal_voltage_switch &&
>> +	    host->mmc->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
>> +		struct intel_host *intel_host = sdhci_acpi_priv(c);
>> +		unsigned int fn = INTEL_DSM_V18_SWITCH;
>> +		u32 result = 0;
>> +
>> +		intel_dsm(intel_host, dev, fn, &result);
>> +	}
>> +}
>> +
>>   #ifdef CONFIG_PM_SLEEP
>>   
>>   static int sdhci_acpi_suspend(struct device *dev)
>>   {
>>   	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>>   	struct sdhci_host *host = c->host;
>> +	int ret;
>>   
>>   	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>>   		mmc_retune_needed(host->mmc);
>>   
>> -	return sdhci_suspend_host(host);
>> +	ret = sdhci_suspend_host(host);
>> +	if (ret)
>> +		return ret;
>> +
>> +	sdhci_acpi_reset_signal_voltage_if_needed(dev);
>> +	return 0;
>>   }
>>   
>>   static int sdhci_acpi_resume(struct device *dev)
>> @@ -841,6 +916,7 @@ static int sdhci_acpi_resume(struct device *dev)
>>   	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>>   
>>   	sdhci_acpi_byt_setting(&c->pdev->dev);
>> +	sdhci_acpi_restore_signal_voltage_if_needed(dev);
>>   
>>   	return sdhci_resume_host(c->host);
>>   }
>> @@ -853,11 +929,17 @@ static int sdhci_acpi_runtime_suspend(struct device *dev)
>>   {
>>   	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>>   	struct sdhci_host *host = c->host;
>> +	int ret;
>>   
>>   	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>>   		mmc_retune_needed(host->mmc);
>>   
>> -	return sdhci_runtime_suspend_host(host);
>> +	ret = sdhci_runtime_suspend_host(host);
>> +	if (ret)
>> +		return ret;
>> +
>> +	sdhci_acpi_reset_signal_voltage_if_needed(dev);
>> +	return 0;
>>   }
>>   
>>   static int sdhci_acpi_runtime_resume(struct device *dev)
>> @@ -865,6 +947,7 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
>>   	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>>   
>>   	sdhci_acpi_byt_setting(&c->pdev->dev);
>> +	sdhci_acpi_restore_signal_voltage_if_needed(dev);
>>   
>>   	return sdhci_runtime_resume_host(c->host, 0);
>>   }
>>
> 

