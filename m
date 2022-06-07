Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F5AC433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jun 2022 09:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbiFGJrw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jun 2022 05:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbiFGJru (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 05:47:50 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC34D02BD
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jun 2022 02:47:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q1so18562003ljb.5
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2022 02:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+fd1kmExEMyURkP01m+1X8U5VoGZ0zrhlDfla9ENQI=;
        b=WFU4KgU0IaHuI1H2ExwN/3ZUE2b1P1cHhhD9C4f7oJgAw5H/nCvhwGNYtIennhcMNM
         46wzmHwWMe810s15B5HvrbGapDqCKNroPwYNtHh1Qn3MJ+WPCvf96MiFJzWG4H5OVLFL
         LgQbdGghStCqcMaBMajXx/ZOWkn0SWOq22S2CK712K0FK+1wJ639tL9avjzwftVzRjwz
         sQ9sKm+yqeAYUBD7KIZWK6Hhru0Td2ig7ZB/qXTQnBtUHYDTVKgxfib4Ej/fKQ9m8WBU
         ySDB9ub005QG9mcm/vyd9FhCCT4E7ntSfdNeuJMdKpojPJ42ieYVu2bc5sBmWffzEkrN
         3/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+fd1kmExEMyURkP01m+1X8U5VoGZ0zrhlDfla9ENQI=;
        b=eErCIv4PGiFRpTHGfoF8iztprrMyDrFNrcNmOqbwZQ4NWumUzxAzZ7pjWnsSLphlGG
         ER6bEEHgu3xmnsg1Bzn6DYn2K87Yf49sAo+qPcs1sehDUOLulcTD10J1G+QUL/XE3w+K
         qwYT0utPzaQGGloml2dbPQj3SyDOiNlqvLptnbyFGjPgRyqknLrG4vD6kyhW5nv3DLUF
         DckeMntnKB6aTvvTHp271QQRbrgLoH7pJAistNn0OY/5ks5dVybwDEkUNbS0dRkE67Mo
         OKgWJDShCxmR7u/BTbKkdhK7nWgksqH0TnhpNllL9e9k1XvAnQlHTmgYyt4FC8lsCfw0
         dYxA==
X-Gm-Message-State: AOAM5320fBqbC9b8DdmTYovWXyL9VdHNawpV7qeUnpco7IKW7YO1iwe9
        uh5aGfymenXOtMx/aWPobXZ3ww==
X-Google-Smtp-Source: ABdhPJwhV6RSaO44Tio23XR609SD3x+ZxluOofJ+L5VyvWEJl2XUA1eVRv8r04171oiALcXMa3o/xw==
X-Received: by 2002:a05:651c:141:b0:255:93fd:f499 with SMTP id c1-20020a05651c014100b0025593fdf499mr6385940ljd.29.1654595265144;
        Tue, 07 Jun 2022 02:47:45 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-137.NA.cust.bahnhof.se. [155.4.133.137])
        by smtp.gmail.com with ESMTPSA id x6-20020ac24886000000b00477b11144e9sm3216359lfc.66.2022.06.07.02.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:47:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.19-rc2
Date:   Tue,  7 Jun 2022 11:47:43 +0200
Message-Id: <20220607094743.204021-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.19-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit b00ed48bb0a7c295facf9036135a573a5cdbe7de:

  Merge tag 'dmaengine-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine (2022-05-29 11:38:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19-2

for you to fetch changes up to 479260419fa4cb30e3e5d935a857fbdf0ffdd854:

  dt-bindings: mmc: Fix unevaluatedProperties warnings in examples (2022-06-01 16:17:30 +0200)

----------------------------------------------------------------
MMC core:
 - Fix CQE recovery reset success for block I/O

MMC host:
 - sdhci-pci-gli: Fix support for runtime resume
 - Fix unevaluatedProperties warnings in DT examples

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: block: Fix CQE recovery reset success

Ben Chuang (1):
      mmc: sdhci-pci-gli: Fix GL9763E runtime PM when the system resumes from suspend

Rob Herring (1):
      dt-bindings: mmc: Fix unevaluatedProperties warnings in examples

 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml  | 2 --
 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 3 +++
 drivers/mmc/core/block.c                                       | 3 +--
 drivers/mmc/host/sdhci-pci-gli.c                               | 3 +++
 4 files changed, 7 insertions(+), 4 deletions(-)
