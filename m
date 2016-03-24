From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/2] regulator: core: Ensure we are at least in bounds for
 our constraints
Date: Thu, 24 Mar 2016 16:18:25 +0900
Message-ID: <CAJKOXPcBOT_8NOH-=sEHSP0Rc+=Dvz-aqVTsBTMKg-VNWqQotw@mail.gmail.com>
References: <1458587912-32665-1-git-send-email-broonie@kernel.org>
	<1458587912-32665-2-git-send-email-broonie@kernel.org>
	<56F0624C.8010004@gmail.com>
	<CAJKOXPd5h0Cq++OxdiXytNJH94PN4Kh_wM3M=p3JdU1m_qyFTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f195.google.com ([209.85.214.195]:35607 "EHLO
	mail-ob0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbcCXHS0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2016 03:18:26 -0400
In-Reply-To: <CAJKOXPd5h0Cq++OxdiXytNJH94PN4Kh_wM3M=p3JdU1m_qyFTA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Thu, Mar 24, 2016 at 3:11 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On Tue, Mar 22, 2016 at 6:06 AM, Ivaylo Dimitrov
> <ivo.g.dimitrov.75@gmail.com> wrote:
>> Hi,
>>
>> On 21.03.2016 21:18, Mark Brown wrote:
>>>
>>> Currently we only attempt to set the voltage during constraints
>>> application if an exact voltage is specified.  Extend this so that if
>>> the currently set voltage for the regualtor is outside the bounds set in
>>
>>
>> regulator
>>
>>> constraints we will move the voltage to the nearest constraint, raising
>>> to the minimum or lowering to the maximum as needed.  This ensures that
>>> drivers can probe without the hardware being driven out of spec.
>>>
>>> Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>>> Signed-off-by: Mark Brown <broonie@kernel.org>
>>> ---
>>>
>>> Untested so far, will give it a spin later/tomorrow.
>>>
>>>   drivers/regulator/core.c | 32 +++++++++++++++++++++++++-------
>>>   1 file changed, 25 insertions(+), 7 deletions(-)
>>>
>>
>> Patch 1 does not apply cleanly on 4.5-rc5, so I applied it by hand, however,
>> you may add:
>>
>> Tested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>
>
> Cc: Ulf, mmc
>
> I bisected today's next MMC/SD card failure to this patch. Plugging a
> SD card on Odroid XU3/XU4 (Exynos5422) causes:
> [   11.759954] mmc1: card never left busy state
> [   11.762795] mmc1: error -110 whilst initialising SD card
>
> Full log (for booting from SD but it happens also when plugging the
> card to the board booted from eMMC):
> http://www.krzk.eu/builders/boot-odroid-xu3-multi_v7/builds/538/steps/Boot%20odroid/logs/serial

+Cc: linux-samsung-soc, Javier and Marek.

Although bisect complained about this patch but I am not convinced
that it is the cause. Before the patch the constraints were not
applied. To none of the regulators. With the patch the constraints are
applied to bucks... which are not directly used by SD card.

Instead some of the bucks are apparently supplying other LDOs. I
suspect buck9 which is mentioned as a supply for VDD 2.8V (2.8V
happens to be also the voltage of regulators going to SD card).
With the patch following constraints are applied:
                 target_min, target max, current
setting BUCK1 to 1100000 1100000 1100000
setting BUCK2 to 1000000 1000000 1000000
setting BUCK3 to 1000000 1000000 1000000
setting BUCK4 to 1000000 1000000 1000000
setting BUCK5 to 1200000 1200000 1200000
setting BUCK6 to 1025000 1025000 1025000
setting BUCK7 to 900000 900000 900000
setting BUCK8 to 1225000 1225000 1225000
setting BUCK9 to 3750000 3750000 5000000

Why the heck current_uV is 5V? I'll try to figure this out...

Best regards,
Krzysztof
