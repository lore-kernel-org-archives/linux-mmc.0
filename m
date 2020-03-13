Return-Path: <SRS0=lJwf=46=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A690CC10DCE
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 12:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2B32074A
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 12:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkW5cons"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCMMcI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:32:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39783 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCMMcH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Mar 2020 08:32:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id f10so10305731ljn.6
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2020 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pBlq/kgkQyhz5z+kgPkCmkKYG8Mjt0ntSBe3WF4OdCY=;
        b=jkW5consK0RByS6GU/4ZhlnhmYj7/yeW/UsEMuEtvTrZDAgRnD/y/i9kzpm2kNX9WV
         3Gh61938BuefWmhxi/Z+KvJmDt8a3JlaQ/dqxENm+PSTnGk5MFBnM+9yYJJ7NpvFf5Rm
         VMT+st2Irg5+W96HeMZDKA0oS2z6iRexVDV0LfNn4gVKPOq8Hqq9sns9GdMQh4TepN0/
         SMdPcO90UR5bZ+wOV7udGPsGmkWiRcLJr0+HIX6fM1IerjT+bjmTFzV07OodCL6wDZqM
         tI2Lw79XyPUg/HhX0eKEWjVrfDcwvxkKOmU2YmzQhWBo/uKBhaR+YBdZNjrg1NBDboZL
         nLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pBlq/kgkQyhz5z+kgPkCmkKYG8Mjt0ntSBe3WF4OdCY=;
        b=eP8j6bi+o43mE3VsQYiXn+ZUk9gfWN0dwD2qqc/3c2bp8XC1HE7J94L+cXk8uRwfJO
         cTntmtuA1IsrjzvkUeeZ7HNbYXcTGD+bTJyYvfwg679e6OhHOJd9ritsKdKShJNaWSWE
         K5s3vrwNnNqwpxRRRRULpDcqhOKR4elPeGZknRXJhS9qKLxus5fmzTDzXBQLSiaDOJyn
         XvuKPrLCDdTEtGe9E7UKUB/g6MjQy8tKQEeGOlZ6J0rCFucbOaSJs/eFhb63QyJX6/hI
         +DgIUtIZ9uO3oV6XTXTkgKbukqQMyqvZPk/nAg8RkPnOUDab59BAwsYPtfJdMN1ryZaj
         7saw==
X-Gm-Message-State: ANhLgQ1l8njXIvFZ9bEgitLmW4T8sfnQ1cUsElf+/2pnGNHv/BvMNzK7
        RFBCmMoSVmRg0DV9M5Rn+ngpwKxa7uA=
X-Google-Smtp-Source: ADFU+vs7HWPz2lfZBxaBCERnGMae9SB3J/PkZFnSFf+rUqekHZ8JoPmWsq2+8bG2XUqZij5Dk8cJFQ==
X-Received: by 2002:a2e:9ac5:: with SMTP id p5mr8365764ljj.200.1584102725175;
        Fri, 13 Mar 2020 05:32:05 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v17sm19194591lfn.64.2020.03.13.05.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 05:32:03 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.6-rc6 take2
Date:   Fri, 13 Mar 2020 13:32:02 +0100
Message-Id: <20200313123202.23685-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.6-rc6. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 31e43f31890ca6e909b27dcb539252b46aa465da:

  mmc: sdhci-pci-gli: Enable MSI interrupt for GL975x (2020-03-04 15:41:22 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.6-rc1-2

for you to fetch changes up to 18d200460cd73636d4f20674085c39e32b4e0097:

  mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for eMMC sleep command (2020-03-12 13:36:55 +0100)

----------------------------------------------------------------
MMC core:
 - Fix HW busy detection support for host controllers requiring the
   MMC_RSP_BUSY response flag (R1B) to be set for the command. In
   particular for CMD6 (eMMC), erase/trim/discard (SD/eMMC) and CMD5
   (eMMC sleep).

MMC host:
 - sdhci-omap|tegra: Fix support for HW busy detection

----------------------------------------------------------------
Ulf Hansson (5):
      mmc: core: Allow host controllers to require R1B for CMD6
      mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for erase/trim/discard
      mmc: sdhci-omap: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
      mmc: sdhci-tegra: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
      mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for eMMC sleep command

 drivers/mmc/core/core.c        | 5 ++++-
 drivers/mmc/core/mmc.c         | 7 +++++--
 drivers/mmc/core/mmc_ops.c     | 6 ++++--
 drivers/mmc/host/sdhci-omap.c  | 3 +++
 drivers/mmc/host/sdhci-tegra.c | 3 +++
 include/linux/mmc/host.h       | 1 +
 6 files changed, 20 insertions(+), 5 deletions(-)
