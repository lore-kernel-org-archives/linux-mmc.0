Return-Path: <SRS0=9sJp=55=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEFFC2BB55
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 02:46:22 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C214206C3
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 02:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc9qUsbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C214206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mmc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgDMCqU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Apr 2020 22:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgDMCqU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Apr 2020 22:46:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D65C0086D3;
        Sun, 12 Apr 2020 19:46:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n13so3867208pgp.11;
        Sun, 12 Apr 2020 19:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jD0arZtt+WUMcK2qKH6C7KoZfXl8ZzSelXg4KYilhDs=;
        b=Fc9qUsbxn5DJg1rVGQ9RplGoWHMwry5kv48peqZDENWsE/JRTENmawnCZh9ejoE5vh
         +IGdxEiJc83fr9iTKTsRznUihCFdZWCnOa3LTSz0oWxi6q4mjp7PaQFYI3r6pcyR6qiU
         RcxqCZsYGjHKIxMgOKWcRF0kJmzHtQnQ5GPFJftGHD/j8WmbwfMfQywVVw1WUMkRmxTz
         w11tosNggwxBzHllRxmBlkZL82VfXdI2wAvEnrOAxrfyL9th40ssBqQ/4ZDJzYWnGJiT
         dhOE+eek4HCPBiF/LZIy6X8AeqjuMMDaIrLPHB2uRGYGOVy/T9Mk6FJgWvBJa2wNxFzf
         DN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jD0arZtt+WUMcK2qKH6C7KoZfXl8ZzSelXg4KYilhDs=;
        b=Sp63Km2tjfTY0bW9POYkr4B9tuO/wf61MBn6QSpeI02sY5nrfFm/ujyvwumdDBGjYT
         oHnfBhOOku36qTSF8MV9H6QIaIqhu3g6ZYxgt+NqnQN9r6MqYwaVlwRyjr3Ukt6jWcZM
         DCxVdZ/uUixqWNMMUmol9o0DnPJSeLJrpWlF4f2QBse5sGht2wQZ1MOlsUKNRW9yfw2H
         gRCNlCRXmN0jcQeWTwj8UVKW21YSf84CpE2mmY/MsNm2v31nbLQoT1TXMVi4a05g/rls
         fSNN2oPlVasx4jPP9yofjJPt/DcMD6eqZAN51nuKzfeASS1ZN4vxsmS3QR1T0i4ZnwTs
         G8oQ==
X-Gm-Message-State: AGi0PuYd7HRAml1Bi9od4Ssr0ZxnP3s/EVoVTuh4KTplRR0+7bAV7ubu
        ED06+q+G/eerWDKadFTMeUm9f6Wt/Aw=
X-Google-Smtp-Source: APiQypLrW+6rz9JA18Kb1WG6Gz+FnhMmTZOpxm/xQNE1cPXbTA0JKx1suwzjZogLggMdO4VLkPA7hw==
X-Received: by 2002:aa7:963b:: with SMTP id r27mr15685419pfg.71.1586745980513;
        Sun, 12 Apr 2020 19:46:20 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.19])
        by smtp.gmail.com with ESMTPSA id i15sm2327882pfe.197.2020.04.12.19.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 19:46:19 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     arnd@arndb.de, baolin.wang7@gmail.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Introduce the request_atomic() for the host
Date:   Mon, 13 Apr 2020 10:46:02 +0800
Message-Id: <cover.1586744073.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch set introduces a new request_atomic() interface for the
MMC host controller, which is used to submit a request to host in
the atomic context, such as in the irq hard handler, to reduce the
request latency.

Note, this patch set is based on Adrian's patch set:
https://www.spinics.net/lists/linux-mmc/msg58529.html

Any comments are welcome. Thanks.

Changes from v4:
 - Remove redundant checking when warning the return value of request_atomic().
 - Add acked tag from Adrian for patch 1.
 - Re-implement the request_atomic() based on the Adrian's patch set.

Changes from v3:
 - Move patch 3 of V3 patch set into patch 1.
 - Add a warning for unexpected return value of request_atomic().
 - Remove redundant checking of ops->request().

Changes from v2:
 - Return busy flag if encountering unusual card busy state
 instead of polling in interrupt context.
 - Add a work for HSQ to try again in non-atomic context if the host
 returns busy flag.

Changes from v1:
 - Re-split the changes to make them more clear suggested by Ulf.
 - Factor out the auto CMD23 checking into a separate function.

Baolin Wang (3):
  mmc: host: Introduce the request_atomic() for the host
  mmc: host: sdhci: Implement the request_atomic() API
  mmc: host: sdhci-sprd: Implement the request_atomic() API

 drivers/mmc/host/mmc_hsq.c    | 29 ++++++++++++++++++++++++++++-
 drivers/mmc/host/mmc_hsq.h    |  1 +
 drivers/mmc/host/sdhci-sprd.c | 23 ++++++++++++++++++++---
 drivers/mmc/host/sdhci.c      | 34 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h      |  1 +
 include/linux/mmc/host.h      |  3 +++
 6 files changed, 87 insertions(+), 4 deletions(-)

-- 
2.17.1

