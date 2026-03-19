Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FCC35A3A4
	for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946793; cv=none; b=TboWM3MTdp/9OUZZO9jhxhNjoHvKjfCv+PQTK6lYjtRasmSZjAS8vpYe8IDmFJ24B9nTJxrYl5l6VILL8Q3ldz4rjOWbUFberRqDR+qBs8WqVgOQMGNYnr9INlaPMQcVK7b/EX1IOrx8lm4BvMdMXqHuofUQ01ylj122ECpeN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946793; c=relaxed/simple;
	bh=qtVua69sP2G9xkMsjuSNOM/NL0Z1s1ViGHEt7N7dPys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rz2MO3EbpA5TQBFbDiH00GjtXRn400uDnnu7ydAljmrI2BNVhF7Cev209YKcGzjJHRraUX17zC3cw9Lue9AuJg3lFNMNy35fdDmAyz6r8N5Vk6oDe82B8tVjQOcP/OY4dWAmslyyOuVUCvjmXsDPZBeo5STvHXhXmq3mJMQyoMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gCl0G/n3; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gCl0G/n3"
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-50904a8f421so11525901cf.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 11:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773946791; x=1774551591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrhXx6wPTVD4bGLE4pIlNQPG1YgkwhB8X1TOJlLEBbo=;
        b=cJXAdiKqJAizYOt6KtagxtbN/Gk7BdMwgcASegNez1uaSX4QXAoeAqSJw+CVTT3Pnn
         PllSEsrgkwzPfA/4g5XHEwoHXYqXSh4esiwje8KucYFjiSpRVi5zAxxQTqbOgyulmwAy
         K2uW5C8jHVTXeOhs/xaKCvGPl9bBU89X7K2PuXeQP27fYKFMVGEgB7VmFm0/g+7gIfRI
         qNcGS619fHTJid6Zptjra7vgZVVXiIsx2uwmtep1UjSXiM010fuvjIN8INZwFvYHBat2
         K66GSe11lXqvnV/SiGOYO5OoC7RPgXPvEngPtFbBmTY5OwMio4wXBVUvnW8XgDjW9cCt
         AIIA==
X-Forwarded-Encrypted: i=1; AJvYcCXgnzGkSnH2fNFonS2b2ZNF1AcX6+l3wDrKfau/r7e//MPzGs1zRphtYQ1tBPRVgykohUXHZY8Q/DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY5WBBzVuiOjo+HUAjvKaZW1al9vaSCfZoxAFb3YAhTMh8n8FG
	njrLDeNAwJtpyzPfj+i5RxXQ9cPtUssWj7bNVC6ITdVxK+zSfUCoo+5m+mhk8x3bo1VDoR9Njov
	gLZ2aTc23ek5rK5DomI0DM4WkGVII3lz8pob16tEaQykBeaa94Wn+FTkxk29PQ/dJ5j7OzEhuEM
	OUmEu+gsJSphsyXy0c41tksoHoCee+Gpczh7PTmH/LoyE9Cz6sh1Lt1II5TJvjg+N5V6ZEmkqA2
	qf9m/Gr0ZQ5
X-Gm-Gg: ATEYQzxNpcQmojpyrcYHS0KhmME2ZW031G5S7jEGRuadrYnG/BHzK+p0L3DzeGPvzUS
	+gF1YJgMkPsHO4BEs+BJbOtuvE+3rURQJ7aeYrWpF9Lv12GYCaJTMSob8yQlW66Eg9gvz99FJ2W
	wrA3tXIdMVq6LLhZFY45meMdcHr4qHEIbvy4vIAW6dwVu+bq8iAI6kp1x+NeMQ+Goph2GiyrPV/
	i6vZbh/U6BUiAzE7CmHMjVh9smZ97ceRtrQ9d/CwmhEX9jJfLm+XRvII+v8D3dW9SW6ouzoNys4
	zGl0pgg5jtiIOsfpqGFkbSYC/mDjGf20MhTql2K6qNWivZTYXeAYpZApXYOoJPRuIuihMP+BCeH
	uPv4FyIKwDGwNJpwBGcKLYIpSJ5dZ2e3xDfMytdd3mesrgokrxIh1oeKBLwaZL6MZ0tPNu9ik79
	Kayu2BB7uDIsROVj8OQzABLLS6gL/w1M4+p3MrNiXZ81HsPQXB+3tOvFVy
X-Received: by 2002:a05:622a:11cc:b0:509:16ba:d537 with SMTP id d75a77b69052e-50b37447c3emr5255371cf.19.1773946790648;
        Thu, 19 Mar 2026 11:59:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50b36ce5231sm218081cf.2.2026.03.19.11.59.50
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 11:59:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12711ec96fbso40462117c88.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773946789; x=1774551589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrhXx6wPTVD4bGLE4pIlNQPG1YgkwhB8X1TOJlLEBbo=;
        b=gCl0G/n3bG19XScO4H+ctWV/S3DrGTjsBuciMrrjKfftYg68KSiD9DTGSb5RzwepNq
         FTfs7i93HmhwyTjWbu2qFYWwKJVB2KDYcCciogxSMEvUtAMFhbzIfC4sbI0eoXnNrLJY
         tD1K7PimT0sU1Y9z+b34y+QJPJj+HtHDCc4xs=
X-Forwarded-Encrypted: i=1; AJvYcCXfRAb6g9FrYfDHFmSVkTAFIJ3fkMYDbmJgOz9CcIv4l6NZKHZ8A0upqkDCJAqtgcKMf/zgLJRmJc0=@vger.kernel.org
X-Received: by 2002:a05:7300:8ca6:b0:2c1:778:d897 with SMTP id 5a478bee46e88-2c109752f8dmr241068eec.21.1773946789220;
        Thu, 19 Mar 2026 11:59:49 -0700 (PDT)
X-Received: by 2002:a05:7300:8ca6:b0:2c1:778:d897 with SMTP id 5a478bee46e88-2c109752f8dmr241048eec.21.1773946788522;
        Thu, 19 Mar 2026 11:59:48 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55834a0sm9607220eec.14.2026.03.19.11.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:59:48 -0700 (PDT)
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
Subject: [PATCH v3 1/4] mmc: core: Add panic-context host operations for pstore backends
Date: Thu, 19 Mar 2026 14:57:02 -0400
Message-Id: <20260319185705.1516950-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319185705.1516950-1-kamal.dasu@broadcom.com>
References: <20260319185705.1516950-1-kamal.dasu@broadcom.com>
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

