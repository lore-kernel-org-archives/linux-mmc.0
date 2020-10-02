Return-Path: <SRS0=YnZp=DJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A15C4363D
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 07:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22552072E
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 07:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWGOV3fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgJBHzH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Oct 2020 03:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBHzH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2020 03:55:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDB6C0613E2
        for <linux-mmc@vger.kernel.org>; Fri,  2 Oct 2020 00:55:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v23so455454ljd.1
        for <linux-mmc@vger.kernel.org>; Fri, 02 Oct 2020 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mdWy51JUAJLNrewH/4Ct0ieYg+BQ1cOIElTbSQvUR0g=;
        b=HWGOV3fzMv5hq0ajSUX6MufczLspk6B0S1qY6UPQRO38qwpPu70HCwWy8/qSz51u/v
         Obcn842ENpChlgM8mUnJS6NOwsCHOIMOCUMJ1ZlydIDEa1C+yQ05kRp8bbQs2dh+QDI7
         /KwwJzlFiUUrQCInSlm7gLhjq2caGg6baDRl9wG5VpYgE/FzDbz60Wx/0mtzkdpH2DIi
         b8Y3b31yM87htO1Fhzm7G9pB/VuJmc0LIvCD4+adCjLKLweAK1to29AxmbZidHitQcP8
         z3Ztj+nM/iD8GFTJjByh2mugOFWW8hmp61JolBFeR8nwqOWJslp4w7BhUf1Qib3TS6is
         z+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mdWy51JUAJLNrewH/4Ct0ieYg+BQ1cOIElTbSQvUR0g=;
        b=iJJfHsIeGYVp1gb24m+FdDvqlCjrGe1p6p1ei+i0v9xzPAo9TO3dVrwqXjoRgcsmtB
         I9r+FUMyvmLZEcIujT3LIcVUDjl1W0PR66Ccv8TWFehbDvaKsGkh6k3XYu/9n+jg1DWi
         dAnbQtvjaFZw0Y6R/PWoVYXbfArpPrMu+FUa9ywIpS7MTm0Dy4P/rPk8oxcuDGjuIQOA
         5yZ8AuKrZ8VSm85xFFy0XKlRO8YNhVUi5FhwV8gLkxEPu1uBd7DRGI6bewwBi+LOGj2/
         x50AfyF4MY771dKLQ0KN+cvDGZ5x+TV4cuhp5A1zK8/ACyAiKgeb5zzNuM5kWgfivGrv
         wQ8w==
X-Gm-Message-State: AOAM532Io186dDxye4XkHS1WPZ5fAgKukbDIln27DMOELEr23KLwhMKW
        axFjIA8Vj7DhdNYITco3dqkOreYugcbJxTnv
X-Google-Smtp-Source: ABdhPJw7zZP5KFEI9ROLR7SsICqR8YmYUY2Q43lah1ObGtbmhfNWChCCfHzfSPs1jB5+OPiOCa/ySA==
X-Received: by 2002:a2e:98cf:: with SMTP id s15mr387045ljj.446.1601625305093;
        Fri, 02 Oct 2020 00:55:05 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-169.NA.cust.bahnhof.se. [155.4.133.169])
        by smtp.gmail.com with ESMTPSA id y80sm147200lff.254.2020.10.02.00.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 00:55:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC/MEMSTICK fixes for v5.9-rc8
Date:   Fri,  2 Oct 2020 09:55:02 +0200
Message-Id: <20201002075502.130199-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with an MMC and a MEMSTICK fix, intended for v5.9-rc7. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 14801c624066a55139c2c57963eb1b859d0a316a:

  mmc: mmc_spi: Fix mmc_spi_dma_alloc() return type for !HAS_DMA (2020-09-14 11:46:16 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4-3

for you to fetch changes up to afd7f30886b0b445a4240a99020458a9772f2b89:

  mmc: sdhci: Workaround broken command queuing on Intel GLK based IRBIS models (2020-09-28 12:16:47 +0200)

----------------------------------------------------------------
MEMSTICK core:
 - Fix deadlock when removing the host

MMC host:
 - sdhci-pci: Workaround broken CMDQ on Intel GLK based IRBIS models

----------------------------------------------------------------
Hans de Goede (1):
      mmc: sdhci: Workaround broken command queuing on Intel GLK based IRBIS models

Kai-Heng Feng (1):
      memstick: Skip allocating card when removing host

 drivers/memstick/core/memstick.c  | 4 ++++
 drivers/mmc/host/sdhci-pci-core.c | 3 ++-
 include/linux/memstick.h          | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)
