From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/4] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Thu, 19 Mar 2015 12:14:11 +0100
Message-ID: <CAPDyKFrkznbW7k_=BDo99jJhWzDbUgbeU+MXWB_E_UWXh=56Eg@mail.gmail.com>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
	<1426112117-18220-2-git-send-email-dianders@chromium.org>
	<CAPDyKFq_WMJfqNGuxwN7xPmhv2X6-+G1zXpdD6zYDkDe7-Jo2A@mail.gmail.com>
	<CAD=FV=U-YnT5jF5MFC==hANXGPqVpV3iLMPu85TrQ4dNDsWeCA@mail.gmail.com>
	<CAPDyKFpG=q88QEkuAgoLqkZU40Kx7dB7PmnXHqEt0EtbYvR_Cg@mail.gmail.com>
	<CAD=FV=X=1=AnXCGgWWkJDcHLO-MfVqsSB2aJxi3WOgWJhD_ggA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=X=1=AnXCGgWWkJDcHLO-MfVqsSB2aJxi3WOgWJhD_ggA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Alexandru Stan <amstan@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Addy Ke <addy.ke@rock-chips.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, Johan Rudholm <johan.rudholm@axis.com>, Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 19 March 2015 at 05:09, Doug Anderson <dianders@chromium.org> wrote:
> Ulf,
>
> On Tue, Mar 17, 2015 at 3:23 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> This will get us within .3V of whatever vmmc is.  If vmmc is 3.3V, it
>>> will allow vqmmc of 3.0V - 3.6V.
>>>
>>> This _seems_ sane to me and given any sane system design we should be
>>> fine here, I think.  I can't see someone designing a system where
>>> vqmmc was not within .3V of vmmc, can you?  If we think someone will
>>> actually build a system where vmmc is 3.3V and vqmmc can't go higher
>>> than 2.7V then we'll either need to increase the tolerance here or add
>>> a new asymmetric system call like my original patches did.
>>
>> I know about SoC that supports 3.4V vmmc and 2.9V vqmmc.
>>
>> What I think we need is the option to have a policy here. We need to
>> allow voltage levels stated by the spec and at the same time try chose
>> the one best suited. That's not being accomplished here.
>>
>> Moreover, I wonder whether it's okay (from spec perspective) to have
>> vqmmc at a higher voltage level than vmmc. I don't think that's
>> allowed, but I might be wrong.
>
> OK, so sounds like I need to add a regulator_set_voltage_tol2()
> function that takes in an upper tolerance and a lower.  We can use the
> same rough implementation in the core we have today (if Mark is OK
> with that) with regulator_set_voltage_tol() but just allow it to be
> asymmetric.

Agree. Moreover we need that API to also pick the closest value to
target, when trying the range "target->minimum". I also believe it
would be good to allow both upper and lower limits to be zero.

If Mark disagrees with this approach, we will have to deal with all
the magic inside the mmc core layer. Very much similar how
mmc_regulator_get_ocrmask() is implemented.

Kind regards
Uffe

>
> From what I see in the spec for 3.3V cards are supposed to react to a
> high signal that is .625 * VDD - VDD + .3
>
>
> I might not be able to get to this till next week, though...
>
> -Doug
