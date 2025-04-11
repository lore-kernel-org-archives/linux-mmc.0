Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B42C80;
	Fri, 11 Apr 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389447; cv=none; b=nQusmb1ESYZiCydLPg4e96uWyB2xDc+/VjvEYPuVAtFHgXlBp5SFHzh2Qr8XAbHgqUWOcGqBWAP60loAo8FtCp2rQX08gzm6tA9gdjr0SX+vGgDvCIrlk9fwjoBF1b4DLwd34p+a8SH0KuY2qxKxVruclCcMUNP846eIvK+e9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389447; c=relaxed/simple;
	bh=vqp5CsnV+rglOXpB6XFlooK5viCKyZFEWdWLAt4mliU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=keJqrxkTwwExYmjVc8a/L51L2KY3nUqtcDTLt4i7OO4Kz1qOdG1zss3hbgYfePnOlBUs+gR+nh1yqIZJ4ys5lhLZjEHayyI+Qy8gOpRuV8hEvcLV+Pi1xj6vt92F6VqJ2IZTjyx7IUT71coKhUMwMxvqR+DYdZrJ05uX6jVjQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pjvAb7+t; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pjvAb7+t"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BGbEu72132599
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 11:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744389434;
	bh=zEY3saqSW+B+k6v2/j1i9iwfie/PlUcC0MXMz82zNSc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=pjvAb7+t/qf0rurFFJz7ofu3UEADgyDx3obJ9JAVRp69U3AH9tpcvC/9C1K0/Amuy
	 t4wCTU+Bx6ZsrYsZEFZV0Mm+ePbN8Ch+iVxpRDFrr7znjWN5LR2yVzu/ZNJXJXWLaw
	 YLtgfMDiStGvIosdLhKy9mAEVWXQadDx4maKYV6w=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BGbEdt014354
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 11:37:14 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 11:37:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 11:37:14 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BGbECu066109;
	Fri, 11 Apr 2025 11:37:14 -0500
Message-ID: <d8e45e50-f0eb-41d0-9c50-56147eaf262a@ti.com>
Date: Fri, 11 Apr 2025 11:37:14 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
To: Hiago De Franco <hiagofranco@gmail.com>, Josua Mayer <josua@solid-run.com>
CC: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Moteen Shah <m-shah@ti.com>,
        Hiago De Franco
	<hiago.franco@toradex.com>
References: <20250407222702.2199047-1-jm@ti.com>
 <20250411130354.dc3sv3e7ruekkhkp@hiago-nb>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250411130354.dc3sv3e7ruekkhkp@hiago-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Hiago,

On 4/11/25 8:03 AM, Hiago De Franco wrote:
> Hi Judith,
> 
> On Mon, Apr 07, 2025 at 05:27:00PM -0500, Judith Mendez wrote:
>> For all TI devices, timing was closed For Legacy and HS modes in
>> half cycle timing, where data is launched on the negative edge of
>> clock and latched on the following positive edge of clock. The
>> switch to full cycle timing happens when any of HIGH_SPEED_ENA,
>> V1P8_SIGNAL_ENA, or UHS_MODE_SELECT is set.
>>
>> Currently HIGH_SPEED_ENA is set for HS modes and violates timing
>> requirements for TI devices so add a .set_hs_ena callback in
>> sdhci_am654 driver so that HIGH_SPEED_ENA is not set for this mode.
>>
>> There are eMMC boot failures seen with V1P8_SIGNAL_ENA with a
>> specific Kingston eMMC due to the sequencing when enumerating to
>> HS200 mode. Since V1P8_SIGNAL_ENA is optional for eMMC, do not
>> set V1P8_SIGNAL_ENA be default. This fix was previously merged in
>> the kernel, but was reverted due to the "heuristics for enabling
>> the quirk"[0]. The new implementation applies the quirk based-off of
>> bus width, which should not be an issue since there is no internal
>> LDO for MMC0 8bit wide interface and hence V1P8_SIGNAL_ENA should only
>> effect timing for MMC0 interface.
>>
>> [0] https://lore.kernel.org/linux-mmc/20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com/
>>
>> Judith Mendez (2):
>>    PENDING: mmc: sdhci*: Add set_hs_ena to sdhci_ops
>>    mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch
>>
>>   drivers/mmc/host/sdhci.c       | 55 +++++++++++++++++++++-------------
>>   drivers/mmc/host/sdhci.h       |  2 ++
>>   drivers/mmc/host/sdhci_am654.c | 48 +++++++++++++++++++++++++++++
>>   3 files changed, 85 insertions(+), 20 deletions(-)
>>
>> -- 
>> 2.49.0
>>
> 
> Thanks for the patches. We are currently experiencing this issue on the
> AM62 Solo SoC (hardware: Toradex Verdin AM62 Solo 512 MB), with the
> latest kernel 6.15-rc1. I tested your patches (added both on top of
> 6.15-rc1) and I can still see the issue, when the kernel boots:
> 
> root@verdin-am62-15412807:~# dmesg | grep -i mmc1
> [    1.912123] mmc1: CQHCI version 5.10
> [    1.985262] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
> [    2.186954] mmc1: error -110 whilst initialising SD card
> [    2.620625] mmc1: error -110 whilst initialising SD card
> [    2.997642] mmc1: error -110 whilst initialising SD card
> [    3.337071] mmc1: error -110 whilst initialising SD card
> 
> This does not happen if I use commit 941a7abd4666 ("mmc: sdhci_am654:
> Add sdhci_am654_start_signal_voltage_switch"), as you described.
> 
> Is there anything I missing or should test to make it work?

The reason that patches fixes SD init for you is because in original 
patch, quirk was applied for both SD and eMMC with the exception of SD 
for am64x SoC. This patch only applies the quirk for eMMC.

We cannot use the original implementation because the logic applying the 
quirk is based off of vmmc/vqmmc nodes in DT. The assumption was that 
am64x based boards will only have vmmc node since there is an internal 
LDO that is used to switch IO signal voltage instead of vqmmc. However, 
SolidRun HimmingBoard-T board has a different implementation on voltage 
regulator nodes in DT and the quirk applied to them as well and breaks 
their SD boot. So we now only apply the quirk for eMMC. Without this 
quirk applied to SD, am62x SD will continue having some stability issues.

~ Judith








