Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A921DE89B;
	Tue, 19 Aug 2025 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610292; cv=none; b=dfzCs0g6aeC61dBSzUBJDm+aDdFvxVKubanorJbL6sdwYdQoNhAPG8HAwt7YaZ95tO+s3Cp3o2FSzm4IiczxYBVMvyF7uRATtQh5omGsH453yaB7us/P2IdMevdO4tglvRB0R3y/VSH+DpfFluI8+auqYL8DlTBvE4DQudy6PQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610292; c=relaxed/simple;
	bh=gR18zS4owt4HOkCTR/xNYwgtLSf5JSfCKDWnpcuiP5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K4IN5mh4usjpe6p7Gre64Pnkxiu0RbMgGFFtLx5MOy+4+yPngAyAuL/XAZXyaMm0Di0B5r5OHV1F0HUM399k+NwHPR/9dlo0Gc2gcRO3Ys8Qdnh7JJioQTPsVSS3K7orlvcsjS0FCepbqL1wbvWIS3XyhX7saObm0DKraZs1dkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OYPisXjS; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OYPisXjS"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JDVReI018494;
	Tue, 19 Aug 2025 08:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755610287;
	bh=uKBtW1UW9cAj+sxoYEZZm7F2EmhL3dhdTImqEhRoVUA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OYPisXjSyK1Q8KpuzUXTqG8VYa/9HkxV8UXeZe3AnIikB7nSNFJcbBU60ejVPqd1v
	 EiXWVBjonsxEVkJTr0fnYUU2tcoLUcT8GW6aU83eWUh7oF+niuIPJdgRhelRUPTo6Z
	 8tybdOV1g/yUjT32ih6tPoeTGwQVYkNlp79fFbCE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JDVRqv1070391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 08:31:27 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 08:31:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 08:31:26 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JDVQfn3061735;
	Tue, 19 Aug 2025 08:31:26 -0500
Message-ID: <202def9b-b9f2-4be1-a21c-6ba9e442d0f5@ti.com>
Date: Tue, 19 Aug 2025 08:31:26 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and
 SR1.1
To: Adrian Hunter <adrian.hunter@intel.com>, Andrew Davis <afd@ti.com>,
        Ulf
 Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250818203310.3066985-1-jm@ti.com>
 <f07d0353-4103-4776-a303-f6a3aad5bf15@ti.com>
 <f117bc05-893f-4c89-8cb7-3f40a8bfb92d@intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <f117bc05-893f-4c89-8cb7-3f40a8bfb92d@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/19/25 8:21 AM, Adrian Hunter wrote:
> On 18/08/2025 23:38, Andrew Davis wrote:
>> On 8/18/25 3:33 PM, Judith Mendez wrote:
>>> This adds SDHCI_AM654_QUIRK_DISABLE_HS400 quirk which shall be used
>>> to disable HS400 support. AM62P SR1.0 and SR1.1 do not support HS400
>>> due to errata i2458 [0] so disable HS400 for these SoC revisions.
>>>
>>> [0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> ---
>>> This patch was separated from [0] since it will be merged to
>>> different trees anyways.
>>>
>>> Link to v2:
>>> [0] https://lore.kernel.org/linux-mmc/20250807225138.1228333-1-jm@ti.com
>>> ---
>>>    drivers/mmc/host/sdhci_am654.c | 18 ++++++++++++++++++
>>>    1 file changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>>> index 8a099508b939..cc8c4145bf2b 100644
>>> --- a/drivers/mmc/host/sdhci_am654.c
>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>> @@ -155,6 +155,7 @@ struct sdhci_am654_data {
>>>      #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>>>    #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
>>> +#define SDHCI_AM654_QUIRK_DISABLE_HS400 BIT(2)
>>>    };
>>>      struct window {
>>> @@ -764,6 +765,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
>>>    {
>>>        struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>        struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>> +    struct device *dev = mmc_dev(host->mmc);
>>>        u32 ctl_cfg_2 = 0;
>>>        u32 mask;
>>>        u32 val;
>>> @@ -819,6 +821,12 @@ static int sdhci_am654_init(struct sdhci_host *host)
>>>        if (ret)
>>>            goto err_cleanup_host;
>>>    +    if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_DISABLE_HS400 &&
>>> +        host->mmc->caps2 & (MMC_CAP2_HS400 | MMC_CAP2_HS400_ES)) {
>>> +        dev_info(dev, "Disable descoped HS400 mode for this silicon revision\n");
>>
>> Messages to the user do not need to be imperative, maybe:
>>
>> "Disabling HS400 mode not supported on this silicon revision\n"
>>
>> Not a blocker,
>>
>> Reviewed-by: Andrew Davis <afd@ti.com>
> 
> I agree about the message.  Another possibility:
> "HS400 mode is not supported on this silicon revision, disabling it"
> 

Ok, that is no problem, I will fix for v4. Thanks!

~ Judith

> Otherwise:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 

