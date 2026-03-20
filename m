Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B38359A6B
	for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038827; cv=none; b=rOR9bDqC2aZ1lS5TmDjVdG8FMQf5kyj6B7dw7m7BkVjtyWX+zQmm2hI+/CAD5cxUS4xBKUcm1Qyv16Lg99f1z5iKs0WwphSUCB/0VPkN4MsRuUQA3wqALa3+zdDS8X/pFCMPCGhcRduIWUM77HBy1WoZvBtKdDHugIBjEzbWRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038827; c=relaxed/simple;
	bh=qtVua69sP2G9xkMsjuSNOM/NL0Z1s1ViGHEt7N7dPys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pnr9el3xVf30hanjicIbXTE5eF9M4MUas2gtaQevx78sBpNitPfJ8d2LaelqSvkbS6oIZOdQMenzRYRaOWEnQfGoDpZ2LRoong3vsWtiM/a/f6HYEyiBd8EjUJ6Gc5qScL6tYQmuyDpPY8GbtoxNUpWLKwAy7cMVRpJgyGhP+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F/Fpy8E3; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F/Fpy8E3"
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-64ad019bbd4so995098d50.0
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 13:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774038825; x=1774643625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrhXx6wPTVD4bGLE4pIlNQPG1YgkwhB8X1TOJlLEBbo=;
        b=WLGgcMA4whwzDGMT2gePxx/U8fI2lFo0BfJrl9Vly+S47GSZpwgCeOROmC0qIq5qC8
         AUYx4wECX+FvXuO3pl52wNU9hbmK0tHRlqxFqRCO3yXvJjd2vi0WdunDuJtEgJw/cQKo
         /D0Y0rNciPUFG2nhVAxu0lWtxZwoK+aX4tfyUXuQbGu2whBEkCMpHHODpY2FVpR/RkBY
         S6zhzEiWT/tqhMo6bm4oN2tVCP275aIhI5XZ+i8zVT3qJLyaPel+oYBm23WJoYIPRMCH
         O2BDqII9wJjUqIYjt53ryiwlJpx8CO4HI13t4zmv3Yihrnc9k2TnC77mL8qW16oaXbAk
         wknw==
X-Forwarded-Encrypted: i=1; AJvYcCVv3ZPSbBB38Zd49zr2EUmgizhI6kS8i5u+R6wSckG1INCBlWyuNZ5318G9joW8iKbveYBEXO8OGJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9Dc3TBgAp5SRRNBeZNTDgZyhTkwC068zA9ExeyYfPTQXLVcH
	XDpnqcMB/Ehw+c8yoVdjKt7njjB2A3ZsriWxRBETEgr8zh1uSExhXVIarJI+qZFkdrRwIBvUjQ0
	JKFxacRXBKxe1Xe2Xu6C6hsYY7k2NsC7lEv8jsncf7yCmH/sakB4dM/hmmtDECw0Qk/QiEnCg7g
	L8dAMsxoZqn2MyTNsCwt6C9XMTwlKuLU/FM1hnhBtWbbzKmlXgs4m2jj00iosa+iufv1yMQA7e4
	YaCAK7+JxLq
X-Gm-Gg: ATEYQzwY1cySP46DoD4wa95iOPNhuC5cSOrYHWSjbkMKeEUgJXECWwO/Y0ZZynUnMmW
	irkGeC/tQGS2rr5y16EFrDd/BtSUYAyfDeETAlXhCbOz4d2EG6DBURQL13KAYUu0Lar34POGY5/
	R7z/swgy5luIIxykukxwR0rG5/PhIhBX/DftOpfv6yJyuqegXntXLjGJVo3BmAh34FHwnEjzgv8
	kFa//m3CQo4Hc/6665PpyV9CSWXnESo1VamEtXDCAAZMT39UksGqJw31dHO9Gq75tm0ReGwsCFj
	r6FGQT2mbvx8ABFWgvpEGu58ghteXC3J1+XppS2g161SSRoxFI8i4uCgaLcIYW9RKCdjbpD67Vz
	vy7lfors+ry3S5MimT+LZaeLx+rdE+JUxCOJgTUSk9irMjIfTuvKnoK9sQyBtfGHxizSGonaYDv
	yBilh9kXpslVwrxLNo+5z0VNDMyEzOe6He4wpvrQPEwtU7AcFPXG/py6Bn
X-Received: by 2002:a53:c706:0:b0:64c:9f87:ffca with SMTP id 956f58d0204a3-64eaa77f0a9mr3138843d50.38.1774038825154;
        Fri, 20 Mar 2026 13:33:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64eabbf8ba1sm296296d50.0.2026.03.20.13.33.44
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 13:33:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cfc5294894so880251785a.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 13:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774038824; x=1774643624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrhXx6wPTVD4bGLE4pIlNQPG1YgkwhB8X1TOJlLEBbo=;
        b=F/Fpy8E37/t6FoTQpPZFFPhtdHsFuCqx7d3MbnZIsUA6hq2dz2BFRrUOx2ysqde6py
         9JyVvegu0TOHbZnDXrZekSmlYB7iIyFztvNcsNyrL+GC34CfmvsXI4yFXdtM9B+8RLxW
         4vxP2XHo4Cv8rSAmAhhzn5pNHVW3jdd+MvRS4=
X-Forwarded-Encrypted: i=1; AJvYcCUu7L+eNcJJzeRl0V9TqKkfRy3ZxM+vUJTKYnXxLnvckfkrUHoScc5JBLJk5nV53xIMZ09A1tsAWZA=@vger.kernel.org
X-Received: by 2002:a05:620a:29d0:b0:8cf:c4d7:dfa with SMTP id af79cd13be357-8cfc7e65890mr675353985a.16.1774038824482;
        Fri, 20 Mar 2026 13:33:44 -0700 (PDT)
X-Received: by 2002:a05:620a:29d0:b0:8cf:c4d7:dfa with SMTP id af79cd13be357-8cfc7e65890mr675349885a.16.1774038823976;
        Fri, 20 Mar 2026 13:33:43 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8fb9c10sm280699985a.19.2026.03.20.13.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 13:33:43 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kees Cook <kees@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v4 1/4] mmc: core: Add panic-context host operations for pstore backends
Date: Fri, 20 Mar 2026 16:32:46 -0400
Message-Id: <20260320203249.1965044-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320203249.1965044-1-kamal.dasu@broadcom.com>
References: <20260320203249.1965044-1-kamal.dasu@broadcom.com>
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
 drivers/mmc/core/core.c  | 23 +++++++++++++++++++++++
 include/linux/mmc/host.h | 12 ++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 860378bea557..5326b246b4f2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -860,6 +860,29 @@ void mmc_release_host(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_release_host);
 
+/**
+ *	mmc_panic_claim_host - force-claim a host in panic context
+ *	@host: mmc host to claim
+ *
+ *	Force-claims the MMC host without locking. During kernel panic
+ *	other CPUs are stopped and may be holding mmc_host->lock (e.g.
+ *	inside __mmc_claim_host or mmc_release_host). Unlike sdhci_host->lock
+ *	which is freed by the hardware drain+reset, mmc_host->lock has no
+ *	hardware counterpart, so we must bypass it with WRITE_ONCE.
+ */
+void mmc_panic_claim_host(struct mmc_host *host)
+{
+	if (!host)
+		return;
+
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

