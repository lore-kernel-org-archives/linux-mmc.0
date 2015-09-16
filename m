From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V3] mmc: block: Add new ioctl to send multi commands
Date: Wed, 16 Sep 2015 17:01:37 +0100
Message-ID: <55F99261.60003@nvidia.com>
References: <1442242844-6859-1-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFqg5Ld+9LE5wHTZWy2M6gJSYqJVqBZ5vFjVkjyTRW_q+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12749 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbbIPQBp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Sep 2015 12:01:45 -0400
In-Reply-To: <CAPDyKFqg5Ld+9LE5wHTZWy2M6gJSYqJVqBZ5vFjVkjyTRW_q+g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Seshagiri Holi <sholi@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Grant Grundler <grundler@google.com>, Olof Johansson <olofj@chromium.org>


On 16/09/15 12:08, Ulf Hansson wrote:
> On 14 September 2015 at 17:00, Jon Hunter <jonathanh@nvidia.com> wrote:
>> From: Seshagiri Holi <sholi@nvidia.com>
>>
>> Certain eMMC devices allow vendor specific device information to be read
>> via a sequence of vendor commands. These vendor commands must be issued
>> in sequence and an atomic fashion. One way to support this would be to
>> add an ioctl function for sending a sequence of commands to the device
>> atomically as proposed here. These multi commands are simple array of
>> the existing mmc_ioc_cmd structure.
>>
>> The structure passed via the ioctl uses a __u64 type to specify the number
>> of commands (so that the structure is aligned on a 64-bit boundary) and a
>> zero length array as a header for list of commands to be issued. The
>> maximum number of commands that can be sent is determined by
>> MMC_IOC_MAX_CMDS (which defaults to 255 and should be more than
>> sufficient).
>>
>> Signed-off-by: Seshagiri Holi <sholi@nvidia.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Grant Grundler <grundler@google.com>
>> Cc: Olof Johansson <olofj@chromium.org>
>> [ jonathanh@nvidia.com: Rebased on linux-next from v3.18. Changed
>>   userspace pointer type for multi command to be a u64. Renamed
>>   from combo commands to multi commands. Updated patch based upon
>>   feedback review comments received. Updated commit message ]
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Overall this looks good to me, only some minor nits.
> 
> Also, it does seem like you have invested quite some work here.
> Perhaps you should claim the authorship and instead give Seshagiri
> some cred in the commit message + his signed-off by?

Yes that's fine with me, plus everyone will know who to blame ;-)

> Anyway, I am fine with whatever!
> 
>> ---
>> V3 changes:
>> - Updated mmc_ioc_multi_cmd structure per Grant's feedback
>> V2 changes:
>> - Updated changelog per Arnd's feedback
>> - Moved mmc_put/get_card() outside of __mmc_blk_ioctl_cmd()
>>
>>  drivers/mmc/card/block.c       | 214 ++++++++++++++++++++++++++++++-----------
>>  include/uapi/linux/mmc/ioctl.h |  19 +++-
>>  2 files changed, 177 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index c742cfd7674e..2007023815cb 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -387,6 +387,24 @@ out:
>>         return ERR_PTR(err);
>>  }

[snip]

>> +static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>> +                            struct mmc_ioc_cmd __user *ic_ptr)
>> +{
>> +       struct mmc_blk_ioc_data *idata;
>> +       struct mmc_blk_data *md;
>> +       struct mmc_card *card;
>> +       int err;
>> +
>> +       /*
>> +        * The caller must have CAP_SYS_RAWIO, and must be calling this on the
>> +        * whole block device, not on a partition.  This prevents overspray
>> +        * between sibling partitions.
>> +        */
>> +       if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
>> +               return -EPERM;
> 
> This check is common for multi and non-multi. Please move it to the
> mmc_blk_ioctl() to avoid some code duplication.

Yes that's true. I can move but it means also passing bdev to
__mmc_blk_ioctl_cmd() as another argument. It is not a big deal, but it
was more convenient to test here. If your preference is to consolidate
the tests to one place then I will move this test.

Cheers
Jon


