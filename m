From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/4] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Tue, 17 Mar 2015 11:23:33 +0100
Message-ID: <CAPDyKFpG=q88QEkuAgoLqkZU40Kx7dB7PmnXHqEt0EtbYvR_Cg@mail.gmail.com>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
	<1426112117-18220-2-git-send-email-dianders@chromium.org>
	<CAPDyKFq_WMJfqNGuxwN7xPmhv2X6-+G1zXpdD6zYDkDe7-Jo2A@mail.gmail.com>
	<CAD=FV=U-YnT5jF5MFC==hANXGPqVpV3iLMPu85TrQ4dNDsWeCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=U-YnT5jF5MFC==hANXGPqVpV3iLMPu85TrQ4dNDsWeCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Alexandru Stan <amstan@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Addy Ke <addy.ke@rock-chips.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, Johan Rudholm <johan.rudholm@axis.com>, Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 16 March 2015 at 16:12, Doug Anderson <dianders@chromium.org> wrote:
> Ulf,
>
> On Mon, Mar 16, 2015 at 7:05 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> +       switch (ios->signal_voltage) {
>>> +       case MMC_SIGNAL_VOLTAGE_120:
>>> +               return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
>>> +                       1200000, 100000);
>>
>> Is 1V the lowest possible value? How did you get to that?
>
> I think you've added a zero in your mind and not realized that I'm
> calling regulator_set_voltage_tol() here and in other calls.  Please
> read the above as:

Hehe, you are absolutely right.

>
> * Try to set the voltage to exactly 1,200,000 uV (1.2V).
> * If you can't get 1.2V exactly, a tolerance ("tol") of 100,000 uV
> (.1V) is OK.
> * In other words, 1.1V - 1.3V are OK, but aim for 1.2V

So what happens in the case when 1.3V and 1.1V, but not 1.2V. Which
value will be used? Is that algorithm defined by the regulator core or
does it depend per regulator implementation?

>
>
>>> +       case MMC_SIGNAL_VOLTAGE_180:
>>> +               return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
>>> +                       1800000, 100000);
>>
>> Is 1V the lowest possible value? How did you get to that?
>
> Again, check my zeros.  This should be 1.7 - 1.9V, aiming for 1.8V.
>
>
>>> +       case MMC_SIGNAL_VOLTAGE_330:
>>> +               return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
>>> +                       regulator_get_voltage(mmc->supply.vmmc), 300000);
>>
>> Why 3V? Shouldn't it be 2.7V? How will else those SoC that for example
>> supports 2.9V only work?
>
> This will get us within .3V of whatever vmmc is.  If vmmc is 3.3V, it
> will allow vqmmc of 3.0V - 3.6V.
>
> This _seems_ sane to me and given any sane system design we should be
> fine here, I think.  I can't see someone designing a system where
> vqmmc was not within .3V of vmmc, can you?  If we think someone will
> actually build a system where vmmc is 3.3V and vqmmc can't go higher
> than 2.7V then we'll either need to increase the tolerance here or add
> a new asymmetric system call like my original patches did.

I know about SoC that supports 3.4V vmmc and 2.9V vqmmc.

What I think we need is the option to have a policy here. We need to
allow voltage levels stated by the spec and at the same time try chose
the one best suited. That's not being accomplished here.

Moreover, I wonder whether it's okay (from spec perspective) to have
vqmmc at a higher voltage level than vmmc. I don't think that's
allowed, but I might be wrong.

>
>>>  int mmc_regulator_get_supply(struct mmc_host *mmc);
>>
>> One more thought,s as for the vmmc regulator we have a
>> "regulator_enabled" member in the mmc_host. Should we add a similar
>> member for vqmmc? That would prevent host drivers from keeping track
>> of this state themselves.
>
> Yeah, that does sound nice.  Are you suggesting that I modify this
> patch or submit a new one.  Let me know.

Yes, please add the option as well. It's seems like it will belongs to
this code.

>
>
> -Doug

Kind regards
Uffe
