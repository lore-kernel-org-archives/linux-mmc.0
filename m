From: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Subject: Re: [PATCH] mmc: mmci: Support non-power-of-two block sizes for ux500v2
 variant
Date: Mon, 26 Nov 2012 11:20:32 +0100
Message-ID: <50B34270.7070403@stericsson.com>
References: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com> <20121121153811.GN3290@n2100.arm.linux.org.uk> <CAFEEs1kzJUgsvnzgWwU4i7o1jkE=8iTq5+NJ_t1jdiHEm7b-RQ@mail.gmail.com> <20121121165048.GO3290@n2100.arm.linux.org.uk> <CAFEEs1nb+UD+8_jsKvGKhyFqGDogN5wsmV30PnELqahTMDyRVA@mail.gmail.com> <20121122173708.GJ5764@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:51350 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753709Ab2KZKV0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 05:21:26 -0500
In-Reply-To: <20121122173708.GJ5764@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Per Forlin <per.lkml@gmail.com>, Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On 11/22/2012 06:37 PM, Russell King - ARM Linux wrote:
> On Thu, Nov 22, 2012 at 06:28:30PM +0100, Per Forlin wrote:
>> On Wed, Nov 21, 2012 at 5:50 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Wed, Nov 21, 2012 at 05:13:55PM +0100, Per Forlin wrote:
>>>> On Wed, Nov 21, 2012 at 4:38 PM, Russell King - ARM Linux
>>>> <linux@arm.linux.org.uk> wrote:
>>>>> On Fri, Oct 12, 2012 at 04:02:02PM +0200, Ulf Hansson wrote:
>>>>>>  /*
>>>>>> + * Validate mmc prerequisites
>>>>>> + */
>>>>>> +static int mmci_validate_data(struct mmci_host *host,
>>>>>> +                           struct mmc_data *data)
>>>>>> +{
>>>>>> +     if (!data)
>>>>>> +             return 0;
>>>>>> +
>>>>>> +     if (!host->variant->non_power_of_2_blksize &&
>>>>>> +         !is_power_of_2(data->blksz)) {
>>>>>> +             dev_err(mmc_dev(host->mmc),
>>>>>> +                     "unsupported block size (%d bytes)\n", data->blksz);
>>>>>> +             return -EINVAL;
>>>>>> +     }
>>>>>> +
>>>>>> +     if (data->sg->offset & 3) {
>>>>>> +             dev_err(mmc_dev(host->mmc),
>>>>>> +                     "unsupported alginment (0x%x)\n", data->sg->offset);
>>>>>> +             return -EINVAL;
>>>>>> +     }
>>>>>
>>>>> Why?  What's the reasoning behind this suddenly introduced restriction?
>>>>> readsl()/writesl() copes just fine with non-aligned pointers.  It may be
>>>>> that your DMA engine can not, but that's no business interfering with
>>>>> non-DMA transfers, and no reason to fail such transfers.
>>>>>
>>>>> If your DMA engine can't do that then its your DMA engine code which
>>>>> should refuse to prepare the transfer.
>>>>>
>>>>> Yes, that means problems with the way things are ordered - or it needs a
>>>>> proper API where DMA engine can export these kinds of properties.
>>>> The alignment constraint is related to PIO, sg_miter and that FIFO
>>>> access must be done with 4 bytes.
>>>
>>> Total claptrap.  No it isn't.
>>>
>>> - sg_miter just deals with bytes, and number of bytes transferred; there
>>>   is no word assumptions in that code.  Indeed many ATA disks transfer
>>>   by half-word accesses so such a restriction would be insane.
>>>
>>> - the FIFO access itself needs to be 32-bit words, so readsl or writesl
>>>   (or their io* equivalents must be used).
>>>
>>> - but - and this is the killer item to your argument as I said above -
>>>   readsl and writesl _can_ take misaligned pointers and cope with them
>>>   fine.
>>>
>>> The actual alignment of the buffer address is totally irrelevant here.
>>>
>>> What isn't irrelevant is the _number_ of bytes to be transferred, but
>>> that's something totally different and completely unrelated from
>>> data->sg->offset.
>> Let's try again :)
>>
>> Keep in mind that the mmc -block layer is aligned so from that aspect
>> everything is fine.
>> SDIO may have any length or alignment but sg-len is always 1.
>>
>> There is just one sg-element and one continues buffer.
>>
>> sg-miter splits the continues buffer in chunks that may not be aligned
>> with 4 byte size. It depends on the start address alignment of the
>> buffer.
>>
>> Is it more clear now?
> 
> Is this more clear: you may be passed a single buffer which is misaligned.
> We cope with that just fine.  There is *no* reason to reject that transfer
> because readsl/writesl cope just fine with it.
> 
The MMCI driver doesn't support alignment smaller than 4 bytes (it may result in data corruption).
There are two options
1. Either one should fix the driver to support it. Currently the driver only supports miss-alignment of the last sg-miter buffer.
2. Or be kind to inform the user that the alignment is not supported.

BR
Per

