Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF885333730
	for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776891095; cv=none; b=TlCggzSRQ0+v14O8bYm5m3EZ7yS4dHQp+sEuAmGhy7CupWJbZyLC4Rh+herNkVBg0k9vftgm9Lr8uuknzY/KZYIMUR4sbEGLp1H3WomaGhYWGybNUgyScVHCY9bkSH1KEwiZRI9KjBxkHXdxrCn49SB/vXbq/VhE74w+VlDdhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776891095; c=relaxed/simple;
	bh=lZgUmf+snJtgn2iqyKzz2f7jkJ/tF6tuXosxy/AYwQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1R6Odl5UAA/TzYQ8IE9puc6n1bYhPIBZEHkLCh4wATdDgcMS4pCdKhszlumYZrnqteimi+AeR+jT0/c2FEzgOcCahLZ8vfb/zD7rqVuFD6XkdtOaP8nrzXIiAfqlBzmEvfWLPseYV8n7AY9ZnfymXe6SVYh+fIeIkWDxdvqVNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QI7PqKzL; arc=none smtp.client-ip=74.125.82.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QI7PqKzL"
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso6292798eec.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 13:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776891093; x=1777495893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vduSvXKe+L7+c8UihFrzYyBr/PDlgqMu0Lyao+9fcwg=;
        b=AQ0QdOzHNOpuHwEVMXC9q5Wdau4PI6DnAAnMoefHe70plZHD23hwelSix7OIdelFNj
         63bJr149n/lEnz6w5rNavqxC+osMsKFJirp7nRjagXe+LLkfSulBwbyQmO4CFtGbQr+l
         FtjGY70pVlh159Ba1XQOxfda4VDNsCovNJXJUQ5zg3eVelZDEI2++30Pj/swsnP6j5nx
         o0tbFDOfkYNKYg9IGq4dqjknmnHnGtFhSWSrgBIgH19d4bNb6q3LC6K8IcIj3FvWWzCt
         zQw1YZTVnKzyln0dX3R06hbf0ShrbyFcJveOpYNxusAdu7D05J8HtaBBHf4t44yZ4jiD
         bhrw==
X-Forwarded-Encrypted: i=1; AFNElJ8gXwuc75h4WplpMLRVzQUgxI5daOccNfdaWl8lK1rHXrnpVnVScy31APFGYXxCstE5qSOswckavZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyim1K4VlfEKytDdkSYXLif2g7J24w0CLALTznWmKGbwGkABodd
	H3YuG1oOtBrux3LubUGqT0bibuRMvWHzpyNBL95xdF6bis2t3RxeSxknk2R41/IcadXdBMlD+8h
	riVZuvhTvTWa5IfRB1ZZxDYOxNxjaIMQp+gofdsrYxAKm0KLXaq7MuwPfSKi88MaOFvKTjcZ0Zl
	2wjbb3ubK2WUIDpnm3h6HtcumiF2uOchcyzNSquts8BAnaOAvViVwzn3c3aTissIIaWB330kFW/
	JYn0xCBbvp/
X-Gm-Gg: AeBDievDPy2nWP6gs3KrLAKuFmILdEFvaix8MUygb+I8ygHpYJhUZN3pkiYSYEI8XIJ
	6hQyIS+E/eqGv5ZAwiGc59Cju9mUtmWn5r8zqCFwHP3zqMn5QMBk7lIq2sJKDP+heL44ipk9l2X
	OkbGzsZBmgNX6e48cHfxI7FYJZJdFerCxGJUE1kFf89cDoRM9ymDvRxzBedYww0a0GBz7WZ3FgR
	TK6XEnkBVFsFNeDFLanYbLgU/bRsADd298X1S0a2DNrf5pmBG4kbvviNdLYBevSt2RN7m4cybQc
	bDp3IlSFKmB9NxqKNkURgtxiSCkYWZCbE1Ccxso7GbyFUiBPIgzWQe/lbyhEyzP9i7yIkKzEczP
	wBWlqkpsJdyYYDwjqfVW+emja2jVsK/VT/MKGst5sGmHk4z4jFbd8coKs6Fz+Uu93QWJu+VDFzr
	QjF3xTMY+V/Q39
X-Received: by 2002:a05:7300:3252:b0:2c4:ec89:bc7 with SMTP id 5a478bee46e88-2e464dacc71mr13907849eec.10.1776891092913;
        Wed, 22 Apr 2026 13:51:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2e53a3abe72sm1263449eec.7.2026.04.22.13.51.32
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2026 13:51:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8acd145817dso74979996d6.3
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 13:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776891092; x=1777495892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vduSvXKe+L7+c8UihFrzYyBr/PDlgqMu0Lyao+9fcwg=;
        b=QI7PqKzLWzAuNkIfzZJiec0NHheMU8OjtfQAjgiobcJBMl2qYP8y69mELAJGE/R2uN
         Fqszy0FMxhewwMmPgjrEjNPBHqBuu/wuzI9YU/upPQcPCxzyFD8xijBB2OSXWx1TTnr1
         mDs+qFopodb2x+9cTnuXXJuJEIW7pLvV6fsq8=
X-Forwarded-Encrypted: i=1; AFNElJ/xHR+ke1EI+NuedS3GcrUUGf076BtQbxNk0GDpFXbvkDvhSzEqtFDUaZiUKI87rfrRDanmwFHFyZY=@vger.kernel.org
X-Received: by 2002:a05:6214:478c:b0:8ac:b402:9af1 with SMTP id 6a1803df08f44-8b02814c824mr349683036d6.47.1776891091672;
        Wed, 22 Apr 2026 13:51:31 -0700 (PDT)
X-Received: by 2002:a05:6214:478c:b0:8ac:b402:9af1 with SMTP id 6a1803df08f44-8b02814c824mr349682806d6.47.1776891091255;
        Wed, 22 Apr 2026 13:51:31 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae88d5fsm171453486d6.39.2026.04.22.13.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 13:51:30 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v5 1/4] mmc: core: Add panic-context host operations for pstore backends
Date: Wed, 22 Apr 2026 16:50:50 -0400
Message-Id: <20260422205053.3392395-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422205053.3392395-1-kamal.dasu@broadcom.com>
References: <20260422205053.3392395-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add three new optional callbacks to struct mmc_host_ops for panic-safe
MMC I/O:

  - panic_prepare: drain in-flight requests and prepare for polled I/O
  - panic_poll_completion: poll for request completion without interrupts
  - panic_complete: restore normal host state after panic I/O

Add mmc_panic_claim_host() which uses WRITE_ONCE() to claim the host
without taking the spin lock, since during panic other CPUs are stopped
and may hold the lock.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/core.c  | 54 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h | 12 +++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 29e80e5f928e..076bd4eb2878 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -861,6 +861,60 @@ void mmc_release_host(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_release_host);
 
+/**
+ *	mmc_panic_claim_host - force-claim a host in panic context
+ *	@host: mmc host to claim
+ *
+ *	Force-claims the MMC host without locking during kernel panic. Other CPUs
+ *	are stopped and may be holding mmc_host->lock (e.g. inside __mmc_claim_host
+ *	or mmc_release_host). Unlike sdhci_host->lock which is freed by the hardware
+ *	drain+reset, mmc_host->lock has no hardware counterpart, so we must bypass
+ *	it with WRITE_ONCE.
+ *
+ *	This function first checks the current host state (claimed/suspended/ongoing),
+ *	then calls panic_prepare() to let the controller driver safely drain any
+ *	in-flight hardware requests and handle runtime PM suspend state. After
+ *	panic_prepare() returns, the host is forcefully claimed for panic I/O.
+ */
+void mmc_panic_claim_host(struct mmc_host *host)
+{
+	bool claimed;
+	bool suspended;
+	struct mmc_request *ongoing;
+
+	if (!host)
+		return;
+
+	/* Check current state for visibility into what we're dealing with */
+	claimed = READ_ONCE(host->claimed);
+	suspended = pm_runtime_suspended(&host->class_dev);
+	ongoing = READ_ONCE(host->ongoing_mrq);
+
+	if (claimed || suspended || ongoing) {
+		pr_info("mmc_panic_claim: host state: claimed=%d suspended=%d ongoing_mrq=%p\n",
+			claimed, suspended, ongoing);
+	}
+
+	/* Always call panic_prepare to drain/reset hardware, regardless of claimed state.
+	 * This ensures the controller is in a safe state for panic I/O even if the
+	 * host was already claimed (which shouldn't happen, but we handle it safely).
+	 */
+	if (host->ops && host->ops->panic_prepare) {
+		int ret = host->ops->panic_prepare(host);
+
+		if (ret)
+			pr_warn("mmc_panic_claim: panic_prepare failed: %d\n", ret);
+	}
+
+	/* Force-claim the host. Safe because all other CPUs are stopped. */
+	WRITE_ONCE(host->claimed, 1);
+	host->claimer = &host->default_ctx;
+	host->claimer->task = current;
+	WRITE_ONCE(host->claim_cnt, 1);
+	WRITE_ONCE(host->ongoing_mrq, NULL);
+}
+EXPORT_SYMBOL(mmc_panic_claim_host);
+
 /*
  * This is a helper function, which fetches a runtime pm reference for the
  * card device and also claims the host.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba84f02c2a10..cd44b62d29cb 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -272,6 +272,16 @@ struct mmc_host_ops {
 	 * negative errno in case of a failure or zero for success.
 	 */
 	int	(*uhs2_control)(struct mmc_host *host, enum sd_uhs2_operation op);
+
+	/*
+	 * Optional panic-context ops for pstore backends that write to MMC
+	 * during kernel panic with interrupts disabled.
+	 */
+	int	(*panic_prepare)(struct mmc_host *host);
+	bool	(*panic_poll_completion)(struct mmc_host *host,
+					 struct mmc_request *mrq);
+	void	(*panic_complete)(struct mmc_host *host,
+				  struct mmc_request *mrq);
 };
 
 struct mmc_cqe_ops {
@@ -758,4 +768,6 @@ int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
 int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 int mmc_read_tuning(struct mmc_host *host, unsigned int blksz, unsigned int blocks);
 
+void mmc_panic_claim_host(struct mmc_host *host);
+
 #endif /* LINUX_MMC_HOST_H */
-- 
2.34.1

