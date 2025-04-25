Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD730242D62
	for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2025 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579668; cv=none; b=FzZxkGavYCu19y3K50QgxE6360habXsHV51Jtx+nMdmvGyw3i/EZgWvlmbrmLGpFDcf+LkmK0NUDGOf09gsZ/rdBDbiZUAIeLwiadllYZZq/uiRLfgbFRA1S2cSWVMCq/FTY91ZEl2q1ibKsrNxyfR4RqaF323XzpeWlK148WzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579668; c=relaxed/simple;
	bh=mmR0W1vXVi+xNHYLsvHs5YMSU7hYdanuaBY4YfkaZkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8cf8nlvBkMk9voMGsg5A3yKVNfwmQiy37Gp/H3aIAaHp8ufAaSdamu4h4qJGIWL6qFVBRBXgKnQN6dGy5cYIijcCJOMYRhHAiMLCLWrMcfx32nTa66MMZr5Ep0woZenxtHXMjhmf4n585p8EdKOQ2riIk73zl9xnu3IVkwKsIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=AzxL5Ffu; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="AzxL5Ffu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=yehkrVqIYA1VSv84XKK+aGBzTLQQRKHS7yLajE9th+8=; b=AzxL5F
	fumta4+uJ/hItuCFYfMNdb8lOjEwFa0i+mkhFNkaUzK7Z2b54+VndBfq/wR++gjz
	4SddQk96rmrShRpRZojkBk7cQwzJyqZsNQK5ocRZm5xGTzFDepuAomxz8NMn/Fkj
	ja7FW/H84gvs0qLNCMXjgyUe70F3ATmgKx8SABbopEieR5tn9clq2V5B1ZkZ/q9s
	37IqFb7AX9CHPX8x9UubKyMHa+cDWQeeuxDG7yu80NK6uiXY87fzex0E1eo1r3kE
	HCBEZ9/ZvbcNbIDLZL63XMHJxA2RJ5f5pVu1nqRG3E2kdYbe8bP6gPMswlkk5wOz
	1CazO2kRqZAZ5uLQ==
Received: (qmail 3801284 invoked from network); 25 Apr 2025 13:14:23 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Apr 2025 13:14:23 +0200
X-UD-Smtp-Session: l3s3148p1@YATJb5gzHpgujnsE
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 08/11] mmc: rename mmc_retune_clear() to mmc_host_retune_clear()
Date: Fri, 25 Apr 2025 13:14:04 +0200
Message-ID: <20250425111414.2522-9-wsa+renesas@sang-engineering.com>
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
 drivers/mmc/core/host.c | 2 +-
 drivers/mmc/core/host.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 352db90785cb..81657449fee1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -947,7 +947,7 @@ int mmc_execute_tuning(struct mmc_card *card)
 
 	err = host->ops->execute_tuning(host, opcode);
 	if (!err) {
-		mmc_retune_clear(host);
+		mmc_host_retune_clear(host);
 		mmc_host_retune_enable(host);
 		return 0;
 	}
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 0e67b6b2ea5b..651c62ea0848 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -148,7 +148,7 @@ void mmc_host_retune_disable(struct mmc_host *host)
 	mmc_host_retune_unpause(host);
 	host->can_retune = 0;
 	timer_delete_sync(&host->retune_timer);
-	mmc_retune_clear(host);
+	mmc_host_retune_clear(host);
 }
 
 void mmc_retune_timer_stop(struct mmc_host *host)
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 7db1239c91e0..cf2d05706283 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -21,7 +21,7 @@ int mmc_host_retune(struct mmc_host *host);
 void mmc_host_retune_pause(struct mmc_host *host);
 void mmc_host_retune_unpause(struct mmc_host *host);
 
-static inline void mmc_retune_clear(struct mmc_host *host)
+static inline void mmc_host_retune_clear(struct mmc_host *host)
 {
 	host->retune_now = 0;
 	host->need_retune = 0;
-- 
2.47.2

