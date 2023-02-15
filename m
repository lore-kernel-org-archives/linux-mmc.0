Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57ADC636CC
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Feb 2023 10:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjBOKBT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Feb 2023 05:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbjBOKBL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2023 05:01:11 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139C12C663
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 02:01:05 -0800 (PST)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 961513F5E4
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676455264;
        bh=N6nLfe3Ogw8JebzYy5+qmB5POBTivnyXYU0aBkUXowQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=JIeaudR4mbYN5e4tKLDFictbCRnvVkglBxXXDqci5fp33DonnGKb6QTB0qQFzKfb6
         vez+mG8MVCKwKnL7SLl0usuVkvF/KCuXL+BXiXhiGowKhVLfAuPyCsTj6LiOOyNejs
         u08z4nyfN0sb9slFB9QVMzj+m0AvncBXSgS73wEnXbvQX5f5kKSptcBs/El+rF9M+y
         HYs6coNe4gp2dk+UTvhTXcTbSpamiDJQ4DKX46tvhwI8L71rtZDfd/AOqyEjARLiK+
         yeBWeNr+mC8G4UGiI64o8gusUbDY4+i5u07TYTEh7TdbQHpyfpvJxFzW2fkJ9u66wN
         HUvqrbZbAjBww==
Received: by mail-qk1-f198.google.com with SMTP id x17-20020a05620a449100b00731b7a45b7fso11044542qkp.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 02:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6nLfe3Ogw8JebzYy5+qmB5POBTivnyXYU0aBkUXowQ=;
        b=FHliPpC+T61M8SUEEPkRwcx5OUZfxcuPfqwLAS9/c0xUh4pPpdHF0sr4Tq+qX0I0XM
         v5jaoSdxrhA2FJvT3nP1n2HccVikykqMVPOdDZUFiG5vXs4wMPqXTj8jW/9T4D1GwrIy
         y/jgcF67NazTrdJnP+oQBPwfUe0qPGtuHXwJlQNYx+3PRzfuQU6/QtD9atYXa+8IooXU
         xVyecFggpq/8LrGWjLO4H0/2sZlt9mXk0cq1VuT374zDrn9mBXs3EK1A3bWm2Y50eHSs
         +VD2Ea2XbQJukJ5+SV+GTZSTACeis4s0eubI8HFBHW4EJ9GH/t9WSpAn0iX9tT0yG0VO
         a4rw==
X-Gm-Message-State: AO0yUKXA0wJlQaf+giLa7W+ZbXgla2Dz1wv6H7APXqoIoQz3cSCqrQQ/
        Rw/EM9m1MWJ8d4/C0COaZ1GTj3GQ8ZeQF0Gn0mg9VZnpcBy9tAE0htjtgqMwH1+MMyzy8BfG/Fx
        o/RtRKGPOrXbn+0/BK27FdOjhD5ETE+65K584/2ZHKvMs38ZQspns3Q==
X-Received: by 2002:a37:4249:0:b0:73b:3411:48b1 with SMTP id p70-20020a374249000000b0073b341148b1mr77165qka.219.1676455263485;
        Wed, 15 Feb 2023 02:01:03 -0800 (PST)
X-Google-Smtp-Source: AK7set+9H4L1nqdu+2ESDHje9l8E+qLdMohDtVuTVdGzCspjXkgOLnXU/9AA+6LBSrMd5WIhdVG6YbR1SazSJWLVTSk=
X-Received: by 2002:a37:4249:0:b0:73b:3411:48b1 with SMTP id
 p70-20020a374249000000b0073b341148b1mr77162qka.219.1676455263227; Wed, 15 Feb
 2023 02:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20230203081913.81968-1-william.qiu@starfivetech.com> <CAPDyKFqei-GjKpBUQnDZUbYnSyn-JS5f_EnTLOuA1U4PdYTyVA@mail.gmail.com>
In-Reply-To: <CAPDyKFqei-GjKpBUQnDZUbYnSyn-JS5f_EnTLOuA1U4PdYTyVA@mail.gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 15 Feb 2023 11:00:46 +0100
Message-ID: <CAJM55Z8gpBDu9818GPLRYJ9DBa+NfXW0uo76_bkwWm6RS1S9wg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] StarFive's SDIO/eMMC driver support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 14 Feb 2023 at 13:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 3 Feb 2023 at 09:19, William Qiu <william.qiu@starfivetech.com> wrote:
> >
> > Hi,
> >
> > This patchset adds initial rudimentary support for the StarFive
> > designware mobile storage host controller driver. And this driver will
> > be used in StarFive's VisionFive 2 board. The main purpose of adding
> > this driver is to accommodate the ultra-high speed mode of eMMC.
> >
> > The last patch should be applied after the patchset [1]:
> > [1] https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/
> >
> > Changes since v2:
> > - Wraped commit message according to Linux coding style.
> > - Rephrased the description of the patches.
> > - Changed the description of syscon regsiter.
> > - Dropped redundant properties.
> >
> > The patch series is based on v6.1.
> >
> > William Qiu (3):
> >   dt-bindings: mmc: Add StarFive MMC module
> >   mmc: starfive: Add sdio/emmc driver support
> >   riscv: dts: starfive: Add mmc node
> >
> >  .../bindings/mmc/starfive,jh7110-mmc.yaml     |  77 ++++++++
> >  MAINTAINERS                                   |   6 +
> >  .../jh7110-starfive-visionfive-2.dtsi         |  23 +++
> >  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  37 ++++
> >  drivers/mmc/host/Kconfig                      |  10 +
> >  drivers/mmc/host/Makefile                     |   1 +
> >  drivers/mmc/host/dw_mmc-starfive.c            | 185 ++++++++++++++++++
> >  7 files changed, 339 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> >  create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
> >
>
> Patch 1 and patch 2 applied for next, thanks!
>
> Note that I fixed some checkpatch errors/warnings. Next time, please
> run ./scripts/checkpatch.pl before you submit your patches.

Hi,

Something here is not right. The bindings document "starfive,sysreg",
but the code is looking for "starfive,syscon".
William, did you test this and run dtbs_check before sending this series?

/Emil

> Kind regards
> Uffe
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
