From: yalin wang <yalin.wang2010@gmail.com>
Subject: Re: [PATCH] mmc: change to use kmalloc
Date: Thu, 12 Nov 2015 19:27:42 +0800
Message-ID: <F779CDF6-6F14-4E92-A8A8-F0ACBB2AF3C8@gmail.com>
References: <1447215791-19429-1-git-send-email-yalin.wang2010@gmail.com> <CAGOxZ53m0Fiudgt-gUBH2QhOW291tVmx1pFyeX5qmO_3kHQvSQ@mail.gmail.com> <5643B07A.3090208@hurleysoftware.com> <CAHp75VdKODX13UUiUs6i2A2phraAEC5Ok5arN3jNSYPta2-qiA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34140 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbbKLL1w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Nov 2015 06:27:52 -0500
In-Reply-To: <CAHp75VdKODX13UUiUs6i2A2phraAEC5Ok5arN3jNSYPta2-qiA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Alim Akhtar <alim.akhtar@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Ben Hutchings <ben@decadent.org.uk>, Jaehoon Chung <jh80.chung@samsung.com>, asaf.vertz@tandemg.com, Tobias Klauser <tklauser@distanz.ch>, Jon Hunter <jonathanh@nvidia.com>, "James E.J. Bottomley" <JBottomley@odin.com>, Grant Grundler <grundler@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


> On Nov 12, 2015, at 05:57, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> On Wed, Nov 11, 2015 at 11:17 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 11/11/2015 12:02 PM, Alim Akhtar wrote:
>>> Hi Yalin,
>>> 
>>> On Wed, Nov 11, 2015 at 9:53 AM, yalin wang <yalin.wang2010@gmail.com> wrote:
>>>> Use kmalloc instead of kzalloc, zero the memory is not needed.
>>>> 
>>> why you want to do this? what problem you faces, and how this resolves the same?
>> 
>> The patch fixes an inefficiency: explicitly zeroing memory that is then
>> immediately overwritten 6 lines below is wasteful.
> 
> It might fix previous kzalloc as well, though better not to do since
> it's error prone.
> 
yeah,  i will send a new patch ,



>> 
>> Regards,
>> Peter Hurley
>> 
>>>> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
>>>> ---
>>>> drivers/mmc/card/block.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>> 
>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>> index 23b6c8e..975cd3e 100644
>>>> --- a/drivers/mmc/card/block.c
>>>> +++ b/drivers/mmc/card/block.c
>>>> @@ -365,7 +365,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
>>>>        if (!idata->buf_bytes)
>>>>                return idata;
>>>> 
>>>> -       idata->buf = kzalloc(idata->buf_bytes, GFP_KERNEL);
>>>> +       idata->buf = kmalloc(idata->buf_bytes, GFP_KERNEL);
>>>>        if (!idata->buf) {
>>>>                err = -ENOMEM;
>>>>                goto idata_err;
>>>> --
>>>> 1.9.1
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

