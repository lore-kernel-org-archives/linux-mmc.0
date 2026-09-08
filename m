Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8BF2D9ECB
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880164; cv=none; b=RBgeCToEAi4/pMUshFPRjr7bQE/sUX1nZli/ZAl3zEWIa3dX0bAVL0WTHsQ5XEZeeiHeyG8EELVTgeNYBZu3qBbLpmxjc2kmiUDsjPE9/9+lHMQcO5Jgfd6mj7Buqq4ozx9DBIXGJSyh4QXaE9WzcLF5t9f4fCXVrFGbpPxA3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880164; c=relaxed/simple;
	bh=hc911xxuUmZN8P+jG4Et5ZWTWNyakO0Xa7s2ndw9gms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HrLkB9tpoEylcelyJeG6Rd2Mv30rL0jYeeigQm6wsg9PK4euqvGZoW+FV0Wao52MkaV//Y31U5vunvLNLCEXSV0m5CMduPN9aVCZQPOKezfLlfuQ+kCWwYt9THWKhYfxhIzWTFu7pw4LOGMCfMwPPi/RWYYvCYHDoaYKtFJGBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLKt9M/k; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLKt9M/k"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c7c57e637eso2390237e0c.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2026 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788880153; x=1789484953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mGr9Cpmb+BSuPew2BBM6BAEAjAFzPbXBB7PZR5ZlT50=;
        b=GLKt9M/kujvwk5Y8aQC7tsdl9sjTIQMlyGnSGcLvrJT/Oxo4I4CpCYwkxVlAld0s8u
         sHZwtFzVGdEflwVPT6pzVbDWhgpvPgGgv8Rv/tUwGsoVWXt3X9hcXM5pQO4XAM4Y0vOA
         ggHKm3e3zpa8GuamtyjJjYzkEOt2hfqWj4nudjNMwKW/qc4XA1qSOFLgos/9l8Ks4CCm
         x86fnZZLWBv/ETujGhzwdEoBEHF+90ODZUvqikNXXhE82KYZRmmrePvQrN79/XP00OKr
         VWPTn3D6aGuOECmqP/dpsrZvTJNPnQ+gHMHv93yFNlBPkkGCrgrgLHgX1JYOX12A87Jh
         oXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788880153; x=1789484953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mGr9Cpmb+BSuPew2BBM6BAEAjAFzPbXBB7PZR5ZlT50=;
        b=j+CTDPJWbE/3ftgd2klYvGg8e6rebEDuxwD5SHrUIobZSPxZCe9LvEuwr8xUPw+0Ry
         8ktMBRMserwyCNsp8S1FZkGFfFTIUkTKEJFh223XpJ5oaxVyEE1n3+5Fdc8+FyoBYPLa
         25TPsI/B8ZdRov5fjsKrCejcaSkGus/oBr0XfiKoPREXn6JUHHWs1rMfUQqDkm4quCit
         bjYD23HWHr3LLZd7BQSPpZCfSeT3HTkt0ED7ltI2qUFDGfTzcntWoYwhzcbULmgiSAiM
         zxdv9yUuqb8EW/l7+/jlknWUDrTgDCW5aF5dhWQLnLVw/A83pZHUCTTWNAUPx4NqKB9G
         Ur6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxnm89zDsyMNjQFlh9ka8gsiADKow67JRfklFyFkFEUfX54qf0uA6yzODzNwgx7yya5rde6RyM9j68=@vger.kernel.org
X-Gm-Message-State: AFuF++lX3EnT3rHhlL6VhSeKCN7SxLWlkQC1HUjEFVnrw0v+tb9Qle3p
	lcCIRHyBV8FfdgyVQmdLj0rbIEQBXkrMGPncVw5v7CxXjvbc23InDVu0
X-Gm-Gg: AYBFou3C7nRs4w0U7nRaT199Sx8QV1uR9NR66WEKHRTU2hXmsFxsT/i8p5Us8NA7OPd
	EBqUY1qYaCGmeGCbsg1quHORdIuL6manPWX8UW7fU3tJwisRxXFXRFBlLSdHflrL+H1VDUoutQW
	f/NGOLOsU+X5jms5H7JzEErN1TB4ev21z8Is+YS2mB8/DH+Bdu1GSKlD4/FdWIYC6rOTZOxJ5A2
	Cy04W2jkJexDqZWajsHz0tcxZviu9lmaQWg8+6gZjxrr4L+yjDrOJl2lpEYzTjKlyqiVL57IOXO
	S0blNgEQFRN5GReeLGl58yHsrGe1ErtiwKqKhWIO9qH787cyFczIlhZs+dPx+caaWRqEOGBehdH
	G9uUxqZb5+Ds/MaIpbsGfxmHcAXtyF6seUa59qwAqEZEM3zd+a43rq5dapmsClfyngV/Usumn5N
	Znw0EiRA0BzwvrW+qSVb0RLbFdEmwbIvRhThf01oBFDg9YEj7pBJteiBJU+YCw+/o=
X-Received: by 2002:a05:6122:6092:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5c7ed83b793mr12351254e0c.7.1788880153383;
        Tue, 08 Sep 2026 08:09:13 -0700 (PDT)
Received: from adriano ([179.57.108.248])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec3b2cb1sm9940418e0c.16.2026.09.08.08.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:09:13 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] mmc: vub300: fix use-after-free in vub300 teardown
Date: Tue,  8 Sep 2026 12:09:00 -0300
Message-ID: <20260908150901.58915-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc_host_classdev_release() reads host->parent->of_node, but the
parent is not guaranteed to outlive the host. Instead, store
host->index_is_alias to avoid reading the parent at release time.

Also, call kref_put() after mmc_request_done(), as the latter
dereferences the host pointer.

Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Reported-by: syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f312381a95cc080992fd
Assisted-by: opencode: deepseek v4 flash
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 drivers/mmc/core/host.c   | 3 ++-
 drivers/mmc/host/vub300.c | 4 ++--
 include/linux/mmc/host.h  | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b7ce3137d452..542bb033c6da 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -67,7 +67,7 @@ static void mmc_host_classdev_release(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
 	wakeup_source_unregister(host->ws);
-	if (of_alias_get_id(host->parent->of_node, "mmc") < 0)
+	if (!host->index_is_alias)
 		ida_free(&mmc_host_ida, host->index);
 	kfree(host);
 }
@@ -538,6 +538,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	}
 
 	host->index = index;
+	host->index_is_alias = (alias_id >= 0);
 
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
 	host->ws = wakeup_source_register(NULL, dev_name(&host->class_dev));
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 2dae474dcd06..c87c54aa0e99 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1794,8 +1794,8 @@ static void vub300_cmndwork_thread(struct work_struct *work)
 			construct_request_response(vub300, cmd);
 			vub300->resp_len = 0;
 			mutex_unlock(&vub300->cmd_mutex);
-			kref_put(&vub300->kref, vub300_delete);
 			mmc_request_done(vub300->mmc, req);
+			kref_put(&vub300->kref, vub300_delete);
 			return;
 		}
 	}
@@ -1946,8 +1946,8 @@ static void vub300_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		    satisfy_request_from_offloaded_data(vub300, cmd)) {
 			cmd->error = 0;
 			mutex_unlock(&vub300->cmd_mutex);
-			kref_put(&vub300->kref, vub300_delete);
 			mmc_request_done(mmc, req);
+			kref_put(&vub300->kref, vub300_delete);
 			return;
 		} else {
 			vub300->cmd = cmd;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba84f02c2a10..165d24104d3c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -356,6 +356,7 @@ struct mmc_host {
 	struct device		*parent;
 	struct device		class_dev;
 	int			index;
+	bool			index_is_alias;
 	const struct mmc_host_ops *ops;
 	struct mmc_pwrseq	*pwrseq;
 	unsigned int		f_min;
-- 
2.51.0

