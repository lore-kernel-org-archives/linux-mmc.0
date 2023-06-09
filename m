Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC26C7EE43
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Jun 2023 11:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbjFIL0X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Jun 2023 07:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjFIL0M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2023 07:26:12 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED6430CB
        for <linux-mmc@vger.kernel.org>; Fri,  9 Jun 2023 04:26:11 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-ba81ded8d3eso1659109276.3
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2023 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686309970; x=1688901970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gMW1YaKatM97etS/62dnKFcc8It58SI65TwJ47R3Y4o=;
        b=BO0w/ofKCQMHsNTepcQnUX69bnO6fBXlCxNv1fQpNcQNuo7w7zpPUkiBZIspnZ3WY6
         SgolR/q65spqEKZuxL30ZYJxBT5pFHzO+Jdlse4utU06WPqgNpsJ6FPdaHzt2zTuBDDV
         EKSocS68wpfxjRqICYV35Mqy9cbpY8VZ2oRtz5OBQZ1tEUD3+UoTmWLQna5jGSgWoIw/
         6HcmobL+kHWCEKCPFoTQ2Ee0tSc0ZICDRuKv6QEkYPAbbVcWpin8PcDiRnYd8rextou2
         JoafI3NIbm2NOaVsmGpYOSxocgKCCLu9C1YGlPswru7/PPdFeOqJ2Z3reJguWxZMsjuD
         Uzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686309970; x=1688901970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMW1YaKatM97etS/62dnKFcc8It58SI65TwJ47R3Y4o=;
        b=N+tt1ossBkgEBN5M/K7qTjGn2yNhiBBMj3LppUO+y1G1gIf46Ec9K0D1CgHa26zkyk
         L3N2xMfIrctFMb2t++9GApDTZFpSL6W41gQYg2OFXInGk4KtgFCg0Gx36F4YVAKVVMJ7
         n9rjzKp+kNY3aw4Wai8Jb1VXEeA8UcD96DkUk/WbCoMMSI+LvBvC9sssVAh73gmFcNE7
         J8cmcUGM4ndnAMQ5LDJVKiLdk95K7VvVnwgIzuoGUj55rDyqBYHiUxaMOh4nWIEKKmRJ
         CsXpR1o11t6cIn0hjw1SwOGZCCWB2rnCpAHdYsue98Tek/OJLizjzsPB+sLCFaETwxn3
         WobQ==
X-Gm-Message-State: AC+VfDyuJmG8Mv0ZhQwmHX7dV3wYpv9plH8GSVnsXJj9mn6zyQSE92s/
        QsdZUCvjTatCe7miHAvl8TtXQW3/nthotC/3YHhMAw==
X-Google-Smtp-Source: ACHHUZ51iWeIcI4UtOC/BFc9wvIIBQstrVDQzsYAqpQDk7l/XUvwqCw2/bTGyHLqwvPF7feAcCjDc2JQ7nKG5uWE++0=
X-Received: by 2002:a25:ac19:0:b0:ba8:620b:38a7 with SMTP id
 w25-20020a25ac19000000b00ba8620b38a7mr711573ybi.53.1686309970382; Fri, 09 Jun
 2023 04:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230609071441.451464-1-victorshihgli@gmail.com>
In-Reply-To: <20230609071441.451464-1-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jun 2023 13:25:34 +0200
Message-ID: <CAPDyKFqQBXeAGS=RmV6HgNetCeJLw0hjFarr28p2m-3MU6N+JQ@mail.gmail.com>
Subject: Re: [PATCH V6 0/4] Add Genesys Logic GL9767 support
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Jun 2023 at 09:14, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> These patches support for the GL9767 chipset and add support SD3/SD Express
> mode for the GL9767.
>
> Changes in v6 (June. 9, 2023)
> * rebased to the linux-kernel-v6.4.0-rc5 in Ulf Hansson next branch.
> * Patch#2: use usleep_range() to instead msleep() in
>            gl9767_set_pll() function.
> * Patch#4: use usleep_range() to instead msleep() in
>            gl9767_init_sd_express() function.
>
> ----------------- original cover letter from v5 -----------------
> These patches support for the GL9767 chipset and add support SD3/SD Express
> mode for the GL9767.
>
> Changes in v5 (June. 1, 2023)
> * rebased to the linux-kernel-v6.4.0-rc1 in Ulf Hansson next branch.
> * Patch#3: adjust the alignment of definitions.
>
> ----------------- original cover letter from v4 -----------------
> These patches support for the GL9767 chipset and add support SD3/SD Express
> mode for the GL9767.
>
> Changes in v4 (May. 31, 2023)
> * rebased to the linux-kernel-v6.4.0-rc1 in Ulf Hansson next branch.
> * add VDD2 definition for power control-register.
> * Patch#4: use SDHCI_VDD2_POWER_ON to instead SDHCI_POWER_ON in
>            gl9767_init_sd_express() function.
>            use SDHCI_VDD2_POWER_180 to instead SDHCI_POWER_180 in
>            gl9767_init_sd_express() function.
>
> ----------------- original cover letter from v3 -----------------
> These patches support for the GL9767 chipset and add support SD3/SD Express
> mode for the GL9767.
>
> Changes in v3 (May. 31, 2023)
> * rebased to the linux-kernel-v6.4.0-rc1 in Ulf Hansson next branch.
> * Patch#2: use msleep() to instead mdelay().
> * Patch#3: modify the if-else condition and content in
>            gl9767_init_sd_express() function.
>            adjust the order of definitions.
>
> ----------------- original cover letter from v2 -----------------
> These patches support for the GL9767 chipset and add support SD3/SD Express
> mode for the GL9767.
>
> Changes in v2 (May. 30, 2023)
> * rebased to the linux-kernel-v6.4.0-rc1 in Ulf Hansson next branch.
> * Add set SDR104's clock to 205MHz and enable SSC for GL9767.
> * drop export sdhci_check_ro() function.
> * Patch#1: add gl9767_vhs_read() and gl9767_vhs_write().
> * Patch#3: use mmc->ops->get_ro() to instead sdhci_check_ro().
>            use msleep() to instead mdelay().
>            modify the wait time for Power valid to CLKREQ.
>            drop unused definitions.
>
> ----------------- original cover letter from v1 -----------------
> These patches support for the GL9767 chipset and add support SD3/SD Express
> mode for the GL9767.
>
> Changes in v1 (May. 12, 2023)
> * rebased to the linux-kernel-v6.4.0-rc1 in Ulf Hansson next branch.
> * enable MSI interrupt for the GL9767.
> * add support SDR mode for the GL9767.
> * export sdhci_check_ro() function.
> * add support SD Express mode for the GL9767.
>
> Victor Shih (4):
>   mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support
>   mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for
>     GL9767
>   mmc: sdhci: Add VDD2 definition for power control register
>   mmc: sdhci-pci-gli: Add support SD Express card for GL9767
>
>  drivers/mmc/host/sdhci-pci-core.c |   1 +
>  drivers/mmc/host/sdhci-pci-gli.c  | 406 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h      |   2 +
>  drivers/mmc/host/sdhci.h          |   7 +
>  4 files changed, 416 insertions(+)
>

Applied for next, thanks!

Kind regards
Uffe
