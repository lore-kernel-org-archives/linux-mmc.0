Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEAD202C50;
	Fri, 11 Apr 2025 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744408551; cv=none; b=SGa71A9dTqmuRjQVRzkYoMscyJSvIBBgUeb5OySMbESo6PCq8VK5kyPzFOieQJ46W0Q6Fk4y6bW2uxTn2sLnUP2YQWDLPR8pqOiTbAsKqa61zE2B5eYd2LJlELIZPySEr0nSh/GHmS3Q/jgNWQhzJK3XyEJUWzPcwucRTGT4ysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744408551; c=relaxed/simple;
	bh=7zzgHuOIC2U8JzosNjyDA6dKxu+qBHRi4JPoRSmT0FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qf5/j76a1KWK0x+1IDgYTzV9qe5LfxpVqsJk30cJEHSfaXmZ1eSi362TTycnFUubGeDbwHVe/O7FgzqRf7y/D13+uDDMp+r8qRIuyVWud7AlLhc2vCNSXbUwAIRFJHHwwFzMngbAsNSttO0iiqtv3oG2Bc4rmuUtpcH+td40Zyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kvzfUy2H; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kvzfUy2H"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BLtd321671044
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 16:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744408539;
	bh=fIAqjnlgAjGFVtKWkUlkUIQ4jDIS6e+nd/Af9aU92ss=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=kvzfUy2HmLWCuvStJcT2FvB2QcoBUtpuFHZnfYdPfIgRNO+K8OblDX5RysxO2sl5R
	 hCJOtcWJjviIo7H9rZmL2DZYLfhSLe7+U5QZZEx004SqFvcBWk9y6T9Lnd6Q7repyT
	 gNnk6i0sgyNCeG3XGmzPLzzdF2SQ2keSjEva5hms=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BLtdxi029694
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 16:55:39 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 16:55:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 16:55:39 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BLtdXB043549;
	Fri, 11 Apr 2025 16:55:39 -0500
Message-ID: <5f36ec5d-bb31-4b6c-aa4e-4ec48cb1d067@ti.com>
Date: Fri, 11 Apr 2025 16:55:39 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
To: Hiago De Franco <hiagofranco@gmail.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Josua Mayer <josua@solid-run.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Moteen Shah
	<m-shah@ti.com>,
        Hiago De Franco <hiago.franco@toradex.com>
References: <20250407222702.2199047-1-jm@ti.com>
 <20250411130354.dc3sv3e7ruekkhkp@hiago-nb>
 <d8e45e50-f0eb-41d0-9c50-56147eaf262a@ti.com>
 <20250411194813.c4ft2uxgdiuza5cm@hiago-nb>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250411194813.c4ft2uxgdiuza5cm@hiago-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Hilago,


On 4/11/25 2:48 PM, Hiago De Franco wrote:
> On Fri, Apr 11, 2025 at 11:37:14AM -0500, Judith Mendez wrote:
>>
>> The reason that patches fixes SD init for you is because in original patch,
>> quirk was applied for both SD and eMMC with the exception of SD for am64x
>> SoC. This patch only applies the quirk for eMMC.
>>
>> We cannot use the original implementation because the logic applying the
>> quirk is based off of vmmc/vqmmc nodes in DT. The assumption was that am64x
>> based boards will only have vmmc node since there is an internal LDO that is
>> used to switch IO signal voltage instead of vqmmc. However, SolidRun
>> HimmingBoard-T board has a different implementation on voltage regulator
>> nodes in DT and the quirk applied to them as well and breaks their SD boot.
>> So we now only apply the quirk for eMMC. Without this quirk applied to SD,
>> am62x SD will continue having some stability issues.
>>
>> ~ Judith
> 
> I got the idea now, thanks for the explanation, I missed in the original
> patches this was only about the eMMC and *not* the SD card. Is there any
> plans to send patches to the SD card as well?
> 
> About that, I was wondering if instead of checking the bus_width to
> apply the fix for the eMMC, we could set a devicetree property to
> explicity apply the quirk. This way, we could also decide to apply it on
> the SD node without checking any bus width. As example:
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> index 1ea8f64b1b3b..c4423c09e809 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> @@ -1466,6 +1466,7 @@ &sdhci1 {
>   	vmmc-supply = <&reg_sdhc1_vmmc>;
>   	vqmmc-supply = <&reg_sdhc1_vqmmc>;
>   	ti,fails-without-test-cd;
> +	ti,suppress-v1p8-ena;
>   	status = "disabled";
>   };
>   
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 4e1156a2f1b8..a0485c2bb549 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -87,7 +87,6 @@
>   #define CLOCK_TOO_SLOW_HZ	50000000
>   #define SDHCI_AM654_AUTOSUSPEND_DELAY	-1
>   #define RETRY_TUNING_MAX	10
> -#define BUS_WIDTH_8		8
>   
>   /* Command Queue Host Controller Interface Base address */
>   #define SDHCI_AM654_CQE_BASE_ADDR 0x200
> @@ -844,7 +843,6 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>   	struct device *dev = &pdev->dev;
>   	int drv_strength;
>   	int ret;
> -	u32 bus_width;
>   
>   	if (sdhci_am654->flags & DLL_PRESENT) {
>   		ret = device_property_read_u32(dev, "ti,trm-icp",
> @@ -886,9 +884,11 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>   	if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
>   		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
>   
> -	/* Suppress V1P8_SIGNAL_ENA for eMMC */
> -	device_property_read_u32(dev, "bus-width", &bus_width);
> -	if (bus_width == BUS_WIDTH_8)
> +	/*
> +	 * Suppress V1P8_SIGNAL_ENA for MMC devices if ti,suppress-v1p8-ena
> +	 * flag is present.
> +	 */
> +	if (device_property_read_bool(dev, "ti,suppress-v1p8-ena"))
>   		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
>   
>   	sdhci_get_of_property(pdev);
> 
> Which makes our Kingston SD card work again:
> 
> root@verdin-am62-15412807:~# dmesg | grep -i mmc1
> [    1.897055] mmc1: CQHCI version 5.10
> [    2.043673] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
> [    2.260610] mmc1: new UHS-I speed SDR104 SDHC card at address 0001
> [    2.268150] mmcblk1: mmc1:0001 SD32G 29.1 GiB
> 
> Sorry if I missed something, would also be a valid solution?

Actually this was one of the previous implementations, I should have 
that original patch somewhere. My understanding was that we do not like 
adding new DT properties if we can find a way to apply the quirk in the 
driver.

If this implementation flies with the maintainers, then we can go back 
to DT property implementation.

Adrian, is this fine with you?

~ Judith






