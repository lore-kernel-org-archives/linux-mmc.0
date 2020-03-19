Return-Path: <SRS0=dO/k=5E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E187C4332B
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 10:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1305120753
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 10:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njLUMSwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCSKzQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:55:16 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:35431 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSKzQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Mar 2020 06:55:16 -0400
Received: by mail-pj1-f50.google.com with SMTP id j20so857944pjz.0;
        Thu, 19 Mar 2020 03:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=idRUqg+TF0Cur/3wE1siUm3zMjSmlyYypSnAlFECMBE=;
        b=njLUMSwPbKU5el0tYMf9MdU7NECJlPA3Z7A66ayMJMZOTygvQt4wodbz1fKUlCz5LY
         9AjLUEyswf7Q4DDjyuybJ4Jyot9yTg44iNz8TxQZ0jgTLiwpfQzS9oidc1ClZLPWsd3Y
         lvpYW+71MReTk9uX4YnppqFf2MHze5tAiWGvDSe+KkzVtnLIBctuPliVmXy2i6omehb4
         jpCKIHQr853N0c3nrOaQBMq/H/WSjJGzdMeg70gMUkXVdf5F7Xeu/PUyMiP55VzgIgKR
         qNJULNYon0v93u0aR4sKhhVQTWxStVO3H9wVW/aQ0Jy06FS/KG16N/4mPcPQx6Prw2yE
         lfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=idRUqg+TF0Cur/3wE1siUm3zMjSmlyYypSnAlFECMBE=;
        b=q7xVH94xPoupqRnwj1wrGcIvoQxCsh3piQfSatfcxsOXsdMxGwsE8/thsRnxZqfy2j
         62HICHwh8F1Ozk/7pV92xOJyv+jALD7qJFiL1vsbkoH6IZEwl+SADr/kBdrdo2pExxZF
         2CQ7JpZEqpzNuJSXh4qKBqsXyBjHYtk0gyf6/RMBHyBLSzgixm3d7uh01l+BmjLvUOvu
         xMm1OtiAZAPKSjbIcv3JeZ4phawN++gpBfCbCwgvTOgtvGsR6McRpRu1mEs/qvPZN7Sz
         0nWZZD6bwqM8FTo7/0IQUKkQF31pfJet6MA/1Qn9aDDRJ1tx2kfR4RSc2y6/9y9JwG6t
         xJSA==
X-Gm-Message-State: ANhLgQ0K/nlhv33g4LQJMF064b2/zbY07ZIHRhfWQcCA5JrHd7Xaqbvr
        9cYCPspTz9iEnT/orKBY920=
X-Google-Smtp-Source: ADFU+vvojvcpDQejdb0HKnVxM5v3mWwqOWZV0xDT9UXG3HjJ6HhWcINLR/4jNvq9iTPjpVgnBY7LZg==
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr2656300pla.97.1584615313490;
        Thu, 19 Mar 2020 03:55:13 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f6sm2209949pfk.99.2020.03.19.03.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Mar 2020 03:55:12 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Introduce the request_atomic() for the host
Date:   Thu, 19 Mar 2020 18:54:18 +0800
Message-Id: <cover.1584615043.git.baolin.wang7@gmail.com>
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

Changes from v2:
 - Return busy flag if encountering unusual card busy state
 instead of polling in interrupt context.
 - Add a work for HSQ to try again in non-atomic context if the host
 returns busy flag.

Changes from v1:
 - Re-split the changes to make them more clear suggested by Ulf.
 - Factor out the auto CMD23 checking into a separate function.

Baolin Wang (4):
  mmc: host: Introduce the request_atomic() for the host
  mmc: host: sdhci: Implement the request_atomic() API
  mmc: host: hsq: Handle an unusual case of returing busy
  mmc: host: sdhci-sprd: Implement the request_atomic() API

 drivers/mmc/host/mmc_hsq.c    | 40 +++++++++++++++++++++++++-
 drivers/mmc/host/mmc_hsq.h    |  1 +
 drivers/mmc/host/sdhci-sprd.c | 23 +++++++++++++--
 drivers/mmc/host/sdhci.c      | 65 ++++++++++++++++++++++++++++++++-----------
 drivers/mmc/host/sdhci.h      |  4 ++-
 include/linux/mmc/host.h      |  3 ++
 6 files changed, 114 insertions(+), 22 deletions(-)

-- 
1.9.1

