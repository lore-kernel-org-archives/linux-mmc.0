Received: from us-smtp-delivery-195.mimecast.com (us-smtp-delivery-195.mimecast.com [170.10.129.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BFC745F9
	for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214980; cv=none; b=QAKP8v4G08Z3jLzpa5UWjUVFLxCKNBqtbp6nwRS123ecImIsroV8QirUU3q5ix0MEG5EOwjvzzd3ytyPGJZ7r0a//VeVr7OzB61AcS9bD4cKolH4nz/jXfWz2s333IVlU5o+38YjK4x6wE0hz3bharJuLhPL+Xd620Lvpyfz9FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214980; c=relaxed/simple;
	bh=0XQtDm61nEWRjPhOME01CDkA4Zyj9StQqWszUPp+8ws=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DAyA5trttibz171Z4LoVUp+b89J7WB+WJMni4UTpaYAQGFvdsJh1HJX0e4SHYFv6CgV4LpAhQ6XA4a4lGuXYe0ijxhnLXfGN4O9fA1l0qVJJGTZhp1YBtKcS2FnKSFqI03o4CuhaU5NiY1rn/FByWXT3AqDkHpTk3NQ68lyj/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mbari.org; spf=pass smtp.mailfrom=mbari.org; arc=none smtp.client-ip=170.10.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mbari.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbari.org
Received: from sleet.shore.mbari.org (sleet.shore.mbari.org [134.89.12.10])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-4M4DQKSEPha-a36yQO2r1w-1; Thu,
 25 Jan 2024 15:36:15 -0500
X-MC-Unique: 4M4DQKSEPha-a36yQO2r1w-1
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id C54A381077A50;
	Thu, 25 Jan 2024 12:36:13 -0800 (PST)
X-Virus-Scanned: amavis at sleet.shore.mbari.org
Received: from sleet.shore.mbari.org ([127.0.0.1])
 by localhost (sleet.shore.mbari.org [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 9bwDME-Sv8hS; Thu, 25 Jan 2024 12:36:13 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by sleet.shore.mbari.org (Postfix) with ESMTP id AE2468106024F;
	Thu, 25 Jan 2024 12:36:13 -0800 (PST)
Received: from [192.168.6.194] (raven.shore.mbari.org [134.89.10.221])
	by sleet.shore.mbari.org (Postfix) with ESMTPSA;
	Thu, 25 Jan 2024 12:36:13 -0800 (PST)
Subject: Re: Regression in sdhci-pci-o2micro.c
To: "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, "Fred Ai(WH)" <fred.ai@bayhubtech.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <890a5a17-5ebf-4d59-c71f-a5e37a601cbd@mbari.org>
 <CAPDyKFqsRounzo1Ns0dDdCS9Qu0doq82ivYwEUNWgOiMtDS0Xg@mail.gmail.com>
 <DM4PR16MB50049CE307E3B479D80EFD95EA712@DM4PR16MB5004.namprd16.prod.outlook.com>
 <DM4PR16MB50041AB09DA48C7FB8C41C57EA712@DM4PR16MB5004.namprd16.prod.outlook.com>
 <DM4PR16MB50042D4CCB7AF6715F9AEBEFEA7A2@DM4PR16MB5004.namprd16.prod.outlook.com>
From: Brent Roman <brent@mbari.org>
Organization: MBARI
Message-ID: <a26809ca-0160-a03c-0aac-b2b772070fe7@mbari.org>
Date: Thu, 25 Jan 2024 12:36:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:46.0) Gecko/20100101 Firefox/46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DM4PR16MB50042D4CCB7AF6715F9AEBEFEA7A2@DM4PR16MB5004.namprd16.prod.outlook.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mbari.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello Chevron,

Ignoring the errors at the probe stage will get the driver working as=20
well as it did before kernel version 5.12, however, it is still incorrect.
Because, if the read errors are ignored, the values returned in the=20
"scratch_32" variable will be invalid.
Those invalid values are then used to compute a mask that written back=20
to the chip's O2_SD_PLL_SETTING register.

Would it be possible to power the chip at the start of the probe call,=20
so its registers could be properly read?

Alternatively, could one delay the configuration of these registers=20
until after the chip had been properly powered?
(Could one turn on the power in probe, delaying the rest of the=20
initialization until after power had stabilized?)

Note that even when this driver functioned, it required

debug_quirks2=3D4

to disable ultra high-speed support.

Also, note that the PCI_DEVICE_ID_O2_SDS0, SDS1 and FUJIN2
cases of the probe function in version 5.10 ignored the results form readin=
g O2_SD_FUNC_REG0 and O2_SD_FUNC_REG4.
I don't have those chip types to test, but I must assume the results, in th=
ese cases, were ignored for similar reasons.

- brent

Chevron Li (WH) wrote:
> Hi, Ulf/Adrian,
>
> Sorry for response late.
>
> After checked some documents internal, we think it's necessary to regress=
ion "mmc: sdhci-pci-o2micro: Add missing checks in sdhci_pci_o2_probe" in s=
dhci-pci-o2micro.c .
> Below is the reason:
> Some chip of this hardware(O2_SEABIRD0/O2_SEABIRD1) main power may be not=
 ready when access it at driver probe stage.
> So, the pci_read_config_dword() calls errors should be ignored at probe s=
tage.
>
> BR,
> Chevron
>
> -----Original Message-----
> From: Chevron Li (WH)
> Sent: Thursday, January 18, 2024 16:53
> To: 'Ulf Hansson' <ulf.hansson@linaro.org>; 'Brent Roman' <brent@mbari.or=
g>; Fred Ai(WH) <fred.ai@bayhubtech.com>
> Cc: 'linux-mmc@vger.kernel.org' <linux-mmc@vger.kernel.org>; 'Adrian Hunt=
er' <adrian.hunter@intel.com>
> Subject: RE: Regression in sdhci-pci-o2micro.c
>
> Hi, Ulf/Adrian,
>
> Please ignore former email.
> I confused it with another issue.
>
> I agree Regression "mmc: sdhci-pci-o2micro: Add missing checks in sdhci_p=
ci_o2_probe" in sdhci-pci-o2micro.c
>
> For the issue Brent reported, we will check it internal first.
>
> BR,
> Chevron
>
> -----Original Message-----
> From: Chevron Li (WH)
> Sent: Thursday, January 18, 2024 11:53
> To: Ulf Hansson <ulf.hansson@linaro.org>; Brent Roman <brent@mbari.org>; =
Fred Ai(WH) <fred.ai@bayhubtech.com>
> Cc: linux-mmc@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>
> Subject: RE: Regression in sdhci-pci-o2micro.c
>
> Hi, Ulf/Adrian,
>
> We tried to implement the "remove_slot" at "sdhci_pci_fixes" and recover =
some changed PCR configure value for next reboot at BIOS stage.
> But I'm not sure that the added patch in "remove_slot" will be called whe=
n OS reboot.
> If there are callback for o2micro host driver when OS reboot.
>
> Attachment is a sample code which implemented the "remove_slot" at "sdhci=
_pci_fixes".
>
> Any suggestions will be appreciated.
>
> BR,
> Chevron
>
> -----Original Message-----
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Wednesday, January 17, 2024 20:18
> To: Brent Roman <brent@mbari.org>; Chevron Li (WH) <chevron.li@bayhubtech=
.com>; Fred Ai(WH) <fred.ai@bayhubtech.com>
> Cc: linux-mmc@vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>
> Subject: Re: Regression in sdhci-pci-o2micro.c
>
> + Fred, Chevron Li, Adrian
>
> On Tue, 16 Jan 2024 at 23:18, Brent Roman <brent@mbari.org> wrote:
>> Hi,
>>
>> I have an Intel Hades Canyon NUC (NUC8i7HVK) whose O2 Micro based
>> SD-Card reader is no longer identified when its Linux kernel is
>> updated past 5.12
>>
>> I "fixed" this by reverting a change from 5/9/21  (git
>> efc58a96adcd29cc37487a60582d9d08b34f6640)
>> that inserted proper error checking after all the PCI config space
>> reads in the device probe.
>> This would be code removed enclosed in #if 0 below:
>>
>>       case PCI_DEVICE_ID_O2_SEABIRD0:
>>       case PCI_DEVICE_ID_O2_SEABIRD1:
>>           /* UnLock WP */
>>           ret =3D pci_read_config_byte(chip->pdev,
>>                   O2_SD_LOCK_WP, &scratch);
>>           if (ret)
>>               return ret;
>>
>>           scratch &=3D 0x7f;
>>           pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>>
>>           ret =3D pci_read_config_dword(chip->pdev,
>>                           O2_SD_PLL_SETTING, &scratch_32); #if 0
>>           if (ret)
>>               return ret;
>> #endif
>>
>>           if ((scratch_32 & 0xff000000) =3D=3D 0x01000000) {
>>               scratch_32 &=3D 0x0000FFFF;
>>               scratch_32 |=3D 0x1F340000;
>>
>>               pci_write_config_dword(chip->pdev,
>>                              O2_SD_PLL_SETTING, scratch_32);
>>           } else {
>>               scratch_32 &=3D 0x0000FFFF;
>>               scratch_32 |=3D 0x25100000;
>>
>>               pci_write_config_dword(chip->pdev,
>>                              O2_SD_PLL_SETTING, scratch_32);
>>
>>               ret =3D pci_read_config_dword(chip->pdev,
>>                               O2_SD_FUNC_REG4,
>>                               &scratch_32); #if 0
>>               if (ret)
>>                   return ret;
>> #endif
>>               scratch_32 |=3D (1 << 22);
>>               pci_write_config_dword(chip->pdev,
>>                              O2_SD_FUNC_REG4, scratch_32);
>>           }
>>
>> Both those pci_read_config_dword() calls return -EINVAL on my machine.
>> The driver had been working earlier precisely because it was ignoring
>> these error returns from pci_read_config_dword.
>> Have you seen this behavior before on any other hardware?
>>
>> The SDcard reader identifies as:
>> 03:00.0 SD Host controller: O2 Micro, Inc. SD/MMC Card Reader
>> Controller (rev 01)
>> 03:00.0 0805: 1217:8621 (rev 01)
>>
>> I've been unable to find /any/ information on this chip.
>> Do you have any you could share?  A datasheet would be ideal :-)
>>
>> Also:
>> I've always had to operate this driver with debug_quirks2=3D4 to disable
>> ultra high-speed support.
>> Is this a known issue?
>> Or, could it be a symptom of the failing pci_read_configs curing probe?
>>
>> Thanks for your attention,
> Looks like the offending commit efc58a96adcd ("mmc: sdhci-pci-o2micro:
> Add missing checks in sdhci_pci_o2_probe"), may not have been thoroughly =
tested. Perhaps a revert is needed.
>
> Let's see if Fred/Chevron Li has some thoughts around this.
>
> Kind regards
> Uffe


--=20
  Brent Roman                                   MBARI
  Software Engineer               Tel: (831) 775-1808
  mailto:brent@mbari.org  http://www.mbari.org/~brent

