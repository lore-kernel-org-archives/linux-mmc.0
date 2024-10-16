Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0120C003;
	Wed, 16 Oct 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086462; cv=none; b=bUb2ldL2oHOHLtft0ljVUtAmZyGgomwKLGyqJ+bfH4k97RySp7kcaPZk0sE5I8cz50P56MorhebMhVOVjLViWgudCXNzGpdaLxJmFpXG/WMOi4yjw0n1Dm4QTt5EkcX03zmFKKc+9Ic1rA7knMQ1ImyfW6/mwDSlEYGBpnxvCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086462; c=relaxed/simple;
	bh=4jiV6lpA6LvFkUarGHlDbMdC5GD5N9KNRE6ueUWGNdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3uEEWRm5m+QX062uj9DheBgm26hfhkP4Vj/ndoPGyHK7CyM6SaXOByWrvyqwv/aBpbBMFUpoqmU+6KhPuYM/bGjLyyHp4uB1xg0lVx6A1HHDfaibJFDgn/Xg5wsjVh1a09+k41RnBoryrFOXQO3njB7vkalNRj4k5+i0MO7bzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=sUnmBJAo; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="sUnmBJAo"
Received: from [192.168.178.76] (business-24-134-207-61.pool2.vodafone-ip.de [24.134.207.61])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 2341C2FC0055;
	Wed, 16 Oct 2024 15:47:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1729086451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=da0JNUrP1qIGABH3kMBOZwZSqcHhtN/AW8nltr5aWI0=;
	b=sUnmBJAoE2jWtStyphrIQ/hHIATnvL45dsL7yfhPDHgA9QbECnJJI/akkCIX+6q5oSYHj+
	yGzdHbWLBPwFX0gVDcSz6q+IJcs9fzpM8XS3K5T4+eAbYnIPHjGdN6BSjlNb6d/ayIZ0Ry
	T1tAzIQPU9MLTx/Hjs6Lwncn4mTw5i4=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=ggo@tuxedocomputers.com
Message-ID: <943124f6-b896-49bb-b77b-e7d78146753f@tuxedocomputers.com>
Date: Wed, 16 Oct 2024 15:47:27 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] mmc: sdhci-pci-gli: fix x86/S0ix SoCs suspend for
 GL9767
To: Ben Chuang <benchuanggli@gmail.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
 victor.shih@genesyslogic.com.tw, Lucas.Lai@genesyslogic.com.tw,
 Greg.tu@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ben.chuang@genesyslogic.com.tw, ggo@tuxedocomputers.com, cs@tuxedo.de
References: <20241016023947.134179-4-benchuanggli@gmail.com>
Content-Language: en-US
From: Georg Gottleuber <ggo@tuxedocomputers.com>
In-Reply-To: <20241016023947.134179-4-benchuanggli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ben,

thank you for the quick reply.

Am 16.10.24 um 04:39 schrieb Ben Chuang:
> From: benchuanggli@gmail.com
> 
> [Resend email format, Sorry.]
> 
> Hi Georg and Christoffer,
> 
> On Tue, Oct 15, 2024 at 8:47 PM Georg Gottleuber <g.gottleuber@tuxedocomputers.com> wrote:
>>
>> Adapt commit 1202d617e3d04c ("mmc: sdhci-pci-gli: fix LPM negotiation
>> so x86/S0ix SoCs can suspend") also for GL9767 card reader.
>>
>> This patch was written without specs or deeper knowledge of PCI sleep
>> states. Tests show that S0ix is reached and a lower power consumption
>> when suspended (6 watts vs 1.2 watts for TUXEDO InfinityBook Pro Gen9
>> Intel).
>>
>> The function of the card reader appears to be normal.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219284
>> Co-developed-by: Christoffer Sandberg <cs@tuxedo.de>
>> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> Maybe need a Fixes: f3a5b56c1286 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support")

I was perhaps too cautious here.

>> ---
>>  drivers/mmc/host/sdhci-pci-gli.c | 65 +++++++++++++++++++++++++++++++-
>>  1 file changed, 64 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c
>> b/drivers/mmc/host/sdhci-pci-gli.c
>> index 0f81586a19df..40f43f5cd5c7 100644
>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>> @@ -1205,6 +1205,32 @@ static void
>> gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot,
>>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>>  }
>>
>> +static void gl9767_set_low_power_negotiation(struct sdhci_pci_slot *slot,
>> +                                            bool enable)
>> +{
>> +       struct pci_dev *pdev = slot->chip->pdev;
>> +       u32 value;
>> +
>> +       pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
>> +       value &= ~GLI_9767_VHS_REV;
>> +       value |= FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_W);
>> +       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
> Maybe replace it with gl9767_vhs_write().
> There are two functions gl9767_vhs_write()/gl9767_vhs_read() and they should be
> meant to be Vendor Header Space (VHS) writable/readable.

Yes. Will fix it in v2.

>> +
>> +       pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
>> +
>> +       if (enable)
>> +               value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
>> +       else
>> +               value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
>> +
>> +       pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
>> +
>> +       pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
>> +       value &= ~GLI_9767_VHS_REV;
>> +       value |= FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_R);
>> +       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
> Maybe replace it with gl9767_vhs_read().

Yes. Will fix it in v2.

> 
>> +}
>> +
>>  static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
>>                                         unsigned int timing)
>>  {
>> @@ -1470,6 +1496,42 @@ static int gl9763e_suspend(struct sdhci_pci_chip
>> *chip)
>>         gl9763e_set_low_power_negotiation(slot, false);
>>         return ret;
>>  }
>> +
>> +static int gl9767_resume(struct sdhci_pci_chip *chip)
>> +{
>> +       struct sdhci_pci_slot *slot = chip->slots[0];
>> +       int ret;
>> +
>> +       ret = sdhci_pci_gli_resume(chip);
>> +       if (ret)
>> +               return ret;
>> +
>> +       gl9767_set_low_power_negotiation(slot, false);
>> +
>> +       return 0;
>> +}
>> +
>> +static int gl9767_suspend(struct sdhci_pci_chip *chip)
>> +{
>> +       struct sdhci_pci_slot *slot = chip->slots[0];
>> +       int ret;
>> +
>> +       /*
>> +        * Certain SoCs can suspend only with the bus in low-
>> +        * power state, notably x86 SoCs when using S0ix.
>> +        * Re-enable LPM negotiation to allow entering L1 state
>> +        * and entering system suspend.
>> +        */
>> +       gl9767_set_low_power_negotiation(slot, true);
>> +
>> +       ret = sdhci_suspend_host(slot->host);
>> +       if (ret) {
>> +               gl9767_set_low_power_negotiation(slot, false);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>>  #endif
>>
>>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>> @@ -1605,6 +1667,7 @@ const struct sdhci_pci_fixes sdhci_gl9767 = {
>>         .probe_slot     = gli_probe_slot_gl9767,
>>         .ops            = &sdhci_gl9767_ops,
>>  #ifdef CONFIG_PM_SLEEP
>> -       .resume         = sdhci_pci_gli_resume,
>> +       .resume         = gl9767_resume,
>> +       .suspend        = gl9767_suspend,
>>  #endif
>>  };
>> --
>> 2.34.1
>>
> Bugzilla wrote that this issue only happens on Intel models, right? 
> How do you confirm the status of L1/L1SS, measuring PCIe link state via hardware or software?
> Thanks.

Yes, high power suspend only happens with (this single) Intel model. AMD
version sleeps well. (We only have these two models with GL9767.)

Unfortunately, we do not have a logic analyzer available. Our test
script reads following files and calculates percentage in relation to
sleep time:

/sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us

Additionally I measure during suspend with the battery disconnected and
USB-C measuring adapter.

Kind regards,
Georg Gottleuber

