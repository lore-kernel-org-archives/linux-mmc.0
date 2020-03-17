Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD62C18E5B
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 10:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0792206EC
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 10:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+amxQSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgCQKOY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:14:24 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51658 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgCQKOX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Mar 2020 06:14:23 -0400
Received: by mail-pj1-f65.google.com with SMTP id hg10so5980717pjb.1;
        Tue, 17 Mar 2020 03:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3msrbtEKUz5qDONy4j/OIQtRcSS3HiRJjn2E802O6AI=;
        b=Q+amxQSVMSwiBr3htoM0Dybfb0UKgyhg2+8RhrMrzU0GzDG9+rHbyWRGE3aWRnHxEU
         jboJHnq6P5KXzldJJwlcdFHryse3ryJltm7+YFiMaYTz//KO6aVBI5tD4ehQa4UGw0py
         ZZB15WJ4STSa8VBFDuLw3u7+9oLoJY/9yL1B65R/nExiTZOLqFErwka8yKDxlxUpaEAm
         xu5ZF4x80T6j/yO6SXhifmjStjR0tDRGI2fSZ7tU+kY0/g5M9eWq2QhT8Km2kCZNCGjc
         Juysk+Nr5F3sMr7KwmcoXL+yLGyAMmbuC03HVcBElPkf5+oDABKLy3AuiOEBnVDuOlPD
         NSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3msrbtEKUz5qDONy4j/OIQtRcSS3HiRJjn2E802O6AI=;
        b=BMi3BvYmsO91PxIfvBQqBtT6NsEJbvbX6J9O4UWEJGoxWKlvEZgvq58EKyea1cda/m
         wZaIcftDO7tvtDQMebR2DOQCgtoFCi1GgSGfaikjx9/EQywQYNq1J4U+8lHfB4RfWuhT
         XdvxoOmnATUoqqyy95TgGptBbBg29jwZO4aWmcuKiFkvoOyausijJ1mhaACHqQ5sm/YE
         wn4dkmkuwCsqcDoO1lRvoeb8MkpfSVUY2pwNFc5fN0iH4KRNo9GqlMmJR5zFdvu7mnE+
         qkZsXOacYiH9iAbksI/YcJ9GGkzLOR5WOHiaNBbGOK2omxleUWzg7Uu+tQaKz/JuBF4F
         Uedw==
X-Gm-Message-State: ANhLgQ39CIVflrLmUxNzGWavRo1xGJw20puCGJfalEWS/ekDyu+hJea8
        3u/iDONTHpOmmWrdbJO/2ko=
X-Google-Smtp-Source: ADFU+vvIJOap+kOH8MutX+0wcPk49AUzJ9KUwWlY2rNxwhXFeUehi00/tI4x/7aEqui/x9FdZ1tbuA==
X-Received: by 2002:a17:902:8d93:: with SMTP id v19mr3650093plo.327.1584440061168;
        Tue, 17 Mar 2020 03:14:21 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s25sm2195487pgv.70.2020.03.17.03.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Mar 2020 03:14:20 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Introduce the request_atomic() for the host
Date:   Tue, 17 Mar 2020 18:14:08 +0800
Message-Id: <cover.1584428736.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch set introduces a new request_atomic() interface for the
MMC host controller, which is used to submit a request to host in
the atomic context, such as in the irq hard handler, to reduce the
request latency.

Any comments are welcome. Thanks.

Note: Adrian pointed out that it is not good if moving the polling of
inhibit bits in sdhci_send_command() into the interrupt context, but
now I have not found a better way to address Adrian's concern. Moveover
this is an unusual abnormal case and the original code has the same
problem, so I plan to create another patch set to talk about and fix
this issue.

Changes from v1:
 - Re-split the changes to make them more clear suggested by Ulf.
 - Factor out the auto CMD23 checking into a separate function.

Baolin Wang (3):
  mmc: host: Introduce the request_atomic() for the host
  mmc: host: sdhci: Implement the request_atomic() API
  mmc: host: sdhci-sprd: Implement the request_atomic() API

 drivers/mmc/host/mmc_hsq.c    |  5 ++++-
 drivers/mmc/host/sdhci-sprd.c | 23 ++++++++++++++++++++---
 drivers/mmc/host/sdhci.c      | 27 +++++++++++++++++++--------
 drivers/mmc/host/sdhci.h      |  1 +
 include/linux/mmc/host.h      |  3 +++
 5 files changed, 47 insertions(+), 12 deletions(-)

-- 
1.9.1

