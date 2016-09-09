From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Use a default maximum erase timeout
Date: Fri, 9 Sep 2016 11:45:53 +0200
Message-ID: <CAPDyKFp5W+AX79F7ho3DnX8huYYSd3OxBeuL_3C9Yf3tT8Zjjw@mail.gmail.com>
References: <1472815801-24932-1-git-send-email-ulf.hansson@linaro.org> <8962af00-8735-a419-5de8-50d5f3eda72d@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36918 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbcIIJpz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Sep 2016 05:45:55 -0400
Received: by mail-wm0-f47.google.com with SMTP id w12so22813069wmf.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Sep 2016 02:45:55 -0700 (PDT)
In-Reply-To: <8962af00-8735-a419-5de8-50d5f3eda72d@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Baolin Wang <baolin.wang@linaro.org>

On 6 September 2016 at 03:59, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi Ulf,
>
> On 2016/9/2 19:30, Ulf Hansson wrote:
>>
>> In cases when the host->max_busy_timeout isn't specified, the calculated
>> number of maximum discard sectors defaults to UINT_MAX. This may cause a
>> too long timeout for a discard request.
>
>
>
> There is a android specific case(aka recovery stage) which may stuck IO
> routine for a very long time (I saw 7 mins for the wrost case) . After
> flashing ROM or factory reset, it will wipe a large number of sectors
> with secure tag[0]. We can image that we may do secdiscard for a 100GB
> free disk and unfortunately the max_busy_timeout isn't specified. It's
> probably ok as on recovery stage there are no other tasks competing for
> the IO and we hope the wipe action could finish ASAP. But if this case
> happens for normal runing time, the system/user-space will be broken
> anyway for waiting for such a long time. So this patch looks sane.

Okay, I have queued this up for next and added your reviewed-by tag.

>
>
> [0]:
> https://android.googlesource.com/platform/system/extras/+/61d6591/ext4_utils/wipe.c
>

Thanks for the information.

Kind regards
Uffe
