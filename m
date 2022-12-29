Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F27EC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Dec 2022 11:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiL2LlI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Dec 2022 06:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiL2LlH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2022 06:41:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FE6EE2B;
        Thu, 29 Dec 2022 03:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672314066; x=1703850066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oeDbj0ZIAbnEAMYuTDE6Q/zKo/muKo1PNiMLz3nWAeY=;
  b=KD+lrPt/NcRcZ6/8xtlfKCQccqpsG4rV7HDX7IvitcUa+tV2wu4XQmUE
   5bie8qWl7kDww6KUrVvsoP6DxzxmJlhW4e/CQz9m9dpZIGo2eSNshod3C
   2xNSQ5ztSHzREg7xGZagifBAYaYztuWsGF98VBuAiWwi9xQy9ZyCP3N/c
   ktbgCaCxXZRJ1FR0Liexw3GvaIRiaz6xA3jSgR5sCUVYLTHkBan2s6sMS
   l+FQIhx4DzJMlxjiaqAuFmQsmwS2huTw3g0NLKqjU1Ir5z2kpckVzvFec
   7KKDE30cYyELMmyIolBss0439sVEZ1I58n1g+nohYnlrK3LHX+tk/d1N7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="301396004"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="301396004"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 03:40:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="603607003"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="603607003"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.63.128])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 03:40:51 -0800
Message-ID: <36cea7c5-75bb-8382-7f76-fcd36a9b482d@intel.com>
Date:   Thu, 29 Dec 2022 13:40:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/8] mmc: sdhci-pxav2: add initial support for PXA168
 V1 controller
Content-Language: en-US
To:     Doug Brown <doug@schmorgal.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20221202031330.94130-1-doug@schmorgal.com>
 <20221202031330.94130-2-doug@schmorgal.com>
 <c2d5fb16-2654-6406-63da-626d6d5029c3@intel.com>
 <beda0a3a-05d9-6c24-0fd2-1d80a86beb6d@schmorgal.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <beda0a3a-05d9-6c24-0fd2-1d80a86beb6d@schmorgal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 26/12/22 22:35, Doug Brown wrote:
> Hi Adrian,
> 
> On 12/22/2022 8:03 AM, Adrian Hunter wrote:
>> On 2/12/22 05:13, Doug Brown wrote:
>>> Add a new compatible string for the version 1 controller used in the
>>> PXA168, along with necessary quirks. Use a separate ops struct in
>>> preparation for a silicon bug workaround only necessary on V1.
>>>
>>> Signed-off-by: Doug Brown <doug@schmorgal.com>
>>> ---
>>>   drivers/mmc/host/sdhci-pxav2.c | 18 +++++++++++++++++-
>>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
>>> index f18906b5575f..2f9fa0ecbddd 100644
>>> --- a/drivers/mmc/host/sdhci-pxav2.c
>>> +++ b/drivers/mmc/host/sdhci-pxav2.c
>>> @@ -101,6 +101,14 @@ static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
>>>       writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>>>   }
>>>   +static const struct sdhci_ops pxav1_sdhci_ops = {
>>> +    .set_clock     = sdhci_set_clock,
>>> +    .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>>> +    .set_bus_width = pxav2_mmc_set_bus_width,
>>> +    .reset         = pxav2_reset,
>>> +    .set_uhs_signaling = sdhci_set_uhs_signaling,
>>> +};
>>> +
>>>   static const struct sdhci_ops pxav2_sdhci_ops = {
>>>       .set_clock     = sdhci_set_clock,
>>>       .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>>> @@ -114,6 +122,9 @@ static const struct of_device_id sdhci_pxav2_of_match[] = {
>>>       {
>>>           .compatible = "mrvl,pxav2-mmc",
>>>       },
>>> +    {
>>> +        .compatible = "mrvl,pxav1-mmc",
>>> +    },
>>>       {},
>>>   };
>>>   MODULE_DEVICE_TABLE(of, sdhci_pxav2_of_match);
>>> @@ -208,7 +219,12 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>>>               host->mmc->pm_caps |= pdata->pm_caps;
>>>       }
>>>   -    host->ops = &pxav2_sdhci_ops;
>>> +    if (match && of_device_is_compatible(dev->of_node, "mrvl,pxav1-mmc")) {
>>> +        host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_32BIT_DMA_SIZE;
>>> +        host->ops = &pxav1_sdhci_ops;
>>> +    } else {
>>> +        host->ops = &pxav2_sdhci_ops;
>>> +    }
>>
>> It would be better to put the information above in a structure and
>> get it with of_device_get_match_data() (instead of of_match_device).
>> Also drivers typically assume there is always a match since that
>> is the only way the driver ->probe() will get run.
> 
> Thanks for all of your great feedback on this series. That makes sense.
> I did have one question about this suggestion. There are other parts of
> sdhci_pxav2_probe() that don't assume there was a match so that it can
> be set up the old way as a platform_device without CONFIG_OF. I was
> trying to preserve compatibility by defaulting to pxav2_sdhci_ops if
> it was set up as a platform_device. Is it all right if I leave a
> fallback in place for that, or should I just end compatibility with the
> old way at this point and assume a match in all cases? I don't see any
> legacy board files that use this driver.

I didn't think about matching by name.  As you say, there doesn't seem
to be anything in mainline.  I will leave it to you to decide.

> 
>>
>>>         ret = sdhci_add_host(host);
>>>       if (ret)
>>
> 
> Thanks,
> Doug

