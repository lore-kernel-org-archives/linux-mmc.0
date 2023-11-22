Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hC1Y6Q11"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DF098;
	Tue, 21 Nov 2023 21:53:44 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AM5rXcu068166;
	Tue, 21 Nov 2023 23:53:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1700632413;
	bh=jb1vLiMYPsOH9+E4K2SmeXPXHHJZ+WhX12z4JbrVx9s=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hC1Y6Q11uZmmxIq9vL9ddpkaFJfBA/z8/mdE6caiWSAEhXMRgFaOQeejKxowsiUgs
	 bwBHN+Ry+VB+cFVMdZ3N6lWxQQ1buJqkfIg0nQjJ8mBYDokGq5FdzKp7pmREVm3OzC
	 zKb3evTIhBSFpa5PbN01Z2haWAtFZtNvY5mD/pPI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AM5rXwD008142
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Nov 2023 23:53:33 -0600
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 Nov 2023 23:53:33 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 23:53:33 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 Nov 2023 23:53:32 -0600
Received: from [172.24.227.94] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AM5rT2x113793;
	Tue, 21 Nov 2023 23:53:30 -0600
Message-ID: <f9d4946e-f5f1-4fb7-adab-eaf624ce838c@ti.com>
Date: Wed, 22 Nov 2023 11:23:29 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci_am654: Drop lookup for deprecated
 ti,otap-del-sel
Content-Language: en-US
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>
References: <20231110072535.2695134-1-vigneshr@ti.com>
 <4bf2e094-622c-4da2-ac46-994acb580bcf@intel.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <4bf2e094-622c-4da2-ac46-994acb580bcf@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 20/11/23 17:38, Adrian Hunter wrote:
> On 10/11/23 09:25, Vignesh Raghavendra wrote:
>> ti,otap-del-sel has been deprecated since v5.7 and there are no users of
>> this property and no documentation in the DT bindings either.
>> Drop the fallback code looking for this property, this makes
>> sdhci_am654_get_otap_delay() much easier to read as all the TAP values
>> can be handled via a single iterator loop.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> 
> One minor comment below, otherwise:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
>> ---
>>
>> Based on discussions at [1]
>> https://lore.kernel.org/linux-mmc/CAPDyKFrCSTW3G6H7qS89d+UQ6RJcAYcKSPULVT8J7XKsUDpHdw@mail.gmail.com/
>>
>> CC'ing DT maintainers to see if there any objection to remove
>> undocumented and deprecated property.
>>
>>  drivers/mmc/host/sdhci_am654.c | 25 ++++---------------------
>>  1 file changed, 4 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index 967bd2dfcda1..402fba0fa418 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -577,32 +577,15 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
>>  	int i;
>>  	int ret;
>>  
>> -	ret = device_property_read_u32(dev, td[MMC_TIMING_LEGACY].otap_binding,
>> -				 &sdhci_am654->otap_del_sel[MMC_TIMING_LEGACY]);
>> -	if (ret) {
>> -		/*
>> -		 * ti,otap-del-sel-legacy is mandatory, look for old binding
>> -		 * if not found.
>> -		 */
>> -		ret = device_property_read_u32(dev, "ti,otap-del-sel",
>> -					       &sdhci_am654->otap_del_sel[0]);
>> -		if (ret) {
>> -			dev_err(dev, "Couldn't find otap-del-sel\n");
>> -
>> -			return ret;
>> -		}
>> -
>> -		dev_info(dev, "Using legacy binding ti,otap-del-sel\n");
>> -		sdhci_am654->legacy_otapdly = true;
> 
> With this removal, legacy_otapdly is not used anymore and should be
> removed also.
> 

Indeed, will post v2 with cleanup. Thanks for the review!

>> -
>> -		return 0;
>> -	}
>> -
>>  	for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
>>  
>>  		ret = device_property_read_u32(dev, td[i].otap_binding,
>>  					       &sdhci_am654->otap_del_sel[i]);
>>  		if (ret) {
>> +			if (i == MMC_TIMING_LEGACY) {
>> +				dev_err(dev, "Couldn't find mandatory ti,otap-del-sel-legacy\n");
>> +				return ret;
>> +			}
>>  			dev_dbg(dev, "Couldn't find %s\n",
>>  				td[i].otap_binding);
>>  			/*
> 

-- 
Regards
Vignesh
