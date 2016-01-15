From: Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC PATCH] mmc: dw_mmc: remove the prefix "SDMMC_##" into mci_read/write
Date: Fri, 15 Jan 2016 09:56:39 -0800
Message-ID: <CAD=FV=W1P0S1G_LCD=-=XoYF3ZWpfmVq1ezsUYeGHrVpz=_u=g@mail.gmail.com>
References: <569379BE.8070907@samsung.com>
	<CAGOxZ53SsR6twPsAj==FJFj4-skbxV1FC1hfM2usioTEWM7cQQ@mail.gmail.com>
	<5699130B.9080705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36723 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbcAOR4k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2016 12:56:40 -0500
Received: by mail-yk0-f177.google.com with SMTP id v14so457771601ykd.3
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2016 09:56:40 -0800 (PST)
In-Reply-To: <5699130B.9080705@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@gmail.com>
Cc: Alim Akhtar <alim.akhtar@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Hi,

On Fri, Jan 15, 2016 at 7:40 AM, Jaehoon Chung <jh80.chung@gmail.com> wrote:
> Hi, Alim.
>
> On 01/15/2016 10:20 PM, Alim Akhtar wrote:
>> Hi Jaehoon,
>>
>> On Mon, Jan 11, 2016 at 3:15 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> It's fixed "SDMMC_##" as prefix into mci_read/write.
>>> So it's difficult to debug or read which offset is used.
>>> If it's passed by original defined register name, it can be checked
>>> which offset is used, and more readability than now.
>>>
>>
>> From commit message it is not clear what problem/difficulty you faced
>> with the current setup?
>> and how does this patch help to resolve the same?
>> Can you put some more light on the same?
>
> Thanks for comments. :)
> Indeed, there is no problem..It's just difficult to search for the defined location with "ctags".
>
> Even though we know that it's related with CTRL register,
> it's difficult to find where CTRL is defined, which offset is used.
> I used the 'grep', 'cscope' command or other methods.
> If using this patch, we can search the defined location more easier than now with "ctags".
>
> When dwmmc controller was implemented, it was defined with "SDMMC_##" in mci_read/write() function.
> But i didn't find the benefit about wrapping the register name.
>
> Actually, it should be my preference.
> If you agree my preference, i will resend the patch with commit msg in more detail.

I agree with your preference.  It's a bunch of churn that touches lots
of lines in the file, but it definitely helps when searching through
the code, especially for those not familiar with it.

-Doug
