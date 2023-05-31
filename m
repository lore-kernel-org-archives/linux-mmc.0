Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3FCC77B73
	for <linux-mmc@archiver.kernel.org>; Wed, 31 May 2023 11:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjEaLfD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 May 2023 07:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjEaLet (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 May 2023 07:34:49 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFCF10F
        for <linux-mmc@vger.kernel.org>; Wed, 31 May 2023 04:34:47 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 6CAD38609E;
        Wed, 31 May 2023 13:34:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685532886;
        bh=YPeHNfGwgykXnN78vbfR4CwuCwrD2z0wu9Lt08wu52Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VQMNgvg219e+XQfbnNnjkyI2QOMZmV2yRcQkVcNqZyS4knhrisVMG5Tmq2gSmbP+C
         C3XcvlTDg6qsBbhsH1WRrf1ixdGc4ipXjpYTcX2/ubt/9z6jCMqfPBDfVL2uxKgDZ+
         X/WZhUBf0fmsaLLDqJ8caKX1EJB/RhMQSu2ME8O86rAjO25QRorl2mNYquczcMcUln
         BmBjMXva4wvUIzWbdreGW00VeusWck3Rgk2PRF9Rhp4aaeem3gUM6eHgJXDq3ARpcj
         +QaYhiQZKnUfTAD2OmCV8Azbl9g/SDhLQxOneX5KzEEIv+KKScOthJG9g00meDp3c9
         27fCQsiJMHKjA==
Message-ID: <ae221597-8956-0ca1-2e67-e2a7c72252a0@denx.de>
Date:   Wed, 31 May 2023 13:34:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] [RFC] Revert "mmc: core: Fixup support for
 writeback-cache for eMMC and SD"
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Wu <michael@allwinnertech.com>,
        Ming Lei <ming.lei@redhat.com>,
        Seunghui Lee <sh043.lee@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20230531002740.1235620-1-marex@denx.de>
 <DM6PR04MB65757BA6C2B6FFFF3C16A901FC489@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <DM6PR04MB65757BA6C2B6FFFF3C16A901FC489@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 5/31/23 08:01, Avri Altman wrote:
>> This reverts commit 08ebf903af57cda6d773f3dd1671b64f73b432b8.
>>
>> On STM32MP153C DHCOR DRC Compact with microSD card Kingston Canvas
>> Go! Plus MicroSDXC I 64 GiB U3/V30/A2 SDCG3/64GB it is no longer possible
>> to mount ext4 filesystem.
>>
>> Git bisect points to this commit which is being reverted here. A bit of
>> investigation shows that for non-working microSD cards
>>    cache_enabled=TRUE fua_enabled=false
>> For working microSD card (Kingston Canvas React Plus, MicroSDXC II
>> 64 GiB U3/V90/A1 SDCR2/64GB)
>>    cache_enabled=FALSE fua_enabled=false
>>
>> It seems enabling the cache for SD cards causes the issue. Before the reverted
>> commit, the cache was not reported enabled for SD cards. I am not sure
>> whether such blunt revert is the correct solution however, any ideas ?
> The commit you are reverting has a couple of fixes tags - so reverting it will re-introduce those issues it aims to fix.
> If I recall correctly, I asked our sd system engineering to follow up on this,
> And they had no problem with the logic.
> 
> I think that we need more data to establish the root cause of this issue,
> Provided that it is not a specific-vendor issue.

I just sent Adrian the command log, but I don't see anything obvious in it.
