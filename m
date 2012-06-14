From: merez@codeaurora.org
Subject: Re: [PATCH v2 1/1] mmc: block: Add write packing control
Date: Thu, 14 Jun 2012 00:46:30 -0700 (PDT)
Message-ID: <3ec17ded5b5a72a1d45d97a4d820cd48.squirrel@www.codeaurora.org>
References: <1338576911-17089-1-git-send-email-merez@codeaurora.org>
    <1338576911-17089-2-git-send-email-merez@codeaurora.org>
    <CAFR8uefCD_WXDM6m+-XwG10+W0UXqOtK7_sxWD3uVckh3pnR-Q@mail.gmail.com>
    <CAFR8uee7hWLC-h_abZOCEuqeUeuhDuJp74x3R-3n+c61xyfaPQ@mail.gmail.com>
    <fb2303ea3a3a5470e76d1faa2abd471b.squirrel@www.codeaurora.org>
    <CAFR8ueecGqw=JzAGVHV61-SqOnn_C-ryT54KCQCbKkJpXUGY9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAFR8ueecGqw=JzAGVHV61-SqOnn_C-ryT54KCQCbKkJpXUGY9w@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Muthu Kumar <muthu.lkml@gmail.com>
Cc: merez@codeaurora.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, DOCUMENTATION <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


On Wed, June 13, 2012 3:21 pm, Muthu Kumar wrote:
> On Wed, Jun 13, 2012 at 12:52 PM,  <merez@codeaurora.org> wrote:
>>
>> On Mon, June 11, 2012 5:28 pm, Muthu Kumar wrote:
>>> On Mon, Jun 11, 2012 at 2:19 PM, Muthu Kumar <muthu.lkml@gmail.com>
>>> wrote:
>>>> On Fri, Jun 1, 2012 at 11:55 AM, Maya Erez <merez@codeaurora.org>
>>>> wrote:
>>>>> trigger
>>>>> the packing can be configured via sysfs by writing the required value
>>>>> to:
>>>>> /sys/block/<block_dev_name>/num_wr_reqs_to_start_packing.
>>>>> The trigger for disabling the write packing is fetching a read
>>>>> request.
>>>>>
>>>>
>>>> If it is applicable only to MMC why do we have this sysfs attr for all
>>>> block devices?
>>>
>>> Just to be clear, please create a directory, say mmc, under
>>> /sys/block/<dev>/ and create the attr inside that.
>>>
>>> You can refer to dm (dm-sysfs.c) for sample implementation.
>> I understand why you think it would be best to distinguish the MMC
>> specific attribute from the general block devices attributes.
>> However, since this attribute is created only for the MMC block device,
>> other block devices won't be aware of it.
>
> I understand its created by the MMC code so will not be there for
> other block devices. But having the device specific attributes inside
> one <device> directory is better/cleaner. And since we are already
> following that model for other devices, why not follow that for MMC
> also?
>
>> Therefore, it doesn't
>> necessarily require a separation to a different folder.
>> Currently there is another MMC specific attribute (force_ro) which is
>> also
>> created in the root directory. I think it would be better to also create
>> the num_wr_reqs_to_start_packing in the same folder as force_ro and not
>> make it an exceptional attribute in its location and the code that
>> handles
>> it.
>
> Then time to move that as well to "mmc" directory.
>
> Regards,
> Muthu

I will make this change for the new attribute and for force_ro as well.

Thanks,
Maya

>
>
>> I would appreciate your opinion on that.
>>
>> Thanks,
>> Maya
>> --
>> Sent by consultant of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>>
>


-- 
Sent by consultant of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

