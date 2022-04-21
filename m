Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFBEC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 18:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391347AbiDUSbG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391327AbiDUSbC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 14:31:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DC7277;
        Thu, 21 Apr 2022 11:28:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h12so1966227plf.12;
        Thu, 21 Apr 2022 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=lRcuPBVOMUIpsOb5XDhu14QHmkL0V1Wp/YDYhYarQ+o=;
        b=FnAB0GbTnY9Gy9+c3vejydTZorYkfWK3EoUz/peHeGBMYhAOyChFp2Axq5Ox3fcnle
         s1xr7ZwAh1how0iw5T4FWZCm8YmeU0aw8qT7HkgYXAh8DNGhhcRhmP9eKmikAE9fkyPo
         n0DYqi3yZ3YcMCIRnRIlMMDai0D93t9YbjQjpDo1gPBFhFZX8/zoCMq1QnUjCdaCQKQv
         Em9/zMIkPSEnHyg2vEWmq+MXo25aC4PBKugKaSS6QdC8uU9dovQXYNvE99Fh5XZAhwL8
         xXt3faLry5SsjmZs380AMvGK/bI1MLdp3Tzqfet4QQWux7k3ygACfLjuTtv1hspXZ4Ao
         wg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lRcuPBVOMUIpsOb5XDhu14QHmkL0V1Wp/YDYhYarQ+o=;
        b=CyNImgsW1G6XkPL4Uk6DyYbv19NzezstuTn/DyB4iNryimBLwe/m4vg4962C9WfeQu
         Y43W85G7ACUAzVBAKsDBfER4F8IwZTNMYlmI+FHi79QJL9r+fs23FAFF6I/KBNo2ialB
         f8p6QND7pl5sXKCV+pHrAaSbXBVMIqYowaE0XSdRD/R9vxcRzinjuMxnGp1H7HkJidvt
         Pd67R4mw3W6OadGQosBbadE0YJ4M8F+f+0YwAFBHHTjttGQkakCaLzhncddXoOK2lYha
         m2xdy4K4x6JH5r+KJ+BuMbL7ijICvq/oNe3bVbPq0DfBvGAVKz1Kxu2yQxwthGfBRCFC
         Kvpg==
X-Gm-Message-State: AOAM532xVrl/pTB6ydjGYJkalZuoAZF1blt2jpatr74Cmhzed4K7YVHy
        VCjqvaoPFudt2GhD+L7A9yc=
X-Google-Smtp-Source: ABdhPJzz0P2RBr5ojD8xDq+xp8K0AqLnOHtDTGsaLN24b/mVB9A2xCJCHuuZ/vQ1PaE7pM+KSw+bdA==
X-Received: by 2002:a17:902:f787:b0:152:157:eb7 with SMTP id q7-20020a170902f78700b0015201570eb7mr738827pln.109.1650565690114;
        Thu, 21 Apr 2022 11:28:10 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id s62-20020a635e41000000b003a9eb7f65absm6509333pgb.85.2022.04.21.11.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:28:09 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 0/5]  mmc: sdhci-brcmstb: host controller clock enhancements
Date:   Thu, 21 Apr 2022 14:27:58 -0400
Message-Id: <20220421182803.6495-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This change set contains broadcom settop sdhci controller clock related
improvements.

Al Cooper (4):
  mmc: sdhci-brcmstb: "mmc1: Internal clock never stabilised." seen on
    72113
  mmc: sdhci-brcmstb: Re-organize flags
  mmc: sdhci-brcmstb: Enable Clock Gating to save power
  mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0

Kamal Dasu (1):
  dt-bindings: mmc: Add Broadcom optional sdio_freq clock

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 29 +++++-
 drivers/mmc/host/sdhci-brcmstb.c              | 96 +++++++++++++++----
 2 files changed, 103 insertions(+), 22 deletions(-)

-- 
2.17.1

