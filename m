Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="CZVrPPHF"
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385D9FE
	for <linux-mmc@vger.kernel.org>; Mon,  4 Dec 2023 09:22:49 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40bda47c489so27144255e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 04 Dec 2023 09:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701710568; x=1702315368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kejOp9HsUmKb2Fyg4pxUOoVogVQGrKdzlwKp1qf6raE=;
        b=CZVrPPHFDdh3EVxO7zoTwkEd0K1NCu5dHnWTNKNSteqIvjJtV4ks7IeeHQsANGlRfA
         MjRRwTgPU8ZNPLu4/l18Xld8nWEk/mYxraD9++u2g7KzastEmFANeQ3nthSuUoBdQSGS
         6ccpr+49O6WpXYq5vJLD5JhMtfK+mmEkvJKEYlfAp5YtQ1l5GNr/izulwACQ+iJe6Qql
         ySx7DZvedcKGO2+wgEZ+VGMatT9VJvOmIvPSHq8QO9CHSmYTihGinBVcVBrGQ2O72QkW
         u5L0J7zFsqoMIJXQ+tT/TCkJWx8AMPTsXy7tOwfOsWsPMWdupONoJp+Ei5VvX2tU54GX
         GQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710568; x=1702315368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kejOp9HsUmKb2Fyg4pxUOoVogVQGrKdzlwKp1qf6raE=;
        b=o0AN/IylEHGTttGi4+B+lIz2uWxNnvt/5kjwLtqulHTU3+tqg3ExZEL2yt+L/WU0ga
         05IVA6PTIDFQCxKa7f82BzJYGcP16NhiLwqvou69WJJBky0f8FCLU8dvMnFes2xpbyRm
         XLLCQvcWlvF1Vwe+5T6UPCVU2rhjQbzPD9Qe5O/dSWVfMbn9QqFx0n5DaCk5723OvmyN
         wBMYuT/96gKRNRXKQdyDzXWPG1JjorqHzmyiO2cf3n8N49lldsiEpe5jP6pTxrwkCOFW
         cYfqqshk9gXENf9NJpIIriCgPe+2qZEi7D3wdNU80FmBpil4ZcGQTuNUPog+sM7DkQw/
         zCRQ==
X-Gm-Message-State: AOJu0YyENyvr6s6oR5S/b8MPmvVOAbPkxSPTM7eSictKa2L/N6f2hPOT
	2pJVaKjCgnjGZuY5R9g6XYCsbw==
X-Google-Smtp-Source: AGHT+IGMuQVV0cAIwEJ+sy2ZvuNt9ylDSo6Yq8nKLvASV7aHN9hZwQfRkMuEDdmnyprEAafKuNKKRg==
X-Received: by 2002:a05:600c:2301:b0:40b:5e59:c574 with SMTP id 1-20020a05600c230100b0040b5e59c574mr2704791wmo.158.1701710567535;
        Mon, 04 Dec 2023 09:22:47 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm19413454wmq.39.2023.12.04.09.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:22:47 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: jorge@foundries.io,
	Avri.Altman@wdc.com,
	adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	christian.loehle@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Date: Mon,  4 Dec 2023 18:22:43 +0100
Message-Id: <20231204172243.3382495-1-jorge@foundries.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Requesting a retune before switching to the RPMB partition has been
observed to cause CRC errors on the RPMB reads (-EILSEQ).

Since RPMB reads can not be retried, the clients would be directly
affected by the errors.

This commit disables the request prior to RPMB switching while allowing
the pause interface to still request a retune before the pause for other
use cases.

This was verified with the sdhci-of-arasan driver (ZynqMP) configured
for HS200 using two separate eMMC cards (DG4064 and 064GB2). In both
cases, the error was easy to reproduce triggering every few tenths of
reads.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
Acked-by: Avri Altman <avri.altman@wdc.com>

---
 drivers/mmc/core/block.c | 2 +-
 drivers/mmc/core/host.c  | 7 ++++---
 drivers/mmc/core/host.h  | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index f9a5cffa64b1..1d69078ad9b2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -859,7 +859,7 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 			if (ret)
 				return ret;
 		}
-		mmc_retune_pause(card->host);
+		mmc_retune_pause(card->host, false);
 	}

 	return ret;
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 096093f7be00..a9b95aaa2235 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -119,13 +119,14 @@ void mmc_retune_enable(struct mmc_host *host)

 /*
  * Pause re-tuning for a small set of operations.  The pause begins after the
- * next command and after first doing re-tuning.
+ * next command and, if retune is set, after first doing re-tuning.
  */
-void mmc_retune_pause(struct mmc_host *host)
+void mmc_retune_pause(struct mmc_host *host, bool retune)
 {
 	if (!host->retune_paused) {
 		host->retune_paused = 1;
-		mmc_retune_needed(host);
+		if (retune)
+			mmc_retune_needed(host);
 		mmc_retune_hold(host);
 	}
 }
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 48c4952512a5..321776b52270 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -18,7 +18,7 @@ void mmc_retune_disable(struct mmc_host *host);
 void mmc_retune_hold(struct mmc_host *host);
 void mmc_retune_release(struct mmc_host *host);
 int mmc_retune(struct mmc_host *host);
-void mmc_retune_pause(struct mmc_host *host);
+void mmc_retune_pause(struct mmc_host *host, bool retune);
 void mmc_retune_unpause(struct mmc_host *host);

 static inline void mmc_retune_clear(struct mmc_host *host)
--
2.34.1
