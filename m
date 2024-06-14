Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFBF147C87
	for <linux-mmc@vger.kernel.org>; Fri, 14 Jun 2024 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352073; cv=none; b=ZUibkxumW2VakazZ8xAvt7T9PfR86tqe6fm01Zl81gj1Rvo15R4TVuCYFjaiExyQ/7w2dW1hVaKuME4qP0wFD0HKLLRk5LXafF4BzeM+C9IVLjloarVjaY/UrArXfGNKc80uzQqvbFT9spA9WMLdx6GvkqJAtZ73TPkA6vy4Y6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352073; c=relaxed/simple;
	bh=4CPqxbB3qJW4OBXvlhnyUXaPKHEJSzcrBKjnyBZzctA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bSTwunPyr7CJp0jyjyiinVyAuPDgu/+II1tR9x5I3IBgF/3m0mxjDRHtseJAJnKBijjhZiHGOlLR4E5ENwIFwIze3JCVSaJ8uTfyQyCNLgXT9h8tqYoEqAjTJMEPQrTv+hRfxTacUd1/KDdKr0BWyQDy1clWH4UqQJPzuy4JBk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bAmNfRyC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bAmNfRyC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718352072; x=1749888072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4CPqxbB3qJW4OBXvlhnyUXaPKHEJSzcrBKjnyBZzctA=;
  b=bAmNfRyCIkX+aAaXm1Gh1u6OuZTm7x/y05hWolWl6XuooG9VPSAkP1LJ
   MPvdrm78OEOy0hbauOiau7mXKUOD088vsdNvwRuUJv/0PLzonA6nEK71y
   +4/IiZkvBZZyZm3QKlDbrE9Q85XJ+YOTAb+dR2TcHb36PYxqLvHQjM0vi
   S9z4my4db3AoMERTLDUjKKmM6EmxfhWrJsq4KJDZFOm960GNr4FG01PAe
   NcRhPlEKclJ8TAcH8n27sf2+4FEUUkxMz36KOqxrcwuEnFgbkHQGXqQGH
   Oq4ArVAx8hmr+iMpsIAoWsS2kpKsQInsBF6cgGWmEbVpRR5F1eaS2HYSu
   g==;
X-CSE-ConnectionGUID: y1inR8UOQlW76W2jlTWXfg==
X-CSE-MsgGUID: 3BHTvy8rQtyy/5lV0NgH2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14962010"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="14962010"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:01:11 -0700
X-CSE-ConnectionGUID: MYF/tDZ5Q6yaRX9+aJqd2A==
X-CSE-MsgGUID: 2Co5IaMLR6e2qm283Y1dwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="45382875"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.248.10])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:01:10 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Subject: [PATCH 1/3] mmc: sdhci: Do not invert write-protect twice
Date: Fri, 14 Jun 2024 11:00:49 +0300
Message-Id: <20240614080051.4005-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614080051.4005-1-adrian.hunter@intel.com>
References: <20240614080051.4005-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

mmc_of_parse() reads device property "wp-inverted" and sets
MMC_CAP2_RO_ACTIVE_HIGH if it is true. MMC_CAP2_RO_ACTIVE_HIGH is used
to invert a write-protect (AKA read-only) GPIO value.

sdhci_get_property() also reads "wp-inverted" and sets
SDHCI_QUIRK_INVERTED_WRITE_PROTECT which is used to invert the
write-protect value as well but also acts upon a value read out from the
SDHCI_PRESENT_STATE register.

Many drivers call both mmc_of_parse() and sdhci_get_property(),
so that both MMC_CAP2_RO_ACTIVE_HIGH and
SDHCI_QUIRK_INVERTED_WRITE_PROTECT will be set if the controller has
device property "wp-inverted".

Amend the logic in sdhci_check_ro() to allow for that possibility,
so that the write-protect value is not inverted twice.

Also do not invert the value if it is a negative error value. Note that
callers treat an error the same as not-write-protected, so the result is
functionally the same in that case.

Also do not invert the value if sdhci host operation ->get_ro() is used.
None of the users of that callback set SDHCI_QUIRK_INVERTED_WRITE_PROTECT
directly or indirectly, but two do call mmc_gpio_get_ro(), so leave it to
them to deal with that if they ever set SDHCI_QUIRK_INVERTED_WRITE_PROTECT
in the future.

Fixes: 6d5cd068ee59 ("mmc: sdhci: use WP GPIO in sdhci_check_ro()")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 746f4cf7ab03..81b81d7bb3d8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2515,26 +2515,34 @@ EXPORT_SYMBOL_GPL(sdhci_get_cd_nogpio);
 
 static int sdhci_check_ro(struct sdhci_host *host)
 {
+	bool allow_invert = false;
 	unsigned long flags;
 	int is_readonly;
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	if (host->flags & SDHCI_DEVICE_DEAD)
+	if (host->flags & SDHCI_DEVICE_DEAD) {
 		is_readonly = 0;
-	else if (host->ops->get_ro)
+	} else if (host->ops->get_ro) {
 		is_readonly = host->ops->get_ro(host);
-	else if (mmc_can_gpio_ro(host->mmc))
+	} else if (mmc_can_gpio_ro(host->mmc)) {
 		is_readonly = mmc_gpio_get_ro(host->mmc);
-	else
+		/* Do not invert twice */
+		allow_invert = !(host->mmc->caps2 & MMC_CAP2_RO_ACTIVE_HIGH);
+	} else {
 		is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
 				& SDHCI_WRITE_PROTECT);
+		allow_invert = true;
+	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	/* This quirk needs to be replaced by a callback-function later */
-	return host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT ?
-		!is_readonly : is_readonly;
+	if (is_readonly >= 0 &&
+	    allow_invert &&
+	    (host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT))
+		is_readonly = !is_readonly;
+
+	return is_readonly;
 }
 
 #define SAMPLE_COUNT	5
-- 
2.34.1

