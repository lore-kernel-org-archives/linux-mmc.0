From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] mmc: change to use kmalloc
Date: Wed, 11 Nov 2015 16:17:46 -0500
Message-ID: <5643B07A.3090208@hurleysoftware.com>
References: <1447215791-19429-1-git-send-email-yalin.wang2010@gmail.com>
 <CAGOxZ53m0Fiudgt-gUBH2QhOW291tVmx1pFyeX5qmO_3kHQvSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35750 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbKKVRt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Nov 2015 16:17:49 -0500
Received: by ioc74 with SMTP id 74so46154115ioc.2
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2015 13:17:48 -0800 (PST)
In-Reply-To: <CAGOxZ53m0Fiudgt-gUBH2QhOW291tVmx1pFyeX5qmO_3kHQvSQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>, yalin wang <yalin.wang2010@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, ben@decadent.org.uk, Jaehoon Chung <jh80.chung@samsung.com>, asaf.vertz@tandemg.com, tklauser@distanz.ch, jonathanh@nvidia.com, "James E.J. Bottomley" <JBottomley@odin.com>, Grant Grundler <grundler@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 11/11/2015 12:02 PM, Alim Akhtar wrote:
> Hi Yalin,
> 
> On Wed, Nov 11, 2015 at 9:53 AM, yalin wang <yalin.wang2010@gmail.com> wrote:
>> Use kmalloc instead of kzalloc, zero the memory is not needed.
>>
> why you want to do this? what problem you faces, and how this resolves the same?

The patch fixes an inefficiency: explicitly zeroing memory that is then
immediately overwritten 6 lines below is wasteful.

Regards,
Peter Hurley

>> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
>> ---
>>  drivers/mmc/card/block.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 23b6c8e..975cd3e 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -365,7 +365,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
>>         if (!idata->buf_bytes)
>>                 return idata;
>>
>> -       idata->buf = kzalloc(idata->buf_bytes, GFP_KERNEL);
>> +       idata->buf = kmalloc(idata->buf_bytes, GFP_KERNEL);
>>         if (!idata->buf) {
>>                 err = -ENOMEM;
>>                 goto idata_err;
>> --
>> 1.9.1

