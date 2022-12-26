Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7B5C4167B
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Dec 2022 20:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLZUfV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Dec 2022 15:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLZUfU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Dec 2022 15:35:20 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B232729
        for <linux-mmc@vger.kernel.org>; Mon, 26 Dec 2022 12:35:20 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso11494524pjh.1
        for <linux-mmc@vger.kernel.org>; Mon, 26 Dec 2022 12:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zZT04BE0Jy+qQBeK2Ut0h38WWYJ74qKLrwC/57eVCw=;
        b=NSXT/nLjP4E4YaOEKbSANohMbFND9Z5HDvSHbwini59mb8vxFnQKUCj1eMVzGQLkWg
         MJJAvTDgIJH17cvo1i6MwEtuYWSHj+g+HKMdCsZyckewz/9mFvfLrjWjlrjjVZKoI1v8
         WeiWbZWfeIKA7QFyGKXFqw0vzektIICrbWCwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zZT04BE0Jy+qQBeK2Ut0h38WWYJ74qKLrwC/57eVCw=;
        b=0vDdPy82vlbQtx2AGLoJBLPKtB0WY7r1xTRmUWLfs7Z7ubFNR6oo1GfZcJ0Df4BvV5
         i2ZKlef2e6iSoy4UDujBNRMvGjMrrHAaToZ0DgQdkwPBLayH9jB4bJFYhBCWLIPCqSHZ
         e+0IZUBvI8CLhbSdeMYpn/qpodp0SRjGNxWahxSK7iejpiIlTnMMiXe9iX2Lo6Dojeqs
         GdFkLC2HA24WZVJqHz1tDZ8W0rs15PXPTRKpwXbahHHsrEkxJBoCP3jX2NkrI/LxMpnM
         FAjZBmsOXpZ2oG3uulon0E/ZpYmy0aZHJGe3UyBt1SLICobtQEd5RndkGpUJGfKcoMkL
         Q4Dg==
X-Gm-Message-State: AFqh2kph0ALqKzLnfhfYfUDLjz5ROvzMgXeTp4eU1NACDJdFXtnPl6+p
        VT6kAKO8Old5qKIxwIbc3qL6UYYWFpxQKUIXD7A=
X-Google-Smtp-Source: AMrXdXu4HGH/Oc5jIA0bmeKP0p6oaZVxyT0RYL1f1Kixkj8ddZFdQ7bpumdtU2zazOZhNJvhQwws1w==
X-Received: by 2002:a17:902:ee13:b0:189:13df:9d86 with SMTP id z19-20020a170902ee1300b0018913df9d86mr23857377plb.14.1672086919133;
        Mon, 26 Dec 2022 12:35:19 -0800 (PST)
Received: from [192.168.1.33] ([192.183.212.197])
        by smtp.googlemail.com with ESMTPSA id p23-20020a1709027ed700b00178b6ccc8a0sm7541996plb.51.2022.12.26.12.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 12:35:18 -0800 (PST)
Message-ID: <beda0a3a-05d9-6c24-0fd2-1d80a86beb6d@schmorgal.com>
Date:   Mon, 26 Dec 2022 12:35:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20221202031330.94130-1-doug@schmorgal.com>
 <20221202031330.94130-2-doug@schmorgal.com>
 <c2d5fb16-2654-6406-63da-626d6d5029c3@intel.com>
Content-Language: en-US
From:   Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH v2 1/8] mmc: sdhci-pxav2: add initial support for PXA168
 V1 controller
In-Reply-To: <c2d5fb16-2654-6406-63da-626d6d5029c3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On 12/22/2022 8:03 AM, Adrian Hunter wrote:
> On 2/12/22 05:13, Doug Brown wrote:
>> Add a new compatible string for the version 1 controller used in the
>> PXA168, along with necessary quirks. Use a separate ops struct in
>> preparation for a silicon bug workaround only necessary on V1.
>>
>> Signed-off-by: Doug Brown <doug@schmorgal.com>
>> ---
>>   drivers/mmc/host/sdhci-pxav2.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
>> index f18906b5575f..2f9fa0ecbddd 100644
>> --- a/drivers/mmc/host/sdhci-pxav2.c
>> +++ b/drivers/mmc/host/sdhci-pxav2.c
>> @@ -101,6 +101,14 @@ static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
>>   	writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>>   }
>>   
>> +static const struct sdhci_ops pxav1_sdhci_ops = {
>> +	.set_clock     = sdhci_set_clock,
>> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>> +	.set_bus_width = pxav2_mmc_set_bus_width,
>> +	.reset         = pxav2_reset,
>> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
>> +};
>> +
>>   static const struct sdhci_ops pxav2_sdhci_ops = {
>>   	.set_clock     = sdhci_set_clock,
>>   	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>> @@ -114,6 +122,9 @@ static const struct of_device_id sdhci_pxav2_of_match[] = {
>>   	{
>>   		.compatible = "mrvl,pxav2-mmc",
>>   	},
>> +	{
>> +		.compatible = "mrvl,pxav1-mmc",
>> +	},
>>   	{},
>>   };
>>   MODULE_DEVICE_TABLE(of, sdhci_pxav2_of_match);
>> @@ -208,7 +219,12 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>>   			host->mmc->pm_caps |= pdata->pm_caps;
>>   	}
>>   
>> -	host->ops = &pxav2_sdhci_ops;
>> +	if (match && of_device_is_compatible(dev->of_node, "mrvl,pxav1-mmc")) {
>> +		host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_32BIT_DMA_SIZE;
>> +		host->ops = &pxav1_sdhci_ops;
>> +	} else {
>> +		host->ops = &pxav2_sdhci_ops;
>> +	}
> 
> It would be better to put the information above in a structure and
> get it with of_device_get_match_data() (instead of of_match_device).
> Also drivers typically assume there is always a match since that
> is the only way the driver ->probe() will get run.

Thanks for all of your great feedback on this series. That makes sense.
I did have one question about this suggestion. There are other parts of
sdhci_pxav2_probe() that don't assume there was a match so that it can
be set up the old way as a platform_device without CONFIG_OF. I was
trying to preserve compatibility by defaulting to pxav2_sdhci_ops if
it was set up as a platform_device. Is it all right if I leave a
fallback in place for that, or should I just end compatibility with the
old way at this point and assume a match in all cases? I don't see any
legacy board files that use this driver.

> 
>>   
>>   	ret = sdhci_add_host(host);
>>   	if (ret)
> 

Thanks,
Doug
