Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427A245037
	for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579667; cv=none; b=kq3yRqU9sbfDhLU8PcJTBYp4snjcbkn8LBM8VzENskBGefCMLMm76kDuduVitK2cvz7Pe01C9iNjkkS0ECNrJr6uiYNKQsGw530sxsDq0SxyhTsXFg3Qf46UBmGhc8qYhDq10Ye9+y6208EPbPj10U6/+GMFSnRGdd5CbtNPLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579667; c=relaxed/simple;
	bh=KEXEmArvJ2+878NdvS1KB5pTxOtVSIn8QpADchQV9+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDc2zRRRHjcgRpPyR43aNCgbX3oBDY3oikQ7AeJ6Th0LvYBDZgPFJqseSWpuewQncVqc3P5xf4OtYNuwUZL+yuH4u41EBBsr+GogjBJx+tkKk37dY/nChcfFrNrMjBhE9u04KdWVf+YAgBVTx2msGI1umDYTp59ASd8xbAdLgCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TuEIId/v; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TuEIId/v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=2sZ/XRw+duqLpjUjmN04ZhzxnzICBfuOo6enpDvw5z8=; b=TuEIId
	/vgkKEo2GeK8JAPMoLlyMCzxelXoMpc2GoP1mNwlxUDwMn0f6Z2Fv0vLBXYT9XiP
	gr0AySxNneDAovlhl2P8oySYOK6McjVq0Hpw0xY6UsTetVLk/UHXYdaOY4IOqoK8
	JWb/l7D6icgWoup06lxIwlHd8AIV0STsIILYcWWl98thGkb2ylCvkE5tl3wnWDwU
	hrolpzNoq+kujB8Z37EWEY/uUyWOkM6LTgJZqRD8oZOElIhjdmawVeWXltduzEGd
	EmIpPeVDDCIe0v+9r+qKhAitaFDHcJupqf2XQNDE4/vPPaoD3gsdWpk++UEth/Cl
	kAFcyAcpmR5KLrMA==
Received: (qmail 3801218 invoked from network); 25 Apr 2025 13:14:21 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Apr 2025 13:14:21 +0200
X-UD-Smtp-Session: l3s3148p1@Ttqkb5gzBJgujnsE
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 05/11] mmc: rename mmc_retune() to mmc_host_retune()
Date: Fri, 25 Apr 2025 13:14:01 +0200
Message-ID: <20250425111414.2522-6-wsa+renesas@sang-engineering.com>
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
 drivers/mmc/core/core.c | 4 ++--
 drivers/mmc/core/host.c | 2 +-
 drivers/mmc/core/host.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7c9c22a25684..352db90785cb 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -217,7 +217,7 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	int err;
 
 	/* Assumes host controller has been runtime resumed by mmc_claim_host */
-	err = mmc_retune(host);
+	err = mmc_host_retune(host);
 	if (err) {
 		mrq->cmd->error = err;
 		mmc_request_done(host, mrq);
@@ -443,7 +443,7 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 	 * active requests i.e. this is the first.  Note, re-tuning will call
 	 * ->cqe_off().
 	 */
-	err = mmc_retune(host);
+	err = mmc_host_retune(host);
 	if (err)
 		goto out_err;
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 9be1727d8d5d..b0c958f761da 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -173,7 +173,7 @@ void mmc_host_retune_release(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_host_retune_release);
 
-int mmc_retune(struct mmc_host *host)
+int mmc_host_retune(struct mmc_host *host)
 {
 	bool return_to_hs400 = false;
 	int err;
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 426e6e54bac6..45200070d318 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -17,7 +17,7 @@ void mmc_host_retune_enable(struct mmc_host *host);
 void mmc_host_retune_disable(struct mmc_host *host);
 void mmc_host_retune_hold(struct mmc_host *host);
 void mmc_host_retune_release(struct mmc_host *host);
-int mmc_retune(struct mmc_host *host);
+int mmc_host_retune(struct mmc_host *host);
 void mmc_retune_pause(struct mmc_host *host);
 void mmc_retune_unpause(struct mmc_host *host);
 
-- 
2.47.2

