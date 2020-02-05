Return-Path: <SRS0=4knG=3Z=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE08C33CA1
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 09:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B74420659
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 09:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgBEJ06 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:26:58 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:41054 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbgBEJ06 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Feb 2020 04:26:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id F0459FB03;
        Wed,  5 Feb 2020 10:26:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Db75lo8tmrVk; Wed,  5 Feb 2020 10:26:54 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id C1A17400E6; Wed,  5 Feb 2020 10:26:53 +0100 (CET)
Date:   Wed, 5 Feb 2020 10:26:53 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: sdhci timeout on imx8mq
Message-ID: <20200205092653.GB2737@bogon.m.sigxcpu.org>
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Fabio,
On Mon, Feb 03, 2020 at 04:19:50PM -0300, Fabio Estevam wrote:
> Hi,
> 
> I observe the following timeout on a imx8mq-evk running linux-next 20200203:
> 
> # [   11.747858] mmc0: Timeout waiting for hardware interrupt.
> [   11.753264] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [   11.759705] mmc0: sdhci: Sys addr:  0x00000800 | Version:  0x00000002
> [   11.766145] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
> [   11.772584] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
> [   11.779024] mmc0: sdhci: Present:   0x01f88a0a | Host ctl: 0x00000011
> [   11.785463] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
> [   11.791902] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x000020ff
> [   11.798342] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
> [   11.804781] mmc0: sdhci: Int enab:  0x117f100b | Sig enab: 0x117f100b
> [   11.811220] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00008402
> [   11.817660] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
> [   11.824100] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00ffffff
> [   11.830539] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [   11.836978] mmc0: sdhci: Resp[2]:   0x320f5913 | Resp[3]:  0x00d04f01
> [   11.843416] mmc0: sdhci: Host ctl2: 0x00000008
> [   11.847860] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0xf97d2200
> [   11.854297] mmc0: sdhci: ============================================
> [   11.860908] mmc0: error -110 whilst initialising MMC card
> [   12.027806] mmc0: new HS400 MMC card at address 0001
> [   12.033283] mmcblk0: mmc0:0001 R1J56L 13.8 GiB
> [   12.038007] mmcblk0boot0: mmc0:0001 R1J56L partition 1 4.00 MiB
> [   12.044112] mmcblk0boot1: mmc0:0001 R1J56L partition 2 4.00 MiB
> [   12.050172] mmcblk0rpmb: mmc0:0001 R1J56L partition 3 128 KiB,
> chardev (235:0)
> [   12.058210]  mmcblk0: p1 p2
> 
> Haven't had a chance to debug this yet, but just reporting in case
> anyone has any ideas.

I've seen the same occasionally on the librem 5 with older linux-next as
well. Do you have a good reproducer?
Cheers,
 -- Guido

> 
> Thanks
> 
