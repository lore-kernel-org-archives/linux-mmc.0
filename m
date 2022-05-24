Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6806C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 24 May 2022 13:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbiEXNbO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 May 2022 09:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiEXNbN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2022 09:31:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB21811C01
        for <linux-mmc@vger.kernel.org>; Tue, 24 May 2022 06:31:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y13so34633022eje.2
        for <linux-mmc@vger.kernel.org>; Tue, 24 May 2022 06:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tYDmk3KZNEY/0gFjpTHY1c7fZ6etOddh0hVUgJ4TD5k=;
        b=Z8nRWj5xI7MCTGKgUz/r1VCZ/xioVQSzR9Te9VvTGqBiehaYTwDLGCk2jDYDoFvigH
         Af1XoxcTrTRSORZU1qiXyoPNoefjdTba7QGQIkh4pKR5xoCM7bTZIta6UdcNYNzQ2J3A
         pYi+AElEjsL0+z+68zARYHo9jRDcAcDKx7osogDL+bb2p3oDmXvpc7fMXtf0kOEJB7e9
         LKyS6jdvLMJtPdaeOf1NYbQLsl5D+nQEMMmiG6XvWOgKdXObk4oAQLVxrRfBWlKQWC62
         HvfQUtnkOFvCHxj1HA6RSlPOXSQhL46/WwhHS0AfVHnAjMiTJq3wTxLkY8rjzsLtfhjj
         KIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tYDmk3KZNEY/0gFjpTHY1c7fZ6etOddh0hVUgJ4TD5k=;
        b=nK+3W9lEoaFU1LOArlT4s+I0pPWgLvB0up7UdqikE/FBJH6msJXO2zYgN53OaepDgV
         /tBOhwF3t9D8SX/Ed4U/Jg4DuKYnpWw4jRacOTtXuLDdR8arIS8l+L8ORLLeajJlEjd8
         KR95Rc9OeVhpkLRQdjVByTPJq/L6dUl7fuYhLyZXm6i0sADkUNXuhxOIqvAH9y/Rim2M
         1y/JrFmlfnYYKQZlGR5XYuqC5PjgWwXYqckWuzjYlX8JYwy83rYPfsS+x+a5HFHz2O9B
         6QxPfgdwZ2y0uiWUqSU4GtdKbcXTc9qxcLTT9BUmp08TBXQf/rgxl0GOmLyjBMGLCKn0
         WSNQ==
X-Gm-Message-State: AOAM532KPjMtGaMKKeoEzJNo49xnyWYXJE5Y+F9brqrhHz6QfkCN+6Xd
        LaKxtmLA95Qajqyux5ucVoxBuEEePn4P5wpxlec=
X-Google-Smtp-Source: ABdhPJybn9nruorivDYyAL0d/OHh8qq8yGaf9NOL5kTa54s1s68WL7eMtnxNDnOf1KeKAzN280KRSO+n8xGN28cr2FA=
X-Received: by 2002:a17:907:728b:b0:6f9:a9bf:a8e7 with SMTP id
 dt11-20020a170907728b00b006f9a9bfa8e7mr25027440ejc.696.1653399070301; Tue, 24
 May 2022 06:31:10 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 24 May 2022 10:31:01 -0300
Message-ID: <CAOMZO5DCbC6MK=O1t20nLNKf2Oipf-Ar1TkHU+o9Bvpr0JRtxQ@mail.gmail.com>
Subject: imx7d: Timeout waiting for hardware interrupt.
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On an imx7d board running 5.10.y the following mmc2 timeout is observed:

mmc2: Timeout waiting for hardware interrupt.
mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc2: sdhci: Sys addr:  0x82f9425c | Version:  0x00000002
mmc2: sdhci: Blk size:  0x0000002c | Blk cnt:  0x00000001
mmc2: sdhci: Argument:  0x1410002c | Trn mode: 0x00000013
mmc2: sdhci: Present:   0x01d88a0a | Host ctl: 0x00000013
mmc2: sdhci: Power:     0x00000002 | Blk gap:  0x00000080
mmc2: sdhci: Wake-up:   0x00000008 | Clock:    0x0000003f
mmc2: sdhci: Timeout:   0x0000008f | Int stat: 0x00000000
mmc2: sdhci: Int enab:  0x107f100b | Sig enab: 0x107f100b
mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000302
mmc2: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000b400
mmc2: sdhci: Cmd:       0x0000353a | Max curr: 0x00ffffff
mmc2: sdhci: Resp[0]:   0x00001000 | Resp[1]:  0x00000000
mmc2: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
mmc2: sdhci: Host ctl2: 0x00000000
mmc2: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0x9c042200
mmc2: sdhci-esdhc-imx: ========= ESDHC IMX DEBUG STATUS DUMP =========
mmc2: sdhci-esdhc-imx: cmd debug status:  0x2100
mmc2: sdhci-esdhc-imx: data debug status:  0x2200
mmc2: sdhci-esdhc-imx: trans debug status:  0x2300
mmc2: sdhci-esdhc-imx: dma debug status:  0x2402
mmc2: sdhci-esdhc-imx: adma debug status:  0x25b4
mmc2: sdhci-esdhc-imx: fifo debug status:  0x2610
mmc2: sdhci-esdhc-imx: async fifo debug status:  0x2751
mmc2: sdhci: ============================================

The mmc2 interface is connected to an SDIO Wifi chip.

This irq timeout occurs very rarely.

Any suggestions on how to debug this?

Thanks,

Fabio Estevam
