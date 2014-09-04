From: Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>
Subject: Re: [RFC PATCH 1/1 v8]mmc: Support-FFU-for-eMMC-v5.0
Date: Thu, 4 Sep 2014 09:06:25 +0800
Message-ID: <CAC1bqKgvUeXewN202yc=txnJuan88GJTQMPKCeA38N1SGEzAmA@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE64B934609@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFr52GkJC-2A4b6dy7VYZZsVgCHnT-GdL_9ZkF=Hd4H=Jw@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333AE73534@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFoFq+XkjVqycEorUDU_aKACPQkHvEsdJjJkj+P=FET5cA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333AE8EC81@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFqumUdoxnGg8nU9FfqEUOGvBfFNBdfg4kW=V4WF5r_OSg@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333AEB94FF@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFpUCvHaq2XrgGVhYJCuDVBALjv9H4bV5g0Z9pKf0ZbieQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:33726 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933102AbaIDBG1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Sep 2014 21:06:27 -0400
Received: by mail-we0-f170.google.com with SMTP id p10so9482926wes.15
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2014 18:06:26 -0700 (PDT)
In-Reply-To: <CAPDyKFpUCvHaq2XrgGVhYJCuDVBALjv9H4bV5g0Z9pKf0ZbieQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, Grant Grundler <grundler@chromium.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "Gwendal Grignou (gwendal@chromium.org)" <gwendal@chromium.org>

Hi, Ulf

the data we expected to write in my case is about 288KB.
BTW, Alex's FFU flow already implemented on my platform which using
exynos SoC without problem.

Thanks,
Hsinhsiang

2014-09-01 19:27 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 1 September 2014 11:26, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote:
>> [snip]
>>
>>> My conclusion from that is (correct me if I am wrong, since it may be vendor
>>> specific), that only minor modifications should be needed to the mmc ioctl. We
>>> need to add special treatment for when "cmd.opcode ==
>>> MMC_FFU_DOWNLOAD_OP". In such scenario the following sequence needs to
>>> be maintained.
>>>
>>> 1. Claim host etc.
>>> 2. Set FFU mode.
>>> 3. Write some sectors to the FFU area, but in the same way as any other mmc
>>> ioctl WRITE is done.
>>> 4. Set normal mode.
>>> 5. Relase host etc.
>>>
>>> That sequence then needs to be repeated to write the complete firmware,
>>> depending on buffer size. Between each and every piece of FFU data that is
>>> written, normal READ/WRITE operations can be served.
>>> Right?
>>
>> We checked again the current IOCTL implementation, and we see issues
>> In implementing FFU as suggested above:
>>
>> 1. No support for multiple Write operations.
>>     For running Multiple I/O, user need to send CMD23 or CMD12.
>>     So structures "sbc" or "stop" of "mmc_blk_request" should be set accordingly.
>
> You are right regarding multiple I/O!
>
> I suppose using single block write option (CMD24) still can be used
> for FFU, right?
>
> Yes, we would suffer from unoptimized performance, but on the other
> hand - how much data could we typically be expected to write? Do you
> have some rough numbers that you can share?
>
>>
>> 2. There is a limit in chunk size in current implementation of IOCTL.
>>      From some reason we can't write more than 64KB on our platform,
>>      Although, the MMC_IOC_MAX_BYTES is defined to be 128KB
>
> That is likely because the mmc host driver may limit the size, due to
> it's controller HW.
>
>>
>> Based on this, we think that using existing IOCTL implementation is not
>> a good solution for FFU.
>
> Okay, let's for now continue with your current approach and try to
> address those concerns I have raised while reviewing the code. I will
> happily review new versions of the patch(es).
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
