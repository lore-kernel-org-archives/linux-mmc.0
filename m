Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE816C433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 16:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F676112E
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 16:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhKCQwd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Nov 2021 12:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhKCQwc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2021 12:52:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634FCC061714
        for <linux-mmc@vger.kernel.org>; Wed,  3 Nov 2021 09:49:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id o14so2942747pfu.10
        for <linux-mmc@vger.kernel.org>; Wed, 03 Nov 2021 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NC0ikTBtU3+s1clUIqx46RqyaSfiqMlNVn/SU2L768I=;
        b=hQ2j74JCPJMOB4iZIoTArqFAQ0mGOPU4HBjaqdjuHKiYKccSeFiqSZ15H77fq0vw7T
         VPtMIc7oJbHlaY4hCsL2ak4y+lJRz14FkLrnxq1YvTeGLMNWsL9AkhiFTtxNv+PIzEdM
         1HyblooUDM/C3H0bTtGMBLHwFVFkTthUVRbH0EhCewSE/YS81i3saUj2yI1x+nCVB/sW
         eZzWxUlNEIZehu/TNtiERZM4wpoy7R5ZlZtj7fC0vqCvIfUD11Z6A1uuc2ESZLrkC/3T
         CaHgvpMTCjA9RsbTMSxiNCO2CMsmMDT3EhVbkbQsIpxbUXpwsNQnf5u6UoigMkcG9dhb
         EUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NC0ikTBtU3+s1clUIqx46RqyaSfiqMlNVn/SU2L768I=;
        b=TaUtV4Q+DAEJH8p563hGc19QP8F53A5pi6bxBWIHXJ4B8ndmy/Jb1gJoqp/enXz2No
         c8Qwa8TXfNT695E2t5arAuPLIhNH4CNSAX1pTurNoKfEfCkn3JzZwG3U+dhgA5KbJ60Q
         kJXo+91V7aL5f3farucCCiGlds1xbL5EzNOD33jxen/J53HVmiMQFbPco7cZROQ/jq9t
         j41q8j3iCnaFzT8qnHxzsfhU0WfPRim1DIFZVXqVnwEu9pniV4qC3qAFpSuYSoYPRyOE
         6RM7FYFnMZkMPFzmeS/4iFc/gKDo2r0WI9mTtCfZbjErOrY2ghhD5ptscCKbQwOQ/at0
         XiLw==
X-Gm-Message-State: AOAM533ryUu6ARSD/Eo7XRCRNmkLoFRe3H4gJf20jk7gVdr4Hthbi4rp
        iImUYDHqzclpfbnqPH78ZydG3jgdoomRT9ufWKMcpg==
X-Google-Smtp-Source: ABdhPJxPb3vgMrdumLmM4nTWcZuOGGIcCzHQUCf93m8CUbDY3Qc9BFBA9z/dfVDCO1yRslJyPZsiz+W4iyLhkGS57Tw=
X-Received: by 2002:a63:2bd5:: with SMTP id r204mr34224815pgr.407.1635958195853;
 Wed, 03 Nov 2021 09:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU2Vt2hWW=Yxh5W=bVerJjwbNoJpTDGgXxUUo9PZvzFe9A@mail.gmail.com>
 <VI1PR04MB52942DA2B09A320B8060A3A8908A9@VI1PR04MB5294.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB52942DA2B09A320B8060A3A8908A9@VI1PR04MB5294.eurprd04.prod.outlook.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 3 Nov 2021 09:49:44 -0700
Message-ID: <CAJ+vNU3zKEVz=fHu2hLmEpsQKzinUFW-28Lm=2wSEghjMvQtmw@mail.gmail.com>
Subject: Re: IMX8MM eMMC CQHCI timeout
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Oct 31, 2021 at 6:57 PM Bough Chen <haibo.chen@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Tim Harvey [mailto:tharvey@gateworks.com]
> > Sent: 2021=E5=B9=B410=E6=9C=8830=E6=97=A5 4:47
> > To: Linux MMC List <linux-mmc@vger.kernel.org>; Marcel Ziswiler
> > <marcel@ziswiler.com>; Fabio Estevam <festevam@gmail.com>; Schrempf
> > Frieder <frieder.schrempf@kontron.de>; Adam Ford <aford173@gmail.com>;
> > Bough Chen <haibo.chen@nxp.com>; Lucas Stach <l.stach@pengutronix.de>;
> > Peng Fan <peng.fan@nxp.com>; Frank Li <frank.li@nxp.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>; Shawn Guo
> > <shawnguo@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; Sascha
> > Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>; Cale Collins
> > <ccollins@gateworks.com>
> > Subject: IMX8MM eMMC CQHCI timeout
> >
> > Greetings,
> >
> > I've encountered the following MMC CQHCI timeout message a couple of ti=
mes
> > now on IMX8MM boards with eMMC with a 5.10 based kernel:
> >
> > [  224.356283] mmc2: cqhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D CQHCI =
REGISTER DUMP
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  224.362764] mmc2: cqhci: Caps:      0x0000310a | Version:
> > 0x00000510
> > [  224.369250] mmc2: cqhci: Config:    0x00001001 | Control:  0x0000000=
0
> > [  224.375726] mmc2: cqhci: Int stat:  0x00000000 | Int enab: 0x0000000=
6
> > [  224.382197] mmc2: cqhci: Int sig:   0x00000006 | Int Coal: 0x0000000=
0
> > [  224.388665] mmc2: cqhci: TDL base:  0x8003f000 | TDL up32: 0x0000000=
0
> > [  224.395129] mmc2: cqhci: Doorbell:  0xbf01dfff | TCN:      0x0000000=
0
> > [  224.401598] mmc2: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x0800000=
0
> > [  224.408064] mmc2: cqhci: Task clr:  0x00000000 | SSC1:     0x0001100=
0
> > [  224.414532] mmc2: cqhci: SSC2:      0x00000001 | DCMD rsp:
> > 0x00000800
> > [  224.420997] mmc2: cqhci: RED mask:  0xfdf9a080 | TERRI:
> > 0x00000000
> > [  224.427467] mmc2: cqhci: Resp idx:  0x0000000d | Resp arg: 0x0000000=
0
> > [  224.433934] mmc2: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI =
REGISTER DUMP
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [  224.440404] mmc2: sdhci: Sys addr:=
  0x7c722000 | Version:
> > 0x00000002 [  224.446877] mmc2: sdhci: Blk size:  0x00000200 | Blk cnt:
> > 0x00000020 [  224.453346] mmc2: sdhci: Argument:  0x00018000 | Trn
> > mode: 0x00000023
> > [  224.459811] mmc2: sdhci: Present:   0x01f88008 | Host ctl: 0x0000003=
0
> > [  224.466281] mmc2: sdhci: Power:     0x00000002 | Blk gap:
> > 0x00000080
> > [  224.472752] mmc2: sdhci: Wake-up:   0x00000008 | Clock:
> > 0x0000000f
> > [  224.479225] mmc2: sdhci: Timeout:   0x0000008f | Int stat: 0x0000000=
0
> > [  224.485690] mmc2: sdhci: Int enab:  0x107f4000 | Sig enab: 0x107f400=
0
> > [  224.492161] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x0000050=
2
> > [  224.498628] mmc2: sdhci: Caps:      0x07eb0000 | Caps_1:
> > 0x8000b407
> > [  224.505097] mmc2: sdhci: Cmd:       0x00000d1a | Max curr: 0x00fffff=
f
> > [  224.511575] mmc2: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0xffc003f=
f
> > [  224.518043] mmc2: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d07f0=
1
> > [  224.524512] mmc2: sdhci: Host ctl2: 0x00000088 [  224.528986] mmc2:
> > sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xfe179020 [  224.535451]
> > mmc2: sdhci-esdhc-imx: =3D=3D=3D=3D=3D=3D=3D=3D=3D ESDHC IMX DEBUG STAT=
US DUMP =3D=3D=3D=3D
> > [  224.543052] mmc2: sdhci-esdhc-imx: cmd debug status:  0x2120
> > [  224.548740] mmc2: sdhci-esdhc-imx: data debug status:  0x2200
> > [  224.554510] mmc2: sdhci-esdhc-imx: trans debug status:  0x2300
> > [  224.560368] mmc2: sdhci-esdhc-imx: dma debug status:  0x2400
> > [  224.566054] mmc2: sdhci-esdhc-imx: adma debug status:  0x2510
> > [  224.571826] mmc2: sdhci-esdhc-imx: fifo debug status:  0x2680
> > [  224.577608] mmc2: sdhci-esdhc-imx: async fifo debug status:  0x2750
> > [  224.583900] mmc2: sdhci:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > I don't know how to make the issue occur, both times it occured simply
> reading
> > a file in the rootfs ext4 fs on the emmc.
> >
> > Some research shows:
> > -
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fcom=
mu
> > nity.nxp.com%2Ft5%2Fi-MX-Processors%2FThe-issues-on-quot-mmc0-cqhci-tim
> > eout-for-tag-0-quot%2Fm-p%2F993779&amp;data=3D04%7C01%7Chaibo.chen%4
> > 0nxp.com%7C1dc0981634f5460a779808d99b1d5a88%7C686ea1d3bc2b4c6fa9
> > 2cd99c5c301635%7C0%7C0%7C637711372651089473%7CUnknown%7CTWFp
> > bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> > 6Mn0%3D%7C1000&amp;sdata=3DITcs7%2FMy%2F1Vx1TMB2VlaY4QhibKuSFBD
> > 6UZhzVFl%2FqY%3D&amp;reserved=3D0
> > -
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgit.=
torad
> > ex.com%2Fcgit%2Flinux-toradex.git%2Fcommit%2F%3Fh%3Dtoradex_5.4-2.3.x
> > -imx%26id%3Dfd33531be843566c59a5fc655f204bbd36d7f3c6&amp;data=3D04%
> > 7C01%7Chaibo.chen%40nxp.com%7C1dc0981634f5460a779808d99b1d5a88%
> > 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637711372651089473
> > %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> > BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DxaamzPb2CdW6YDzW
> > g8uBb0PjomkoWAziu5qglvMbT2I%3D&amp;reserved=3D0
> >
> > I'm not clear if this info is up-to-date. The NXP 5.4 kernel did not
> enable this
> > feature but if I'm not mistaken CQHCI support itself didn't land in
> mainline until
> > a later kernel so it would make sense it was not enabled at that time. =
I
> do see
> > the NXP 5.10 kernels have this enabled so I'm curious if it is an issue
> there.
> >
> > Any other IMX8MM or other SoC users know what this could be about or wh=
at
> I
> > could do for a test to try to reproduce it so I can see if it occurs in
> other kernel
> > versions?
>
> Hi Tim,
>
> I'm debugging this issue those days, but unfortunately, still not find th=
e
> root cause.
> The register value of Doorbell, Dev Queue, Dev Pend seems abnormal. This
> issue happens
> on all i.MX SoC which support cmdq feature when cpu loading is high.. Now=
 I
> lack a mmc
> logic analyzer, make it not easy to debug this issue. So stll need some
> time. Sorry about that.
> If you want to make mmc work stable, you can disable the cmdq as a
> workaround.
>
> Best Regards
> Haibo Chen

Haibo,

Thanks for the information. Do you know how to easily reproduce it
reliably for testing?

I have tried the following on an eMMC filesystem:
stress --cpu 32 --io 32 &
dd if=3D/dev/zero of=3Dfoo bs=3D1M count=3D1000 &
dd if=3D/dev/zero of=3Dfoo bs=3D1M count=3D1000 &
rm foo

I'm unable to reproduce the issue that way, and it has only happened
randomly once or twice.

Perhaps we should disable CMDQ for now until you can sort this out? I
can submit a patch for that.

Best regards,

Tim
