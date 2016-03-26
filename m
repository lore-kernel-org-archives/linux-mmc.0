From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH 2/2] regulator: core: Ensure we are at least in bounds for
 our constraints
Date: Sat, 26 Mar 2016 16:50:41 -0700
Message-ID: <CAJAp7OgGQ3qm-_QhydvN0n6QeNoHFdso4zOk41qvVJhKNeRn8Q@mail.gmail.com>
References: <1458587912-32665-1-git-send-email-broonie@kernel.org>
	<1458587912-32665-2-git-send-email-broonie@kernel.org>
	<56F0624C.8010004@gmail.com>
	<CAJKOXPd5h0Cq++OxdiXytNJH94PN4Kh_wM3M=p3JdU1m_qyFTA@mail.gmail.com>
	<CAJKOXPcBOT_8NOH-=sEHSP0Rc+=Dvz-aqVTsBTMKg-VNWqQotw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPcBOT_8NOH-=sEHSP0Rc+=Dvz-aqVTsBTMKg-VNWqQotw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Mark Brown <broonie@kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 24, 2016 at 12:18 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On Thu, Mar 24, 2016 at 3:11 PM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> On Tue, Mar 22, 2016 at 6:06 AM, Ivaylo Dimitrov
>> <ivo.g.dimitrov.75@gmail.com> wrote:
>>> Hi,
>>>
>>> On 21.03.2016 21:18, Mark Brown wrote:
>>>>
>>>> Currently we only attempt to set the voltage during constraints
>>>> application if an exact voltage is specified.  Extend this so that if
>>>> the currently set voltage for the regualtor is outside the bounds set in
>>>
>>>
>>> regulator
>>>
>>>> constraints we will move the voltage to the nearest constraint, raising
>>>> to the minimum or lowering to the maximum as needed.  This ensures that
>>>> drivers can probe without the hardware being driven out of spec.
>>>>
>>>> Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>>>> Signed-off-by: Mark Brown <broonie@kernel.org>
>>>> ---
>>>>
>>>> Untested so far, will give it a spin later/tomorrow.
>>>>
>>>>   drivers/regulator/core.c | 32 +++++++++++++++++++++++++-------
>>>>   1 file changed, 25 insertions(+), 7 deletions(-)
>>>>
>>>
>>> Patch 1 does not apply cleanly on 4.5-rc5, so I applied it by hand, however,
>>> you may add:
>>>
>>> Tested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>>
>>
>> Cc: Ulf, mmc
>>
>> I bisected today's next MMC/SD card failure to this patch. Plugging a
>> SD card on Odroid XU3/XU4 (Exynos5422) causes:
>> [   11.759954] mmc1: card never left busy state
>> [   11.762795] mmc1: error -110 whilst initialising SD card
>>

Mark,

I'm facing the same issue on my Qualcomm based boards; my eMMCs fails
to talk to me because I'm not powering them.

The problem in my case comes from the vmmc regulator having min_uV ==
max_uV and patch 1 in this series changes the logic of
of_get_regulation_constraints() to no longer set apply_uV. I.e. we end
up never calling set_voltage(), ever.

When the mmc framework calls regulator_set_load() to change voltage
REGULATOR_CHANGE_VOLTAGE is not set (because min == max) so we will
never call set_voltage().

Before patch 1 apply_uV was set and we did set up the voltage earlier,
so regulator_get_voltage() will return a valid voltage and
regulator_set_voltage() will succeed for the valid voltages (if the
range spans the current setting).


Reinstating the following snippet in of_get_regulation_constraints()
sort this out:
if (constraints->min_uV && constraints->max_uV)
                                       constraints->apply_uV = true;


I did look at an alternative of having regulator_set_voltage() pass
and call set_voltage() if the requested voltage matches the
constraints, but this does indeed seem to mess things up. So checking
in with you before continuing on that hack.

Regards,
Bjorn
