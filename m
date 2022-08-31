Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A818CECAAD1
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Aug 2022 12:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiHaMoW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Aug 2022 08:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiHaMoV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2022 08:44:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E80D419C
        for <linux-mmc@vger.kernel.org>; Wed, 31 Aug 2022 05:44:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so9518710pjj.4
        for <linux-mmc@vger.kernel.org>; Wed, 31 Aug 2022 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=B2f/uGSqWuJvhQs4Hm3LS726QXawD649pQiq9j/efiE=;
        b=oOn7rhhydkjVM/gmx2E10T1NetI8Y5eeEYpFP3XkHYt1fDgmIb/gkNGWEu8313LbS7
         bhBMlCMbTD7LjbJT/C1jxg/omWCg35pL4ndgAmd1foxdAvH1AhPiXPcHYGs1CakdWhj+
         nsK8FJBsekHzCUYriUyZKkvYzISZCP3WeLoYOR0RI/Uk2h+T6t0b4eD3VSxG6WDFsXqH
         44ZCPCAvlpebiXPTGlgRrAuzQE66vZTIXo5hXdiPrvAGuwKD8N7xOMtAbjAaMeoyZq6t
         DMRVj1w/huG8hzoKZUwkbzquX3ynVA4/5JTfaEAWF27AUXAog94HbjxvJ4W0JofJIGR5
         A3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=B2f/uGSqWuJvhQs4Hm3LS726QXawD649pQiq9j/efiE=;
        b=J1uDB+0rpHsxDC8QsfIZj1FeAgSkK2eawF82ciCwXcrh0pDPKq81bJDXjyj+mko15B
         WV/XZdcy70KfHVYTbP0J35Q9CJmibb7X30qLu8vpMWZiJAzzGMs25auQr8aOtUidfdp6
         P8BvISLo725+YljK7Pyci3zV+v0i0cioD7M5kiXKhWy81QJwxGdJbYQedvMTWLVQMLVn
         /mooMKBr+pW3S1USCxm9bC0Fd2TsH0sygl0dp/z740AvjMxqXOOFl4SM909roDThE7aU
         vepFOtPu/yzBMb/irZt9o5Ykssohs9g/+PynqCvaHqHEnNhKdPCY3DfzEBEAFqLN1XI+
         AGnA==
X-Gm-Message-State: ACgBeo3pfmendmclxEFnc2WI/E7VusAGj9kXEhu2LLlaBI9bVyBo49Eg
        DR66gFo5b7jduvbgPlTs0rew2JosutWinrPH
X-Google-Smtp-Source: AA6agR46IKDvG7Z8jISNcLJ+ew3vDOnejQPimi+Vp2MlNbBwuVAWHkJq0m3huQhEn9KPw0wubDJDqQ==
X-Received: by 2002:a17:90a:9b04:b0:1fb:fcb:1de1 with SMTP id f4-20020a17090a9b0400b001fb0fcb1de1mr3110321pjp.235.1661949858240;
        Wed, 31 Aug 2022 05:44:18 -0700 (PDT)
Received: from localhost ([111.184.129.17])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b001752cb111e0sm3190344ple.69.2022.08.31.05.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:44:17 -0700 (PDT)
From:   "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
X-Google-Original-From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To:     linux-mmc@vger.kernel.org
Cc:     "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH 0/1] mmc: sdhci: check host->cmd is null or not in sdhci_cqe_irq()
Date:   Wed, 31 Aug 2022 20:43:58 +0800
Message-Id: <20220831124359.2005165-1-paulliu@debian.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

If we don't check host->cmd. We will get the following oops
when booting from eMMC on RockPi4.

 Unable to handle kernel read from unreadable memory at
   virtual address 0000000000000000
 Call trace:
   sdhci_cqe_irq+0x40/0x254

Ying-Chun Liu (PaulLiu) (1):
  mmc: sdhci: check host->cmd is null or not in sdhci_cqe_irq()

 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.35.1

