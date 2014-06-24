From: Tim Kryger <tim.kryger@gmail.com>
Subject: Re: MMC error on Exynos4210 board
Date: Tue, 24 Jun 2014 06:49:06 -0700
Message-ID: <CAD7vxxKt=nho_rLu9A-kPZ1H=peFEXyWGGN=9bRyvP5LOE-pHA@mail.gmail.com>
References: <CAK5sBcEB5GnjiR37DXDAeKYBWKw_4NTDM=pKCVK=0oKFDBjSbw@mail.gmail.com>
	<CAD7vxxJrRd7nrhZBRWH=43r7AMopz1w30aMRHqMO9PvaZYOpHg@mail.gmail.com>
	<CAK5sBcHqjmT7rcXLPkP3WHBdcphJjhm2aBfy4ksbXakNUfVYYw@mail.gmail.com>
	<CAD7vxxJ2mrk9Wrhw+0rB1Afk5zUsR05a1P8aeyou9JPVk6sCrA@mail.gmail.com>
	<CAK5sBcFCbhBCbgss=KU=__gxpb7KUm6GWhO_MWQAqRgkvCagwQ@mail.gmail.com>
	<CAD7vxxK5a_Nc4DjP8x4-=Um6xi=kPa=3sRZdvBuNBXMLUEEimA@mail.gmail.com>
	<CAK5sBcF=5NYd-tuvRrQk7Yq_r_oUYftpNuHcz7iJ8TGNWkG0iA@mail.gmail.com>
	<53A2DA96.3070500@samsung.com>
	<CAK5sBcEoNm85qtY2gfWAo1FZoVWXNj1f3FFFngB7FjpTBTnJdQ@mail.gmail.com>
	<CAD7vxxKqr=GoQO7kH6ukG=HbpvLyWYmfst3wHct7doMVXhD0gg@mail.gmail.com>
	<CAK5sBcGQAcyKd84fc0xNw0Wb-Jb1A=KrbitZTWGmnGvd_v6U+g@mail.gmail.com>
	<91de6a4b-40dc-408b-b170-6b0450ae41c5@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:37820 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbaFXNtI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jun 2014 09:49:08 -0400
In-Reply-To: <91de6a4b-40dc-408b-b170-6b0450ae41c5@email.android.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sachin Kamat <spk.linux@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Markus Mayer <markus.mayer@linaro.org>, Matt Porter <mporter@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Yuvaraj C D <yuvaraj.cd@samsung.com>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>

Sure thing.  I'll try to get it sent out later today.

-Tim

On Tue, Jun 24, 2014 at 4:11 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>
> On 23 juni 2014 06:30:08 CEST, Sachin Kamat <spk.linux@gmail.com> wrote:
>>Hi Tim,
>>
>>On Sat, Jun 21, 2014 at 2:31 AM, Tim Kryger <tim.kryger@gmail.com>
>>wrote:
>>> On Thu, Jun 19, 2014 at 8:33 PM, Sachin Kamat <spk.linux@gmail.com>
>>wrote:
>>>> On Thu, Jun 19, 2014 at 6:11 PM, Jaehoon Chung
>><jh80.chung@samsung.com> wrote:
>>>>> On 06/19/2014 07:40 PM, Sachin Kamat wrote:
>>>>>> On Thu, Jun 19, 2014 at 2:40 PM, Tim Kryger <tim.kryger@gmail.com>
>>wrote:
>>>>>>> On Thu, Jun 19, 2014 at 1:49 AM, Sachin Kamat
>><spk.linux@gmail.com> wrote:
>>>>>>>> On Thu, Jun 19, 2014 at 2:12 PM, Tim Kryger
>><tim.kryger@gmail.com> wrote:
>>>>>>>>> On Wed, Jun 18, 2014 at 8:54 PM, Sachin Kamat
>><spk.linux@gmail.com> wrote:
>>>>>>>>>>> On Wed, Jun 18, 2014 at 4:33 AM, Sachin Kamat
>><spk.linux@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>>>>> I see the below error on Exynos4210 based Origen board with
>>linux-next
>>>>>>>>>>>> (20140618).
>>>>>>>>>>>> Reverting the below commit works fine.
>>>>>>>>>>>>
>>>>>>>>>>>> Commit: 8d02e775a6 "mmc: sdhci: Use mmc core regulator
>>infrastucture"
>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> -- [    2.068992] sdhci: Secure Digital Host Controller
>>Interface driver
>>>>>>>>>>>> [    2.075059] sdhci: Copyright(c) Pierre Ossman
>>>>>>>>>>>> [    2.079762] of_get_named_gpiod_flags: can't parse gpios
>>property of
>>>>>>>>>>>> node '/sdhci@12510000[0]'
>>>>>>>>>>>> [    2.088021] s3c-sdhci 12510000.sdhci: clock source 2:
>>mmc_busclk.2
>>>>>>>>>>>> (50000000 Hz)
>>>>>>>>>>>> [    2.095322] of_get_named_gpiod_flags: can't parse gpios
>>property of
>>>>>>>>>>>> node '/sdhci@12510000[0]'
>>>>>>>>>>>> [    2.103794] of_get_named_gpiod_flags: can't parse gpios
>>property of
>>>>>>>>>>>> node '/sdhci@12510000[0]'
>>>>>>>>>>>> [    2.112478] s3c-sdhci 12510000.sdhci: No vqmmc regulator
>>found
>>>>>>>>>>>> [    2.118117] mmc0: Hardware doesn't report any support
>>voltages.
>>>>>>>>>>>> [    2.124004] s3c-sdhci 12510000.sdhci: sdhci_add_host()
>>failed
>>>>>>>>>>>> [    2.130080] of_get_named_gpiod_flags: can't parse gpios
>>property of
>>>>>>>>>>>> node '/sdhci@12530000[0]'
>>>>>>>>>>>> [    2.138352] s3c-sdhci 12530000.sdhci: clock source 2:
>>mmc_busclk.2
>>>>>>>>>>>> (16666667 Hz)
>>>>>>>>>>>> [    2.145661] of_get_named_gpiod_flags: can't parse gpios
>>property of
>>>>>>>>>>>> node '/sdhci@12530000[0]'
>>>>>>>>>>>> [    2.154139] of_get_named_gpiod_flags: can't parse gpios
>>property of
>>>>>>>>>>>> node '/sdhci@12530000[0]'
>>>>>>>>>>>> [    2.162834] s3c-sdhci 12530000.sdhci: No vqmmc regulator
>>found
>>>>>>>>>>>> [    2.168464] mmc0: Hardware doesn't report any support
>>voltages.
>>>>>>>>>>>> [    2.174349] s3c-sdhci 12530000.sdhci: sdhci_add_host()
>>failed
>>>>>>>>>
>>>>>>>>>>>> [    2.336148] Waiting for root device /dev/mmcblk0p1...
>>>>>>>>>
>>>>>>>>>> FYI, the board has a 2.8V fixed regulator supply connected to
>>the MMC.
>>>>>>>>>> You may refer to arch/arm/boot/dts/exynos4210-origen.dts for
>>more details.
>>>>>>>>>
>>>>>>>>> A 2.8v regulator results in mmc->ocr_avail being set to
>>MMC_VDD_27_28
>>>>>>>>> | MMC_VDD_28_29.
>>>>>>>>>
>>>>>>>>> The SDHCI capabilities register only indicates support of three
>>voltage levels
>>>>>>>>>   - 1.8v: SDHCI_CAN_VDD_180 => MMC_VDD_165_195
>>>>>>>>>   - 3.0v: SDHCI_CAN_VDD_300 => MMC_VDD_29_30 | MMC_VDD_30_31
>>>>>>>>>   - 3.3v: SDHCI_CAN_VDD_330 => MMC_VDD_32_33 | MMC_VDD_33_34
>>>>>
>>>>> Right. sdhci capabilities only indicated them.
>>>>> But I think SoC can be support the specific VDD range.
>>>>>
>>>>>>>>>
>>>>>>>>> Even if all capability bits of the host controller were set,
>>there
>>>>>>>>> still wouldn't be any overlap.  Thus you see a "Hardware
>>doesn't
>>>>>>>>> report any support voltages" message.
>>>>>>>>>
>>>>>>>>> Previously, this issue was being swept under the rug by cec2e21
>>mmc:
>>>>>>>>> sdhci: Use regulator min/max voltage range according to spec.
>>That
>>>>>>>>> change hacked up the voltage range checks such that with your
>>2.8v
>>>>>>>>> fixed regulator, the driver would believe the host could
>>support
>>>>>>>>> MMC_VDD_29_30 | MMC_VDD_30_31 | MMC_VDD_32_33 | MMC_VDD_33_34.
>>The
>>>>>>>>> driver would start down the path of commanding 3.3v-3.4v (the
>>highest
>>>>>>>>> voltage range believed to be supported).  At the last second,
>>the
>>>>>>>>> driver would see the regulator was fixed and blindly skip over
>>the set
>>>>>>>>> voltage operation, saving it from failure.
>>>>>>>>>
>>>>>>>>> Since my patch eliminates the bogus voltage range checks, your
>>board
>>>>>>>>> is now getting caught playing too loose with the SDHCI
>>regulator
>>>>>>>>> voltages.
>>>>>>>>>
>>>>>>>>> Furthermore, the fixed regulator special-case logic that helped
>>hide
>>>>>>>>> your issue should also be considered for removal given that
>>fixed
>>>>>>>>> regulators now behave properly thanks to c00dc35 regulator:
>>core:
>>>>>>>>> Allow regulator_set_voltage for fixed regulators.
>>>>>>>>
>>>>>>>> Thanks for the detailed explanation. What do you propose to get
>>this fixed
>>>
>>>>>>> It would be nice if the driver could be extended
>>>>>>> to handle the peculiarities of your board in a deliberate manner
>>but
>>>>>>> limiting the common sdhci driver to supporting only the three
>>voltages
>>>>>>> from the spec also seems sensible.
>>>>>>
>>>>>> Until such time that the driver gets fixed to handle 2.8V fixed
>>supply your
>>>>>> current patch leaves several of Exynos boards broken for now.
>>>>>
>>>>> the all of exynos used the fixed-regulator(2.8v) should be broken.
>>>>> (Maybe exynos4 series??)
>>>>
>>>> Probably. I haven't verified for the other boards. Hence would be
>>good to handle
>>>> this case in the driver itself.
>>>
>>> The current external VDD regulator support in the SDHCI driver feels
>>a
>>> bit tacked on.
>>>
>>> External regulators could reasonably support other voltage ranges,
>>> like MMC_VDD_27_28 | MMC_VDD_28_29, but those never appear in the
>>> final ocr_avail for the host. The driver only looks for the
>>> intersection of the ranges implied by the capabilities register and
>>> those of the external regulator.
>>>
>>> Later, when it comes time to set a voltage, the driver will BUG if it
>>> can't translate the requested voltage into one of the three voltage
>>> levels supported by the SDHCI Power Control register.
>>>
>>> I wonder if it is really necessary to constrain the driver this way.
>>> It seems like if we are using an external regulator, the capabilities
>>> of the host controller itself are irrelevant.  Also, must we touch
>>the
>>> Power Control register if we are using an external regulator?  I
>>would
>>> think not.
>>
>>You argument above seems reasonable.
>>
>>>
>>> Can you give the following patch a try and see if it resolves the
>>> issue you observed?
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index c23a872..07a2426 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1226,6 +1226,13 @@ static void sdhci_set_power(struct sdhci_host
>>> *host, unsigned char mode,
>>>   struct mmc_host *mmc = host->mmc;
>>>   u8 pwr = 0;
>>>
>>> + if (!IS_ERR(mmc->supply.vmmc)) {
>>> + spin_unlock_irq(&host->lock);
>>> + mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd);
>>> + spin_lock_irq(&host->lock);
>>> + return;
>>> + }
>>> +
>>>   if (mode != MMC_POWER_OFF) {
>>>   switch (1 << vdd) {
>>>   case MMC_VDD_165_195:
>>> @@ -1284,12 +1291,6 @@ static void sdhci_set_power(struct sdhci_host
>>> *host, unsigned char mode,
>>>   if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
>>>   mdelay(10);
>>>   }
>>> -
>>> - if (!IS_ERR(mmc->supply.vmmc)) {
>>> - spin_unlock_irq(&host->lock);
>>> - mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd);
>>> - spin_lock_irq(&host->lock);
>>> - }
>>>  }
>>>
>>>
>>/*****************************************************************************\
>>> @@ -3092,8 +3093,9 @@ int sdhci_add_host(struct sdhci_host *host)
>>>     SDHCI_MAX_CURRENT_MULTIPLIER;
>>>   }
>>>
>>> + /* If OCR set by external regulators, use it instead */
>>>   if (mmc->ocr_avail)
>>> - ocr_avail &= mmc->ocr_avail;
>>> + ocr_avail = mmc->ocr_avail;
>>>
>>>   if (host->ocr_mask)
>>>   ocr_avail &= host->ocr_mask;
>>
>>I can confirm that the above patch fixes the reported issue on
>>Exynos4210 and 4412
>>based origen boards that I have. Thanks for the fix.
>
> Hi Tim/Sachin,
>
> Great that you seemed to have work out issues. Could you please resend a the patch in proper format, thus I can apply it as a fix for 3.16.
>
> Kind regards
> Uffe
>
