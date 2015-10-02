From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Fri, 02 Oct 2015 17:48:18 +0900
Message-ID: <560E44D2.9060101@samsung.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
 <CAPDyKFqrkYXsbBJ61yYo0G8za1szARvA=as-5nLTiwGH5pCrEQ@mail.gmail.com>
 <560DF150.3000906@samsung.com> <3312969.jJ2hfB2JkV@diego>
 <560E3800.1060603@samsung.com>
 <CAPDyKFro3Uk3+Jzz3Y0WBKZvTs5LjahT7KgRbh_nWWVBG7V3=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <CAPDyKFro3Uk3+Jzz3Y0WBKZvTs5LjahT7KgRbh_nWWVBG7V3=w@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Doug Anderson <dianders@chromium.org>, Alexandru Stan <amstan@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On 10/02/2015 05:43 PM, Ulf Hansson wrote:
> On 2 October 2015 at 09:53, Jaehoon Chung <jh80.chung@samsung.com> wr=
ote:
>> On 10/02/2015 04:06 PM, Heiko St=C3=BCbner wrote:
>>> Am Freitag, 2. Oktober 2015, 11:52:00 schrieb Jaehoon Chung:
>>>> On 10/02/2015 06:05 AM, Ulf Hansson wrote:
>>>>> On 1 October 2015 at 19:35, Stephen Boyd <sboyd@codeaurora.org> w=
rote:
>>>>>> On 10/01, Heiko St=C3=BCbner wrote:
>>>>>>> Am Donnerstag, 1. Oktober 2015, 11:54:24 schrieb Ulf Hansson:
>>>>>>>> On 30 September 2015 at 16:55, Heiko St=C3=BCbner <heiko@sntec=
h.de> wrote:
>>>>>>>>> Am Mittwoch, 30. September 2015, 16:42:05 schrieb Ulf Hansson=
:
>>>>>>>>>> On 30 September 2015 at 16:07, Heiko Stuebner <heiko@sntech.=
de>
>>> wrote:
>>>>>>>>> The clock changes of course only touch internals of the phase=
-clocks,
>>>>>>>>> so
>>>>>>>>> should have no problem going through another tree.
>>>>>>>>
>>>>>>>> What happens if I take mmc and dt changes, wouldn't I need the=
 clock
>>>>>>>> patches as well?
>>>>>>>
>>>>>>> The API stays of course the same, only the degree to settings
>>>>>>> translation gets optimized, so I guess in the worst case you wo=
uld get
>>>>>>> no good phase and thus fall back to non-highspeed modes - but t=
he
>>>>>>> system would stay running.
>>>>>>>
>>>>>>> But of course, if the clock maintainers could Ack the two clock=
 patches
>>>>>>> and
>>>>>>> everything would stay together that would work even better :-)
>>>>>>
>>>>>> If Ulf doesn't want to take them we can apply them to clk tree.
>>>>>> Otherwise, you can have my acked-by on the clk patches.
>>>>>
>>>>> I don't mind picking up the clock patches. So I consider this as =
an
>>>>> ack for both patch 1 and patch2, thanks.
>>>>>
>>>>> Now, let's give Jaehoon some time to review the dw_mmc parts.
>>>>
>>>> I will check other patches on today, if it's ok, i will apply at m=
y
>>>> repository. Thanks for giving time! :)
>>>
>>> I think Ulf wanted to apply the whole series via the mmc tree direc=
tly, but I
>>> guess that is between you two to decide ;-)
>>
>> If it will get Stephen's acked-by, i will pick up all after checked =
the dwmmc patches. how about?
>=20
> Stephen already acked the clock patches from this thread.
>=20
> Perhaps this time, it's easier if you ack the dw_mmc patches and I ca=
n
> pick up the hole series? Does that work for you?

I doesn't review dwmmc patches (Sorry), could you give me more time?
If you're ok, i will notice to you...then you can pick up all. :)

Best Regards,
Jaehoon Chung

>=20
> Kind regards
> Uffe
>=20

