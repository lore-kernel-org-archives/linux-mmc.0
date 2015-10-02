From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Fri, 02 Oct 2015 16:53:36 +0900
Message-ID: <560E3800.1060603@samsung.com>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
 <CAPDyKFqrkYXsbBJ61yYo0G8za1szARvA=as-5nLTiwGH5pCrEQ@mail.gmail.com>
 <560DF150.3000906@samsung.com> <3312969.jJ2hfB2JkV@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <3312969.jJ2hfB2JkV@diego>
Sender: linux-clk-owner@vger.kernel.org
To: =?windows-1252?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Doug Anderson <dianders@chromium.org>, Alexandru Stan <amstan@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On 10/02/2015 04:06 PM, Heiko St=FCbner wrote:
> Am Freitag, 2. Oktober 2015, 11:52:00 schrieb Jaehoon Chung:
>> On 10/02/2015 06:05 AM, Ulf Hansson wrote:
>>> On 1 October 2015 at 19:35, Stephen Boyd <sboyd@codeaurora.org> wro=
te:
>>>> On 10/01, Heiko St=FCbner wrote:
>>>>> Am Donnerstag, 1. Oktober 2015, 11:54:24 schrieb Ulf Hansson:
>>>>>> On 30 September 2015 at 16:55, Heiko St=FCbner <heiko@sntech.de>=
 wrote:
>>>>>>> Am Mittwoch, 30. September 2015, 16:42:05 schrieb Ulf Hansson:
>>>>>>>> On 30 September 2015 at 16:07, Heiko Stuebner <heiko@sntech.de=
>=20
> wrote:
>>>>>>> The clock changes of course only touch internals of the phase-c=
locks,
>>>>>>> so
>>>>>>> should have no problem going through another tree.
>>>>>>
>>>>>> What happens if I take mmc and dt changes, wouldn't I need the c=
lock
>>>>>> patches as well?
>>>>>
>>>>> The API stays of course the same, only the degree to settings
>>>>> translation gets optimized, so I guess in the worst case you woul=
d get
>>>>> no good phase and thus fall back to non-highspeed modes - but the
>>>>> system would stay running.
>>>>>
>>>>> But of course, if the clock maintainers could Ack the two clock p=
atches
>>>>> and
>>>>> everything would stay together that would work even better :-)
>>>>
>>>> If Ulf doesn't want to take them we can apply them to clk tree.
>>>> Otherwise, you can have my acked-by on the clk patches.
>>>
>>> I don't mind picking up the clock patches. So I consider this as an
>>> ack for both patch 1 and patch2, thanks.
>>>
>>> Now, let's give Jaehoon some time to review the dw_mmc parts.
>>
>> I will check other patches on today, if it's ok, i will apply at my
>> repository. Thanks for giving time! :)
>=20
> I think Ulf wanted to apply the whole series via the mmc tree directl=
y, but I=20
> guess that is between you two to decide ;-)

If it will get Stephen's acked-by, i will pick up all after checked the=
 dwmmc patches. how about?

Best Regards,
Jaehoon Chung

>=20
>=20
> Heiko
>=20

