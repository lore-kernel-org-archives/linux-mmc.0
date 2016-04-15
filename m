From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] mmc: reduce nesting and join error strings into one line
Date: Fri, 15 Apr 2016 18:30:02 +0900
Message-ID: <CAK7LNAS2eoDJCcHuiNP8vBE2W0=TNrqSqguYqnX4y5iHPJH2uA@mail.gmail.com>
References: <1455018191-8545-1-git-send-email-yamada.masahiro@socionext.com>
	<CAK7LNARfTbN2ZO5APHtM7gY1cmqyCQV4FuSHx5h_D+PkfjxOAw@mail.gmail.com>
	<CAPDyKFqV4bwrqsGOsEnWWYrYmC5Z9-PvH9faBXuWsnJNQck6Ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqV4bwrqsGOsEnWWYrYmC5Z9-PvH9faBXuWsnJNQck6Ag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

2016-04-15 18:26 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 15 April 2016 at 11:01, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Hi Ulf,
>>
>> No interest in this clean-up?
>>
>
> Well, no.
>
> Don't get me wrong, I am interested in clean-ups, but this doesn't
> improve code quality that much.
>

At least, current code splits the error message string into two lines.



-- 
Best Regards
Masahiro Yamada
