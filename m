Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743BCC4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 18:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244764AbiD0SM4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244718AbiD0SMx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 14:12:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3582A5B3E7;
        Wed, 27 Apr 2022 11:09:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x52so663129pfu.11;
        Wed, 27 Apr 2022 11:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=+KXRf/57x56ly7QPrHBJNjAsIFjinEQkIFdxhHsGWqQ=;
        b=jRqSHBqIJp9enwZsF34BOf9cfk1rweaTre2KBac6TvAgWOiBTExqMuh0+Bxf6G8d+2
         VF0df8PUgrgh8UY+xjblKqQX1BQ+Y/ZSoSorRIdw1Y9QO5qt4N6axyvHoTa9FUC4TDom
         3AnlVB08EB8Zu+Vz2CVTWqNqRf19GigjTVgG0hkMu/eYZQFNpDcjm0/GZ/L7MdOsVj8y
         Nyo8/XJvBcRyAypFzrq8VDPnDHjmL+JlC1ivRN+jUtFbZOXsAqs+Tol9FueSM9xEvkCM
         ylk78/cbIPZbzBwOWztaPseLeIkNgKm+ia7IlHnzoH0Go6o+kb+OJFjRNYhTgEd62rpu
         QaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+KXRf/57x56ly7QPrHBJNjAsIFjinEQkIFdxhHsGWqQ=;
        b=vRoXVYf7bm6Bd252Cby2Ti0Teahfj2avUKPnCjwlnlZkZuMtBm+2MtPAJrNz2UuC0b
         HqnQy+iuPqS4ZcqwBp2+neqTfHS+dHH1BtRlLhR3c3cZ5sCQDa4cfdouLVos/u8BeNH9
         IPtQs6qU9jP8Rmhx+EhHIN0NKG0XF5m8DgPTcWJbZ1Axq6738YX1/Fh/WJUxmPFBJlnE
         QFzhUPlQF2tjOETzmwi29vSGXvi2qjxTvW4PVQejXzI0vWYz83qT7YDzHEKxM1TDNV3k
         YXZHu5XT5BFEEe/PimSx0sPOZzrVcX/izvKSKwKFZcPTsLdBU7YNXNV9JlyqJS2xHl5S
         TU+g==
X-Gm-Message-State: AOAM533j28X4G/z61faPo1MsPlzbR3HicHnUrVYa4q2Rs0daaaZfYd7B
        Hk5gsYGL6e7V+8RrRJ9JnHA=
X-Google-Smtp-Source: ABdhPJwfFK6H2f2WPptRfXfSIKQ8r8RI+rwulzGigURsruAGudtJEXNARTIxe7ZssSrwIlrdGTpMxg==
X-Received: by 2002:a63:8f45:0:b0:398:d78:142f with SMTP id r5-20020a638f45000000b003980d78142fmr24993082pgn.162.1651082965769;
        Wed, 27 Apr 2022 11:09:25 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78399000000b00505f75651e7sm19076859pfm.158.2022.04.27.11.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:09:25 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v2 0/4] mmc: sdhci-brcmstb: host controller clock enhancements
Date:   Wed, 27 Apr 2022 14:08:49 -0400
Message-Id: <20220427180853.35970-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This change set contains broadcom settop sdhci controller clock related
improvements.

v2 changes:
 - Removed a redundant fix from patchset 
 - Implemented review comments for brcm,sdhci-brcmstb.yaml and
   sdhci-brcmstb.c for setting max-frequency for optional sdio_freq clock
 - Added Acked-by to two of the patches

Al Cooper (3):
  mmc: sdhci-brcmstb: Re-organize flags
  mmc: sdhci-brcmstb: Enable Clock Gating to save power
  mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0

Kamal Dasu (1):
  dt-bindings: mmc: Add Broadcom optional sdio_freq clock

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 24 ++++-
 drivers/mmc/host/sdhci-brcmstb.c              | 92 +++++++++++++++----
 2 files changed, 94 insertions(+), 22 deletions(-)

-- 
2.17.1

