Received: from mail-aws33103.qiye.163.com (mail-aws33103.qiye.163.com [54.168.33.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7693DAACE;
	Thu, 17 Sep 2026 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.168.33.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663550; cv=none; b=Bd54GmC+vHdtMBAp52LvEDgNX+dAxVTXXy/3/VMZNQLWQrRiEDp2sz+3gyi/6zcLPGlYyW3pelomVvqAH8msAeJ+kEhAG0ITw+fdPa1cFqSA+3bF9b7qrr6sgUINg0pt7dgH9RR8QnGYFjyZtD7c5PGLaeIFLf3Mjuhx1Niqa3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663550; c=relaxed/simple;
	bh=ybUw/VAHJ34uriUZtpn0bT3L0WPyk0v+DTnIOENRITc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cDXC0RwQC9s572fbrPs9eXGlNYUOcV9V4iZmEB2Ce0egls0V7yGjGl5Au8AMYX/coFOgXXuaxU5xC6IAHMgQRpcz50u4kTuKUADyQ9iU4deqaJiETISr/V7QCcRhotIaN4AbkXb8xRv5TF5weJpzRDmJ9WfQEZrjQQt5qUSEYCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=AJBIpqTB; arc=none smtp.client-ip=54.168.33.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="AJBIpqTB"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e203485e;
	Thu, 17 Sep 2026 16:49:01 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH 3/3] mmc: core: fix stale mmc_start_req() references in comments
Date: Thu, 17 Sep 2026 16:48:37 +0800
Message-Id: <1789634917-143165-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1789634917-143165-1-git-send-email-shawn.lin@rock-chips.com>
References: <1789634917-143165-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0aa0ae8e123003a4kunm476cf0c8983d6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQhoeSFZDQkNMGEMaGk
	xPHk5WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=AJBIpqTB66BmBkvQGDaS6nhAmkGwXURz4jekSHHbDQAOcxRTSzXCcTZXkQcCWBLmhg2lsVTmBFOwnVAHPqwy/WRq0QrsOgRK+gqL3NTeEQsOeelbHPLRKXm5IEZpR1JCbXoxJRoDljZjP0w7d1UBtrwflykP9DMGvVwvQGJYd0Y=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=/k6J3dxPvPltz/ZMrbyXh8Ewz7+GFZJ0zTlamg5BQ3Q=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

Two comments still refer to mmc_start_req(). That function was renamed
to mmc_start_areq() then removed.

So, let's update the mmc_is_req_done() and mmc_pre_req() comments to refer
to the current APIs: mmc_start_request() and mmc_wait_for_req().

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---

 drivers/mmc/core/core.c | 4 ++--
 drivers/mmc/core/core.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 59430bc..920e4b1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -588,8 +588,8 @@ EXPORT_SYMBOL(mmc_cqe_recovery);
  *	mmc_is_req_done() is used with requests that have
  *	mrq->cap_cmd_during_tfr = true. mmc_is_req_done() must be called after
  *	starting a request and before waiting for it to complete. That is,
- *	either in between calls to mmc_start_req(), or after mmc_wait_for_req()
- *	and before mmc_wait_for_req_done(). If it is called at other times the
+ *	after mmc_start_request() or mmc_wait_for_req() and before
+ *	mmc_wait_for_req_done(). If it is called at other times the
  *	result is not meaningful.
  */
 bool mmc_is_req_done(struct mmc_host *host, struct mmc_request *mrq)
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 601c737..9be2875 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -170,7 +170,7 @@ int mmc_cqe_recovery(struct mmc_host *host);
  *	@host: MMC host to prepare command
  *	@mrq: MMC request to prepare for
  *
- *	mmc_pre_req() is called in prior to mmc_start_req() to let
+ *	mmc_pre_req() is called in prior to mmc_start_request() to let
  *	host prepare for the new request. Preparation of a request may be
  *	performed while another request is running on the host.
  */
-- 
2.7.4

