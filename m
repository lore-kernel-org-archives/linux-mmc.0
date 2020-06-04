Return-Path: <SRS0=N8Xy=7R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D869C433E6
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 12:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA228207DA
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 12:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="S3rfTSN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgFDMHF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:07:05 -0400
Received: from www.zeus03.de ([194.117.254.33]:45450 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgFDMGu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 4 Jun 2020 08:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=geolHvEIFJdhr1
        O7xNDDaH9ERBFP97XHJhFBPhVVr8o=; b=S3rfTSN+k5O9GX/L5j32aeXpdkPr7X
        SdumOicsQVMlsKiHj7lYCigbuwL/e1FJF1KpVz+qSsKCJyM7Y0C+AOF7XdnMv8LQ
        CXGXOv/EuMvc4nT3lIB9c7/cEL/vL57YdvraNoSTzukCs5jo0Gkxr4DrEzSRmNi7
        GrN2EZbz3AwGc=
Received: (qmail 1676226 invoked from network); 4 Jun 2020 14:06:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jun 2020 14:06:47 +0200
X-UD-Smtp-Session: l3s3148p1@Uzmd+kCn1OUgAwDPXw1XANux7yWtmp4Z
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v3 1/2] mmc: tmio: add generic hook to fixup after a completed request
Date:   Thu,  4 Jun 2020 14:06:32 +0200
Message-Id: <20200604120633.22795-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604120633.22795-1-wsa+renesas@sang-engineering.com>
References: <20200604120633.22795-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Sadly, due to HW bugs, we need a callback to work around issues just
before completing the request.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h      | 1 +
 drivers/mmc/host/tmio_mmc_core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index b4cf10109162..766a6116a9d1 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -177,6 +177,7 @@ struct tmio_mmc_host {
 	void (*reset)(struct tmio_mmc_host *host);
 	void (*hw_reset)(struct tmio_mmc_host *host);
 	bool (*check_retune)(struct tmio_mmc_host *host);
+	void (*fixup_request)(struct tmio_mmc_host *host, struct mmc_request *mrq);
 
 	/*
 	 * Mandatory callback for tuning to occur which is optional for SDR50
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index d7fde57c78c1..1672c849f78a 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -827,6 +827,9 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 		return;
 	}
 
+	if (host->fixup_request)
+		host->fixup_request(host, mrq);
+
 	mmc_request_done(host->mmc, mrq);
 }
 
-- 
2.20.1

