From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] mmc: reduce nesting and join error strings into one line
Date: Fri, 15 Apr 2016 19:14:40 +0900
Message-ID: <CAK7LNAS8mLwYdRFyuevh7RbGutC8-xAQPUHmfg28fyEfHk1_Aw@mail.gmail.com>
References: <1455018191-8545-1-git-send-email-yamada.masahiro@socionext.com>
	<CAK7LNARfTbN2ZO5APHtM7gY1cmqyCQV4FuSHx5h_D+PkfjxOAw@mail.gmail.com>
	<CAPDyKFqV4bwrqsGOsEnWWYrYmC5Z9-PvH9faBXuWsnJNQck6Ag@mail.gmail.com>
	<CAK7LNAS2eoDJCcHuiNP8vBE2W0=TNrqSqguYqnX4y5iHPJH2uA@mail.gmail.com>
	<CAPDyKFr-6ZEw+0EchJJHE4_Rh_9WMe8yoxtiaXze1_U-3Tmhhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91]:42942 "EHLO
	conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbcDOKPD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2016 06:15:03 -0400
In-Reply-To: <CAPDyKFr-6ZEw+0EchJJHE4_Rh_9WMe8yoxtiaXze1_U-3Tmhhg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>

2016-04-15 18:36 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 15 April 2016 at 11:30, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2016-04-15 18:26 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
>>> On 15 April 2016 at 11:01, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> Hi Ulf,
>>>>
>>>> No interest in this clean-up?
>>>>
>>>
>>> Well, no.
>>>
>>> Don't get me wrong, I am interested in clean-ups, but this doesn't
>>> improve code quality that much.
>>>
>>
>> At least, current code splits the error message string into two lines.
>>
>>
>
> Yes, and that minor improvement also makes it more cumbersome to use
> "git blame" when trying to understand why something was changed.
>
> Hopes that clarifies how I think. It's balance. :-)

OK.  This balance slightly varies from maintainer to maintainer.

I am quite new to this sub-system, so I need to learn your criteria.

I spent some time to read the MMC core code before starting to write
my own MMC driver.
During diving into the code, I left some tiny patches,
which I think clean-ups(, but perhaps sound cumbersome for you).

So, please give me your 1 minute to learn how your bar's height.

For example, is the following above or below your bar?
https://github.com/masahir0y/linux-yamada/commit/fe4e4bc06

If welcome, I am happy to post it, of course.
but if not, please feel free to say so.

Thanks.

-- 
Best Regards
Masahiro Yamada
