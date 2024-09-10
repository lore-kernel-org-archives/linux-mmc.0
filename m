Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A22AE69;
	Tue, 10 Sep 2024 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978613; cv=none; b=R2yXaOu9IqlDZMHnXZ1POF0YpKj7b0Y5tly54YWyzT5/Y/oWtl8hrF4n6hKuqODLPWAXxIsdrR00OG010rEMzOuaglQANRcYaR3mOskHwe+5WdDK0tje5sAE0R3pcZIFTwhO0POAXRG9GHmFugtpmIyPasG/dtaUTpIGebQSou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978613; c=relaxed/simple;
	bh=nyP8gGIqz1HNCKQ43YMfbuFv0X2uU9OB/eHjvDX9cNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UZR+j4hV/mupQgKwl70UCHIqdVwFFhLFKmixlMmsKaeemk9xxwaXuDpUxQ5qpdWixce5ZJaA9cJ+qLl7PTsPBM6TY07zjVv0GbRzB4HACLgGb6JHYLhbkWVRqnG0n7E+5WWg1ti/5aKaA6g9woX5xR1K3XIt6H2QmMAcquatHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uVt8KKIr; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uVt8KKIr"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48AEU7Cs045589;
	Tue, 10 Sep 2024 09:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725978607;
	bh=61eYwKRhuRqQS3ULiocJSrEz/fWsMwjqarfdzK+H2aM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uVt8KKIrgReB1VvmcksWAXNsY82w42Wbr7S6Zq1MeoRTiks53Q+Vab+SdNaGoPqCr
	 KXK4JeyTkBDG8xGCXGoN5LhVDPKZhHmff6l6j/xMX87Oiuuaa/ZwOJDZwgkR3TWvq+
	 gOu8rJlyEBe3oiShYYrf0KXm2MIt5BaDjftkOgJQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48AEU7cn125891;
	Tue, 10 Sep 2024 09:30:07 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 09:30:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 09:30:07 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48AEU7Xm052787;
	Tue, 10 Sep 2024 09:30:07 -0500
Message-ID: <cce6ec2f-3293-4f08-a965-76dece0ddfab@ti.com>
Date: Tue, 10 Sep 2024 09:30:07 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240906175032.1580281-1-jm@ti.com>
 <068093ed-1ab5-40d6-b709-cd6810825ba3@intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <068093ed-1ab5-40d6-b709-cd6810825ba3@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Adrian,

On 9/9/24 1:26 AM, Adrian Hunter wrote:
> On 6/09/24 20:50, Judith Mendez wrote:
>> The sdhci_start_signal_voltage_switch function sets
>> V1P8_SIGNAL_ENA by default after switching to 1v8 signaling.
>> V1P8_SIGNAL_ENA determines whether to launch cmd/data on neg
>> edge or pos edge of clock.
>>
>> Due to some eMMC and SD failures seen across am62x platform,
>> do not set V1P8_SIGNAL_ENA by default, only enable the bit
>> for devices that require this bit in order to switch to 1v8
>> voltage for uhs modes.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 86 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 86 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index 0aa3c40ea6ed8..fb6232e56606b 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -155,6 +155,7 @@ struct sdhci_am654_data {
>>   	u32 tuning_loop;
>>   
>>   #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>> +#define SDHCI_AM654_QUIRK_SET_V1P8_ENA BIT(1)
> 
> It would be better for the quirk to represent the deviation
> from normal i.e.
> 
> #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
> 
>>   };
>>   
>>   struct window {
>> @@ -356,6 +357,79 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>>   	sdhci_set_clock(host, clock);
>>   }
>>   
>> +int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc,
>> +					    struct mmc_ios *ios)
> 
> Simpler to call sdhci_start_signal_voltage_switch() for the normal
> case e.g.

This is simpler, so sure will use thanks.

> 
> static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> {
> 	struct sdhci_host *host = mmc_priv(mmc);
> 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> 
> 
> 	if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
> 	    ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> 		ret = mmc_regulator_set_vqmmc(mmc, ios);
> 		if (ret < 0) {
> 			pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
> 				mmc_hostname(mmc));
> 			return -EIO;
> 		}
> 		return 0;
> 	}
> 
> 	return sdhci_start_signal_voltage_switch(mmc, ios);
> }
> 
>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>> +	u16 ctrl;
>> +	int ret;
>> +
>> +	if (host->version < SDHCI_SPEC_300)
>> +		return 0;
>> +
>> +	switch (ios->signal_voltage) {
>> +	case MMC_SIGNAL_VOLTAGE_330:
>> +		if (!(host->flags & SDHCI_SIGNALING_330))
>> +			return -EINVAL;
>> +
>> +		ctrl &= ~SDHCI_CTRL_VDD_180;
>> +		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>> +
>> +		if (!IS_ERR(mmc->supply.vqmmc)) {
>> +			ret = mmc_regulator_set_vqmmc(mmc, ios);
>> +			if (ret < 0) {
>> +				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
>> +					mmc_hostname(mmc));
>> +				return -EIO;
>> +			}
>> +		}
>> +
>> +		usleep_range(5000, 5500);
>> +
>> +		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +		if (!(ctrl & SDHCI_CTRL_VDD_180))
>> +			return 0;
>> +
>> +		pr_warn("%s: 3.3V regulator output did not become stable\n",
>> +			mmc_hostname(mmc));
>> +
>> +		return -EAGAIN;
>> +
>> +	case MMC_SIGNAL_VOLTAGE_180:
>> +		if (!(host->flags & SDHCI_SIGNALING_180))
>> +			return -EINVAL;
>> +
>> +		if (!IS_ERR(mmc->supply.vqmmc)) {
>> +			ret = mmc_regulator_set_vqmmc(mmc, ios);
>> +			if (ret < 0) {
>> +				pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
>> +					mmc_hostname(mmc));
>> +				return -EIO;
>> +			}
>> +		}
>> +
>> +		if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_SET_V1P8_ENA) {
>> +			ctrl |= SDHCI_CTRL_VDD_180;
>> +			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>> +
>> +			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> +			if (ctrl & SDHCI_CTRL_VDD_180)
>> +				return 0;
>> +
>> +			pr_warn("%s: 1.8V regulator output did not become stable\n",
>> +				mmc_hostname(mmc));
>> +
>> +			return -EAGAIN;
>> +		}
>> +		return 0;
>> +
>> +	default:
>> +		return 0;
>> +	}
>> +}
>> +
>>   static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
>>   {
>>   	writeb(val, host->ioaddr + reg);
>> @@ -801,6 +875,8 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>>   					struct sdhci_am654_data *sdhci_am654)
>>   {
>>   	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct device_node *node;
>>   	int drv_strength;
>>   	int ret;
>>   
>> @@ -844,6 +920,15 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>>   	if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
>>   		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
>>   
>> +	node = of_parse_phandle(np, "vmmc-supply", 0);
>> +
>> +	if (node) {
>> +		node = of_parse_phandle(np, "vqmmc-supply", 0);
>> +
>> +		if (!node)
>> +			sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SET_V1P8_ENA;
>> +	}
> 
> It would be simpler without 'np' and 'node'.  Not sure
> what the rule is meant to be, but it could be something like:
> 
> 	if (of_parse_phandle(dev->of_node, "vmmc-supply", 0) &&
> 	    of_parse_phandle(dev->of_node, "vqmmc-supply", 0)
> 		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;

My issue with this is that I also need the quirk 
(SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) for eMMC. DT node for eMMC does
not include vmmc and vqmmc supplies. That is why I had the quirk logic
inverted.

This patch fixes timing issues with both eMMC and SD. (:

~ Judith


> 
>> +
>>   	sdhci_get_of_property(pdev);
>>   
>>   	return 0;
>> @@ -940,6 +1025,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>>   		goto err_pltfm_free;
>>   	}
>>   
>> +	host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>>   	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>>   
>>   	pm_runtime_get_noresume(dev);
>>
>> base-commit: cf6444ba528f043398b112ac36e041a4d8685cb1
> 
> 

