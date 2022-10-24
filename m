Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4573BC38A2D
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Oct 2022 19:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiJXTV5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiJXTVV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2022 15:21:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E6579918
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:56:49 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so9678221pjl.3
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4wUfJCplte1+G0mWPV9aexgL/jA5N4Dat7pKZr+Tgc=;
        b=EXsYa0C60uNhGdEspNoh3iWFaw7LXl1Qtz/v/6RA3nAXmgVTB45Y0Cs+4b/mZHdegE
         dyRJc/5yn06OQe3TCE8a5/DHQvB2BGRErC6Gf2fMarXGfx6Gq1rWeAymo685l+trGjT1
         JHZZosjGut02uUo1aIgDPN3HbNldejPRGdGO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4wUfJCplte1+G0mWPV9aexgL/jA5N4Dat7pKZr+Tgc=;
        b=pDHPa5G/SQ1rGlokwIdrpbfiHX1PfoUX13EqHV7QHltE4ykS8Z8PCkVDzkeqiSmztV
         h5XVTJLUNQxqQ/r7jTbRYgcRALVeIGqRn49tgMN+OC0h8awq+V5PD26FIpA6fwJbqm0Q
         soOt3LsSb1TURFhcY0sdpGgC447f+gbhmbd2pyScNZt/y9NpsPsEkPg87KBrCIS9xvXz
         QrPe2r75OW519ANcoyE8a1IGuCvt/jHp53u3CPBYwbd0mmVwUraIyvLKFHYmIHNWmCFF
         tniF2sDQTR3352Opn52WXyC46rlc1nde89n1LBl6JU8ILQV+g4Ip/4wRrbe+1+gq+KH6
         ga8A==
X-Gm-Message-State: ACrzQf1BfdUsQiTC/Qx9y5+INjuHxqakHHlvWHn+jDanNt29M3qIfc1/
        9UpphSYB2L707M19ZF5YSNTcLg==
X-Google-Smtp-Source: AMsMyM7ROYfV1N2CFGcOsy94fO7hR1Gm02MWsKlw8jSqt/5VNmn1MzJI6nKhj5d01/InBR08iMMFnw==
X-Received: by 2002:a17:902:f687:b0:185:4163:3368 with SMTP id l7-20020a170902f68700b0018541633368mr35234456plg.25.1666634169850;
        Mon, 24 Oct 2022 10:56:09 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:808b:e2f6:edcf:ccb0])
        by smtp.gmail.com with UTF8SMTPSA id l20-20020a656814000000b0043be67b6304sm54917pgt.0.2022.10.24.10.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:56:09 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Faiz Abbas <faiz_abbas@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 0/7] mmc: sdhci controllers: Fix SDHCI_RESET_ALL for CQHCI
Date:   Mon, 24 Oct 2022 10:54:54 -0700
Message-Id: <20221024175501.2265400-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a series of identical fixes for several SDHCI host
drivers. Patch #2 (for sdhci-of-arasan; plus its dependency in patch #1)
is the only one I've tested, and I wrote it due to a bug described
there.

I then noticed that several other drivers do the same thing, and that
commit df57d73276b8 ("mmc: sdhci-pci: Fix SDHCI_RESET_ALL for CQHCI for
Intel GLK-based controllers") points out the likely-repeated bug. So the
fix is now factored into a separate sdhci_and_cqhci_reset() helper,
and it's likely that most/all drivers that support a combo SDHCI/CQHCI
controller will want to use it.

Thus, I include additional patches (compile-tested only) that apply this
helper/fix to the other drivers which call cqhci_init() but not
cqhci_deactivate(). They contain appropriate disclaimers and the
relevant parties are CC'd. I would suggest only merging them if you get
some kind of ACK from people familiar with the relevant hardware.

Notably, I do *not* patch drivers/mmc/host/mtk-sd.c although it uses
CQHCI, because it doesn't seem to be an SDHCI-based controller, and so
even if it has a similar bug, it's not clear to me how to patch it.

- Brian

Changes in v3:
 - Refactor to a "SDHCI and CQHCI" helper -- sdhci_and_cqhci_reset()

Changes in v2:
 - Rely on cqhci_deactivate() to safely handle (ignore)
   not-yet-initialized CQE support

Brian Norris (7):
  mmc: cqhci: Provide helper for resetting both SDHCI and CQHCI
  mmc: sdhci-of-arasan: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci-brcmstb: Fix SDHCI_RESET_ALL for CQHCI
  mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci-tegra: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
  mmc: sdhci-*: Convert drivers to new sdhci_and_cqhci_reset()

 drivers/mmc/host/sdhci-brcmstb.c   |  3 ++-
 drivers/mmc/host/sdhci-cqhci.h     | 25 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc-imx.c |  3 ++-
 drivers/mmc/host/sdhci-msm.c       | 10 ++--------
 drivers/mmc/host/sdhci-of-arasan.c |  3 ++-
 drivers/mmc/host/sdhci-pci-core.c  | 11 ++---------
 drivers/mmc/host/sdhci-pci-gli.c   | 11 ++---------
 drivers/mmc/host/sdhci-tegra.c     |  3 ++-
 drivers/mmc/host/sdhci_am654.c     |  3 ++-
 9 files changed, 41 insertions(+), 31 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-cqhci.h

-- 
2.38.0.135.g90850a2211-goog

