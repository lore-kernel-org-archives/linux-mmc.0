From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 6/8] mmc: dw_mmc: Generic MMC tuning with the clock phase
 framework
Date: Thu, 17 Sep 2015 11:03:52 +0900
Message-ID: <55FA1F88.3090108@samsung.com>
References: <1441045446-30858-1-git-send-email-heiko@sntech.de>
 <8878355.D5Q8mk4qcM@diego> <55F8D442.5020004@samsung.com>
 <2272810.k4vHSW5D0y@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-reply-to: <2272810.k4vHSW5D0y@diego>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: =?windows-1252?Q?Heiko_St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Alexandru M Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, CPGS <cpgs-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 09/16/2015 11:52 PM, Heiko St=FCbner wrote:
> Hi,
> =

> Am Mittwoch, 16. September 2015, 11:30:26 schrieb Jaehoon Chung:
>> On 09/16/2015 07:09 AM, Heiko St=FCbner wrote:
>>> Am Dienstag, 15. September 2015, 17:25:38 schrieb Jaehoon Chung:
>>>> On 09/01/2015 03:24 AM, Heiko Stuebner wrote:
>>>>> From: Alexandru M Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>>>>
>>>>> This algorithm will try 1 degree increments, since there's no way to
>>>>> tell
>>>>> what resolution the underlying phase code uses. As an added bonus, do=
ing
>>>>> many tunings yields better results since some tests are run more than
>>>>> once
>>>>> (ex: if the underlying driver uses 45 degree increments, the tuning c=
ode
>>>>> will try the same angle more than once).
>>>>>
>>>>> It will then construct a list of good phase ranges (even ranges that
>>>>> cross
>>>>> 360/0), will pick the biggest range then it will set the sample_clk to
>>>>> the
>>>>> middle of that range.
>>>>>
>>>>> We do not touch ciu_drive (and by extension define default-drive-phas=
e).
>>>>> Drive phase is mostly used to define minimum hold times, while one co=
uld
>>>>> write some code to determine what phase meets the minimum hold time (=
ex
>>>>> 10
>>>>> degrees) this will not work with the current clock phase framework
>>>>> (which
>>>>> floors angles, so we'll get 0 deg, and there's no way to know what
>>>>> resolution the floors happen at). We assume that the default drive
>>>>> angles
>>>>> set by the hardware are good enough.
>>>>>
>>>>> If a device has device specific code (like exynos) then that will sti=
ll
>>>>> take precedence, otherwise this new code will execute. If the device
>>>>> wants
>>>>> to tune, but has no sample_clk defined we'll return EIO with an error
>>>>> message.
>>>>
>>>> Which point is "_generic_"? I don't find the code that control the
>>>> register
>>>> relevant to CLK_DRV/SMPL PHASE. It seems that posted the similar patch=
es
>>>> at
>>>> u-boot mailing list..
>>>
>>> The "generic" part is that it uses the clk phase API for dw_mmc
>>> implementations where the clkgen controlling interface is outside the
>>> dw_mmc IP itself. So it's open for other implementations as well.
>>
>> Designware IP also has the CLK phase register(UHS_REG_EXT register)...
>> if this code is related with it, it should be located into dw-mmc.c.
> =

> UHS_REG_EXT is acutally "reserved" on both the rk3288 as well as the rk33=
68. =

> rk3036/rk3128 (Cortex-A7) provide a bit description, but the tuning =

> documentation still uses the controls located in the clock controller.
> =

> So I guess UHS_REG_EXT is the real "generic" solution.
> =

>>> But if you are more comfortable with it, I can also move it into the
>>> dw_mmc- rockchip variant for the time being, until another user comes
>>> along.
>> I think more better that this code is located into dw_mmc-rockchip. how
>> about?
> =

> As described above, moving that to the rockchip part sounds sensible. And=
 I =

> guess we can think more about it, once a second user appears.

Sure, we can think more about this.
As you knew, clock phase is closely related to the timing issue.
So clock phase scheme needs to control however.
In future, if somebody introduce the similar control as rockchip, we can di=
scuss about it.

Best Regards,
Jaehoon Chung

> =

> =

> Heiko
> =
