Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFCA2459DD
	for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579669; cv=none; b=gw7zkzhiOc9td93QmnBUJymGATDyqnjxYWmnhTclU4scbJaScyXd86C6Nl9rBm1VJgift/mS6d97Z3cpJ+laIL/Nof74/dcNNntnLiTpnX498quQi7042J4fYeevp1OZLGBFbZ+VnGSJL11YzoXIzdibFaS00VJEai3CAXB4yVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579669; c=relaxed/simple;
	bh=SvyXNukR7T5uUKvSuunEQdZ0t4sqR4oxxbZH47LZ8Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYnXO+hWdQ95Xmo8N/pDNPrrbt4YD6QdlU6mWmZLjwIzMrrSZ74Ir3AT77joqzN4Z8WKZSzTLKJYnRCsS7HEcm/OtUHXNtfJsgYDqtHL6ZSh6IMFxUBL8qiCjcxiWTAwS55uziInLzd4i27x/33kUQB/0tOtqF/0/+3sXL3E4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bulccgdf; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bulccgdf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=nzcjNl2sJfZ1fAZT+Onu+MVEJlHvRUQ2cqlGBbQ1J3Y=; b=bulccg
	dfkVlMQFPytBJZHTiWj6NOGqD9dgTNKqDDoiLUK5+uZC9vqkM8UJVnuyZBsbm0Ei
	U5QesKHnjcfLYJtvsaEtMGa3NXtxTw7OiyOwJG7kY7k+X9XeKgaGj2WZCcgbnaxk
	CPqudKKIcdml+BqNPMrbipjDRuaD7oWY9lsqdhdvXapO/4AkFlmiOBl/WQQvLNzY
	Rmb5FzyERXyrzvdyLj9sGa1HjjMgCnFd9GRkjIefn1Gpfz2YmFvuG+10zH0BbG2P
	KjAm3Yg63Sb8x35XVaf2+uVqfHw2gjK0NnX8pWx+vSPE+jVMoPmYdR2rz8yNGibN
	Vb1RCzhdaOJQMEYA==
Received: (qmail 3801335 invoked from network); 25 Apr 2025 13:14:25 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Apr 2025 13:14:25 +0200
X-UD-Smtp-Session: l3s3148p1@cdvib5gzOJgujnsE
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 10/11] mmc: rename mmc_retune_recheck() to mmc_host_retune_recheck()
Date: Fri, 25 Apr 2025 13:14:06 +0200
Message-ID: <20250425111414.2522-11-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250425111414.2522-1-wsa+renesas@sang-engineering.com>
References: <20250425111414.2522-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc_* functions sometimes relate to the card and sometimes to the host.
Make it obvious by renaming this function to include 'host'.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/core.c | 2 +-
 drivers/mmc/core/host.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c553eecce1ab..960d7f4a3503 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -412,7 +412,7 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 		    mmc_card_removed(host->card))
 			break;
 
-		mmc_retune_recheck(host);
+		mmc_host_retune_recheck(host);
 
 		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
 			 mmc_hostname(host), cmd->opcode, cmd->error);
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index fb1a9d7b5c91..b1bd4388e215 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -33,7 +33,7 @@ static inline void mmc_host_retune_hold_now(struct mmc_host *host)
 	host->hold_retune += 1;
 }
 
-static inline void mmc_retune_recheck(struct mmc_host *host)
+static inline void mmc_host_retune_recheck(struct mmc_host *host)
 {
 	if (host->hold_retune <= 1)
 		host->retune_now = 1;
-- 
2.47.2

