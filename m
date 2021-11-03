Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BC9C433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 17:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6F760FC4
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 17:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhKCR3m (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:29:42 -0400
Received: from mout.perfora.net ([74.208.4.196]:42835 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhKCR3l (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Nov 2021 13:29:41 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Nov 2021 13:29:41 EDT
Received: from [10.10.1.231] ([194.191.235.54]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MPn4m-1mmBpc0SF0-004zYw;
 Wed, 03 Nov 2021 18:21:34 +0100
Message-ID: <c276f255a406d3e8cfe6bdc8ba89b0b3d5cbf08c.camel@ziswiler.com>
Subject: Re: IMX8MM eMMC CQHCI timeout
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Tim Harvey <tharvey@gateworks.com>, Bough Chen <haibo.chen@nxp.com>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, Frank Li <frank.li@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Cale Collins <ccollins@gateworks.com>
Date:   Wed, 03 Nov 2021 18:21:29 +0100
In-Reply-To: <CAJ+vNU3zKEVz=fHu2hLmEpsQKzinUFW-28Lm=2wSEghjMvQtmw@mail.gmail.com>
References: <CAJ+vNU2Vt2hWW=Yxh5W=bVerJjwbNoJpTDGgXxUUo9PZvzFe9A@mail.gmail.com>
         <VI1PR04MB52942DA2B09A320B8060A3A8908A9@VI1PR04MB5294.eurprd04.prod.outlook.com>
         <CAJ+vNU3zKEVz=fHu2hLmEpsQKzinUFW-28Lm=2wSEghjMvQtmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 (by Flathub.org) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CjQXPNeSG86gmuiATCM3Sh9D3ufFOn18qoW7yjQytsbq+kXQTx6
 mjSZ3kkYgP9Kujb0lbVVEYTneDj3I8+ZGMvP8QJ9GgsLLGeMssykty+WICbmUCaRbhTswY9
 J6OGcetcTPpnzmeb9l2u5J/y2k2YvUJxEW+35ZNsUmNIZry0n/QRQL48tn4DKFdpXKEMyEA
 r9OcTG75mdtRF9VHJqM0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eM89y4eZ4qo=:R6aox01N91XGFMrMGN1hS9
 kGrubS/F4EtE+5e7Rohf7WHKg4RJRN+UpuWvQrQJqJ9Jf+lJgvEg+/i2+FPNAkfkUysCEhApP
 Z0Oy2lFemDEUg9qALq+df+xJkJPYpNWWZ5cI5t84uwDj+xyvXbpzTrFsj3xQKveyvM9CiurbG
 zI4ndmP4qfWVKuwj7S2Qa/t6TQfWfhcaEdcdLHY5RmZrt9e347wQT2sStRj//p2V9gQHReTKg
 n81uO/+Fuq5Uo7HUg0c9RZIeV2hK2OMDuQCrsX3UxovPtJ/zLuZIrADUPVB5oOUtK6BrLEaS/
 mpiLZJPdelYN6grhdLfyAUClyn3RyQIWix603UxVvn1M0r+4YZL6EQlzTGaG3H3i20oVXlMCV
 2A7gNe3e0ABen6KzzcxQjAz7zVciOAg3XP2hobE+i9cgrLKrMIio/pV0KYKQtTNmjIYbF6aDT
 bgrCEVnxy0NZ+gVyfn1kYMny5mI/GOe0cUYhgCS5z/Wueer4S34E4vGJ7wXM54buaNZrKnd2J
 KGnZkq7F98YFnDszC0nAGeb1HBMCcbmgEgxxhcGvKe1d4qCDAycc4ogNzbnGtAlakTeLnm3eN
 GF9iWhTcXV71gW0j5O01s7XcOqGwvs5n2DcXEzBcyS42hY+WiKCDQbn3z7azOzQyVpit/yUWs
 xYPTHjvxa+vMvU8edfy9pfO6hqUj4t1E1MAog+XGwhgmcN4n2aENvK/vssJKG2H0kzGM=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2021-11-03 at 09:49 -0700, Tim Harvey wrote:
> On Sun, Oct 31, 2021 at 6:57 PM Bough Chen <haibo.chen@nxp.com> wrote:
> > 
> > > -----Original Message-----
> > > From: Tim Harvey [mailto:tharvey@gateworks.com]
> > > Sent: 2021年10月30日 4:47
> > > To: Linux MMC List <linux-mmc@vger.kernel.org>; Marcel Ziswiler
> > > <marcel@ziswiler.com>; Fabio Estevam <festevam@gmail.com>; Schrempf
> > > Frieder <frieder.schrempf@kontron.de>; Adam Ford <aford173@gmail.com>;
> > > Bough Chen <haibo.chen@nxp.com>; Lucas Stach <l.stach@pengutronix.de>;
> > > Peng Fan <peng.fan@nxp.com>; Frank Li <frank.li@nxp.com>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>; Shawn Guo
> > > <shawnguo@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; Sascha
> > > Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > <kernel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>; Cale Collins
> > > <ccollins@gateworks.com>
> > > Subject: IMX8MM eMMC CQHCI timeout
> > > 
> > > Greetings,
> > > 
> > > I've encountered the following MMC CQHCI timeout message a couple of times
> > > now on IMX8MM boards with eMMC with a 5.10 based kernel:
> > > 
> > > [  224.356283] mmc2: cqhci: ============ CQHCI REGISTER DUMP
> > > ===========
> > > [  224.362764] mmc2: cqhci: Caps:      0x0000310a | Version:
> > > 0x00000510
> > > [  224.369250] mmc2: cqhci: Config:    0x00001001 | Control:  0x00000000
> > > [  224.375726] mmc2: cqhci: Int stat:  0x00000000 | Int enab: 0x00000006
> > > [  224.382197] mmc2: cqhci: Int sig:   0x00000006 | Int Coal: 0x00000000
> > > [  224.388665] mmc2: cqhci: TDL base:  0x8003f000 | TDL up32: 0x00000000
> > > [  224.395129] mmc2: cqhci: Doorbell:  0xbf01dfff | TCN:      0x00000000
> > > [  224.401598] mmc2: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x08000000
> > > [  224.408064] mmc2: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
> > > [  224.414532] mmc2: cqhci: SSC2:      0x00000001 | DCMD rsp:
> > > 0x00000800
> > > [  224.420997] mmc2: cqhci: RED mask:  0xfdf9a080 | TERRI:
> > > 0x00000000
> > > [  224.427467] mmc2: cqhci: Resp idx:  0x0000000d | Resp arg: 0x00000000
> > > [  224.433934] mmc2: sdhci: ============ SDHCI REGISTER DUMP
> > > =========== [  224.440404] mmc2: sdhci: Sys addr:  0x7c722000 | Version:
> > > 0x00000002 [  224.446877] mmc2: sdhci: Blk size:  0x00000200 | Blk cnt:
> > > 0x00000020 [  224.453346] mmc2: sdhci: Argument:  0x00018000 | Trn
> > > mode: 0x00000023
> > > [  224.459811] mmc2: sdhci: Present:   0x01f88008 | Host ctl: 0x00000030
> > > [  224.466281] mmc2: sdhci: Power:     0x00000002 | Blk gap:
> > > 0x00000080
> > > [  224.472752] mmc2: sdhci: Wake-up:   0x00000008 | Clock:
> > > 0x0000000f
> > > [  224.479225] mmc2: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
> > > [  224.485690] mmc2: sdhci: Int enab:  0x107f4000 | Sig enab: 0x107f4000
> > > [  224.492161] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000502
> > > [  224.498628] mmc2: sdhci: Caps:      0x07eb0000 | Caps_1:
> > > 0x8000b407
> > > [  224.505097] mmc2: sdhci: Cmd:       0x00000d1a | Max curr: 0x00ffffff
> > > [  224.511575] mmc2: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0xffc003ff
> > > [  224.518043] mmc2: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d07f01
> > > [  224.524512] mmc2: sdhci: Host ctl2: 0x00000088 [  224.528986] mmc2:
> > > sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xfe179020 [  224.535451]
> > > mmc2: sdhci-esdhc-imx: ========= ESDHC IMX DEBUG STATUS DUMP ====
> > > [  224.543052] mmc2: sdhci-esdhc-imx: cmd debug status:  0x2120
> > > [  224.548740] mmc2: sdhci-esdhc-imx: data debug status:  0x2200
> > > [  224.554510] mmc2: sdhci-esdhc-imx: trans debug status:  0x2300
> > > [  224.560368] mmc2: sdhci-esdhc-imx: dma debug status:  0x2400
> > > [  224.566054] mmc2: sdhci-esdhc-imx: adma debug status:  0x2510
> > > [  224.571826] mmc2: sdhci-esdhc-imx: fifo debug status:  0x2680
> > > [  224.577608] mmc2: sdhci-esdhc-imx: async fifo debug status:  0x2750
> > > [  224.583900] mmc2: sdhci:
> > > ============================================
> > > 
> > > I don't know how to make the issue occur, both times it occured simply
> > reading
> > > a file in the rootfs ext4 fs on the emmc.
> > > 
> > > Some research shows:
> > > -
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcommu
> > > nity.nxp.com%2Ft5%2Fi-MX-Processors%2FThe-issues-on-quot-mmc0-cqhci-tim
> > > eout-for-tag-0-quot%2Fm-p%2F993779&amp;data=04%7C01%7Chaibo.chen%4
> > > 0nxp.com%7C1dc0981634f5460a779808d99b1d5a88%7C686ea1d3bc2b4c6fa9
> > > 2cd99c5c301635%7C0%7C0%7C637711372651089473%7CUnknown%7CTWFp
> > > bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> > > 6Mn0%3D%7C1000&amp;sdata=ITcs7%2FMy%2F1Vx1TMB2VlaY4QhibKuSFBD
> > > 6UZhzVFl%2FqY%3D&amp;reserved=0
> > > -
> > > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fgit.torad
> > > ex.com%2Fcgit%2Flinux-toradex.git%2Fcommit%2F%3Fh%3Dtoradex_5.4-2.3.x
> > > -imx%26id%3Dfd33531be843566c59a5fc655f204bbd36d7f3c6&amp;data=04%
> > > 7C01%7Chaibo.chen%40nxp.com%7C1dc0981634f5460a779808d99b1d5a88%
> > > 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637711372651089473
> > > %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> > > BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=xaamzPb2CdW6YDzW
> > > g8uBb0PjomkoWAziu5qglvMbT2I%3D&amp;reserved=0
> > > 
> > > I'm not clear if this info is up-to-date. The NXP 5.4 kernel did not
> > enable this
> > > feature but if I'm not mistaken CQHCI support itself didn't land in
> > mainline until
> > > a later kernel so it would make sense it was not enabled at that time. I
> > do see
> > > the NXP 5.10 kernels have this enabled so I'm curious if it is an issue
> > there.
> > > 
> > > Any other IMX8MM or other SoC users know what this could be about or what
> > I
> > > could do for a test to try to reproduce it so I can see if it occurs in
> > other kernel
> > > versions?
> > 
> > Hi Tim,
> > 
> > I'm debugging this issue those days, but unfortunately, still not find the
> > root cause.
> > The register value of Doorbell, Dev Queue, Dev Pend seems abnormal. This
> > issue happens
> > on all i.MX SoC which support cmdq feature when cpu loading is high.. Now I
> > lack a mmc
> > logic analyzer, make it not easy to debug this issue. So stll need some
> > time. Sorry about that.
> > If you want to make mmc work stable, you can disable the cmdq as a
> > workaround.
> > 
> > Best Regards
> > Haibo Chen
> 
> Haibo,
> 
> Thanks for the information. Do you know how to easily reproduce it
> reliably for testing?
> 
> I have tried the following on an eMMC filesystem:
> stress --cpu 32 --io 32 &
> dd if=/dev/zero of=foo bs=1M count=1000 &
> dd if=/dev/zero of=foo bs=1M count=1000 &
> rm foo
> 
> I'm unable to reproduce the issue that way, and it has only happened
> randomly once or twice.

It seems to only happen on rather concurrent and high IO load. We got it reliably e.g. when doing docker pulls.

> Perhaps we should disable CMDQ for now until you can sort this out?

We also had to disable it. There even was some inconclusive discussion on NXP's community forum at one time.
However, downstream related.

https://community.nxp.com/t5/i-MX-Processors/The-issues-on-quot-mmc0-cqhci-timeout-for-tag-0-quot/m-p/1330691/highlight/true#M179200

> I can submit a patch for that.
> 
> Best regards,
> 
> Tim
