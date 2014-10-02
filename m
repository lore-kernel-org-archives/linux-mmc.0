From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH] ARM: dts: fix MMC2 regulators for Exynos5420 Arndale Octa board
Date: Thu, 2 Oct 2014 09:45:41 -0700
Message-ID: <CAD=FV=X7hStwYj2tOCBKH0ncUmhTeUi8qWZjFGjFaMO8rxiZCA@mail.gmail.com>
References: <2750153.I3nVqzmXTP@amdc1032>
	<CAD=FV=XtJVWkUwWK8=E+mvSdvBn1MuS9c+_91VPhbOSQ3kF_kA@mail.gmail.com>
	<2384118.ElmRrZpdEv@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:42470 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbaJBQpn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Oct 2014 12:45:43 -0400
Received: by mail-vc0-f175.google.com with SMTP id id10so1644015vcb.6
        for <linux-mmc@vger.kernel.org>; Thu, 02 Oct 2014 09:45:42 -0700 (PDT)
In-Reply-To: <2384118.ElmRrZpdEv@amdc1032>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "cpgs ." <cpgs@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Seung-Won Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <tomasz.figa@gmail.com>, SUNIL JOSHI <joshi@samsung.com>, PRASHANTH GODREHAL <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Abhilash Kesavan <a.kesavan@samsung.com>

Bartiomiej

On Thu, Oct 2, 2014 at 9:39 AM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Thursday, October 02, 2014 09:19:08 AM Doug Anderson wrote:
>> Bartiomiej,
>>
>> On Thu, Oct 2, 2014 at 9:10 AM, Bartlomiej Zolnierkiewicz
>> <b.zolnierkie@samsung.com> wrote:
>> > Regulators for MMC2 (SD card) are PVDD_TFLASH_2V8 (LDO19) for vmmc
>> > and PVDD_APIO_MMCOFF_2V8 (LDO13) for vqmmc.  Currently the device
>> > tree entry for MMC2 uses PVDD_PRE_1V8 (LDO10) for vmmc and vqmmc is
>> > not specified.  Fix it.
>> >
>> > Without this patch:
>> > - "mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators"
>> >   patch causes a SD card detection to fail
>> > - "mmc: dw_mmc: Support voltage changes" patch causes a boot hang
>> >
>> > This patch fixes both above problems.
>> >
>> > Suggested-by: Doug Anderson <dianders@google.com>
>> > Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> > ---
>> >  arch/arm/boot/dts/exynos5420-arndale-octa.dts |    3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > Index: b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
>> > ===================================================================
>> > --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts     2014-10-02 15:44:53.014826886 +0200
>> > +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts     2014-10-02 17:35:24.110600398 +0200
>> > @@ -74,7 +74,8 @@
>> >                 samsung,dw-mshc-ddr-timing = <1 2>;
>> >                 pinctrl-names = "default";
>> >                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>> > -               vmmc-supply = <&ldo10_reg>;
>> > +               vmmc-supply = <&ldo19_reg>;
>> > +               vqmmc-supply = <&ldo13_reg>;
>>
>> This looks right to me.  ...but I notice that ldo13 and ldo19 are not
>> "always-on" in the DTS.  Are you sure card detect works for you if you
>> eject your card and try to put it back in?
>>
>> ...eventually the "always-on" won't be needed, but for now I think it is...
>
> Card detection works fine without "always-on".

That's weird.

1. In the schematics I see XMMC2CDN has an external pullup to PVDD_TFLASH_2V8.

2. The internal pullup should (I think) be to VDDQ_MMC2 which is
PVDD_APIO_MMCOFF_2V8.

3. In (51da224 mmc: dw_mmc: use mmc_regulator_get_supply to handle
regulators) we should be turning off both regulators in
"MMC_POWER_OFF".

4. If I understand correctly MMC_POWER_OFF is called when the card is
ejected, which means that both regulators should be off when the card
is ejected.

5. I don't think card detect can work if neither regulator is powered.


One of the above points must be wrong.  Any idea which one?  Can you
check to see if MMC_POWER_OFF is called for you when the card is
ejected?  Can you check to see if these regulators are off?


-Doug
