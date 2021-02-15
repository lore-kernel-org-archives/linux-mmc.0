Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC2C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Feb 2021 00:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A9F64D5D
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Feb 2021 00:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhBOAcg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhBOAcg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Feb 2021 19:32:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27F7C061574
        for <linux-mmc@vger.kernel.org>; Sun, 14 Feb 2021 16:31:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y10so1368183edt.12
        for <linux-mmc@vger.kernel.org>; Sun, 14 Feb 2021 16:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EPnN7V+TXLymh4O0EgyFMT7UejwMzeaWKlMB31n3+0w=;
        b=JLIdCsZFPZCPR5mAH2lmpvUvo4Pf7BA7MHfoXepsF06J2WRg8WD56u0WVYbLvSXd3Q
         0rzlxoSAJqbHY0h3psHOUt5o54gSDcTiAqdNNrX5HiMp6xvwymYf9VDcMJvawKLLhkq7
         obhEBhlduXweDUfoEkMOmPkRbssiZDGqFIxVn8VwXns7QoT5mJBNXGM+M4VYBYiSOWnc
         S3y5QDSJEhMXnPl5JlepWSnjdTbdgR6q4tjiT6nCiOlr58Sm2tu0dfKWYKYXMv/dmPgK
         xTKHF0hWm1zvKt1/IXuZyMGNqeFLKpnFPzYaup+xaS1nQIgG1Obvw8HH2573VIo8v9gJ
         RdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EPnN7V+TXLymh4O0EgyFMT7UejwMzeaWKlMB31n3+0w=;
        b=TR0RBRUCFsukZLG2VUY6tIFfkrQrvnvpL+QMgW2+hZzXLsW5dLa82cs/9a/J11LQU0
         L1vkgpQtmJ7x/spR9tR3+KRXySeXMr6WwA+cOJwL5y65D104mDAJKXKVZ4Xf8Oo44VaD
         211K9pt/LzPRCHnvSeyAkj/U1LfVGe4G2FHcKMlPyPYWeZkilNpRSrAw7s9J3BdGCy45
         /C22+8OFfYbOAhD2TuEOFntQYGJ59w6J/Eraewfzo84ZyHZSqJWcd2AWdEQODP3r3tCK
         5J/cvSND3lD3/013TFZ1sBEoKOtIaB7SwyO2KUa6Ejb2TUmOmH22cpKlV7J9ZiZ1niYl
         251A==
X-Gm-Message-State: AOAM531r6qK4ETeW6JV0QGdCDvEm+Z2kw7L955rCtKQR94/jvk+ZRRcB
        K+hGzrnWHOQ6VzhxyETDcoCkI9yxVSo=
X-Google-Smtp-Source: ABdhPJys8NrVjCv6rVJJikFneYev22ro2hHAiJNV+kjuj2kply/kPcifRfZaHalCdE/YSwba+Q8BJg==
X-Received: by 2002:a05:6402:1215:: with SMTP id c21mr13281236edw.310.1613349114329;
        Sun, 14 Feb 2021 16:31:54 -0800 (PST)
Received: from lupo-laptop (host-79-32-153-26.retail.telecomitalia.it. [79.32.153.26])
        by smtp.gmail.com with ESMTPSA id m24sm9645136eji.10.2021.02.14.16.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:31:54 -0800 (PST)
From:   Luca Porzio <porzio@gmail.com>
X-Google-Original-From: Luca Porzio <lporzio@micron.com>
Date:   Mon, 15 Feb 2021 01:31:52 +0100
To:     linux-mmc@vger.kernel.org
Cc:     Zhan Liu <zliua@micron.com>, Luca Porzio <lporzio@micron.com>
Subject: [RFC PATCH 0/2] Support temporarily disable of the CMDQ mode
Message-ID: <20210215003150.GA12202@lupo-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

eMMC protocol was born as single threaded and many use cases still
expect single thread operation mode. Through time the Command Queue
was developed and supported but many legacy operation are still
performed using single thread mode.

An example is FFU operation performed by using mmc-utils which is
currently broken for devices supporting CMDQ mode.

In order to enable legacy command sequences, we make cmdq_en sysfs
parameter writeable: setting this parameter to zero will temporarily
disable CMDQ mode and let legacy command sequence be supported.

Setting the cmdq_en parameter to one, will enable CMDQ mode back on.

Luca Porzio (2):
  Remove unnecessary usage of use_cqe parameter in mmc_queue and use
    more appropriate mmc_host->cqe_enabled
  Make cmdq_en attribute in sysfs, writeable. When 0 is written:     -
    CMDQ is disabled and kept disabled across device reboots. When 1 is
    written:     - CMDQ mode is instantly reneabled (if supported).

 drivers/mmc/core/block.c |   7 +-
 drivers/mmc/core/mmc.c   | 152 ++++++++++++++++++++++++++++++---------
 drivers/mmc/core/queue.c |  11 ++-
 drivers/mmc/core/queue.h |   1 -
 include/linux/mmc/card.h |   1 +
 5 files changed, 127 insertions(+), 45 deletions(-)

-- 
2.17.1

