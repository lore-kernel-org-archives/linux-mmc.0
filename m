From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: BUG 4.4rc-4: wrong eMMC signaling voltage reported
Date: Tue, 22 Dec 2015 09:33:21 +0100
Message-ID: <87poxyrige.fsf@gmail.com>
References: <87fuzbvfl9.fsf@gmail.com> <CAPDyKFoQqQFmPwrnCeJBcz=mnzW8zbWb5i7bc64oo7bN_113zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33540 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbbLVIdY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2015 03:33:24 -0500
Received: by mail-wm0-f43.google.com with SMTP id p187so98303368wmp.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Dec 2015 00:33:24 -0800 (PST)
In-reply-to: <CAPDyKFoQqQFmPwrnCeJBcz=mnzW8zbWb5i7bc64oo7bN_113zQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>


> The no-1-8-v is a somewhat broken DT binding. I advise people to not
> use any more.
> Depending on the sdhci variant it have different meanings.
>
> I guess you are using the sdhci-esdhc-imx variant, which means
> no-1-8-v will disable UHS modes for SD-cards (those requiring 1.8V
> signal voltage). It has no impact on (e)MMC.

Correct, I'm on i.MX6 and using sdhci-esdhc-imx.


> As the host driver announces support for MMC_CAP_1_8V_DDR, that's what
> the mmc core will try to use. Actually the mmc core will first try
> 1.8V and if it fails, go for 3.3V.
>
> Likely, sdhci_do_start_signal_voltage_switch() will success to write
> the corresponding registers to change the signal voltage to 1.8V,
> which makes the mmc core believe it was a success.
>
> *If* your statement around that your HW don't support 1.8V signal
> voltage, we should perhaps add new mmc cap as currently we don't have
> a "MMC_CAP_3_3V_DDR". Although, you need to convince on that, because
> my experience tells that quite many has misunderstood the HW design in
> this regard.

The hardware guys told me that the eMMC chip get's its power from the
i.MX6, there are connections NVCC_SD1...NVCC_SD3 which are directly
connected to 3V3, not to some PMIC. When I read the docs correctly, this
means that the SDHCI related I/O lines of the i.MX6 are therefore tied
to 3.3V only, because of this NVCC_SDx power domain.

And on the eMMC schematic page, the signals VCC and VCCQ ("DQ Power") of
the eMMC are also tied directly to 3.3V.

Therefore I assume that the hardware itself cannot provide 1.8V and I
added this "knowledge" to the Device Tree.




Two questions:

* should I propose a patch that reads theno-1-8-v setting from DT and
removes the announcement of MMC_CAP_1_8V_DDR ?

* isn't MMC_CAP_3_3V_DDR superfluous, because it must any implementation
must support 3.3V (I'm not too much into the standard ...).

