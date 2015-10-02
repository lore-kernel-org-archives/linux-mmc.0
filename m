From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Fri, 2 Oct 2015 10:43:55 +0200
Message-ID: <CAPDyKFro3Uk3+Jzz3Y0WBKZvTs5LjahT7KgRbh_nWWVBG7V3=w@mail.gmail.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
	<CAPDyKFqrkYXsbBJ61yYo0G8za1szARvA=as-5nLTiwGH5pCrEQ@mail.gmail.com>
	<560DF150.3000906@samsung.com>
	<3312969.jJ2hfB2JkV@diego>
	<560E3800.1060603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34973 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbJBIn4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2015 04:43:56 -0400
Received: by wicge5 with SMTP id ge5so23004209wic.0
        for <linux-mmc@vger.kernel.org>; Fri, 02 Oct 2015 01:43:55 -0700 (PDT)
In-Reply-To: <560E3800.1060603@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Doug Anderson <dianders@chromium.org>, Alexandru Stan <amstan@chromium.org>

On 2 October 2015 at 09:53, Jaehoon Chung <jh80.chung@samsung.com> wrot=
e:
> On 10/02/2015 04:06 PM, Heiko St=C3=BCbner wrote:
>> Am Freitag, 2. Oktober 2015, 11:52:00 schrieb Jaehoon Chung:
>>> On 10/02/2015 06:05 AM, Ulf Hansson wrote:
>>>> On 1 October 2015 at 19:35, Stephen Boyd <sboyd@codeaurora.org> wr=
ote:
>>>>> On 10/01, Heiko St=C3=BCbner wrote:
>>>>>> Am Donnerstag, 1. Oktober 2015, 11:54:24 schrieb Ulf Hansson:
>>>>>>> On 30 September 2015 at 16:55, Heiko St=C3=BCbner <heiko@sntech=
=2Ede> wrote:
>>>>>>>> Am Mittwoch, 30. September 2015, 16:42:05 schrieb Ulf Hansson:
>>>>>>>>> On 30 September 2015 at 16:07, Heiko Stuebner <heiko@sntech.d=
e>
>> wrote:
>>>>>>>> The clock changes of course only touch internals of the phase-=
clocks,
>>>>>>>> so
>>>>>>>> should have no problem going through another tree.
>>>>>>>
>>>>>>> What happens if I take mmc and dt changes, wouldn't I need the =
clock
>>>>>>> patches as well?
>>>>>>
>>>>>> The API stays of course the same, only the degree to settings
>>>>>> translation gets optimized, so I guess in the worst case you wou=
ld get
>>>>>> no good phase and thus fall back to non-highspeed modes - but th=
e
>>>>>> system would stay running.
>>>>>>
>>>>>> But of course, if the clock maintainers could Ack the two clock =
patches
>>>>>> and
>>>>>> everything would stay together that would work even better :-)
>>>>>
>>>>> If Ulf doesn't want to take them we can apply them to clk tree.
>>>>> Otherwise, you can have my acked-by on the clk patches.
>>>>
>>>> I don't mind picking up the clock patches. So I consider this as a=
n
>>>> ack for both patch 1 and patch2, thanks.
>>>>
>>>> Now, let's give Jaehoon some time to review the dw_mmc parts.
>>>
>>> I will check other patches on today, if it's ok, i will apply at my
>>> repository. Thanks for giving time! :)
>>
>> I think Ulf wanted to apply the whole series via the mmc tree direct=
ly, but I
>> guess that is between you two to decide ;-)
>
> If it will get Stephen's acked-by, i will pick up all after checked t=
he dwmmc patches. how about?

Stephen already acked the clock patches from this thread.

Perhaps this time, it's easier if you ack the dw_mmc patches and I can
pick up the hole series? Does that work for you?

Kind regards
Uffe
