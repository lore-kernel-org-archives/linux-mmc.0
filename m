Return-Path: <SRS0=dO/k=5E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626A2C4332B
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 19:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233B62070A
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 19:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYwyBnPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgCSTjf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:39:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43780 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgCSTjd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Mar 2020 15:39:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id u15so3602054lji.10
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2020 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y++5cg6Ut1NMeVblwVvOtBBYzEaVMhHlf61V1wVtyG0=;
        b=iYwyBnPlNoZei8l2IRQGtE+bzhQCueMCFxMeE6YIHGlnCvCBnreXfYuzn48HSPD7zU
         xafCb3OjeUoVilnelGPmLc7zOaJv3GcurnNwxkgPN7M6152JTRM3Ag3dUI+hDQwiM5XJ
         XT/WL/M4W3cS30e6Fu7sZx8fum72YmHvnNp+3HTeXcIR7eRb9rxcIwhJW3wNztf/laob
         v6Aep/Pl10offkKfI1icDzZI6ykZhH+OT/rMfnmbvzKJ0bWmzcPjfkg0+hEKSu2+3arf
         YkRobNXZr3l0RmfZNdr0mFEqLSIQYX2MI6kqs4rPW8HPD9ecd21HGdGBa4gCqTogs881
         lRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y++5cg6Ut1NMeVblwVvOtBBYzEaVMhHlf61V1wVtyG0=;
        b=BVbjdw+Cg1k7BDKLV/2BDqbl0s56IhskSD6uj53+oym44X/LpQTmpCzsd/nsjssJgT
         1W6L5dIE+kOsM1NiuPwhbM8zu3yv0OZnFs2SRBErJEljG/OmXDn9ytuUansN1kLHN/cn
         tWSvavQg15vjZZW4VvFaXbCfRgoikVB2qCMozHak0U2lLY/93MZmNwJKrgR0YDXhJp2F
         XaJs0TH2QEtB8aqYyViqkQZke2gkqrBlGlZKuwvmDLjWjz4c2D/a6zNwp4P7Zukb+cjf
         JmY4+YwoOpgSb7mmYIVu+r562a0EQYzsGJamr9Q0AGMYxWhjGNBUcyu3PXGKz4kg0Fpp
         GxsA==
X-Gm-Message-State: ANhLgQ0yeAt8or99enDlW7kNLIk+eyNb/5KoKA6cf+g3YVGwq06zaH6F
        9b21uHTo/DVELYeEM/+BKBWa3JkzGNQ=
X-Google-Smtp-Source: ADFU+vtEisBhIMsKqPexnykennrEe+xUIsIAfirgoG6mKeWuBazk+xdN8fut9yE9LzTJXblkebYBUg==
X-Received: by 2002:a2e:9754:: with SMTP id f20mr3275582ljj.100.1584646770152;
        Thu, 19 Mar 2020 12:39:30 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id p10sm2367808ljc.72.2020.03.19.12.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:39:27 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.6-rc7
Date:   Thu, 19 Mar 2020 20:39:25 +0100
Message-Id: <20200319193925.19656-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.6-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit fb33c6510d5595144d585aa194d377cf74d31911:

  Linux 5.6-rc6 (2020-03-15 15:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.6-rc6

for you to fetch changes up to 4686392c32361c97e8434adf9cc77ad7991bfa81:

  mmc: rtsx_pci: Fix support for speed-modes that relies on tuning (2020-03-18 11:55:02 +0100)

----------------------------------------------------------------
MMC host:
 - rtsx_pci: Fix support for some various speed modes
 - sdhci-of-at91: Fix support for GPIO card detect on SAMA5D2
 - sdhci-cadence: Fix support for DDR52 speed mode for eMMC on UniPhier
 - sdhci-acpi: Fix broken WP support on Acer Aspire Switch 10
 - sdhci-acpi: Workaround FW bug for suspend on Lenovo Miix 320

----------------------------------------------------------------
Hans de Goede (2):
      mmc: sdhci-acpi: Switch signal voltage back to 3.3V on suspend on external microSD on Lenovo Miix 320
      mmc: sdhci-acpi: Disable write protect detection on Acer Aspire Switch 10 (SW5-012)

Masahiro Yamada (1):
      mmc: sdhci-cadence: set SDHCI_QUIRK2_PRESET_VALUE_BROKEN for UniPhier

Michał Mirosław (1):
      mmc: sdhci-of-at91: fix cd-gpios for SAMA5D2

Ricky Wu (1):
      mmc: rtsx_pci: Fix support for speed-modes that relies on tuning

 drivers/misc/cardreader/rts5227.c |  2 +-
 drivers/misc/cardreader/rts5249.c |  2 +
 drivers/misc/cardreader/rts5260.c |  2 +-
 drivers/misc/cardreader/rts5261.c |  2 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c | 13 +++---
 drivers/mmc/host/sdhci-acpi.c     | 84 ++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-cadence.c  | 18 ++++++++-
 drivers/mmc/host/sdhci-of-at91.c  |  8 +++-
 8 files changed, 117 insertions(+), 14 deletions(-)
