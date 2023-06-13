Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA10C7EE2E
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 12:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbjFMMIp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 08:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjFMMIo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 08:08:44 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A6E55
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 05:08:43 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bcad7f7dabcso1758425276.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 05:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686658123; x=1689250123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=83Vvn1AtpC3kjFmfmJpDNEecuXzjnAlbe9sDtMkiAH8=;
        b=DGjMjE+rei7cVc/hiT+/YGufBbLcvZlWf/ZxDjzAmGr6N1QwQ05Rg0ZA+P/HNM3+5g
         Ol+zpDspPIcBbHfJXL8teQAORkKTI/seF0YMo3LK8M6kW/jk3rNr8PpZHn9YgPkDdB5o
         PiXFuZKyETSZp97dTsiYYLcmiXxOJv5ft/dRW/QlWVdbSIMWlRWr8SbxqAQ6sZkSBjRA
         OtB2suus8yph/lqBkOvXw/oNV26sf9GmY0n6v/0hyIYgc7VaLe5VBKZpb4m5ngNelF0h
         J9qoscIWQCMSvmKptkqzDPaoktHTP8aps7PsFp8taTY74I+ZUOY4fXcE1p81Sgt83n3w
         V4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686658123; x=1689250123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83Vvn1AtpC3kjFmfmJpDNEecuXzjnAlbe9sDtMkiAH8=;
        b=EHANvmiAgnn7DMzLZqsc49b1wXQmhptd8A3IG0GvHEazhw7iesS2Qw8PQcYGblOxOY
         cuvJb6tSJV141InSR1ESVXvXJC0AEoOoyGc20Wq5kTzcJTBT9hPS2rpOeMSWAeex5o6y
         zoAhSoFLm4DmgOxyLGK4+uvtftiSHCviH5i5rz7csobPFBBTxnT/n4hWkWm5cPZTkhYy
         0UXnyjZUDM9tS6SeFiiolL80iG7sC4uQhi+3TzbGciJlpSVE0nqgdn5sbOY60LvD+Szn
         /w4cGoH1HWCqLhiwC7HdF/qosLwGVbhueu0d0ixu1hnl27yK/zEwcvgyo8B9A6k/OK1m
         XEkg==
X-Gm-Message-State: AC+VfDyYmEPSveL1726yTYywUknobhnuGHphSI6Snou3ZuDokYINXChk
        pUdy1nBubooaKPuT4ck3x+UDSn+W0NR8CCENJUZ7Ag==
X-Google-Smtp-Source: ACHHUZ7fMurZ/F0UWw96LY76vsoO/8roFrU/LgtGY1mu/hLsztbYiSnmLFCKIEEnZvzUdG06IZxYxJxvasi7ZOZJ+mg=
X-Received: by 2002:a25:6c54:0:b0:bcd:73a2:d2cc with SMTP id
 h81-20020a256c54000000b00bcd73a2d2ccmr1044643ybc.59.1686658122515; Tue, 13
 Jun 2023 05:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org> <20230405-pl180-busydetect-fix-v3-5-cd3d5925ae64@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v3-5-cd3d5925ae64@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 13 Jun 2023 14:08:06 +0200
Message-ID: <CAPDyKFoWsQrS+8K6HiRGKvDu8kJ=9_5c7TdDy7DUti-HfnpH9w@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] mmc: mmci: Make busy complete state machine explicit
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[...]

> @@ -1259,6 +1276,8 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>
>         host->busy_status = 0;
>         if ((cmd->flags & MMC_RSP_BUSY) && (host->variant->busy_timeout)) {
> +               host->busy_state = MMCI_BUSY_DONE;
> +

Nitpick:

I would move this up a few lines, along when clearing the busy_status.
In other words, let's clear the busy_state no matter if the current
command flag has MMC_RSP_BUSY.

>                 if (!cmd->busy_timeout)
>                         cmd->busy_timeout = 10 * MSEC_PER_SEC;
>

[...]

Kind regards
Uffe
