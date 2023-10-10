Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B22CD8CB4
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Oct 2023 19:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjJJTgO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Oct 2023 15:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjJJTgM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Oct 2023 15:36:12 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033DFAF;
        Tue, 10 Oct 2023 12:36:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c008042211so74146651fa.2;
        Tue, 10 Oct 2023 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696966568; x=1697571368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EnCyCL9CqSgjOWusL/DcIe34tmAuDeD2eNNCQWG/+So=;
        b=lg/9Mhl57JyJXxLTkAks6IVUyv3WYJQbeVVmejFsdRRjTfLPox/mdoq6dgM0xy3R0h
         1/7kS34bfTTqdW26sBrbDaoiOaG/FDdLbdrgAWL+VGJ+UipDegRwAvr2S/+09Lh7Zgm3
         U+EQGUa6uevRgQsPd5PsRKOJl5DRQG85SaRxCvYGB8ATxRR6uD2DSdBwvUdZaKKYAdq9
         u0GWBXACdc5ugWo4Bus/OAE/lfwkLqnZ55LJSNLN9y9ocnMpFIjkIqx731DvpKtsl40W
         iERPb/c2rjy9YBN3FEL1gnL+IRdIjXLVxWQkZi+M99/HH/fhwI+ZzF21MLUoAVEIGBzM
         uwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696966568; x=1697571368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnCyCL9CqSgjOWusL/DcIe34tmAuDeD2eNNCQWG/+So=;
        b=Urn/i3HVqciQ2ao897J8eVJCXBo2UeOgrW1ZTl+9w3MCBJ+x5dvTyZRRQnbPIdSSZh
         rA1wDbKtX6e0wP48Rhb2ezJgQmxTj1tumFRcZT9u8zI2x0pJ+drWDBTSqJf5IveR+RyE
         pNFHW9wIa4W6WpLCEb7AfFPxUyi9vn4sqyTIOBiJOWR95jHykQWCiAzZtvacHlYbJOlM
         3VDx+TElsfdjK/7LG0wDw6IDsPb3JcZHDDzfwV0Nv0Kz+Pq+GQ2azxjpNT/zp+ku7nN7
         vRhiPYh3TSIx6mU0EX0p6yUSuVRTf50n9zRvkMhi6mqYPVkxw7beqtQE69F3haXb98Rs
         pC4g==
X-Gm-Message-State: AOJu0Ywh0DU+zE3PIcEtfLg0WcI2CR14M51eGsd7Y9LodYB+kScKKdQe
        VUfQ70wFJ2yA+GebKeL0q7FRsfoCiW40IwVjaQk=
X-Google-Smtp-Source: AGHT+IFh0GPOwwi4vGUKtm0FShcUPBvpdzJkQpyfIUh9wMFu4ei5Fw3aFTsOCszk/QW3i1AUiC1n+Anw6KOmvvZ82v4=
X-Received: by 2002:a05:651c:141:b0:2c0:2583:520e with SMTP id
 c1-20020a05651c014100b002c02583520emr14990485ljd.41.1696966567771; Tue, 10
 Oct 2023 12:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231002200610.129799-1-tmaimon77@gmail.com> <CAPDyKForPWPHoAuRuyXBHRpNVA9MvYa-eTXDrHx8Z94nSWpXBg@mail.gmail.com>
In-Reply-To: <CAPDyKForPWPHoAuRuyXBHRpNVA9MvYa-eTXDrHx8Z94nSWpXBg@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 10 Oct 2023 22:35:56 +0300
Message-ID: <CAP6Zq1hZF=v6T+Bn8AuZNUKCaTChpyLZKLvPcSo-SbfNS1-V+g@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] add NPCM SDHCI driver support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        adrian.hunter@intel.com, skhan@linuxfoundation.org,
        davidgow@google.com, pbrobinson@gmail.com, gsomlo@gmail.com,
        briannorris@chromium.org, arnd@arndb.de, krakoczy@antmicro.com,
        andy.shevchenko@gmail.com, openbmc@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Thank a lot Ulf

Appreciate it!

On Tue, 10 Oct 2023 at 17:28, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 2 Oct 2023 at 22:06, Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> > This patch set adds SDHCI support for the Nuvoton NPCM Baseboard
> > Management Controller (BMC).
> >
> > Deeply sorry it took that long until sending version three, promise to try
> > to do better on the next versions (if needed) :-),
> >
> > The NPCM SDHCI driver tested on NPCM750 and NPCM845 EVB.
> >
> > Addressed comments from:
> >  - Andy Shevchenko : https://www.spinics.net/lists/devicetree/msg638000.html
> >
> > Changes since version 4:
> >  - Remove unnecessary clk_disable_unprepare function.
> >
> > Changes since version 3:
> >  - Use devm_clk_get_optional_enabled function.
> >  - Add mod_devicetable.h.
> >  - Modify copyright year.
> >
> > Changes since version 2:
> >  - Add data to handle architecture-specific SDHCI parameters.
> >  - Change config place in make and kconfig files.
> >  - Calling sdhci_pltfm_free to to avoid a memory leak on error.
> >
> > Changes since version 1:
> >  - Use correct spaces in the dt-bindings.
> >  - Drop unused labels from dt-bindings.
> >  - Order by module name in the make a configuration.
> >  - Remove unnecessary blank lines.
> >  - Using devm_clk_get_optional instead of devm_clk_get.
> >
> > Tomer Maimon (2):
> >   dt-bindings: mmc: npcm,sdhci: Document NPCM SDHCI controller
> >   mmc: sdhci-npcm: Add NPCM SDHCI driver
> >
> >  .../devicetree/bindings/mmc/npcm,sdhci.yaml   | 45 +++++++++
> >  drivers/mmc/host/Kconfig                      |  8 ++
> >  drivers/mmc/host/Makefile                     |  1 +
> >  drivers/mmc/host/sdhci-npcm.c                 | 94 +++++++++++++++++++
> >  4 files changed, 148 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
> >  create mode 100644 drivers/mmc/host/sdhci-npcm.c
> >
>
> Applied for next (and by amending patch2 to remove some commas), thanks!
>
> Kind regards
> Uffe
