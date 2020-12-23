Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317FBC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 21:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D8E2246B
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 21:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgLWVGx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Dec 2020 16:06:53 -0500
Received: from node.akkea.ca ([192.155.83.177]:46900 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgLWVGw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 23 Dec 2020 16:06:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 7F9934E7973;
        Wed, 23 Dec 2020 21:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1608757572; bh=F4kVbAC1fiNjqQCNQtH+R+Y+w2DekOd7qvPJuY26BbM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=PH/Wt8IxKOgGYBNxxsV1hxXzvhN5sgkYCvWnwdvWYar12zcWHl16sHbISNSJ7dWZN
         D7GaV9UCdIAhVdYOX/vup+5qMygbg9S2fGbiMFzkzsY5RNYexwGbREl0UzrS4XPXaD
         Bbu5ac/ifqdQAjjGCK8fXd8dRPcfvuPuyGRztbpE=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cZpFwZGwgZKM; Wed, 23 Dec 2020 21:06:09 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id D20FD4E796B;
        Wed, 23 Dec 2020 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1608757569; bh=F4kVbAC1fiNjqQCNQtH+R+Y+w2DekOd7qvPJuY26BbM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=ACobnMibFxj7qdRyxg9k1J0d3KljzW37BDJ44PmkB/k93ibBm69WQrDeqN48+3UhS
         rR9W6MYlbacJ39YIzV4BisO3TXIksBJZERqiIx/mcsHOHKNqEUOS6tJYGb5ePso3L/
         fy7+sI2gyFl3kvKSTt07Ylnhv1YZ2X9AC+mZWmnE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Dec 2020 13:06:08 -0800
From:   Angus Ainslie <angus@akkea.ca>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     BOUGH CHEN <haibo.chen@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: sdhci timeout on imx8mq
In-Reply-To: <4a1fb9fa69d6fdb0ec2d7c390112d412d512ff13.camel@pengutronix.de>
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
 <20200205092653.GB2737@bogon.m.sigxcpu.org>
 <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
 <VI1PR04MB5040A046E5D93265AE636B29901C0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <VI1PR04MB504091C7991353F6092A8D91901A0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <CAOMZO5CkSSidzLUSBUvJNAio3SnmU-fisTbDCiLN9v1EjS+HHQ@mail.gmail.com>
 <5ad361195f2e191484c8a231be0f5a07@akkea.ca>
 <CAOMZO5BarV1=6rx9L_hkJJLUQSicwPNUO4HFKWAXSQ6n0N+Kzg@mail.gmail.com>
 <VI1PR04MB52942233A0BA6BCB692F281E90670@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <4a1fb9fa69d6fdb0ec2d7c390112d412d512ff13.camel@pengutronix.de>
Message-ID: <0c2bdbe7b99f7edd6c39272d8307cd33@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Lucas,

On 2020-12-18 12:07, Lucas Stach wrote:
> 
> Can you show me the full fail log? I do not meet this issue on my side,
> besides, which kind of uboot do you use?
> 

I've got the dmesg output and it's 33K. Should I send it to the list or 
do you want to see it out of band ?

The 2 relevant sections are

[   13.281867] mmc0: Timeout waiting for hardware interrupt.
[   13.287310] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[   13.293810] mmc0: sdhci: Sys addr:  0x00000800 | Version:  0x00000002
[   13.300290] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
[   13.306774] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
[   13.313258] mmc0: sdhci: Present:   0x01f88a0a | Host ctl: 0x00000011
[   13.319738] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
[   13.326218] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x000020ff
[   13.332699] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
[   13.339178] mmc0: sdhci: Int enab:  0x107f100b | Sig enab: 0x107f100b
[   13.345658] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00008402
[   13.352141] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
[   13.358622] mmc0: sdhci: Cmd:       0x0000083a | Max curr: 0x00ffffff
[   13.365106] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
[   13.371589] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d02700
[   13.378068] mmc0: sdhci: Host ctl2: 0x00000000
[   13.382554] mmc0: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0xe5b90200
[   13.389042] mmc0: sdhci-esdhc-imx: ========= ESDHC IMX DEBUG STATUS 
DUMP =========
[   13.396661] mmc0: sdhci-esdhc-imx: cmd debug status:  0x2100
[   13.402361] mmc0: sdhci-esdhc-imx: data debug status:  0x2200
[   13.408119] mmc0: sdhci-esdhc-imx: trans debug status:  0x2300
[   13.413991] mmc0: sdhci-esdhc-imx: dma debug status:  0x2402
[   13.419718] mmc0: sdhci-esdhc-imx: adma debug status:  0x2501
[   13.425478] mmc0: sdhci-esdhc-imx: fifo debug status:  0x2610
[   13.431294] mmc0: sdhci-esdhc-imx: async fifo debug status:  0x2751
[   13.437600] mmc0: sdhci: ============================================
[   13.453076] mmc0: error -110 whilst initialising MMC card
[   13.662288] mmc0: new HS400 MMC card at address 0001
[   13.676191] mmcblk0: mmc0:0001 032G32 29.1 GiB
[   13.684755] mmcblk0boot0: mmc0:0001 032G32 partition 1 4.00 MiB
[   13.694405] mmcblk0boot1: mmc0:0001 032G32 partition 2 4.00 MiB
[   13.702264] mmcblk0rpmb: mmc0:0001 032G32 partition 3 4.00 MiB, 
chardev (245:0)
[   13.715966]  mmcblk0: p1 p2

[   29.665891] mmc1: Timeout waiting for hardware interrupt.
[   29.671310] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[   29.677758] mmc1: sdhci: Sys addr:  0x00000800 | Version:  0x00000002
[   29.684201] mmc1: sdhci: Blk size:  0x00000004 | Blk cnt:  0x00000001
[   29.690642] mmc1: sdhci: Argument:  0x12008004 | Trn mode: 0x00000013
[   29.697086] mmc1: sdhci: Present:   0x01f88a0a | Host ctl: 0x00000013
[   29.703529] mmc1: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
[   29.709980] mmc1: sdhci: Wake-up:   0x00000008 | Clock:    0x0000003f
[   29.716426] mmc1: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
[   29.722868] mmc1: sdhci: Int enab:  0x107f110b | Sig enab: 0x107f110b
[   29.729310] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00008402
[   29.735754] mmc1: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
[   29.742212] mmc1: sdhci: Cmd:       0x0000353a | Max curr: 0x00ffffff
[   29.748658] mmc1: sdhci: Resp[0]:   0x00002000 | Resp[1]:  0x00000000
[   29.755099] mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[   29.761540] mmc1: sdhci: Host ctl2: 0x00000000
[   29.765989] mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0xe6605200
[   29.772439] mmc1: sdhci-esdhc-imx: ========= ESDHC IMX DEBUG STATUS 
DUMP =========
[   29.780026] mmc1: sdhci-esdhc-imx: cmd debug status:  0x2100
[   29.785692] mmc1: sdhci-esdhc-imx: data debug status:  0x2200
[   29.791448] mmc1: sdhci-esdhc-imx: trans debug status:  0x2300
[   29.797284] mmc1: sdhci-esdhc-imx: dma debug status:  0x2402
[   29.802943] mmc1: sdhci-esdhc-imx: adma debug status:  0x2501
[   29.808690] mmc1: sdhci-esdhc-imx: fifo debug status:  0x2690
[   29.814437] mmc1: sdhci-esdhc-imx: async fifo debug status:  0x2751
[   29.820701] mmc1: sdhci: ============================================

Thanks
Angus
