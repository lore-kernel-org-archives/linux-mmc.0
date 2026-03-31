Received: from mail-m3285.qiye.163.com (mail-m3285.qiye.163.com [220.197.32.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9283E023F;
	Tue, 31 Mar 2026 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945837; cv=none; b=aluY+YXTKlJ+Sqt8xUky2LjuSm23v7i/lIk7iz+FgSI7/En4tInZKZAMSkyjquuZ+25Sp3KEaXAjc/ES5PfFq2MVE3DsrnOXJN9D+ZxYJ3VNDr9jD0Gl6EZ1y3U6ox3dvdphafgVDcZFBC9lssOT6ZVfkjEFsUoq/tEmQx8Y8dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945837; c=relaxed/simple;
	bh=PtnLQHHFJps2Ogy+qGrNTHD9/lKagFEeBG3vN96pMN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Kktq1H2jc6qtGa3TUzIXR2zT7uaGXxFrOBM0o4OjBKM45j4zvZZSBK/8A6QvLefC7NIjd1hGWY5PS+rAoYZeYpl2V2sDkgMiERFfYMAIkciutaBaJSw/rDy0dkOAtKmifUKCBCy133aG0yQdkXIoK4iyJgXCS8SAkHslf9txCyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PdsAwRPn; arc=none smtp.client-ip=220.197.32.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PdsAwRPn"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 38f5d4c09;
	Tue, 31 Mar 2026 15:54:58 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] mmc: dw_mmc: Remove dw_mci_start_request wrapper and rename core function
Date: Tue, 31 Mar 2026 15:54:50 +0800
Message-Id: <1774943690-219754-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1774943690-219754-1-git-send-email-shawn.lin@rock-chips.com>
References: <1774943690-219754-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9d42e37f7709cckunmd4b3018ef138ba
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0xCS1ZDHkoZHk4YHxhNShhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PdsAwRPnJNwxIWAIdoanOX20/doBJktP5JzHPys/6WFWsHZZnHAf31n0YGRQlQcfzR+j5FErqVbxWKBwQKm9oUS2IvVrlrHUEf5VKYu2vpwFST5iMFWBNdZ52e/mYDNUpzBCvF7BUSnabGc2uSvnAgvPNeIKa1bPEVlTiz18wd0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=ZAEMBAwd88qEJBJL7jXJ75RWiPa3Tw+dBgESQ2qZUqs=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The function dw_mci_start_request() was just a thin wrapper around
__dw_mci_start_request(). Since it serves almost no functional purpose,
remove the wrapper to simplify the code flow.

Consequently, rename __dw_mci_start_request() to dw_mci_start_request()
so that the core implementation uses the primary name.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 8e78faf..20193ee 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1224,8 +1224,7 @@ static void dw_mci_set_data_timeout(struct dw_mci *host,
 		timeout_ns, tmout >> 8);
 }
 
-static void __dw_mci_start_request(struct dw_mci *host,
-				   struct mmc_command *cmd)
+static void dw_mci_start_request(struct dw_mci *host, struct mmc_command *cmd)
 {
 	struct mmc_request *mrq;
 	struct mmc_data	*data;
@@ -1284,18 +1283,10 @@ static void __dw_mci_start_request(struct dw_mci *host,
 	host->stop_cmdr = dw_mci_prep_stop_abort(host, cmd);
 }
 
-static void dw_mci_start_request(struct dw_mci *host)
-{
-	struct mmc_request *mrq = host->mrq;
-	struct mmc_command *cmd;
-
-	cmd = mrq->sbc ? mrq->sbc : mrq->cmd;
-	__dw_mci_start_request(host, cmd);
-}
-
 static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct dw_mci *host = mmc_priv(mmc);
+	struct mmc_command *cmd;
 
 	WARN_ON(host->mrq);
 
@@ -1329,7 +1320,8 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	if (host->state == STATE_IDLE) {
 		host->state = STATE_SENDING_CMD;
-		dw_mci_start_request(host);
+		cmd = mrq->sbc ? mrq->sbc : mrq->cmd;
+		dw_mci_start_request(host, cmd);
 	}
 
 	spin_unlock_bh(&host->lock);
@@ -1949,7 +1941,7 @@ static void dw_mci_work_func(struct work_struct *t)
 			set_bit(EVENT_CMD_COMPLETE, &host->completed_events);
 			err = dw_mci_command_complete(host, cmd);
 			if (cmd == mrq->sbc && !err) {
-				__dw_mci_start_request(host, mrq->cmd);
+				dw_mci_start_request(host, mrq->cmd);
 				goto unlock;
 			}
 
-- 
2.7.4

