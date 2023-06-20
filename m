Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE60EB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 19:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjFTT1W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTT1W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 15:27:22 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB9C1704
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 12:27:20 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-570877f7838so43226287b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687289240; x=1689881240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8Gg6Tb/6UJioUHDZTn18LvDCaiO2bRr0FMtQ/jPY/U=;
        b=ZgLbPEj/RIZ3jh0DghONFB0y2S0fQhq92DlZEVzhz9yopU0HoASN4OJUyf2EKzO3de
         CrRxGVwzd/qHCYqVVZVaoSOf+jf9xJuRdrX02R33I3jcteJ+JtrSvCaPnEqswpU2Eiig
         8S2inivNH2O3FTwwWHg+NmBRc562+9gBIgYSgU+NiyV3vIBfOdOBs1HBVGrxcS5ZZvaA
         jJ8MEbEkjyTSG7l1Q97VUCml/BNNoLITBgVzahDleAikMbv/cgvF0AtfRaco8i0GOccx
         ungMXbU0W9egd3X60FDPldDhm8xXbuGz+bPqrMxKAPU31KifKqts/D7+PYi+7uxjjPG4
         a8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687289240; x=1689881240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8Gg6Tb/6UJioUHDZTn18LvDCaiO2bRr0FMtQ/jPY/U=;
        b=JbTeli2QrsBfSr45PWJunazXc555NFFl7/Ai2NicwNIvZIY5tExyeFIC3sQ5GpWZFP
         urbHJqbsoCfCiqNL10UMJolwqNvUz+Qs7DopYizZvWW5qHOouOvXLZHX2pReHDMRceRg
         ZTA/sfUmzqn5u3HZ+RYZSzZ/zG2zB3uBl1s5t9pg8fmOLu/Viikb98oXNhDm1YPdVaPX
         OCXqa50ltjm6jNz6Z25Ik2GKI/TZMrO0zYC/COWWaw+HlGu9SJB++5HVGH87uhT5o18+
         061AHoGZ0cUf7+tTRToosxwSqUy2rmJlDUWTH5B1wGNsnXjXESVovnTogXnK1WuFdBDn
         NZvw==
X-Gm-Message-State: AC+VfDzmpIJORmfJcJvL3Iwky3LskMK2wzXLdMMeL05Go+SZIcyqOwU8
        Ao8PX3ge+qPl3eAgMB8qor+Z3Jg8DABCmfBbipe97Cnxx4tBEJ83TDU=
X-Google-Smtp-Source: ACHHUZ6b2wy/GO7XLt9Y2s1E+Ow4N903Q1/ZMIgdhXljyCq5pX/F4CtHWUHENHsFEDDHlTqUROH3AusfydIgLakRi0k=
X-Received: by 2002:a25:3486:0:b0:bcb:9b43:5a89 with SMTP id
 b128-20020a253486000000b00bcb9b435a89mr9835727yba.61.1687289240057; Tue, 20
 Jun 2023 12:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230620091113.33393-1-ulf.hansson@linaro.org>
In-Reply-To: <20230620091113.33393-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Jun 2023 21:27:08 +0200
Message-ID: <CACRpkdZfhPxFZhjiU9k5fjM9v9VOuZwu16eyn_qHL4Jm+CyhBg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Add support for SW busy-end timeouts
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>,
        Yann Gautier <yann.gautier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jun 20, 2023 at 11:11=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:

> The ux500 variant doesn't have a HW based timeout to use for busy-end IRQ=
s.
> To avoid hanging and waiting for the card to stop signaling busy, let's
> schedule a delayed work, according to the corresponding cmd->busy_timeout
> for the command. If work gets to run, let's kick the IRQ handler to
> completed the currently running request/command.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Some experiments: I added a patch to print the offending command and
dev_err() all the timing bugs. The resulting log:

/home/linus # dmesg |grep '80005000\|mmcblk2'
[    2.684814] mmci-pl18x 80005000.mmc: mmc2: PL180 manf 80 rev4 at
0x80005000 irq 81,0 (pio)
[    2.695831] mmci-pl18x 80005000.mmc: DMA channels RX dma0chan4, TX dma0c=
han5
[    3.410400] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[    3.434936] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[    3.451721] mmci-pl18x 80005000.mmc: lost busy status when waiting
for busy start IRQ (op 06)
[    3.489379] mmcblk2: mmc2:0001 M4G1YC 3.69 GiB
[    3.569000]  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13
p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25
[    3.583526] mmcblk2boot0: mmc2:0001 M4G1YC 2.00 MiB
[    3.594726] mmcblk2boot1: mmc2:0001 M4G1YC 2.00 MiB
[    3.602233] mmcblk2rpmb: mmc2:0001 M4G1YC 128 KiB, chardev (246:0)
[    4.103057] mmci-pl18x 80005000.mmc: lost busy status when waiting
for busy start IRQ (op 06)
[    8.074188] mmci-pl18x 80005000.mmc: lost busy status when waiting
for busy start IRQ (op 06)
[    8.084350] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[    8.451446] mmci-pl18x 80005000.mmc: lost busy status when waiting
for busy start IRQ (op 06)
[    8.757934] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[   10.211883] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[   10.587646] mmci-pl18x 80005000.mmc: lost busy status when waiting
for busy start IRQ (op 06)
[   10.913604] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[   10.924072] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[   10.931671] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[   12.023345] mmci-pl18x 80005000.mmc: lost busy status when waiting
for busy start IRQ (op 06)
[   12.357757] mmci-pl18x 80005000.mmc: lost busy status when waiting
for busy start IRQ (op 06)
[   14.087677] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[   14.096191] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[   15.124114] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[   15.153411] mmci-pl18x 80005000.mmc: lost busy status when waiting
for busy start IRQ (op 06)
[   15.525024] mmci-pl18x 80005000.mmc: lost busy status when waiting
for busy start IRQ (op 06)
[   15.850036] mmci-pl18x 80005000.mmc: timeout waiting for busy IRQ (op 06=
)
[   18.250122] mmci-pl18x 80005000.mmc: lost busy status when waiting
for busy start IRQ (op 06)
[   18.988983] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[   19.302612] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[   19.320953] mmci-pl18x 80005000.mmc: no busy signalling in time (OP 06)
[   19.333251] mmci-pl18x 80005000.mmc: lost busy status when waiting
for busy start IRQ (op 06)
[   21.851715] mmci-pl18x 80005000.mmc: lost busy status when waiting
for busy start IRQ (op 06)

Always command 0x06, MMC_SWITCH. But this is also the *only*
command that resturns MMC_RSP_BUSY so it doesn't say very
much about the card in general.

We have speculated that the card is maybe operating out of spec, such as
holding DAT0 high for too short time (not across enough MCLK cycles)
or similar when indicating busy for short timespans.

I tested on the other problematic phone, Kyle, and the log is identical
(it has the same eMMC card, M4G1YC.)

Yours,
Linus Walleij
