From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: 4.8-rc1 REGRESSION mmc-blk triggers WARN_ON(!host->claimed),
 related to: "drivers: use req op accessor" ?
Date: Fri, 26 Aug 2016 09:13:34 +0200
Message-ID: <CAPDyKFrZCNv9VWu1pVg02wE3Pth3z3J0uh5dCdeYU8LYd_wXJQ@mail.gmail.com>
References: <6e68ae5a-4b79-a636-2c46-5726cf2cc44b@redhat.com>
 <57BB23D0.3050606@redhat.com> <2a2ee1e8-8682-0647-a66d-04ceb54f58ec@redhat.com>
 <6bfb134a-43bf-addd-3ff0-cc1d677a1606@intel.com> <7210392e-2c1c-5676-bb53-274ea6a5ca74@redhat.com>
 <41ab9b3e-cb39-fb9e-defd-f38ea6d5b791@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36261 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750700AbcHZHOZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2016 03:14:25 -0400
Received: by mail-wm0-f52.google.com with SMTP id q128so267238302wma.1
        for <linux-mmc@vger.kernel.org>; Fri, 26 Aug 2016 00:13:37 -0700 (PDT)
In-Reply-To: <41ab9b3e-cb39-fb9e-defd-f38ea6d5b791@fb.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jens Axboe <axboe@fb.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Mike Christie <mchristi@redhat.com>, regressions@leemhuis.info, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 25 August 2016 at 22:12, Jens Axboe <axboe@fb.com> wrote:
> On 08/25/2016 12:26 PM, Hans de Goede wrote:
>>>>
>>>> I've tried 4.8-rc3 with my hack drop and this commit cherry-picked,
>>>> but the problem is still there, so this patch does not fix it.
>>>
>>>
>>> I wasn't able to reproduce your problem, but a possibility could be
>>> accessing the request after it is completed.  You could try this:
>>
>>
>> Good catch, that seems to fix things for me. Note sometimes this bug
>> would not hit immediately for me. But I've been running several
>> affected boards for about 1 hour or so, without issues, so I believe
>> this is fixed. So this is:
>>
>> Tested-by: Hans de Goede <hdegoede@redhat.com>
>
>
> Awesome, thanks for reporting/testing. Adrian, I have turned it into a real
> patch and applied it for 4.8. Thanks!

Jens, thanks for helping out! You may add my ack for it!

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

BTW, for some reason I (and linux-mmc) was not cc:ed on the commit
that caused the regression:

c2df40dfb8c015211ec55f4b1dd0587f875c7b34
Author: Mike Christie <mchristi@redhat.com>
Date:   Sun Jun 5 14:32:17 2016 -0500
    drivers: use req op accessor

Even if I probably wouldn't noticed that the patch was incorrect, it
would have helped to know that we changed some parts in the mmc block
layer when trying to find the regression. Could you please keep on eye
on this future wise so it doesn't happen again.

Kind regards
Uffe
