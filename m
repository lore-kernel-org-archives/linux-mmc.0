From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: add newline to sysfs display of force_ro
Date: Mon, 27 Oct 2014 12:29:18 +0100
Message-ID: <CAPDyKFqPbhCzbep9ZEvsVBLp9QBzftMP=ZczDbpG1ka9p4ie+A@mail.gmail.com>
References: <f7fa9dd28f967c578a07333d92eba159f3f63863.1411369971.git.baruch@tkos.co.il>
	<20141021092012.GB2220@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:44655 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaJ0L3U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Oct 2014 07:29:20 -0400
Received: by mail-qc0-f177.google.com with SMTP id l6so3474953qcy.8
        for <linux-mmc@vger.kernel.org>; Mon, 27 Oct 2014 04:29:19 -0700 (PDT)
In-Reply-To: <20141021092012.GB2220@tarshish>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrei Warkentin <andrey.warkentin@gmail.com>

On 21 October 2014 11:20, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Chris, Ulf,
>
> Ping?
>
> Not a big deal, I guess, but still nice to have for consistency sake.
>
> When applying please make sure to change Andrei's email address.

Thanks! Applied for next!

Kind regards
Uffe

>
> Thanks,
> baruch
>
> On Mon, Sep 22, 2014 at 10:12:51AM +0300, Baruch Siach wrote:
>> Make force_ro consistent with other sysfs entries.
>>
>> Fixes: 371a689f64b0d ('mmc: MMC boot partitions support')
>> Cc: Andrei Warkentin <andreiw@motorola.com>
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>>  drivers/mmc/card/block.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index ede41f05c392..dad364b09952 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -260,7 +260,7 @@ static ssize_t force_ro_show(struct device *dev, struct device_attribute *attr,
>>       int ret;
>>       struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
>>
>> -     ret = snprintf(buf, PAGE_SIZE, "%d",
>> +     ret = snprintf(buf, PAGE_SIZE, "%d\n",
>>                      get_disk_ro(dev_to_disk(dev)) ^
>>                      md->read_only);
>>       mmc_blk_put(md);
>> --
>> 2.1.0
>
> --
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
