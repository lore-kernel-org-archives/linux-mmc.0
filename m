From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: BUG 4.4rc-4: wrong eMMC signaling voltage reported
Date: Tue, 22 Dec 2015 10:18:29 +0100
Message-ID: <CAPDyKFr7kABv_Uo025FPodpzsgDEnWx1Gv8iQLJxHGD0_Z5rNw@mail.gmail.com>
References: <87fuzbvfl9.fsf@gmail.com>
	<CAPDyKFoQqQFmPwrnCeJBcz=mnzW8zbWb5i7bc64oo7bN_113zQ@mail.gmail.com>
	<87poxyrige.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33221 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbbLVJS3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2015 04:18:29 -0500
Received: by mail-yk0-f171.google.com with SMTP id 140so157731111ykp.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Dec 2015 01:18:29 -0800 (PST)
In-Reply-To: <87poxyrige.fsf@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Holger Schurig <holgerschurig@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 22 December 2015 at 09:33, Holger Schurig <holgerschurig@gmail.com> wrote:
>
>> The no-1-8-v is a somewhat broken DT binding. I advise people to not
>> use any more.
>> Depending on the sdhci variant it have different meanings.
>>
>> I guess you are using the sdhci-esdhc-imx variant, which means
>> no-1-8-v will disable UHS modes for SD-cards (those requiring 1.8V
>> signal voltage). It has no impact on (e)MMC.
>
> Correct, I'm on i.MX6 and using sdhci-esdhc-imx.
>
>
>> As the host driver announces support for MMC_CAP_1_8V_DDR, that's what
>> the mmc core will try to use. Actually the mmc core will first try
>> 1.8V and if it fails, go for 3.3V.
>>
>> Likely, sdhci_do_start_signal_voltage_switch() will success to write
>> the corresponding registers to change the signal voltage to 1.8V,
>> which makes the mmc core believe it was a success.
>>
>> *If* your statement around that your HW don't support 1.8V signal
>> voltage, we should perhaps add new mmc cap as currently we don't have
>> a "MMC_CAP_3_3V_DDR". Although, you need to convince on that, because
>> my experience tells that quite many has misunderstood the HW design in
>> this regard.
>
> The hardware guys told me that the eMMC chip get's its power from the
> i.MX6, there are connections NVCC_SD1...NVCC_SD3 which are directly
> connected to 3V3, not to some PMIC. When I read the docs correctly, this
> means that the SDHCI related I/O lines of the i.MX6 are therefore tied
> to 3.3V only, because of this NVCC_SDx power domain.
>
> And on the eMMC schematic page, the signals VCC and VCCQ ("DQ Power") of
> the eMMC are also tied directly to 3.3V.

Thanks, I am convinced! :-)

>
> Therefore I assume that the hardware itself cannot provide 1.8V and I
> added this "knowledge" to the Device Tree.

The problem with the "no-1-8-v" binding is that it's describing what
the hardware *can't* do. It thus becomes easy to abuse it.

I suggest we stop using it, we should mark it deprecated.

>
>
>
>
> Two questions:
>
> * should I propose a patch that reads theno-1-8-v setting from DT and
> removes the announcement of MMC_CAP_1_8V_DDR ?

No.

>
> * isn't MMC_CAP_3_3V_DDR superfluous, because it must any implementation
> must support 3.3V (I'm not too much into the standard ...).

For eMMC it's acceptable to support any of the 3.3V or 1.8V as the
only supported signal voltage.

However, for the old MMC standard this isn't the case and that also
true for UHS SD cards.

So, I suggest we add this new cap and a corresponding DT binding that
we parse in the mmc_of_parse() function.

Whether you should drop the announcement of MMC_CAP_1_8V_DDR, I don't
know as it seems like it would affect more than imx6. Something more
clever is needed there I think.

Kind regards
Uffe
