Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4DAC4743C
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Jun 2021 07:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8598F6128D
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Jun 2021 07:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFWHwX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Jun 2021 03:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFWHwW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jun 2021 03:52:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EAEC061574
        for <linux-mmc@vger.kernel.org>; Wed, 23 Jun 2021 00:50:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h23so1038205pjv.2
        for <linux-mmc@vger.kernel.org>; Wed, 23 Jun 2021 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCWBbioEHtHJzv9+CJcDh4HpVJY4QYX5sGkNG1Q+JpY=;
        b=CycEjqYrALZTqZwmi2GhplKGcGO3AgLKB7KOs55ZnNHyaUZ4yYKGyX9gdEyVGLoHF4
         hbNwESHFpujY6WNiBV6UJ1rFS3jEcpnLloByEQVMCHxZlwHVmLZaOz8q0TJbnkv8zyFn
         ZUb4aAnSP++Ho6TStCr5p9JMvHEhDht2A1ZZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCWBbioEHtHJzv9+CJcDh4HpVJY4QYX5sGkNG1Q+JpY=;
        b=jlEFqEifAO/XTNHLxMVCBACY/o9g7i9ZUdGBQuYSbWcTNNimwtP9yqjbWywDF+/Uvb
         di4VThT8Aaf1akX56MKC2XwioqntPvgWSSluKZijETaX0GFHmDF+zeAqkWlN18uHqURN
         whDL/2zmCHoQGcAB0iCIgqevJ0itZ5FYkL2NruKKvt6cflSmGkfScDcbhPEBUliJjB85
         jNgf0oBOxG9LUE4mXzZ1C2eXds3JmvvfAkG2nSbu5icJuPtu4WeG7W87/S+O7qGJLseO
         YUbKxwr2nueqMvrXZ6wM5eGM6mm0hufXx3+U5jTaYzmUollb9DQ/wB+eC1JX8JCZJusj
         1QwQ==
X-Gm-Message-State: AOAM532j4K+Oo8xNj1w3k7DXL9PhRVU/K+pvtqy6KOPkxfqZIqo/LPwp
        JyamF0YNa2XipdSdAR+bJo7p0A==
X-Google-Smtp-Source: ABdhPJymIdrXB1rmnc/2QWjH6a2YQ+H05IEkm6jQdByEZxAOxIYruKmHKw8lw+lX87It0FMaIBJDqQ==
X-Received: by 2002:a17:90a:4592:: with SMTP id v18mr8181027pjg.132.1624434604167;
        Wed, 23 Jun 2021 00:50:04 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:afc8:33fb:90fb:4110])
        by smtp.gmail.com with ESMTPSA id m4sm4352625pjv.41.2021.06.23.00.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 00:50:03 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sujit Kautkar <sujitka@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 0/2] Two mmc fixes for IDA and KASAN issues
Date:   Wed, 23 Jun 2021 00:50:00 -0700
Message-Id: <20210623075002.1746924-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Here's a followup to a thread I sent a couple months ago[1]. They're only
marginally related to each other, but I have bundled them here into one
series to make it easier to track. Resending to restart the discussion.

Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Sujit Kautkar <sujitka@chromium.org>
Cc: Zubin Mithra <zsm@chromium.org>

[1] https://lore.kernel.org/r/20210413003621.1403300-1-swboyd@chromium.org

Stephen Boyd (2):
  mmc: block: Use kref in place of struct mmc_blk_data::usage
  mmc: core: Don't allocate IDA for OF aliases

 drivers/mmc/core/block.c | 35 +++++++++++++++++++++--------------
 drivers/mmc/core/host.c  | 20 ++++++++++----------
 2 files changed, 31 insertions(+), 24 deletions(-)


base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
-- 
https://chromeos.dev

