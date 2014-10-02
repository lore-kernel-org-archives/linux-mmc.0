From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH V2 1/3] mmc: dw_mmc: use mmc_regulator_get_supply to handle
 regulators
Date: Thu, 02 Oct 2014 18:06:51 +0200
Message-ID: <1754745.SCGBco8pNI@amdc1032>
References: <01.09.14890.83F4B245@epcpsbge5.samsung.com>
 <1831792.g28ajrp9B5@amdc1032>
 <CAD=FV=Xcv6E57u=kUj4QSWOpxCwOuJ4UyrFhSg1z0O1zx8nCag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:44349 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbaJBQHH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Oct 2014 12:07:07 -0400
In-reply-to: <CAD=FV=Xcv6E57u=kUj4QSWOpxCwOuJ4UyrFhSg1z0O1zx8nCag@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "cpgs ." <cpgs@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Seung-Won Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, SUNIL JOSHI <joshi@samsung.com>, PRASHANTH GODREHAL <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Abhilash Kesavan <a.kesavan@samsung.com>


Hi,

On Wednesday, October 01, 2014 09:04:09 AM Doug Anderson wrote:
> Hi,
> 
> On Wed, Oct 1, 2014 at 7:00 AM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > Hi,
> >
> > On Wednesday, October 01, 2014 12:47:52 AM YUVARAJ CD wrote:
> >
> >> Since I am out of station, i dont have an access to my work set up.
> >> Can you send me the dts entries of sd crad and their corresponding regulator entries?
> >
> > From arch/arm/boot/dts/exynos5420-arndale-octa.dts:
> >
> > ...
> >         mmc@12200000 {
> >                 status = "okay";
> >                 broken-cd;
> >                 supports-highspeed;
> >                 card-detect-delay = <200>;
> >                 samsung,dw-mshc-ciu-div = <3>;
> >                 samsung,dw-mshc-sdr-timing = <0 4>;
> >                 samsung,dw-mshc-ddr-timing = <0 2>;
> >                 pinctrl-names = "default";
> >                 pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
> >                 vmmc-supply = <&ldo10_reg>;
> >
> >                 slot@0 {
> >                         reg = <0>;
> >                         bus-width = <8>;
> >                 };
> >         };
> >
> >         mmc@12220000 {
> >                 status = "okay";
> >                 supports-highspeed;
> >                 card-detect-delay = <200>;
> >                 samsung,dw-mshc-ciu-div = <3>;
> >                 samsung,dw-mshc-sdr-timing = <2 3>;
> >                 samsung,dw-mshc-ddr-timing = <1 2>;
> >                 pinctrl-names = "default";
> >                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> >                 vmmc-supply = <&ldo10_reg>;
> >
> >                 slot@0 {
> >                         reg = <0>;
> >                         bus-width = <4>;
> >                 };
> >         };
> > ...
> >                                 ldo10_reg: LDO10 {
> >                                         regulator-name = "PVDD_PRE_1V8";
> >                                         regulator-min-microvolt = <1800000>;
> >                                         regulator-max-microvolt = <1800000>;
> >                                         regulator-always-on;
> >                                 };
> 
> I don't have schematics for Arndale Octa, but the above is really
> fishy.  "vmmc" shouldn't be 1.8V.  That's the general power signal to
> MMC and should be 2.7V - 3.6V.  "vqmmc" could be 1.8V in certain
> situations, but my understanding is that for maximum compatibility it
> should at least start out identical to "vmmc" (and later go down to
> 1.7V - 1.95V).
> 
> My first thought would be to just remove the "vmmc-supply" from your
> DTS.  I think we could land that and pick it back easily.  That will
> get you something working and won't introduce any regressions because:
> 1. MMC core will give you a dummy regulator
> 2. The code will default to assuming that vmmc is 3.3V, which is what
> it used to do anyway.
> 3. The only referenced regulator is always on anyway.
> 
> Separately you could specify a proper vmmc and maybe even a vqmmc.
> 
> On SMDK5420 I see this for the SD card (mmc2):
> * vmmc should be "VDD_SD_2V8".  From LDO19.
> * vqmmc should be "VDDQ_MMC2_AP".  From LDO13.
> 
> OK, I dug up the Arndale schematics.  For mmc2:
> * vmmc should be PVDD_TFLASH_2V8.  That's LDO19.
> * vqmmc (hooked up to VDDQ_MMC2): PVDD_APIO_MMCOFF_2V8.  LDO13 just like SMDK.
> 
> ...sadly it looks like Anrdale has a schematics problem that prevents
> you from doing UHS.  I see that the data lines are pulled up to
> PVDD_TFLASH_2V8 (vmmc), not pulled up to PVDD_APIO_MMCOFF_2V8 (vqmmc).
> I think that means that if you ever lower vqmmc to 1.8V (as needed for
> UHS) then you'll still be pulling up to 2.8V.  That's not good.  You
> should probably make sure that both LDO13 and LDO19 are listed as
> being exactly 2.8V.
> 
> 
> Anyway, the above has (obviously) not been tested and is just based on
> a casual browsing of schematics.  Please let me know how it goes.

Removing the "vmmc-supply" entry fixes the problem.  Using LDO13 for vmmc
and LDO19 for vqmmc also works fine.  I'll post a patch fixing the mmc2 DT
entry to Kukjin in a few minutes.  Thank you for your help.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

