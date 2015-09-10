From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/8] mmc: core: Add mmc_regulator_set_vqmmc()
Date: Thu, 10 Sep 2015 14:40:26 +0200
Message-ID: <CAPDyKFqR-+GzV0SGiA_cnoNftcZ0Y_fwe5vW2NvDxd6HbO__UQ@mail.gmail.com>
References: <1441045446-30858-1-git-send-email-heiko@sntech.de>
	<1441045446-30858-4-git-send-email-heiko@sntech.de>
	<CAPDyKFqJp3VuOeTh4Abkn2X6gQxNHDXwJj8N51OxxSo+Agespw@mail.gmail.com>
	<CAD=FV=Wy7foROYkmR+cX+NS5-=BaB36WsW1sc1XjmmdUnPCxsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=Wy7foROYkmR+cX+NS5-=BaB36WsW1sc1XjmmdUnPCxsA@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-clk@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2 September 2015 at 18:20, Doug Anderson <dianders@chromium.org> wrote:
> Ulf,
>
> On Wed, Sep 2, 2015 at 4:38 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> +/**
>>> + * mmc_regulator_set_vqmmc - Set VQMMC as per the ios
>>> + *
>>> + * For 3.3V signaling, we try to match VQMMC to VMMC as closely as possible.
>>
>> Looking at the code, I don't think this statement is entirely true.
>> Isn't it so that we will be trying with a maximum tolerance of 0.3 V
>> towards the VMMC voltage level (then fall-back to the complete range)?
>> Perhaps you can find a better way to describe that in the change log.
>
> If regulator_set_voltage_triplet() is ever implemented more correctly
> then the description here is correct.  ...the problem is that
> regulator_set_voltage_triplet() is still using the same shortcut that
> regulator_set_voltage_tol() was using.

Okay, let's mention that somehow.

>
>
>>> +int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
>>> +{
>>> +       int volt, min_uV, max_uV;
>>> +
>>> +       /* If no vqmmc supply then we can't change the voltage */
>>> +       if (IS_ERR(mmc->supply.vqmmc))
>>> +               return -EINVAL;
>>
>> In general vqmmc is considered as an optional regulator and that's
>> also how host drivers treat it. So perhaps it would make sense to
>> return 0 here instead of an error code or what do you think?
>
> The idea is that since this is intended to be called by
> start_signal_voltage_switch() and having no vqmmc should be considered
> an error for start_signal_voltage_switch() then it should be an error
> here.  What do you think?

Okay!

>
>
>>> +
>>> +               /* try to stay close to vmmc at first */
>>> +               if (!mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
>>> +                                               min_uV, volt, max_uV))
>>> +                       return 0;
>>> +
>>> +               return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
>>> +                                               2700000, volt, 3600000);
>
> The whole fact that there are two calls here is really just because of
> the limitations of the current implementation of
> regulator_set_voltage_triplet().  If that implementation is ever fixed
> then we'd just need a single call.  Probably worth a comment saying
> that?

Yes, please!

Kind regards
Uffe
