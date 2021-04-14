Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E21BC433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 16:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3BB61177
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 16:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351891AbhDNQuH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Apr 2021 12:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232143AbhDNQuG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Apr 2021 12:50:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A679561153;
        Wed, 14 Apr 2021 16:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618418985;
        bh=sWQ71+khW/HhXEH6hXNiMZxDq1vYrXn/LOWzn6c44Bg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QMUyXw0imrkvaPO1DWlSoQPOurzaRmc1x1bEpx2J2ASyKkNIRZnHyThxy/B/lhFdZ
         WU3Gt3PTy3qprvS11oWrVbrpTm6l8VGR/c6WygHAXfQuBI9fOqp17Nv4P7+kHpSvMr
         A16Bh3y/EoduKIVAZDoqth0DJM9MYRmcuw00wMxwpM5fgRRjjzATgPaCHq1euVbhqA
         ibH3KIrG/E7ICcMmKJbTtDhy20hsvB7Q/i2hI15w9oGaQ4W+OaUXYwe0HoGw2UAM2D
         R8FK2q3K5tKKScXXv+taCmhIc6umUcgvIkkeDJeE5/s03heWQcs6QKLgYM2WOPUtSk
         Exdf3oa672aIQ==
Subject: Re: [PATCH 1/3] mmc: sdhci-s3c: fix possible NULL pointer dereference
 when probed via platform
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
 <a0ac5d21-acc1-825a-1585-f8d897902b14@canonical.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <74059494-3610-c24e-7d09-b89106c0a396@kernel.org>
Date:   Wed, 14 Apr 2021 18:49:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a0ac5d21-acc1-825a-1585-f8d897902b14@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14.04.2021 17:25, Krzysztof Kozlowski wrote:
> On 14/04/2021 17:12, Krzysztof Kozlowski wrote:
>> The driver can be matched by legacy platform way or OF-device matching.
>> In the first case, of_match_node() can return NULL, which immediately
>> would be dereferenced to get the match data.
>>
>> Addresses-Coverity: Dereference null return value
>> Fixes: cd1b00eb24b0 ("mmc: sdhci-s3c: Add device tree support")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

>> -#ifdef CONFIG_OF
>> -static const struct of_device_id sdhci_s3c_dt_match[];
>> -#endif
>> -
>>   static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
>>   			struct platform_device *pdev)
>>   {
>>   #ifdef CONFIG_OF
>> -	if (pdev->dev.of_node) {
>> -		const struct of_device_id *match;
>> -		match = of_match_node(sdhci_s3c_dt_match, pdev->dev.of_node);
> 
> Now I have second thoughts whether NULL pointer can actually happen.  If
> device is matched via platform/board files, maybe the pdev->dev.of_node
> will be NULL thus skipping this branch?
> 
> Could there be a case where device is matched via platform_device_id()
> (which has different name than compatible!) and (pdev->dev.of_node) is
> still assigned? Maybe in case of out of tree DTS?

That seems unlikely, the platform device would need to be initialized
via board file and then its of_node assigned somehow. It doesn't make
much sense to me. We either use board file or dtb to instantiate devices.

> Anyway, the patch makes the code simpler/smaller, so I still think it is
> reasonable. Just the severity of issue is questionable...

Yes, the patch looks good. Similar cleanups are already done in most of
the s3c/s5p/exynos drivers.

--
Thanks,
Sylwester
