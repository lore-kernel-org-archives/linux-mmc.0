From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: bounce limit in mmc?
Date: Wed, 27 Sep 2017 07:54:21 +0200
Message-ID: <d387ccaa-6534-9d3d-1c7a-bc9e534b768c@ossman.eu>
References: <20170828174808.GA8384@infradead.org>
 <9df8e5a2-b802-72fb-f28e-13c60ba27c49@rock-chips.com>
 <CAG8K7gS7Lo2GL9ve7ze-huTT9ETNQMwdzjM6hb7_f8-GsSEF4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from saehrimnir.ossman.eu ([193.12.253.10]:46650 "EHLO
        smtp-relay.ossman.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbdI0GEj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Sep 2017 02:04:39 -0400
In-Reply-To: <CAG8K7gS7Lo2GL9ve7ze-huTT9ETNQMwdzjM6hb7_f8-GsSEF4A@mail.gmail.com>
Content-Language: en-GB
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avri Altman <avri.altman@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-mmc@vger.kernel.org

On 30/08/17 15:09, Avri Altman wrote:
> better ask the author -  (mmc: bounce requests for simple hosts) and
> (mmc_block: bounce buffer highmem support).
> 

Sorry for the late reply. This got lost in my inbox.

> On Wed, Aug 30, 2017 at 9:14 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> 
>> Hi Christoph,
>>
>> On 2017/8/29 1:48, Christoph Hellwig wrote:
>>
>>> Hi all, any idea why the mmc driver defaults to bouncing highmem
>>> pages if the device doesn't have a DMA mask?  highmem is defined
>>> different on different architectures or even based on config options,
>>> so it seems like a very odd choice.
>>>
>>
>> Not sure why mmc stack defaults to use BLK_BOUNCE_HIGH as it seems that
>> it has been there when mmc was added into linux.
>>
>> I *guess* this is a copy-and-paste from other block drivers, especially
>> see drivers/memstick/core/ms_block.c which does actual the same thing.
>>
>> And that raises another question that if mmc stack doesn't defaults to
>> boucing highmem pages but host drivers don't provide DMA mask either, so
>> what should we use for saftly limiting bouncing for DMA capable?
>>

I'm afraid it's way too long ago, so I don't really remember. git blame 
seems to suggest it has been there since before I took over though. RMK 
was the one in charge before me.

The only thing I do remember is that the original bounce stuff was done 
for the wbsd driver, which is a ISA bus device so it had to work around 
the limitations of that system.

Regards
-- 
Pierre Ossman
