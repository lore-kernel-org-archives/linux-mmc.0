Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12140C7EE25
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jun 2023 20:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjFGUok (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Jun 2023 16:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjFGUof (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jun 2023 16:44:35 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51311FF0
        for <linux-mmc@vger.kernel.org>; Wed,  7 Jun 2023 13:44:17 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id AE0D885D4E;
        Wed,  7 Jun 2023 22:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1686170620;
        bh=et/O1Q7n3B6o0Josn7Q/8nFOfo94H7iA/4ihvH+RRgA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=0SjwAbvhjBHLtB2HTXR1N1eixxGJAan3i/PE89PZ9bs31Cz3jGTlcjxGYJ3u2rplz
         dj8BkJuAcnFtRoSYqKUHzzb6JUE2lMdd3zrWejCOLdXW2zkxqgQvBN3lWpWNl3cGw8
         AVBDkrn1S5xZJQi0KXUZKdvMhy0giqyKM0tMwpeg2tVfTLqwoUMy+ZZpKj/2IerD+E
         rTEBppGA/rZ7JOLk6LOOd0Cb31XbJf57RzyUFsve3UrG5bmbn47quB8a8uoLeXhPoZ
         C+tC/3+DsNe2xxK1nObGlBLTnOekDQYuB8w0T9NPnlar9Rh+jDkIzg0MfBlGWxZa6y
         NYcCg7OaDukNw==
Message-ID: <b494062c-7e9e-24ba-ef0a-13faf0fe7706@denx.de>
Date:   Wed, 7 Jun 2023 22:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] [RFC] Revert "mmc: core: Fixup support for
 writeback-cache for eMMC and SD"
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Wu <michael@allwinnertech.com>,
        Ming Lei <ming.lei@redhat.com>,
        Seunghui Lee <sh043.lee@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20230531002740.1235620-1-marex@denx.de>
 <ecad717c-77b5-c78a-795b-2c3019b7452a@intel.com>
 <a69823e8-4e87-9eaa-1cb8-7d1457df1492@denx.de>
 <f41e1546-f6d3-7f4d-7662-3b7eca291178@intel.com>
 <29a5f24d-2b8c-8387-8c11-601af8e13940@denx.de>
 <4c8d84ae-c8d0-fa12-81c6-a47382684d73@intel.com>
 <3bd65a30-756d-e7ee-ce77-e5ebfe6b6e30@denx.de>
 <75ab27e9-9203-f59b-c720-99bfa992bb9b@intel.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <75ab27e9-9203-f59b-c720-99bfa992bb9b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/4/23 18:30, Adrian Hunter wrote:

[...]

>>>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>>>> index 72b664ed90cf..9c3123867a99 100644
>>>>> --- a/drivers/mmc/core/sd.c
>>>>> +++ b/drivers/mmc/core/sd.c
>>>>> @@ -1313,6 +1313,8 @@ static int sd_flush_cache(struct mmc_host *host)
>>>>>     {
>>>>>         struct mmc_card *card = host->card;
>>>>>         u8 *reg_buf, fno, page;
>>>>> +    unsigned long timeout;
>>>>> +    bool expired;
>>>>>         u16 offset;
>>>>>         int err;
>>>>>     @@ -1338,11 +1340,15 @@ static int sd_flush_cache(struct mmc_host *host)
>>>>>             goto out;
>>>>>         }
>>>>>     +    timeout = jiffies + msecs_to_jiffies(SD_WRITE_EXTR_SINGLE_TIMEOUT_MS) + 1;
>>>>> +again:
>>>>>         err = mmc_poll_for_busy(card, SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
>>>>>                     MMC_BUSY_EXTR_SINGLE);
>>>>>         if (err)
>>>>>             goto out;
>>>>>     +    expired = time_after(jiffies, timeout);
>>>>> +
>>>>>         /*
>>>>>          * Read the Flush Cache bit. The card shall reset it, to confirm that
>>>>>          * it's has completed the flushing of the cache.
>>>>> @@ -1354,8 +1360,12 @@ static int sd_flush_cache(struct mmc_host *host)
>>>>>             goto out;
>>>>>         }
>>>>>     -    if (reg_buf[0] & BIT(0))
>>>>> -        err = -ETIMEDOUT;
>>>>> +    if (reg_buf[0] & BIT(0)) {
>>>>
>>>> I am getting here, multiple times, with expired=0 .
>>>
>>> So either the host controller's busy detection does not work, or the
>>> card is not indicating busy by pulling down DAT0.
>>>
>>> Can you try to figure out which it is?
>>
>> The byte 261 bit 0 is never cleared, I had this looping for an hour and the 'Flush Cache' bit just never got cleared. The SD spec 6.00 and 9.00 both indicate the bit should be cleared by the card once cache flush is completed.
>>
>> I tried three different controllers now -- STM32MP15xx ARM MMCI, i.MX6Q uSDHC, laptop rtsx_pci_sdmmc , they all fail.
>>
>> I tried to find another card which also has cache, I cannot find any other card, all the rest report no cache. The kingston card SSR (see the 2ff in 6th field, the last f bit 2 is cache supported indication, SSR bit 330):
>>
>> 00000000:08000000:04009000:011b391e:00080000:0002ff00:03000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:
>>
>> So either this card is weird, or the cards with cache are so rare that nobody noticed the problem yet.
> 
> The patch set cover letter says it was tested with 64GB Sandisk Extreme PRO UHS-I A2 card
> 
> 	https://lore.kernel.org/linux-mmc/20210506145829.198823-1-ulf.hansson@linaro.org/

I got that one now, tested it, the cache bit is being cleared correctly. 
I also tested a few more cards and dumped their SSR too:

Kingston Canvas Go! Plus:
80000000:08000000:04009000:011b391e:00080000:0002ff00:03000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:
Flush never finishes

Sandisk Extreme PRO A2 64GiB:
80000000:08000000:04009000:0f05391e:00080000:0002fc00:03000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:
mmc0: flushing cache took 5 ms, 1 iterations, error 0

Goodram IRDM V30 A2 64GiB:
80000000:08000000:0400a001:00fd3a1e:00080000:00023c00:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:
mmc0: flushing cache took 5 ms, 1 iterations, error 0

Samsung Pro Plus 512GiB V30 A2 (ext reg general info is all zeroes, 
cache not enabled):
80000000:08000000:04009000:0811391e:00080000:0002fc00:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:00000000:

> I ordered a Kingston Canvas Go Plus card as you described but it won't arrive for a week.

I'm really interested in what you would find with that one.

Maybe the card I have here is defective, although I would expect not 
just the cache functionality to fail in such a case.

Is there anyone at kingston we could ask about the cache specifics on 
that card ?

> Currently I am thinking we could do a cache flush after enabling the cache, just
> to see if it works.  If not, then disable the cache.
> 
> It would also be interesting to read back the extended register to see if the
> enable bit has actually been set.

Both offset 260 and 261 read back as 0x01 during the endless flush.
