Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D5EC7EE23
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 08:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbjEXIzk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 04:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbjEXIzj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 04:55:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA6D97
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 01:55:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f1411e8111so618445e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2023 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684918535; x=1687510535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xY75exFFc4pLe253DwACRmicg541kJJKSeJfAcbzZL4=;
        b=cR4OOaDYF9vBD0ac6I93hzlAoNYHVBnRsa0e0anqL18v7B+r/OvCvXTJFHJRkxSFXl
         4QT1SA7ehERodfK/74U/QrYANGs+MlJoSOB+mXquHN+jVWlSNoJVFgA0M0oH4ghPD55e
         ZLYsvymofq9MMWRnDgG+zIQf28GQzfTw66EkDOpIjhHixzPLwNNR5f8DrXMDxba2Soc7
         ru+t0ri/Z0hnvOeHQraBkv9y8m/g33NeWvHGWRZzAG11lIO6xIkyjwYgc5qFbmbyUXY8
         r2siW9ez3fU6JbxXwtfWOfcP6uXanw0ET4XUW1EDap6H2d7VuEMhDOauM/8ufy1Xxt2t
         iLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684918535; x=1687510535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xY75exFFc4pLe253DwACRmicg541kJJKSeJfAcbzZL4=;
        b=bUeJxTd0abyvAO9JzUviOFwG592Pa9BNrkhgjgEKw7I0odeJCJq9OkrFkV9rX0Qi+p
         aBJ2sLvESg7J5lR2e5jzVCilBaaRJRRQb9lOZyoodHhL12AccJRnG3sYsXsxF+dQg/Lw
         ZnnWke0gtrgHSxguHAqrbMMHZvH7wokOrYXn4m5fQ/PJ3ZrB3FT0RPO/szJBLKrCVku7
         9gVG1J0NW9rGwBYiPCjhWVDZH7Oy11kyMMEV+V7NYN5yKVoxASbGzmIxDFXpmTAUFf+Z
         tKnoS2YdES46Cjj195eRDkEKwG/BpmS9f2oOckBqrV1wQDNt8uKdcxQ3etvDROVlGTmm
         ZgUQ==
X-Gm-Message-State: AC+VfDzdbJnfasN4A5c4YDMFpQeB08L+hkO3FeEEtFvGejdCvQDGLl9u
        EmWW5IpF/iD/4aUGOKJO618rnw==
X-Google-Smtp-Source: ACHHUZ7w8HrOshJTCZsj04zG70rWFL7ybf7IddSv+nrCIeK32BlN9QJ687mEFidwEq24Oirv2NxajA==
X-Received: by 2002:ac2:46fc:0:b0:4f3:9a2c:589e with SMTP id q28-20020ac246fc000000b004f39a2c589emr4929567lfo.24.1684918535422;
        Wed, 24 May 2023 01:55:35 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p1-20020a19f001000000b004f1477cf8a7sm1622811lfc.115.2023.05.24.01.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 01:55:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.4-rc4
Date:   Wed, 24 May 2023 10:55:33 +0200
Message-Id: <20230524085533.124092-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.4-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.4-rc1

for you to fetch changes up to 81dce1490e28439c3cd8a8650b862a712f3061ba:

  mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works (2023-05-09 11:55:02 +0200)

----------------------------------------------------------------
MMC core:
 - Fix error propagation for the non-block-device I/O paths

MMC host:
 - sdhci-cadence: Fix an error path during probe
 - sdhci-esdhc-imx: Fix support for the "no-mmc-hs400" DT property

----------------------------------------------------------------
Christian Loehle (1):
      mmc: block: ensure error propagation for non-blk

Christophe JAILLET (1):
      mmc: sdhci-cadence: Fix an error handling path in sdhci_cdns_probe()

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: make "no-mmc-hs400" works

 drivers/mmc/core/block.c           |  5 +++++
 drivers/mmc/host/sdhci-cadence.c   |  8 +++++---
 drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++--------
 3 files changed, 20 insertions(+), 11 deletions(-)
