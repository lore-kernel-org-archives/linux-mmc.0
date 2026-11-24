Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545003;
	b=Niz8nu8xDQv6nlOInyTIHgFNJqAWa7UxN7WWaJm0n5HOiBZz91QzncAgXqjqA5otEgbD
	 t1GkLwfa49wDEUfkHwqNW7N7Q06N0JuLAd9RhYmfevXXT3UYbbvFngm+YGs+iedmGnExc
	 VVUEHIBAxkGyZqYMM2Zv7nWoXSWAvmRbHlNEIS2iRHSzR132MEBhl30+4flawZIu+Uhte
	 nSVfllNABvNk8hVq3eIkhdqcz0Chpg0qt8uhvuE9u57l1mk04YeeLV45XssBw+u4ku3R2
	 6o5QACKn2jMXEzCVLgSBteCe9HlcTds51483STO6Pa4GtTCzOv41hiL0N9hOvtsOTiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=lrwfQJcwFhFffOygVO/MIPK8atOxj4tdwaWQGKK21rQ=;
	b=njNofuoZHcb6YjPhxpqRNFQZ1PvW7XcY3NBfRXAMBDUX5RNAH5BJpG9wFRSTDAOW2CQW
	 yhdsvYuXCaz+v6hmpDEViqwNH8cuzDx8IVLwagI2HBbunHHwTrm2Sns45auYZpVZsNuSo
	 4qaiC7Fwqnj8rHa4wvXpfaVxYIEn0Dotowvbv9SJFBzmXkUkmt+2kZA86D4UIOS5eCrDj
	 LhsxS3Y/AsUtWMq4mfbGrhfFeI5MNzDe+FET0YGzfsz9JoVeWOkQv4DnbJgCmXMBAY5wm
	 1lZxiMOIGztMVULIotMATVrb9ej7ZbHVoNZWyGf/lC+ttjqLdqisaL3Co27iAMEJHhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=go7z79EE;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE26606A333
	for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 18:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCE26606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=go7z79EE
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-38531c1a566so4435884eec.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 10:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795545002; x=1796149802; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lrwfQJcwFhFffOygVO/MIPK8atOxj4tdwaWQGKK21rQ=;
        b=go7z79EEMwM8DcKxyu1rcawcR9gem2qglmb/EX8DKunyp/71HLowR54WVpZIsq3lRt
         x2spNPZjMIY4tmnDH7C5G1ilTKVQ/UoVrrSLgZ4gBjDWlKIjieYMFKurYhSq/aWEUG4l
         o+nMR97UarPCQ+DqFa4dG49AJZYoJ/rWMUJSxuG3yUaeYIe7+6vm0j0Om62zSc+HGAnZ
         hut+4iI6cwvGeZaxb00WGO45t47JHg/X/CZmMCaO9COHfE3gFcszc0MG9WQTAErpwD9S
         nSMV6J0KwL9BOvEgZchHljB/LeCFrhbj6df3ou/Fc3M5kwPEPYvoJF04O0dqdPa27Fzu
         5+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795545002; x=1796149802;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lrwfQJcwFhFffOygVO/MIPK8atOxj4tdwaWQGKK21rQ=;
        b=oycyG2aDquOMBX5fHzzZE2UJtC9iqoD90vS44ESlPe8EpXWioOomSFgG2u/l6Q0Tg/
         esIgSyrYnccJDCbPkOMMSm1XGt9E/wnZLoepYG/RPlTJpuK+AKGZHVLMYXjgnI+sLobg
         cCmN1Ga6kNoqYo4kkjlfE5snVZLUO/AgMRbaW/S1yuT8EtSJflzJSzUKDIL7gXy3ZjER
         /na+dkHaOnMrwp5vc7FitFo8ejyBeJLiF77GQRUepn+WvRkROF434evKxdrLp9Y2gpCA
         lPGd23pWX9Kwtt/ZXnI/58INbAmPuDAI0bdV3PcAHivWgftouAsNucghkwU8uL4u+YoF
         UgVw==
X-Forwarded-Encrypted: i=1; AL+hErGBP/O0y65V0AnfjtTCm0LeNzCPRUGk1SQlc/raJa6P3fdj7qNdCtq0E0fFGvhW/c6hSjYnTXsp6Zk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jOslYAcMI8MlNukEv1PRhjcB5XWK8SL1LAA0eTnYfZyscQKS5
	EIaDZh8o6PXW50CSMZ0Vpkr6JEc0A7TM2pCkHpCVZ3IuizLCDyAPH4+/v7c3GFERx6ARn6fTl7p
	klzD0x5e7heLS4A==
X-Received: from dybnj14.prod.google.com ([2002:a05:7300:d08e:b0:381:f292:18e4])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:4710:b0:378:314:4042 with SMTP id 5a478bee46e88-385702587c5mr14762927eec.14.1795545000942;
 Tue, 24 Nov 2026 10:30:00 -0800 (PST)
Date: Tue, 24 Nov 2026 10:29:14 -0800
In-Reply-To: <20261124182911.3886897-5-wusamuel@google.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124182911.3886897-5-wusamuel@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124182911.3886897-8-wusamuel@google.com>
Subject: [PATCH 3/3] mmc: sdio: avoid waking idle host on keep-power suspend/resume
From: Samuel Wu <wusamuel@google.com>
To: Ulf Hansson <ulfh@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ben Dooks <ben-linux@fluff.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mmc_sdio_suspend() and mmc_sdio_resume() always claim the host, which
runtime-resumes it. If the card keeps power, uses no SDIO IRQs, and
nobody holds the host, neither function does bus I/O, so an idle host is
woken for nothing.

Skip the host claim in that case, saving cycles and reducing suspend and
resume latency.

Comparing with and without this patch on a Pixel Watch 4:
  - mmc1 suspend + resume: 11.59 ms -> 0.01 ms
  - sdhci suspend: 3.75 ms -> 0.002 ms
  - dpm_suspend median: 38.79 ms -> 32.51 ms

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 drivers/mmc/core/sdio.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 83c785ae677a..99368eb230a3 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -7,6 +7,7 @@
 
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
+#include <linux/spinlock.h>
 #include <linux/sysfs.h>
 
 #include <linux/mmc/host.h>
@@ -1048,18 +1049,41 @@ static int mmc_sdio_pre_suspend(struct mmc_host *host)
 	return 0;
 }
 
+/*
+ * The host must be claimed for SDIO suspend/resume unless the card keeps
+ * power, uses no SDIO IRQs and nobody holds the host. In that case no bus
+ * I/O is needed, so skip the claim to avoid waking a runtime-suspended host.
+ *
+ * If somebody holds the host, claim it to wait for them, as before. A claim
+ * taken after this check is not waited for, same as a claim taken after
+ * mmc_release_host() before.
+ */
+static bool mmc_sdio_need_claim_host(struct mmc_host *host)
+{
+	if (!mmc_card_keep_power(host) || mmc_card_wake_sdio_irq(host) ||
+	    host->sdio_irqs)
+		return true;
+
+	guard(spinlock_irqsave)(&host->lock);
+	return host->claimed;
+}
+
 /*
  * SDIO suspend.  Suspend all functions separately.
  */
 static int mmc_sdio_suspend(struct mmc_host *host)
 {
+	bool need_claim;
+
 	WARN_ON(host->sdio_irqs && !mmc_card_keep_power(host));
 
 	/* Prevent processing of SDIO IRQs in suspended state. */
 	mmc_card_set_suspended(host->card);
 	cancel_work_sync(&host->sdio_irq_work);
 
-	mmc_claim_host(host);
+	need_claim = mmc_sdio_need_claim_host(host);
+	if (need_claim)
+		mmc_claim_host(host);
 
 	if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host))
 		sdio_disable_4bit_bus(host->card);
@@ -1071,17 +1095,20 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 		mmc_retune_needed(host);
 	}
 
-	mmc_release_host(host);
+	if (need_claim)
+		mmc_release_host(host);
 
 	return 0;
 }
 
 static int mmc_sdio_resume(struct mmc_host *host)
 {
+	bool need_claim = mmc_sdio_need_claim_host(host);
 	int err = 0;
 
 	/* Basic card reinitialization. */
-	mmc_claim_host(host);
+	if (need_claim)
+		mmc_claim_host(host);
 
 	/*
 	 * Restore power and reinitialize the card when needed. Note that a
@@ -1127,7 +1154,8 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	}
 
 out:
-	mmc_release_host(host);
+	if (need_claim)
+		mmc_release_host(host);
 
 	host->pm_flags &= ~MMC_PM_KEEP_POWER;
 	return err;
-- 
2.56.1.831.g720f3f5937-goog

