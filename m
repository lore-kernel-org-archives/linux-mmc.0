From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/1] mmc: Check to disable IOCTL when card is mounted
Date: Wed, 28 Dec 2011 15:11:31 +0200
Message-ID: <4EFB1583.3050800@intel.com>
References: <1325069180-16319-1-git-send-email-shashidharh@vayavyalabs.com> <4EFB06EC.1050100@intel.com> <CANYdXnqfokBvVZhnK2TGh=gxaX=RrjJRs=aAJ32_rTqHHUWDSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47366 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753506Ab1L1NLd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Dec 2011 08:11:33 -0500
In-Reply-To: <CANYdXnqfokBvVZhnK2TGh=gxaX=RrjJRs=aAJ32_rTqHHUWDSg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Andrei Warkentin <awarkentin@vmware.com>, linux-mmc@vger.kernel.org

On 28/12/11 14:46, Shashidhar Hiremath wrote:
> On Wed, Dec 28, 2011 at 5:39 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 28/12/11 12:46, Shashidhar hiremath wrote:
>>> From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>>>
>>> The Patch adds a check to disable the IOCTL from running when the card is mounted
>>> or device is opened elsewhere.
>>
>> What if someone wants to do that.
> The issue with not having this is that if there is huge size data
> transfer operation happening, the IOCTL issuing will corrupt the data
> transfer operation. So it would be better to finish the device's
> access by one thing and give control to ioctl after that.


It does claim the host so the ioctl will wait while I/O requests
are being processed.


>>
>> Generally the kernel does not prevent access to raw block devices
>> just because a file system is mounted on them, so I guess MMC should
>> not either.
> 
>>
>>
>>>
>>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>>> ---
>>>  drivers/mmc/card/block.c |    6 ++++++
>>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index 0cad48a..e680929 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -387,6 +387,12 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>>>               err = -EINVAL;
>>>               goto cmd_done;
>>>       }
>>> +     /* Disallow the IOCTL run if card is already mounted or device is
>>> +      * opened elsewhere */
>>> +     if (md->usage > 3) {
>>> +             err = -EINVAL;
>>> +             goto cmd_done;
>>> +     }
>>
>> Checking the usage will not work consistently e.g.
>> if there is a sysfs access or another ioctl access at the
>> same time, or just some other kernel user of the device.
>>
>>>
>>>       card = md->queue.card;
>>>       if (IS_ERR(card)) {
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

