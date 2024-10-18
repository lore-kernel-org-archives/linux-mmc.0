Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3851FA25A;
	Fri, 18 Oct 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243938; cv=none; b=QCEInhgnVT49X/oCxGkVE/OeFGspZ1Com5gnMbYZHERJEPJeqWEX6CF03aQ14u7pSj7j0DbnkbKU32aYhHoVBTc1ag60bAQ2uHg80jcYXJh0HLbbcxooYBHoB4OBax/UZ9G+FEPjihmY9AvGxour2OwC2cdwrcqpEENdEqIrF6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243938; c=relaxed/simple;
	bh=NRUNnP2mZXs2WNH4S9WNytayeFYHXzK5nj5USGUYSRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+GkHduDVppVH725H4FA5jc4d+k68+OP0UMop7+0rGOlsKIpXrgqos1TC/Eq6BrHoq9TPyAUH1UjHFJWl1Gb0kfYUuu0mOCO9Nv04K9i3Cdji/nFqS55cnLFKObMVXJOjpW5MpeE62nfWW8pINmHXDEmZ4ekfXRbvqfzpQR1ogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=qSEIkl/2; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="qSEIkl/2"
Received: from [192.168.178.76] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 76D792FC0050;
	Fri, 18 Oct 2024 11:31:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1729243925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RISW6pgFXjPBnkGM/1U0Ir7dOMl38aJw8Abj2tGkQQg=;
	b=qSEIkl/2jyct94EKLzHdZx747BT27ZNffQCo67zWlc81G3td5nrwEjYaMkreE5XIOG+yz+
	9oDxIeTp7BsN0kCWmQggUm4FOwm396m4P+grKvdYR2I7c8nzprMYL9Fs7Tzr6uHo8k0EgH
	S0KHaYexl5+51I+YLuj9TZgwd8nWRQo=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=ggo@tuxedocomputers.com
Message-ID: <5b72bde8-1084-4bf5-94a7-de5807302d96@tuxedocomputers.com>
Date: Fri, 18 Oct 2024 11:31:57 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FW: [RFC PATCH v2 1/1] mmc: sdhci-pci-gli: fix x86/S0ix SoCs
 suspend for GL9767
To: Victor Shih <victorshihgli@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, Greg.tu@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Ben Chuang <benchuanggli@gmail.com>, Lucas.Lai@genesyslogic.com.tw,
 =?UTF-8?B?VmljdG9yU2hpaFvmlr3li53mlodd?= <victor.shih@genesyslogic.com.tw>,
 cs@tuxedo.de, Georg Gottleuber <ggo@tuxedocomputers.com>
References: <41c1c88a-b2c9-4c05-863a-467785027f49@tuxedocomputers.com>
 <SI2PR01MB3916D4C2E36365A0CC2E128BA7472@SI2PR01MB3916.apcprd01.prod.exchangelabs.com>
 <CAK00qKCdKsdWbJ7DQRQX3RjSsd31PkinAUXt9fYtG+crx3G0Rg@mail.gmail.com>
Content-Language: en-US
From: Georg Gottleuber <ggo@tuxedocomputers.com>
In-Reply-To: <CAK00qKCdKsdWbJ7DQRQX3RjSsd31PkinAUXt9fYtG+crx3G0Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Victor,

Am 17.10.24 um 17:05 schrieb Victor Shih:
> Hi, Georg
> 
> I noticed that you mentioned in the patch for version 1 that the AMD
> platform is fine,
> may I ask that are AMD platforms and Intel platforms using the same
> kernel version?

yes, they use the same kernel version.

> If they are using the same kernel version, how do you confirm that
> the solution is to modify the kernel code?

I think the problem is similar to the one fixed by commit
1202d617e3d04c ("mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
SoCs can suspend") from Sven van Ashbrook.

Unfortunately, I only have two devices with GL9767. I don't know if it
really only affects Intel, but Sven van Ashbrook wrote in his commit:

"This prevents a large number of SoCs from suspending, notably x86
systems which commonly use S0ix as the suspend mechanism - for example,
Intel Alder Lake and Raptor Lake processors."

That sounds like AMD is implementing the suspend differently.

Additional experience / tests with GL9767 on Intel and AMD hardware
would be helpful.

Kind regards,

Georg


>> -----Original Message-----
>> From: Georg Gottleuber <ggo@tuxedocomputers.com>
>> Sent: Thursday, October 17, 2024 4:11 PM
>> To: Ben Chuang <benchuanggli@gmail.com>
>> Cc: Ben Chuang <benchuanggli@gmail.com>; adrian.hunter@intel.com; Ulf Hansson <ulf.hansson@linaro.org>; VictorShih[施勝文] <Victor.Shih@genesyslogic.com.tw>; LucasLai[賴宗清] <Lucas.Lai@genesyslogic.com.tw>; GregTu[杜啟軒] <Greg.Tu@genesyslogic.com.tw>; HLLiu[劉鴻霖] <HL.Liu@genesyslogic.com.tw>; cs@tuxedo.de; Georg Gottleuber <ggo@tuxedocomputers.com>; BenChuang[莊智量] <Ben.Chuang@genesyslogic.com.tw>; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [RFC PATCH v2 1/1] mmc: sdhci-pci-gli: fix x86/S0ix SoCs suspend for GL9767
>>
>> [Some people who received this message don't often get email from ggo@tuxedocomputers.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Adapt commit 1202d617e3d04c ("mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix SoCs can suspend") also for GL9767 card reader.
>>
>> This patch was written without specs or deeper knowledge of PCI sleep states. Tests show that S0ix is reached and lower power consumption when suspended (6 watts vs 1.2 watts for TUXEDO InfinityBook Pro Gen9 Intel).
>>
>> The function of the card reader appears to be OK.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219284
>> Fixes: f3a5b56c1286 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support")
>> Co-developed-by: Christoffer Sandberg <cs@tuxedo.de>
>> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>> ---
>> v1 -> v2:
>> - use gl9767_vhs_read() and gl9767_vhs_write()
>> - editorial changes to the commit message
>>
>>  drivers/mmc/host/sdhci-pci-gli.c | 61 +++++++++++++++++++++++++++++++-
>>  1 file changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c
>> b/drivers/mmc/host/sdhci-pci-gli.c
>> index 0f81586a19df..bdccd74bacd2 100644
>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>> @@ -1205,6 +1205,28 @@ static void
>> gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot,
>>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);  }
>>
>> +static void gl9767_set_low_power_negotiation(struct sdhci_pci_slot *slot,
>> +                                            bool enable) {
>> +       struct pci_dev *pdev = slot->chip->pdev;
>> +       u32 value;
>> +
>> +       gl9767_vhs_write(pdev);
>> +
>> +       pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
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
>> +       gl9767_vhs_read(pdev);
>> +}
>> +
>>  static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
>>                                         unsigned int timing)  { @@ -1470,6 +1492,42 @@ static int gl9763e_suspend(struct sdhci_pci_chip
>> *chip)
>>         gl9763e_set_low_power_negotiation(slot, false);
>>         return ret;
>>  }
>> +
>> +static int gl9767_resume(struct sdhci_pci_chip *chip) {
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
>> +static int gl9767_suspend(struct sdhci_pci_chip *chip) {
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
>>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot) @@ -1605,6 +1663,7 @@ const struct sdhci_pci_fixes sdhci_gl9767 = {
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
