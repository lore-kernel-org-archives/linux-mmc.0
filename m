From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 6/8] mmc: dw_mmc: Generic MMC tuning with the clock phase
 framework
Date: Wed, 16 Sep 2015 11:30:26 +0900
Message-ID: <55F8D442.5020004@samsung.com>
References: <1441045446-30858-1-git-send-email-heiko@sntech.de>
 <1441045446-30858-7-git-send-email-heiko@sntech.de>
 <55F7D602.70003@samsung.com> <8878355.D5Q8mk4qcM@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <8878355.D5Q8mk4qcM@diego>
Sender: linux-clk-owner@vger.kernel.org
To: =?windows-1252?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: ulf.hansson@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandru M Stan <amstan@chromium.org>, CPGS <cpgs@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 09/16/2015 07:09 AM, Heiko St=FCbner wrote:
> Hi,
>=20
> Am Dienstag, 15. September 2015, 17:25:38 schrieb Jaehoon Chung:
>> On 09/01/2015 03:24 AM, Heiko Stuebner wrote:
>>> From: Alexandru M Stan <amstan@chromium.org>
>>>
>>> This algorithm will try 1 degree increments, since there's no way t=
o tell
>>> what resolution the underlying phase code uses. As an added bonus, =
doing
>>> many tunings yields better results since some tests are run more th=
an once
>>> (ex: if the underlying driver uses 45 degree increments, the tuning=
 code
>>> will try the same angle more than once).
>>>
>>> It will then construct a list of good phase ranges (even ranges tha=
t cross
>>> 360/0), will pick the biggest range then it will set the sample_clk=
 to the
>>> middle of that range.
>>>
>>> We do not touch ciu_drive (and by extension define default-drive-ph=
ase).
>>> Drive phase is mostly used to define minimum hold times, while one =
could
>>> write some code to determine what phase meets the minimum hold time=
 (ex 10
>>> degrees) this will not work with the current clock phase framework =
(which
>>> floors angles, so we'll get 0 deg, and there's no way to know what
>>> resolution the floors happen at). We assume that the default drive =
angles
>>> set by the hardware are good enough.
>>>
>>> If a device has device specific code (like exynos) then that will s=
till
>>> take precedence, otherwise this new code will execute. If the devic=
e wants
>>> to tune, but has no sample_clk defined we'll return EIO with an err=
or
>>> message.
>>
>> Which point is "_generic_"? I don't find the code that control the r=
egister
>> relevant to CLK_DRV/SMPL PHASE. It seems that posted the similar pat=
ches at
>> u-boot mailing list..
>=20
> The "generic" part is that it uses the clk phase API for dw_mmc=20
> implementations where the clkgen controlling interface is outside the=
 dw_mmc=20
> IP itself. So it's open for other implementations as well.

Designware IP also has the CLK phase register(UHS_REG_EXT register)...
if this code is related with it, it should be located into dw-mmc.c.

>=20
> But if you are more comfortable with it, I can also move it into the =
dw_mmc-
> rockchip variant for the time being, until another user comes along.

I think more better that this code is located into dw_mmc-rockchip. how=
 about?

Best Regards,
Jaehoon Chung

>=20
>=20
> Heiko
>=20
>=20

