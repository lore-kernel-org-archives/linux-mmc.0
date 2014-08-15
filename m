From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] mmc: core: Use regulator_get_voltage() if OCR mask
 is empty.
Date: Fri, 15 Aug 2014 09:48:43 +0200
Message-ID: <53EDBB5B.4000209@collabora.co.uk>
References: <1408019940-11153-1-git-send-email-javier.martinez@collabora.co.uk>	<CAD7vxxKvzxvmzgx=S5ZZn54ts99ca2TqBYFvY1SXZQZDkhjq3w@mail.gmail.com>	<20140814151958.GY17528@sirena.org.uk> <CAD7vxxLHtk2ywHGoBtDp6x3-5BtDdaFnCdc_pfgMwq63Cg8Qow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAD7vxxLHtk2ywHGoBtDp6x3-5BtDdaFnCdc_pfgMwq63Cg8Qow@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Haijun Zhang <Haijun.Zhang@freescale.com>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello Tim,

On 08/15/2014 07:36 AM, Tim Kryger wrote:
> On Thu, Aug 14, 2014 at 8:19 AM, Mark Brown <broonie@kernel.org> wrote:
> 
>> Right, there's two things going on here.  One is that as you describe we
>> shouldn't be putting constraints in .dtsi files if we don't know they're
>> OK for a given board.  The other thing is that on this particular board
>> it turns out that there's no support for varying the voltages at all so
>> it doesn't make sense to have to specify a range, there's only one value
>> anyway so the software really should be able to figure out that fixed
>> value all by itself.
> 
> If constraints are truly irrelevant when the voltage supplied to
> consumers is fixed, why doesn't regulator_list_voltage honor this
> exemption and skip the voltage filtering that uses (potentially
> unspecified) constraints when output is entirely determined by a
> parent (or grandparent) supply that can't change its voltage?
>

I had a similar thought before and proposed the patch:

"[RFC 3/5] regulator: core: Only apply constraints if available on list
voltage" [0].

But then Mark explained to me that this is wrong since in that case
regulator_list_voltage() will list voltages that can't really be set [1].

But now I wonder why regulator_list_voltage() even list the voltage for
fixed regulators (desc->fixed_uV) since they don't have the ability to
vary voltage. The regulator_list_voltage() documentation says:

"Returns a voltage that can be passed to @regulator_set_voltage(), zero if
this selector code can't be used on this system, or a negative errno."

But in the case of fixed regulators, it is actually listing a voltage that
can't be selected. Although regulator_set_voltage() checks if the desired
voltage is equal to the regulator min_uV and max_uV and just exits in that
case, it feels wrong to list the voltage for a fixed regulators.

regulator_list_voltage() only works because of the way we define the
generic fixed voltage regulators and that is assuming that
"regulator-min-microvolt" and "regulator-max-microvolt" DT properties
being the same means that the regulator is fixed.

This is kind of unfortunate, maybe it would had been better to define it
explicitly using a "regulator-fixed-microvolt" or something. If we had
such a DT property, then constraints wouldn't had been set for fixed
regulators and regulator_list_voltage() wouldn't list its voltage neither.

> It seems odd to make callers be the ones to handle this subtlety.
> 

If regulator_list_voltage() didn't list the voltage for fixed regulators,
then this subtlety should had been handled by callers before but they
didn't because they rely on regulator_list_voltage() to always return a
voltage even for fixed regulators.

> Thanks,
> Tim Kryger
> 

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/7/29/418
[1]: https://lkml.org/lkml/2014/7/29/453
