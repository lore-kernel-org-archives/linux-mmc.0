Return-Path: <SRS0=CvS5=DC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9781EC4363D
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 08:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7CB20936
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 08:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgIYIuA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Sep 2020 04:50:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58610 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgIYIuA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Sep 2020 04:50:00 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kLjQT-0007Hx-Qd; Fri, 25 Sep 2020 08:49:58 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     ulf.hansson@linaro.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        linux-mmc@vger.kernel.org (open list:SONY MEMORYSTICK SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] memstick: Skip allocating card when removing host
Date:   Fri, 25 Sep 2020 16:49:51 +0800
Message-Id: <20200925084952.13220-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

After commit 6827ca573c03 ("memstick: rtsx_usb_ms: Support runtime power
management"), removing module rtsx_usb_ms will be stuck.

The deadlock is caused by powering on and powering off at the same time,
the former one is when memstick_check() is flushed, and the later is called
by memstick_remove_host().

Soe let's skip allocating card to prevent this issue.

Fixes: 6827ca573c03 ("memstick: rtsx_usb_ms: Support runtime power management")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/memstick/core/memstick.c | 4 ++++
 include/linux/memstick.h         | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 693ee73eb291..ef03d6fafc5c 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -441,6 +441,9 @@ static void memstick_check(struct work_struct *work)
 	} else if (host->card->stop)
 		host->card->stop(host->card);
 
+	if (host->removing)
+		goto out_power_off;
+
 	card = memstick_alloc_card(host);
 
 	if (!card) {
@@ -545,6 +548,7 @@ EXPORT_SYMBOL(memstick_add_host);
  */
 void memstick_remove_host(struct memstick_host *host)
 {
+	host->removing = 1;
 	flush_workqueue(workqueue);
 	mutex_lock(&host->lock);
 	if (host->card)
diff --git a/include/linux/memstick.h b/include/linux/memstick.h
index da4c65f9435f..ebf73d4ee969 100644
--- a/include/linux/memstick.h
+++ b/include/linux/memstick.h
@@ -281,6 +281,7 @@ struct memstick_host {
 
 	struct memstick_dev *card;
 	unsigned int        retries;
+	bool removing;
 
 	/* Notify the host that some requests are pending. */
 	void                (*request)(struct memstick_host *host);
-- 
2.17.1

