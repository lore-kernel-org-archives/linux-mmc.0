Return-Path: <SRS0=9HeC=D6=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163D5C388F9
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 10:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394BB2225F
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Oct 2020 10:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=inventati.org header.i=@inventati.org header.b="Vd6mWOjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462587AbgJWK71 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Oct 2020 06:59:27 -0400
Received: from confino.investici.org ([212.103.72.250]:20953 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462580AbgJWK71 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Oct 2020 06:59:27 -0400
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CHh7c0hKkz12x9;
        Fri, 23 Oct 2020 10:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inventati.org;
        s=stigmate; t=1603450764;
        bh=yNcJZ3ElgPayh7U8Voi9JgyHgdjsR7dkUwM7SBAhUxo=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=Vd6mWOjgVYN/ixvjMX436njnH0GDzD2FtVKWLecGq6kxxmY5PJOZ+vXHibSaC8oz1
         J7uCsBnZ4K4u1fyxcxT3aXaTorgNTwUQlZTkEnMKJdCo2ZTfkkSDFRUb8jfRATItbY
         v7cBGHUBSOqUUGYB3+4SED3vbG7UllqY8cxqa8Ds=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: rinni@inventati.org) by localhost (Postfix) with ESMTPSA id 4CHh7b5r1Rz12x6;
        Fri, 23 Oct 2020 10:59:23 +0000 (UTC)
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <0d590f91-5d7a-697a-5644-710d14e3ea75@inventati.org>
 <CAJiuCceLR_zfyA0zHyRrqZ46DoQ6Ju-xVaa2Rf_PkjDkPOR8JA@mail.gmail.com>
 <20201022091337.3u5ya3jouhmaukcj@gilmour.lan>
 <CAJiuCcfyx734fo52VU4t5jF6pZ7vcg4VR1HhWMzg_UW9Xfaj8A@mail.gmail.com>
 <CAJiuCcd1O0OVeJSmqa=srOOzwuKciqKbm4Xbh+dn4XCycSbLAg@mail.gmail.com>
From:   Philip Rinn <rinni@inventati.org>
Autocrypt: addr=rinni@inventati.org; prefer-encrypt=mutual; keydata=
 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
 bA8HdppJKhaDOUdekpLdnVfd5A==
Subject: Re: [linux-sunxi] [PATCH] Disable HS-DDR mode for Olimex
 A64-OLinuXino variants with eMMC
Message-ID: <f9cab2ce-1155-217c-bfa4-95f66d5cbfad@inventati.org>
Date:   Fri, 23 Oct 2020 12:59:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCcd1O0OVeJSmqa=srOOzwuKciqKbm4Xbh+dn4XCycSbLAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Clément,

Am 23.10.20 um 10:45 schrieb Clément Péron:
> Hi Philip and Chen-Yu
> 
> (+Chen-Yu added as He also have the issue for H5)
> 
> On Thu, 22 Oct 2020 at 17:39, Clément Péron <peron.clem@gmail.com> wrote:
>>
>> Hi Maxime,
>>
>> On Thu, 22 Oct 2020 at 11:13, Maxime Ripard <maxime@cerno.tech> wrote:
>>>
>>> Hi,
>>>
>>> On Thu, Oct 22, 2020 at 09:52:29AM +0200, Clément Péron wrote:
>>>> Hi Philipp,
>>>>
>>>> On Thu, 22 Oct 2020 at 00:10, Philip Rinn <rinni@inventati.org> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> the Olimex A64-OLinuXino board comes in various variants, three with eMMC.
>>>>> While MMC HS-DDR mode works fine on one of them (A64-OLinuXino-1Ge4GW) it
>>>>> doesn't work on the A64-OLinuXino-2Ge8G-IND variant (I don't have the
>>>>> third variant so I can't check if it works there).
>>>>
>>>> We got similar situations for Allwinner H6 (Beelink GS1 and Tanix TX6).
>>>>
>>>> There is definitely an issue in the MMC sunxi driver with HS-DDR mode
>>>> and it's not limited to "olimex,a64-olinuxino-emmc".
>>>>
>>>> Have a look at this this message posted by Jernej:
>>>> https://www.spinics.net/lists/arm-kernel/msg846093.html
>>>>
>>>> I think we should disable the HS-DDR mode for A64 / H6 like it's done
>>>> for H5 and not disable board per board until the issue is resolved.
>>>
>>> I'm not opposed to that on principle, but "it doesn't work on some
>>> board" is not a proper justification to do so. It does on some others,
>>> so surely there's more to it and this would just paper over whatever
>>> issue we have instead of properly fixing it.
>>
>> Maybe the term board is not correct, maybe it's the eMMC chip which is
>> different.
>> I don't know if all Beelink GS1/Tanix TX6 use the same eMMC chip for
>> all the boards.
>>
>>>
>>>> If you want to disable only for your board you can set in your
>>>> device-tree: mmc-hs200-1_8v; This will switch to HS200 mode without
>>>> using the HS-DDR mode.
>>>
>>> Sigh. Can we at least work on a fix instead of providing terrible
>>> workarounds?
>>
>> I agree with you on this, but my board doesn't have this issue and I
>> tried to read the vendor kernel and spot a difference but didn't find
>> anything relevant.
> 
> After reviewing the correct file this time :P
> 
> I catched a slight difference between the mainline and vendor driver
> in DDR mode.
> 
> the phase is set to 1
> case MMC_TIMING_UHS_DDR50:
> case MMC_TIMING_MMC_DDR52:
> dat_drv_ph = 1;
> speed_mod = SM2_HSDDR52_DDR50;
> break;
> 
> Could you add a hack in DDR mode and see if it's working better ?
> 
> Maybe line 738:
> 
> #define SDXC_REG_DRV_DL (0x0140)
> #define SDXC_DAT_DRV_PH_SEL BIT(17)
> 
> rval = mmc_readl(host, REG_DRV_DL);
> rval |= SDXC_DAT_DRV_PH_SEL;
> mmc_writel(host, REG_DRV_DL, rval);

I tried with this patch but no luck, see log below

--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -230,6 +230,8 @@

 #define SDXC_CAL_TIMEOUT	3	/* in seconds, 3s is enough*/

+#define SDXC_DAT_DRV_PH_SEL BIT(17)
+
 struct sunxi_mmc_clk_delay {
 	u32 output;
 	u32 sample;
@@ -718,6 +720,7 @@
 				   struct mmc_ios *ios, u32 rate)
 {
 	int index;
+	u32 rval;

 	/* clk controller delays not used under new timings mode */
 	if (host->use_new_timings)
@@ -736,6 +739,10 @@
 		if (ios->timing != MMC_TIMING_UHS_DDR50 &&
 		    ios->timing != MMC_TIMING_MMC_DDR52) {
 			index = SDXC_CLK_50M;
+
+			rval = mmc_readl(host, REG_DRV_DL);
+			rval |= SDXC_DAT_DRV_PH_SEL;
+			mmc_writel(host, REG_DRV_DL, rval);
 		} else if (ios->bus_width == MMC_BUS_WIDTH_8) {
 			index = SDXC_CLK_50M_DDR_8BIT;
 		} else {



log:

[...]
[    3.526269] sunxi-mmc 1c0f000.mmc: Error applying setting, reverse things back
[    3.526488] sun50i-a64-pinctrl 1c20800.pinctrl: Couldn't get bank PG regulator
[    3.526495] sun50i-a64-pinctrl 1c20800.pinctrl: request() failed for pin 192
[    3.526502] sun50i-a64-pinctrl 1c20800.pinctrl: pin-192 (1c10000.mmc) status -517
[    3.526509] sun50i-a64-pinctrl 1c20800.pinctrl: could not request pin 192 (PG0)
from group PG0  on device 1c20800.pinctrl
[    3.526514] sunxi-mmc 1c10000.mmc: Error applying setting, reverse things back
[    3.526707] sun50i-a64-pinctrl 1c20800.pinctrl: Couldn't get bank PC regulator
[    3.526713] sun50i-a64-pinctrl 1c20800.pinctrl: request() failed for pin 69
[    3.526720] sun50i-a64-pinctrl 1c20800.pinctrl: pin-69 (1c11000.mmc) status -517
[    3.526727] sun50i-a64-pinctrl 1c20800.pinctrl: could not request pin 69 (PC5)
from group PC5  on device 1c20800.pinctrl
[    3.526732] sunxi-mmc 1c11000.mmc: Error applying setting, reverse things back
[    3.571178] sun50i-a64-pinctrl 1c20800.pinctrl: Couldn't get bank PH regulator
[    3.571191] sun50i-a64-pinctrl 1c20800.pinctrl: request() failed for pin 233
[    3.571199] sun50i-a64-pinctrl 1c20800.pinctrl: pin-233 (1c20800.pinctrl:233)
status -517
[...]
[    3.899303] sunxi-mmc 1c11000.mmc: initialized, max. request size: 2048 KB,
uses new timings mode
[    3.984611] mmc2: new DDR MMC card at address 0001
[    3.986242] mmcblk2: mmc2:0001 Q2J55L 7.09 GiB
[    3.987147] mmcblk2boot0: mmc2:0001 Q2J55L partition 1 16.0 MiB
[    3.988071] mmcblk2boot1: mmc2:0001 Q2J55L partition 2 16.0 MiB
[    3.995437] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    3.995452] sunxi-mmc 1c11000.mmc: send stop command failed
[    3.995898] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    3.996262] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    3.996275] sunxi-mmc 1c11000.mmc: send stop command failed
[    3.996503] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    3.996827] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    3.997149] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    3.997162] sunxi-mmc 1c11000.mmc: send stop command failed
[    3.998239] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    3.998527] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    3.998733] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    3.998746] sunxi-mmc 1c11000.mmc: send stop command failed
[    3.999305] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    3.999323] sunxi-mmc 1c11000.mmc: send stop command failed
[    3.999545] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    3.999752] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    3.999765] sunxi-mmc 1c11000.mmc: send stop command failed
[    4.081911] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    4.133171] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    4.133184] sunxi-mmc 1c11000.mmc: send stop command failed
[    4.133252] blk_update_request: I/O error, dev mmcblk2, sector 0 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[    4.133260] Buffer I/O error on dev mmcblk2, logical block 0, async page read
[    4.133384] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    4.133464] blk_update_request: I/O error, dev mmcblk2, sector 2 op 0x0:(READ)
flags 0x0 phys_seg 4 prio class 0
[    4.133470] Buffer I/O error on dev mmcblk2, logical block 2, async page read
[    4.133477] Buffer I/O error on dev mmcblk2, logical block 3, async page read
[    4.133483] Buffer I/O error on dev mmcblk2, logical block 4, async page read
[    4.133489] Buffer I/O error on dev mmcblk2, logical block 5, async page read
[    4.133762] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    4.133774] sunxi-mmc 1c11000.mmc: send stop command failed
[    4.134285] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    4.134297] sunxi-mmc 1c11000.mmc: send stop command failed
[    4.134519] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    4.134531] sunxi-mmc 1c11000.mmc: send stop command failed
[    4.134752] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    4.134764] sunxi-mmc 1c11000.mmc: send stop command failed
[    4.134976] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    4.134988] sunxi-mmc 1c11000.mmc: send stop command failed
[    4.186318] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    4.186330] sunxi-mmc 1c11000.mmc: send stop command failed
[    4.186384] blk_update_request: I/O error, dev mmcblk2, sector 0 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[...]

Regards,
Philip

> Regards,
> Clement
> 
>>
>> Regards,
>> Clement
>>
>>>
>>> Maxime

