Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2326C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 20:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4543600D4
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 20:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhJ2UuP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhJ2UuL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2021 16:50:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4B4C061767
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2021 13:47:42 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id m26so10293735pff.3
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2021 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=q6q7dhl63K0a4V6lewAQaxJp4RGvHA9klh2DreQqjXE=;
        b=Mj591mzc0wcoRmJBkK3AHtHEhUgfomweYYpsRd6FRXw3g5o8k2LwmSBjuTTvUsY7wc
         cJZRFP4wxvayjmnmYtE+eB9OLAxe4K5RZvlLRcB/v0RJUFPFA1rbVGE35uEUfocjRBYK
         1Up10ZBunn2UXZFQQUzGkYZ4B6mayWg5sMMq85w4TWio19YGriVG5HOlQrWEXHLkc2VK
         Tl7WBdI2xsBd0+dTStGxyRL4E5i76mitnaDZBA5TwxQUUBTYrKLSVjfxLD58RVgLEZyT
         u6hrVjuXd2IGudPZ8XPtwMkBUnTJii+duzzjC6gb7sAxIezze770w26RcbltzlG2zPH3
         ADtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=q6q7dhl63K0a4V6lewAQaxJp4RGvHA9klh2DreQqjXE=;
        b=T+QHjDKy9UPjIEiObaBdqi/JvAV3HAzh37d5D08Eo02rTtIdm26L8oTyLlin5lNhQa
         PQw5uN44Rg8pR2N1EeFLCpTNF3ruK44f5dBBd+qS1gM5EqKeBKt268/kzOH+3z0nTih5
         +fJFTmz3Qcr0ya1pEYCsCZ2Nak5nZmhXdc6oMDpv6en6W6hHtwbVNuLUPY+oA/oKfx5N
         o6rQ2WlfUCbk5AaDQSFISf9dNcZBnFhGgE9xGKmbiyUQC4phD4zK1LUFEXMwifW39HxW
         7AA9CVeHXsP9rXxDNx3EsiasYCTrWuwmuE6LsOrLdpKcjYAwvWOvbBfuwFJ5gurGSjfc
         FBHA==
X-Gm-Message-State: AOAM5327TjAfM8dFSFpazalVpcZQY8RgK1YQlHmWxJMvwAMRNMdnvFo+
        Z9qbQZmJKWC+J/Vp+Bi/EpsqMLhMGvRxpOe5CDDkn9WAtoajcmjL
X-Google-Smtp-Source: ABdhPJw+U9FRiC/wIUE2OexNPkKJ7zAvW3OfkX9BZqxejhcm7/AXeJJpW3pTuMADiK8n/xbJPKFIjeHhjWnSiQU1Xms=
X-Received: by 2002:aa7:96f8:0:b0:47b:eb13:e0b6 with SMTP id
 i24-20020aa796f8000000b0047beb13e0b6mr13304394pfq.27.1635540460700; Fri, 29
 Oct 2021 13:47:40 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 29 Oct 2021 13:47:29 -0700
Message-ID: <CAJ+vNU2Vt2hWW=Yxh5W=bVerJjwbNoJpTDGgXxUUo9PZvzFe9A@mail.gmail.com>
Subject: IMX8MM eMMC CQHCI timeout
To:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Fabio Estevam <festevam@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Adam Ford <aford173@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Cale Collins <ccollins@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Greetings,

I've encountered the following MMC CQHCI timeout message a couple of
times now on IMX8MM boards with eMMC with a 5.10 based kernel:

[  224.356283] mmc2: cqhci: ============ CQHCI REGISTER DUMP ===========
[  224.362764] mmc2: cqhci: Caps:      0x0000310a | Version:  0x00000510
[  224.369250] mmc2: cqhci: Config:    0x00001001 | Control:  0x00000000
[  224.375726] mmc2: cqhci: Int stat:  0x00000000 | Int enab: 0x00000006
[  224.382197] mmc2: cqhci: Int sig:   0x00000006 | Int Coal: 0x00000000
[  224.388665] mmc2: cqhci: TDL base:  0x8003f000 | TDL up32: 0x00000000
[  224.395129] mmc2: cqhci: Doorbell:  0xbf01dfff | TCN:      0x00000000
[  224.401598] mmc2: cqhci: Dev queue: 0x00000000 | Dev Pend: 0x08000000
[  224.408064] mmc2: cqhci: Task clr:  0x00000000 | SSC1:     0x00011000
[  224.414532] mmc2: cqhci: SSC2:      0x00000001 | DCMD rsp: 0x00000800
[  224.420997] mmc2: cqhci: RED mask:  0xfdf9a080 | TERRI:    0x00000000
[  224.427467] mmc2: cqhci: Resp idx:  0x0000000d | Resp arg: 0x00000000
[  224.433934] mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
[  224.440404] mmc2: sdhci: Sys addr:  0x7c722000 | Version:  0x00000002
[  224.446877] mmc2: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000020
[  224.453346] mmc2: sdhci: Argument:  0x00018000 | Trn mode: 0x00000023
[  224.459811] mmc2: sdhci: Present:   0x01f88008 | Host ctl: 0x00000030
[  224.466281] mmc2: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
[  224.472752] mmc2: sdhci: Wake-up:   0x00000008 | Clock:    0x0000000f
[  224.479225] mmc2: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
[  224.485690] mmc2: sdhci: Int enab:  0x107f4000 | Sig enab: 0x107f4000
[  224.492161] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000502
[  224.498628] mmc2: sdhci: Caps:      0x07eb0000 | Caps_1:   0x8000b407
[  224.505097] mmc2: sdhci: Cmd:       0x00000d1a | Max curr: 0x00ffffff
[  224.511575] mmc2: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0xffc003ff
[  224.518043] mmc2: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d07f01
[  224.524512] mmc2: sdhci: Host ctl2: 0x00000088
[  224.528986] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xfe179020
[  224.535451] mmc2: sdhci-esdhc-imx: ========= ESDHC IMX DEBUG STATUS DUMP ====
[  224.543052] mmc2: sdhci-esdhc-imx: cmd debug status:  0x2120
[  224.548740] mmc2: sdhci-esdhc-imx: data debug status:  0x2200
[  224.554510] mmc2: sdhci-esdhc-imx: trans debug status:  0x2300
[  224.560368] mmc2: sdhci-esdhc-imx: dma debug status:  0x2400
[  224.566054] mmc2: sdhci-esdhc-imx: adma debug status:  0x2510
[  224.571826] mmc2: sdhci-esdhc-imx: fifo debug status:  0x2680
[  224.577608] mmc2: sdhci-esdhc-imx: async fifo debug status:  0x2750
[  224.583900] mmc2: sdhci: ============================================

I don't know how to make the issue occur, both times it occured simply
reading a file in the rootfs ext4 fs on the emmc.

Some research shows:
- https://community.nxp.com/t5/i-MX-Processors/The-issues-on-quot-mmc0-cqhci-timeout-for-tag-0-quot/m-p/993779
- http://git.toradex.com/cgit/linux-toradex.git/commit/?h=toradex_5.4-2.3.x-imx&id=fd33531be843566c59a5fc655f204bbd36d7f3c6

I'm not clear if this info is up-to-date. The NXP 5.4 kernel did not
enable this feature but if I'm not mistaken CQHCI support itself
didn't land in mainline until a later kernel so it would make sense it
was not enabled at that time. I do see the NXP 5.10 kernels have this
enabled so I'm curious if it is an issue there.

Any other IMX8MM or other SoC users know what this could be about or
what I could do for a test to try to reproduce it so I can see if it
occurs in other kernel versions?

Best regards,

Tim
