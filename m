From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: reduce nesting and join error strings into one line
Date: Fri, 15 Apr 2016 11:36:42 +0200
Message-ID: <CAPDyKFr-6ZEw+0EchJJHE4_Rh_9WMe8yoxtiaXze1_U-3Tmhhg@mail.gmail.com>
References: <1455018191-8545-1-git-send-email-yamada.masahiro@socionext.com>
	<CAK7LNARfTbN2ZO5APHtM7gY1cmqyCQV4FuSHx5h_D+PkfjxOAw@mail.gmail.com>
	<CAPDyKFqV4bwrqsGOsEnWWYrYmC5Z9-PvH9faBXuWsnJNQck6Ag@mail.gmail.com>
	<CAK7LNAS2eoDJCcHuiNP8vBE2W0=TNrqSqguYqnX4y5iHPJH2uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35390 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbcDOJgn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2016 05:36:43 -0400
Received: by mail-wm0-f47.google.com with SMTP id a140so23137098wma.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2016 02:36:43 -0700 (PDT)
In-Reply-To: <CAK7LNAS2eoDJCcHuiNP8vBE2W0=TNrqSqguYqnX4y5iHPJH2uA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>

On 15 April 2016 at 11:30, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2016-04-15 18:26 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 15 April 2016 at 11:01, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> Hi Ulf,
>>>
>>> No interest in this clean-up?
>>>
>>
>> Well, no.
>>
>> Don't get me wrong, I am interested in clean-ups, but this doesn't
>> improve code quality that much.
>>
>
> At least, current code splits the error message string into two lines.
>
>

Yes, and that minor improvement also makes it more cumbersome to use
"git blame" when trying to understand why something was changed.

Hopes that clarifies how I think. It's balance. :-)

Kind regards
Uffe
