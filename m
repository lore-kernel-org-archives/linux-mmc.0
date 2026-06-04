Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5312F7EE8
	for <linux-mmc@vger.kernel.org>; Thu,  4 Jun 2026 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552016; cv=none; b=JPKvlLVTw34mY7r5qxcymyqO/vD5pZSjXqbYqTE00uGHu1R8I/7nE1l+MS8LL8n9Y6CdKBqmY6Qz3ymKpotB2nbyQ5V2aOY/BAUbK9V1io1VPq1Q/8YYYGg3f7fvOS+6YX7onAiM0jXhUxXn+30t+E39QmzteAs91dLoVt3ogLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552016; c=relaxed/simple;
	bh=93HkJOpojF64Z+TCoiNjhN20OEqXTjcRnTeZAK1EbKQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j1RUPTjNplnxpT08VV5wfNoFkLxglS0TdxyCWJos2bqdmTkt+fbcCQVGMANieSa1/wdEwWxbcuaPN0Rucg3ncK2tzauWc7OaOlN5HEcGxDrIBWiofyZMqmoxPKnuHxSExENoTwG9t9vvEUPH9OWY9jE1K2VD1U5yDdCLwiQr+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLyLBQIA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLyLBQIA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c132ac5ec2so3416325ad.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jun 2026 22:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780552014; x=1781156814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NEsT65LHwLzJoUe9GB4Xv2mK2nINIQSL7VlQ43PkVds=;
        b=iLyLBQIARAzuN7p+zhmbPRk1mct+OYKZAsiWFDOwkgZlVT1hhei69uOlJUuB/7U74A
         exiUoh0L/RsUkBYLQAhsmw5jcKIAhQQrnvq+fUuf5jhyD0dWgh8lP1m3UjXPzbw4bpuN
         NY2altqLXM7l9BSec2u1xGR443Ty31bN9WGwWFrtdv7vBzdiI1eyLVMUj/4Tnz56/cYe
         /JUNe7eHkvyuskad4/je/5j/7iFzMhnlSn7gKmYLTKgaEd72SLiWHS4brcHCgOLboOc5
         iM1PW1mgwsBuOoxMQ032LV68h1puRwPAjiFhdTL4kZoOurBsIm8wK7Q4U4hv/5tzcDNz
         6qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780552014; x=1781156814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEsT65LHwLzJoUe9GB4Xv2mK2nINIQSL7VlQ43PkVds=;
        b=FGSs9IH/S7i+Esf+UYSrBLxP9S1SPBekl8+/kzmcqebbpDirk9ZvDVpu6a2/ztFEVw
         YFfuAQrDL5+jLbEZlKzqniTZh1BU/deSX19R/fLaAAwMjfjlymZjCtx778kDmYxPXxFt
         osuUFsHwjqdX9TEW3lYAfe+1v2GBZjbGtgkOVxqaBNDbqlEoshCCJ5E+Rp815eEt2w6W
         cP2CPfCQCvD4pb+SBktDv7Z2+kaDizStTI4sDlbRx/38eAHpzEOKqcOBnKWXwUrkz2GR
         w6mFg3xd1pSd3XXLR+Fj6mkfUDuG2U6ST3cITYFc+DfXYV1zU1tbgc2xlDxC0tr7LwoE
         CDEg==
X-Forwarded-Encrypted: i=1; AFNElJ+RNgFgqqAUQugNpIkVvJdETqTEMvaEqFNLXrt3ffMfJAPyefgaDkma3b5w1pfpr0M7j84gADVlpmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHqo9KWw1iuix7yLvzGFGS+eEIqrb+iumTcNIdYCJWcqzfj2Y
	EB9sgKrs/j6flpXjv5NRMB3xZ+4BMaU5AXrXkJsStww4PmCyWA5AKFcxw1VRso+EeXI=
X-Gm-Gg: Acq92OFr5zISZvS2G8RJ/mOUIRA98wSD9elsjD+BYvm7gTyk4c+lyyR6RZYT/+ifBlM
	cuaF7vSPeWebmmQVlMC1VVcX8VVy5MgOEVnm1HMhdtVRP2aK5LXJUIiRaNxfR5zupbx2sQFNfRz
	PUtNuWRNc1FyHowEXSkLuPXWPSnjpV+xFF0AVPrFo0uDzpasMdeQ7pdbcl5XSdA3BaHrRBDRVbp
	jGi6JXp2Rz/5YLCSie4B+cGGAS9wHYGziT1U66ox9f5rNrDhVe6pvCa80AzjondmyruwWsD5UP3
	Vx/Y57uCGCcF3Qm0dXNQBp0Oksyf9kXuaNDdKlXacxhw9aum1k+3QQkzHmFOkgDhBiHCeG+/aYL
	7HVvUCCIs5qCnqUwyEoZiAAxzT3ZlEe+o0yD2C32CBErAAYhcyp33uq7fN0MMJS4fPGvGfwOlYO
	g+jjmgb4Pdp8v3jdt1P9LqrRU=
X-Received: by 2002:a17:903:94d:b0:2c0:b4f5:41d7 with SMTP id d9443c01a7336-2c163c642bcmr75191405ad.18.1780552014390;
        Wed, 03 Jun 2026 22:46:54 -0700 (PDT)
Received: from lgs.. ([101.36.106.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ae328sm43193655ad.84.2026.06.03.22.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:46:53 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: vub300: fix use-after-free on probe failure
Date: Thu,  4 Jun 2026 13:46:28 +0800
Message-ID: <20260604054628.1411107-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vub300 driver lifetime-manages its controller state using
vub300->kref, with vub300_delete() freeing the mmc host when the last
reference is dropped. The probe error path after the inactivity timer has
been armed still bypasses that lifetime rule, however, and falls through
to mmc_free_host() directly if mmc_add_host() fails.

The race window is between arming the inactivity timer and reaching the
probe error unwind after mmc_add_host() fails:

        probe thread                     timer/workqueue
        ------------                     ---------------
        kref_init(&vub300->kref)         ref = 1
        kref_get(&vub300->kref)          ref = 2, timer ref
        add_timer(inactivity_timer)
        |
        |   race window
        |<---------------------------------------------------->
        |
        mmc_add_host(mmc)
                                         inactivity timer fires
                                         vub300_queue_dead_work()
                                           kref_get()          ref = 3
                                           queue_work(deadwork)
        mmc_add_host() fails
        timer_delete_sync()
        mmc_free_host(mmc)
          frees vub300
                                         deadwork runs
                                           use-after-free

timer_delete_sync() only waits for the timer callback itself. It does
not flush deadwork that the callback may already have queued. As a
result, queued deadwork can still hold a kref while the probe error path
directly frees the backing mmc host and the vub300 storage.

Fix this by making the post-timer probe error path obey the kref lifetime
rules. After deleting the inactivity timer, drop both the timer reference
and the initial probe reference, and return without falling through to
err_free_host. If deadwork was queued, its reference keeps the object
alive until the work item drops it; otherwise the final kref_put() runs
vub300_delete() and releases the mmc host and USB resources.

Fixes: 8f4d20a71022 ("mmc: vub300: fix use-after-free on disconnect")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mmc/host/vub300.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 3c9df27f9fa7..3546473d3486 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2341,6 +2341,14 @@ static int vub300_probe(struct usb_interface *interface,
 	return 0;
 error6:
 	timer_delete_sync(&vub300->inactivity_timer);
+	/*
+	 * vub300 may have async references via queued deadwork. Drop the
+	 * timer's kref and let the last kref release free vub300 via the
+	 * proper destructor.
+	 */
+	kref_put(&vub300->kref, vub300_delete);  /* timer's kref */
+	kref_put(&vub300->kref, vub300_delete);  /* init's kref */
+	return retval;
 err_free_host:
 	mmc_free_host(mmc);
 	/*
-- 
2.43.0

