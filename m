Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887BCC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Mar 2022 15:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347903AbiCKPKx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Mar 2022 10:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344507AbiCKPKw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2022 10:10:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7031B60A4
        for <linux-mmc@vger.kernel.org>; Fri, 11 Mar 2022 07:09:49 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bt26so15561510lfb.3
        for <linux-mmc@vger.kernel.org>; Fri, 11 Mar 2022 07:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqY71AUzATHTLGKyAzwvSw6q4/NroX39pMmuicUc9QM=;
        b=lNYnqjfB2ONnlK2OT+blK4EuYRqEDUuqvPBFjmbTehTX9zN0zNGdAMbmGFjuz2ju3d
         pYM0kM2QuWs1T361dlk5ChZN+7gljju/RfsrwfymsUScdXysvOFcF5KIEJFOe6MjfSUS
         lwxonnSHL7D/TeeRoMSDmUnTPw4LtToaAgb7aRtkJ5j82jznc1nlFK1Q5mdEbRLJ+A9J
         paMeQNbenMSVJSYv/KQrBP67rWb/B2jpUpwo0hx/13ob9tveOqe7PMDzpcswEh0LIVOA
         WC7ou0vQqRGSupaTU76Zj4l+zhWHobs5QiDR0XEgkT3fq4G6pwOj07nu5K5wQB0mlTxq
         5hiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqY71AUzATHTLGKyAzwvSw6q4/NroX39pMmuicUc9QM=;
        b=XDchStCsCScpoP9FufvQUQbbuka6UYQxIkw/1Nx+jTlRQzuoWo1QnFxbicBkX0Ng5+
         fdzEyd/zWXEJp0Wpk4OmhIKKjsEufd8BDRXEvxSkTVazYCjCsMsHs3xfiTJ8UUGf4UOH
         2pKrI7vj9fyKpaXR2lTiSPqI8qQ2+1oezAZgph6jxJGGdnypyz0ui2MBD16MnSgp2E0H
         wEcNmVWrIAGpWQN6RX6J6+dXXHh1LXsDPIMv4pLxTQsKLkK7zxeexWMgHM5Zzq6YkN+Y
         fonQpPJJkTGHyThGPhF4R/ugt6gWvui8A8IHikdFdaR1JuIGaVnbSr9NEDNN/6zHuSJ0
         VMpg==
X-Gm-Message-State: AOAM532qESLflehN4q8Flc/wb+dmeCyu9uSaE2jSEEYIsT+CBs0ZXtTn
        3w+V6sIthuUOYrzbk7z8c0W27A==
X-Google-Smtp-Source: ABdhPJyP7Hm372/ApUE3c0lGEDB1sgUok3CVvp4PMBVGtAi8hCEmi+cS9QBaZtP14ItjK+kQCbA3gw==
X-Received: by 2002:ac2:4145:0:b0:448:273a:7697 with SMTP id c5-20020ac24145000000b00448273a7697mr6370536lfi.601.1647011386742;
        Fri, 11 Mar 2022 07:09:46 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-34.NA.cust.bahnhof.se. [155.4.129.34])
        by smtp.gmail.com with ESMTPSA id 16-20020ac25f10000000b00443890bd84asm1663988lfq.114.2022.03.11.07.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:09:45 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.17-rc8
Date:   Fri, 11 Mar 2022 16:09:45 +0100
Message-Id: <20220311150945.84262-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.17-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc6

for you to fetch changes up to 1760fdb6fe9f796fbdb9b4106b3e0bbacc16b55c:

  mmc: core: Restore (almost) the busy polling for MMC_SEND_OP_COND (2022-03-07 11:47:39 +0100)

----------------------------------------------------------------
MMC core:
 - Restore (almost) the busy polling for MMC_SEND_OP_COND

MMC host:
 - meson-gx: Fix DMA usage of meson_mmc_post_req()

----------------------------------------------------------------
Rong Chen (1):
      mmc: meson: Fix usage of meson_mmc_post_req()

Ulf Hansson (1):
      mmc: core: Restore (almost) the busy polling for MMC_SEND_OP_COND

 drivers/mmc/core/block.c        |  2 +-
 drivers/mmc/core/mmc.c          |  2 +-
 drivers/mmc/core/mmc_ops.c      | 13 +++++++++----
 drivers/mmc/core/mmc_ops.h      |  3 ++-
 drivers/mmc/core/sd.c           |  2 +-
 drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
 6 files changed, 22 insertions(+), 15 deletions(-)
