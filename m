From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: BUG 4.4rc-4: wrong eMMC signaling voltage reported
Date: Tue, 22 Dec 2015 11:28:46 +0100
Message-ID: <CAPDyKFqQ-NEPh5hC=YpiqDzDAeoRmdTEFMumAosozuo=BVO-kw@mail.gmail.com>
References: <87fuzbvfl9.fsf@gmail.com>
	<CAPDyKFoQqQFmPwrnCeJBcz=mnzW8zbWb5i7bc64oo7bN_113zQ@mail.gmail.com>
	<CAOMZO5B3WpJRYD7CRX54G0NeWj_BxNL5dB+KjG=YttDHQTx3vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34667 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbbLVK2r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2015 05:28:47 -0500
Received: by mail-yk0-f176.google.com with SMTP id p130so159192267yka.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Dec 2015 02:28:47 -0800 (PST)
In-Reply-To: <CAOMZO5B3WpJRYD7CRX54G0NeWj_BxNL5dB+KjG=YttDHQTx3vQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Holger Schurig <holgerschurig@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 22 December 2015 at 10:39, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Ulf and Holger,
>
> On Thu, Dec 17, 2015 at 2:10 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> The no-1-8-v is a somewhat broken DT binding. I advise people to not
>> use any more.
>> Depending on the sdhci variant it have different meanings.
>>
>> I guess you are using the sdhci-esdhc-imx variant, which means
>> no-1-8-v will disable UHS modes for SD-cards (those requiring 1.8V
>> signal voltage). It has no impact on (e)MMC.
>>
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
> Yes, I have added a 'MMC_CAP_3_3V_ONLY_DDR' in this proposal to fix
> the same issue as Holger describes:
> http://www.spinics.net/lists/linux-mmc/msg32285.html
>
> ,but it seems you were not happy with such approach at that time.
> Unfortunately, I was not able to rework it.

Yes, I had vague memory of this discussion. Thanks for pointing it out.

So, I think I am reaching the same consensus again. We need to move
away from using the no-1.8-v, and thus not add any new interpretation
of that binding.

I think what I suggested as the solution here should work, right!?

I understand the problem with keeping DTB backwards compatible, don't
you think sdhci-esdhc-imx can handle that internally via using a
MMC_CAP_3_3V_DDR?

Kind regards
Uffe
