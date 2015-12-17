From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: BUG 4.4rc-4: wrong eMMC signaling voltage reported
Date: Thu, 17 Dec 2015 17:10:14 +0100
Message-ID: <CAPDyKFoQqQFmPwrnCeJBcz=mnzW8zbWb5i7bc64oo7bN_113zQ@mail.gmail.com>
References: <87fuzbvfl9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36496 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812AbbLQQKQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2015 11:10:16 -0500
Received: by mail-yk0-f170.google.com with SMTP id x184so24286951yka.3
        for <linux-mmc@vger.kernel.org>; Thu, 17 Dec 2015 08:10:15 -0800 (PST)
In-Reply-To: <87fuzbvfl9.fsf@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Holger Schurig <holgerschurig@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 9 December 2015 at 15:53, Holger Schurig <holgerschurig@gmail.com> wrote:
> Hi,
>
> I have an i.MX6Q based system that cannot provide 1.8V voltage towards
> the eMMC. But Linux 4.4-rc4 reports 1.8V for the eMMC, but this is
> impossible. Neither my hardware allows this, nor does the DT say it.
>
> root@imx6q:/sys/kernel/debug# cat mmc1/ios
> clock:          52000000 Hz
> actual clock:   49500000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    8 (mmc DDR52)
> signal voltage: 0 (1.80 V)
> driver type:    0 (driver type B)
>
> My device tree however tells that I don't have 1.8V:
>
> /* this is the built in eMMC */
> &usdhc4 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_usdhc4>;
>         bus-width = <8>;
>         non-removable;
>         vmmc-supply = <&reg_3p3v>;
>         max-frequency = <198000000>;
>         no-1-8-v;

The no-1-8-v is a somewhat broken DT binding. I advise people to not
use any more.
Depending on the sdhci variant it have different meanings.

I guess you are using the sdhci-esdhc-imx variant, which means
no-1-8-v will disable UHS modes for SD-cards (those requiring 1.8V
signal voltage). It has no impact on (e)MMC.

As the host driver announces support for MMC_CAP_1_8V_DDR, that's what
the mmc core will try to use. Actually the mmc core will first try
1.8V and if it fails, go for 3.3V.

Likely, sdhci_do_start_signal_voltage_switch() will success to write
the corresponding registers to change the signal voltage to 1.8V,
which makes the mmc core believe it was a success.

*If* your statement around that your HW don't support 1.8V signal
voltage, we should perhaps add new mmc cap as currently we don't have
a "MMC_CAP_3_3V_DDR". Although, you need to convince on that, because
my experience tells that quite many has misunderstood the HW design in
this regard.

Kind regards
Uffe
