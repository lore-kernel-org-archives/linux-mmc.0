Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36515A85A;
	Fri,  1 Nov 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456092; cv=none; b=OP019hp77ojS6ReWPFenlPZzFRq1vzRtwlzfWbNJXyiaktxPuK/t0XZDnKdNCqcXQE/isrNqsDprFexPgQ+3yXdJBXljMHeq/jWyhaOjDPBOtg44PojdilCRLza3jIsQrXxNvpYgJWlf9GQNpNLb8YgSXnQxNQKyXvs0NkRJ7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456092; c=relaxed/simple;
	bh=6qxhurwg7wQQ0SVBWF79JClFB8oz8njwIY/xTqVlC6Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZ9uMNv4DOZqm3n1Kgd0g6w3UMesFhwSSXL84ycOsswmL2Fqxi0x3CDMn82xVpB3WMqwgzfOKWqFohS7bqlJNj7ClZXZGYrnLL4YGfN1fNuk/v93L0Mtd+kD4Gp75JQhT1AEArhkPsyuzY+4xYslrCq1X8+AjkbYYSdFdVLARwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPLNSxu+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPLNSxu+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730456090; x=1761992090;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=6qxhurwg7wQQ0SVBWF79JClFB8oz8njwIY/xTqVlC6Y=;
  b=TPLNSxu+ju4euZXHHAwYWknXkcEojYRC0EJQFFhnSliPJZdYaLZTOXtm
   UvLXJDTfkGnh5mG9UajY/pEqy81xWOaWp2buW1ESBvH8ZSGTJ/Ty+QWLw
   BcIrl91Nh0LxD3oaQ1ZA+XMF9C50W7hbuk5oGrlqIzXdFkwU0ECJSIf5M
   UujSU9fDOhcTafdGtracE3v37sSfpSfapf2BywKc27VN2bEwqPJ1hOJMN
   GQVgIFWjISUyuhPWMENdJJtRjwZDyjAqMpCvkOgoCNMI6qaSb0+52llvj
   s/kPU2w+kEOxNVpRtwsX2Vwh//TfWADd5Sz0inAIWEC5YCqQA3mb+Dm7S
   w==;
X-CSE-ConnectionGUID: bi3mt5f4TdeF1aXBo2TcWw==
X-CSE-MsgGUID: 1EbBQ+eRQ1OkjE0Vdl1zhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41319316"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41319316"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 03:14:48 -0700
X-CSE-ConnectionGUID: yBkLw6+DSU27Dv0cKy3V2Q==
X-CSE-MsgGUID: THeCa9/5Q26IXzgIGBEpWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83355129"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 01 Nov 2024 03:14:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B50B22AF; Fri, 01 Nov 2024 12:14:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] mmc: sdhci-acpi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Date: Fri,  1 Nov 2024 12:11:32 +0200
Message-ID: <20241101101441.3518612-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
and require an ifdeffery protection against unused function warnings.
The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
the compiler to see the functions, thus suppressing the warning. Thus
drop the ifdeffery protection.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index d1ce9193ece9..5241c5c26891 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -1006,8 +1006,6 @@ static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
 	}
 }
 
-#ifdef CONFIG_PM_SLEEP
-
 static int sdhci_acpi_suspend(struct device *dev)
 {
 	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
@@ -1034,10 +1032,6 @@ static int sdhci_acpi_resume(struct device *dev)
 	return sdhci_resume_host(c->host);
 }
 
-#endif
-
-#ifdef CONFIG_PM
-
 static int sdhci_acpi_runtime_suspend(struct device *dev)
 {
 	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
@@ -1064,12 +1058,9 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
 	return sdhci_runtime_resume_host(c->host, 0);
 }
 
-#endif
-
 static const struct dev_pm_ops sdhci_acpi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_acpi_suspend, sdhci_acpi_resume)
-	SET_RUNTIME_PM_OPS(sdhci_acpi_runtime_suspend,
-			sdhci_acpi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(sdhci_acpi_suspend, sdhci_acpi_resume)
+	RUNTIME_PM_OPS(sdhci_acpi_runtime_suspend, sdhci_acpi_runtime_resume, NULL)
 };
 
 static struct platform_driver sdhci_acpi_driver = {
@@ -1077,7 +1068,7 @@ static struct platform_driver sdhci_acpi_driver = {
 		.name			= "sdhci-acpi",
 		.probe_type		= PROBE_PREFER_ASYNCHRONOUS,
 		.acpi_match_table	= sdhci_acpi_ids,
-		.pm			= &sdhci_acpi_pm_ops,
+		.pm			= pm_ptr(&sdhci_acpi_pm_ops),
 	},
 	.probe	= sdhci_acpi_probe,
 	.remove = sdhci_acpi_remove,
-- 
2.43.0.rc1.1336.g36b5255a03ac

