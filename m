From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 3/3] mmc: dw_mmc: Dont cut off vqmmc and vmmc
Date: Thu, 28 Aug 2014 09:25:55 +0200
Message-ID: <CAPDyKFrcA183V-R-nbZcY8wXCRqONb1WUu3BS_0vNJe2+Ej2_w@mail.gmail.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
	<1408715272-13833-4-git-send-email-yuvaraj.cd@samsung.com>
	<CAPDyKFqz8sGj2td=ihZXN4zvAqmu9FHZjWdCn-ZRcdHugNHe2g@mail.gmail.com>
	<CAPz6YkXH1mMOTwcLkKdffdUHN+TaCAhpa8oG0h+rFn9i+GMoCw@mail.gmail.com>
	<CAPDyKFqp7oEt9ASmdxrgUwbQ8aTZzAuJ7uD1oGN50iuzPzBfVg@mail.gmail.com>
	<CAD=FV=VQWzhiSU+iULACj+Dp_tDf3SszQ8ELLEGqVEyJJRQy1Q@mail.gmail.com>
	<CAPDyKFo9-5=uPqD8RvLGsYtSCynBFnGGeSCpwLZuzDtW+652hA@mail.gmail.com>
	<CAD=FV=VveHTYmiBu42DJeFFGARV2+1bS6Y2CQM995YkX_O9SQA@mail.gmail.com>
	<CAPDyKFpUU643iXVbxuu9Vx1zY0K7x4z-ZxxVEWd+Lsuwp0iA+g@mail.gmail.com>
	<CAD=FV=Vqz=kA=D5KDyq_QuPi-6B05VixYManTsFe2PC-fzxRkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:54813 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936165AbaH1HZ4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Aug 2014 03:25:56 -0400
Received: by mail-la0-f46.google.com with SMTP id pv20so418739lab.33
        for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2014 00:25:55 -0700 (PDT)
In-Reply-To: <CAD=FV=Vqz=kA=D5KDyq_QuPi-6B05VixYManTsFe2PC-fzxRkw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: Sonny Rao <sonnyrao@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, ABHILASH KESAVAN <a.kesavan@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

On 27 August 2014 17:52, Doug Anderson <dianders@google.com> wrote:
> Ulf,
>
> On Wed, Aug 27, 2014 at 4:17 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> Now, we've got MMC_CAP_NEEDS_POLL, so dw_mmc will periodically be
>>> called to check the card detect line, but with vmmc and vqmmc off.  It
>>> will be unable to return a sensible value without actually turning on
>>> vmmc and vqmmc.
>>
>> Currently MMC_CAP_NEEDS_POLL mean the mmc rescan work will reschedule
>> itself with HZ interval. This to check for card insert/removal.
>>
>> Now, mmc_rescan() will, if present, invoke host's ->get_cd() callback
>> to check whether it's worth to continue initialization sequence or if
>> it should re-schedule itself again.
>>
>> If your host driver can distinguish whether a card is inserted, which
>> in this case are when vccq is turned off, your ->get_cd() callback need
>> to return 1. That will allow mmc_rescan() to continue it's
>> initialization sequence and do mmc_power_up().
>
> As per my other email, we can't tell whether a card is inserted when
> vqmmc is off.

I understand.

The solution I proposed above, is:

1) Enable MMC_CAP_NEEDS_POLL.
2) Make ->get_cd() return 1, when you can't distinguish if the card is inserted.

That will solve this issue and without messing up the mmc core.

>
> Does this mean that you have removed your objections to a solution
> like Yuvaraj has posted?  We still need to break it into two patches
> (the core part and the dwmmc part), but otherwise is it OK?  I can
> post the original patch I sent Yuvaraj if it's helpful (or he can just
> include my patch as part 1 of his series).

No. This can entirely be fixed in the host driver. As suggested above.

Kind regards
Uffe
