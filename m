Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8277DC61DD8
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 18:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9EB20759
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 18:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MZUcf7VE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgKMSe0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Nov 2020 13:34:26 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12698 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKMSe0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Nov 2020 13:34:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5faed1ba0003>; Fri, 13 Nov 2020 10:34:34 -0800
Received: from [10.2.50.194] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov
 2020 18:34:22 +0000
Subject: Re: [RFC PATCH] mmc: sdhci: tegra: fix wrong unit with busy_timeout
To:     Thierry Reding <thierry.reding@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>
References: <20201113125354.3507-1-wsa+renesas@sang-engineering.com>
 <20201113163846.GF1408970@ulmo>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <728ad4ee-c5a2-65a6-c037-689bc77acbdf@nvidia.com>
Date:   Fri, 13 Nov 2020 10:34:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113163846.GF1408970@ulmo>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605292474; bh=RMh5cHeRnFMp4PmO2fhDfKqsLtUARA3uOLfJuAQxxmY=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=MZUcf7VEiSWrii73CUBJX2iPkP6yTOseinDekLEhebQ9MLuB33kKHSJSbPHgs5vgn
         zX+oz1vWnQBPC9NsB42bqYSbvVHK8v76I5haqqDCc2W9CzejzbV9IG6nivm9H3i3MW
         9AGMVzzkBJiN3OroASjFa+bST+A82hoeGWoK9tC/XALvV2AMW0T+Ax1YhrNjSCTGE5
         6Wk5rmvL+jMP6gj08ig2oAlBMQHCc4l4yP/5SLK+raXsF36sZOwbro6t/Lwso53tnS
         Gnck3W8MtToJ1/ld7OSiDmQ1zdFunKdhZC/7p4m/GEk01dak4h72Tfq1b38VQsap14
         SdVCxKUIWJ92A==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 11/13/20 8:38 AM, Thierry Reding wrote:
> On Fri, Nov 13, 2020 at 01:53:30PM +0100, Wolfram Sang wrote:
>> 'busy_timeout' is in msecs, not in jiffies. Use the correct factor.
>>
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> ---
>>
>> Not tested. Found by code investigation about 'busy_timeout'. A quick
>> grep showed no other problematic code within the MMC host drivers.
>>
>>   drivers/mmc/host/sdhci-tegra.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> Sowjanya, can you take a look at this?
>
> Thierry

Thanks Wolfram.

Right cmd busy_timeout is in msec and we have to enable 
ERASE_TIMEOUT_LIMIT bit for more than 11s busy operations.

So it should be MSEC_PER_SEC.

>
>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
>> index ed12aacb1c73..ad0dc3adc7d1 100644
>> --- a/drivers/mmc/host/sdhci-tegra.c
>> +++ b/drivers/mmc/host/sdhci-tegra.c
>> @@ -1272,7 +1272,7 @@ static void tegra_sdhci_set_timeout(struct sdhci_host *host,
>>   	 * busy wait mode.
>>   	 */
>>   	val = sdhci_readl(host, SDHCI_TEGRA_VENDOR_MISC_CTRL);
>> -	if (cmd && cmd->busy_timeout >= 11 * HZ)
>> +	if (cmd && cmd->busy_timeout >= 11 * MSECS_PER_SEC)
>>   		val |= SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
>>   	else
>>   		val &= ~SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
>> -- 
>> 2.28.0
