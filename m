Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937C3EB64D9
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 01:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjFTBob (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Jun 2023 21:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjFTBoa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2023 21:44:30 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A3E6C
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 18:44:28 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C7F43861F6;
        Tue, 20 Jun 2023 03:44:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1687225466;
        bh=TzcnGnaD/AWvHkTiIiS9YoEXARz6/aQ6X/vVH/KbKLM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=phzMKChivizlPUDd/txi7j+2P5p8xL2Gj+DCsBsDF/llPpaH1krCpIrT0gzLhwQqg
         Fpsch154iBo9LNVxFW56Rxkau5675yi45SfF+ordaTe35XEYMCvvJJ10hmUz9e3eKR
         BTPXlU+jOX1o6HEnH0MbfTBZJfLOFebb7+PRY8x1Rz4DwetFDY/P9MmJBviUC4OjW9
         4Cuv7/UH4NRS9npXM23hqjiQzVDrmgVBNuIOQH2N92Ewh4DUGzlAUjdxT7OMKO3VOG
         qzDx+CqsHQTKWV4GQD5gk9QTAaUhh9Ce30lSlM+cXGae8NnB4d0285b4+ro+zkwKQ0
         eICEc3w25oQVw==
Message-ID: <a0115a9d-90b1-81ac-3a57-c7939a8367b7@denx.de>
Date:   Tue, 20 Jun 2023 03:44:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] [RFC] Revert "mmc: core: Fixup support for
 writeback-cache for eMMC and SD"
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Wu <michael@allwinnertech.com>,
        Ming Lei <ming.lei@redhat.com>,
        Seunghui Lee <sh043.lee@samsung.com>, xander_li@kingston.com.tw
References: <20230531002740.1235620-1-marex@denx.de>
 <ecad717c-77b5-c78a-795b-2c3019b7452a@intel.com>
 <a69823e8-4e87-9eaa-1cb8-7d1457df1492@denx.de>
 <f41e1546-f6d3-7f4d-7662-3b7eca291178@intel.com>
 <29a5f24d-2b8c-8387-8c11-601af8e13940@denx.de>
 <4c8d84ae-c8d0-fa12-81c6-a47382684d73@intel.com>
 <3bd65a30-756d-e7ee-ce77-e5ebfe6b6e30@denx.de>
 <75ab27e9-9203-f59b-c720-99bfa992bb9b@intel.com>
 <b494062c-7e9e-24ba-ef0a-13faf0fe7706@denx.de>
 <a316b98e-fe56-23a3-7d58-13fcd5d9abb5@intel.com>
 <0029620e-4d22-d8f9-5566-4b1ea7f05bae@denx.de>
 <CAPDyKFoe0WWs2-wSETMZR5shjmWnLfD4GPwOXJNhyKd8xntq8A@mail.gmail.com>
 <e6243501-908d-dec9-36ef-206c20ccf8cc@intel.com>
 <6423ae91-7585-b141-960a-f8cfd4b23538@denx.de>
 <CAPDyKFo5PfSWfZdyq25P87hvpZd4=GC54zp-SbjRZE1EZNoFxQ@mail.gmail.com>
 <3a660f13-5397-cb7e-49d3-b464ec677e69@denx.de>
 <CAPDyKFrY84vairXcWo3hRo26nV8=7KZmEaDua-pna6pj5LLRyw@mail.gmail.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAPDyKFrY84vairXcWo3hRo26nV8=7KZmEaDua-pna6pj5LLRyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/16/23 12:33, Ulf Hansson wrote:

Hi,

[...]

>>>>>> I have been trying to follow the progress around this matter. If I
>>>>>> understand correctly we are leaning towards making a card quirk for
>>>>>> this particular SD, to avoid us from turning on and using a broken
>>>>>> cache feature.
>>>>>>
>>>>>> Or what are you thinking?
>>>>>
>>>>> That is probably the simplest option.
>>>>
>>>> Just give me a day or two to test the other newer card.
>>>>
>>>> What would you base that quirk off of ? Date ? We don't know when the
>>>> "fixed" cards started to be produced .
>>>
>>> Right. It seems like the best we can do is to make a quirk for that
>>> particular version of card that you proved to have failed.
>>
>> I just sent a few more data points . It is either date, or C_SIZE, or
>> ERASE_TIMEOUT (if I decode it right). I can also just archive the card,
>> since we have sample size of the defective card equal 1 . It could just
>> be a defective card after all, although the fact that only cache would
>> be defective is unusual.
> 
> I wouldn't mind having a card quirk and to use "date". But it looks
> like it's your call to make. :-)

I sent the quirk patch:

[PATCH] mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus 
from 11/2019

It seems it is a bit bigger than I though it would originally be.
