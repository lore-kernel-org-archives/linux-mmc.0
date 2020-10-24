Return-Path: <SRS0=0cVg=D7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3836BC2D0A3
	for <linux-mmc@archiver.kernel.org>; Sat, 24 Oct 2020 21:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9362098B
	for <linux-mmc@archiver.kernel.org>; Sat, 24 Oct 2020 21:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=inventati.org header.i=@inventati.org header.b="nVeIacZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764849AbgJXVzB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 24 Oct 2020 17:55:01 -0400
Received: from confino.investici.org ([212.103.72.250]:60721 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764841AbgJXVzB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 24 Oct 2020 17:55:01 -0400
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4CJZdV3XYZz12bf;
        Sat, 24 Oct 2020 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inventati.org;
        s=stigmate; t=1603576494;
        bh=kAZ4og6OYL1coY0e1LlAtF7Q1hNVq4HVhP7A76mEIws=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=nVeIacZDPdYParjywnhGaA9WuExFwmYduymd0EaDJiMColZCrwM6vrBNfDXRBZP0Q
         2zGvIiGjCPRHNo6Drrqv93y2qf8jODIaxlCHvTUcnbK3fYZ4imBv33ht7ybFu9Hp/u
         x9OOBPDVQbCG91h5qKDyfSuaXqUfZfxpTfTisQH0=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: rinni@inventati.org) by localhost (Postfix) with ESMTPSA id 4CJZdV1XRbz12bV;
        Sat, 24 Oct 2020 21:54:54 +0000 (UTC)
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
 <f9cab2ce-1155-217c-bfa4-95f66d5cbfad@inventati.org>
 <CAJiuCcckhT8rP_RGub=RdpgtLfPbm_37JGgAywKzO9EVB6bk8w@mail.gmail.com>
From:   Philip Rinn <rinni@inventati.org>
Autocrypt: addr=rinni@inventati.org; prefer-encrypt=mutual; keydata=
 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
 bA8HdppJKhaDOUdekpLdnVfd5A==
Subject: Re: [linux-sunxi] [PATCH] Disable HS-DDR mode for Olimex
 A64-OLinuXino variants with eMMC
Message-ID: <22c45ac3-5406-3f80-0521-325e0fb9cacb@inventati.org>
Date:   Sat, 24 Oct 2020 23:54:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCcckhT8rP_RGub=RdpgtLfPbm_37JGgAywKzO9EVB6bk8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Clément,

On 24.10.20 at 15:00, Clément Péron wrote:
> Hi Philip
> 
> <snip>
> 
>>>
>>> I catched a slight difference between the mainline and vendor driver
>>> in DDR mode.
>>>
>>> the phase is set to 1
>>> case MMC_TIMING_UHS_DDR50:
>>> case MMC_TIMING_MMC_DDR52:
>>> dat_drv_ph = 1;
>>> speed_mod = SM2_HSDDR52_DDR50;
>>> break;
>>>
>>> Could you add a hack in DDR mode and see if it's working better ?
>>>
>>> Maybe line 738:
>>>
>>> #define SDXC_REG_DRV_DL (0x0140)
>>> #define SDXC_DAT_DRV_PH_SEL BIT(17)
>>>
>>> rval = mmc_readl(host, REG_DRV_DL);
>>> rval |= SDXC_DAT_DRV_PH_SEL;
>>> mmc_writel(host, REG_DRV_DL, rval);
>>
>> I tried with this patch but no luck, see log below

<snip>

> Sorry this will not work, as H6 uses new timing mode the function will
> return before setting the DRV_PHASE.

I'm actually testing on an A64 - but that shouldn't matter, right?

> Could you retry with a patch like this :
> https://github.com/clementperon/linux/commit/287a62a6e9ccda3ade9b407ce12ee7db0865b41b.patch

Unfortunately that didn't work either:

[...]
[    3.755418] sunxi-mmc 1c0f000.mmc: initialized, max. request size: 16384 KB,
uses new timings mode
[    3.755432] sunxi-mmc 1c0f000.mmc: MMC version: 0.0.0
[    3.758685] sunxi-mmc 1c10000.mmc: allocated mmc-pwrseq
[    3.783369] sunxi-mmc 1c10000.mmc: initialized, max. request size: 16384 KB,
uses new timings mode
[    3.783382] sunxi-mmc 1c10000.mmc: MMC version: 0.0.0
[    3.798267] mmc0: new high speed SDHC card at address aaaa
[    3.799776] mmcblk0: mmc0:aaaa SC16G 14.8 GiB
[    3.804248]  mmcblk0: p1
[    3.811371] sunxi-mmc 1c11000.mmc: initialized, max. request size: 2048 KB,
uses new timings mode
[    3.811385] sunxi-mmc 1c11000.mmc: MMC version: 0.0.0
[...]
[    3.936574] sunxi-mmc 1c11000.mmc: Setting Phase delay
[    3.936890] mmc2: new DDR MMC card at address 0001
[    3.938617] mmcblk2: mmc2:0001 Q2J55L 7.09 GiB
[    3.939692] mmcblk2boot0: mmc2:0001 Q2J55L partition 1 16.0 MiB
[    3.940519] mmcblk2boot1: mmc2:0001 Q2J55L partition 2 16.0 MiB
[    3.943067] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    3.943083] sunxi-mmc 1c11000.mmc: send stop command failed
[...]
[    4.009680] blk_update_request: I/O error, dev mmcblk2, sector 0 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 0
[    4.009692] Buffer I/O error on dev mmcblk2, logical block 0, async page read
[    4.009817] sunxi-mmc 1c11000.mmc: data error, sending stop command
[    4.009899] blk_update_request: I/O error, dev mmcblk2, sector 2 op 0x0:(READ)
flags 0x0 phys_seg 6 prio class 0
[    4.009906] Buffer I/O error on dev mmcblk2, logical block 2, async page read
[    4.009914] Buffer I/O error on dev mmcblk2, logical block 3, async page read
[    4.009920] Buffer I/O error on dev mmcblk2, logical block 4, async page read
[    4.009926] Buffer I/O error on dev mmcblk2, logical block 5, async page read
[    4.009931] Buffer I/O error on dev mmcblk2, logical block 6, async page read
[    4.009937] Buffer I/O error on dev mmcblk2, logical block 7, async page read
[...]

> Thanks for your test,
> Clement

Thanks for trying to fix that :-)
Philip
