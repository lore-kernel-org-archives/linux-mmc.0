Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133F115B54A;
	Fri,  1 Nov 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456090; cv=none; b=mihxm5ra6QPIftoF9mPlBpJnqFP47AWjDfv0kvrxlbmRog93T78yYhKE9639/6GOuyoLLv12y/6Bw/NZYfBLKhXUpxkeHOk9J/5SP4WcHUzoHFX3lNGcq1w5A1jEFSpy283CKeSne5idTwT+Uhhx9t6QKSMMUXc/uO3cWzQytDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456090; c=relaxed/simple;
	bh=z0iIdso+J7LGPzcPMzboewHXIyjSWL2bxSuCGFnjYCw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pH6dAyfSM3znOaio6LDheqmmI80eg5UmBYhzTamgOk8vRaTWgYSygSnYMkDAt20zw+YhBeVgqqCFx+AQpixWb/uWwg9L9jHeDjqK5ASorYtBt/cEa5issR47HKB8CCy7JQ5T1F2cNbouBjTRs4vpA6fL+wcgkq+c1pMqzYlMjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmKs60/q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmKs60/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730456088; x=1761992088;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=z0iIdso+J7LGPzcPMzboewHXIyjSWL2bxSuCGFnjYCw=;
  b=hmKs60/q4AoeQJx7B6dpEI2yKful+cc2LByjrBV6QSY7FkQ1yGaVCSRP
   Erbiy9uRv/E73xRHvkLX1t9KlWrmS69fvCQYKB7vO3pXVibrnrco4jHQE
   b1usOhXLNaUNjTNRHFTYJ9q33tzFnOuw8QplKcwl2QQXD8IIwd2bNBMxk
   vnHKbcVIuD7lt5ZSabGzULsVEKyK/czjd2lIMGr0khnwJpCkWqxClkosr
   homhs9sYaj66o0hv0wYlJaQvq06I6WS20GcjGRtrV5p7jZMPf5f0CazqQ
   WkLlwPcvO2xGP5+ldDui/W5eAAMbYK5Yu7F2vQRDULqK5kDaDCSgclUu9
   g==;
X-CSE-ConnectionGUID: Hrim4uOUS9apWEXGLDBoYg==
X-CSE-MsgGUID: vCasybZERbqEZUwOo8Ip+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="41615776"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="41615776"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 03:14:48 -0700
X-CSE-ConnectionGUID: y6ilDAbzT2G4aKHGcKCVkQ==
X-CSE-MsgGUID: PAd6ENQsT02Uhn596ZAvZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83737449"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 01 Nov 2024 03:14:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CEA732D3; Fri, 01 Nov 2024 12:14:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] mmc: sdhci-acpi: Use devm_platform_ioremap_resource()
Date: Fri,  1 Nov 2024 12:11:34 +0200
Message-ID: <20241101101441.3518612-5-andriy.shevchenko@linux.intel.com>
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

The struct resource is not used for anything else, so we can simplify
the code a bit by using the helper function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index f861e9a3a911..8e265b53d7ce 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -822,8 +822,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	struct acpi_device *device;
 	struct sdhci_acpi_host *c;
 	struct sdhci_host *host;
-	struct resource *iomem;
-	resource_size_t len;
 	size_t priv_size;
 	int quirks = 0;
 	int err;
@@ -844,14 +842,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (sdhci_acpi_byt_defer(dev))
 		return -EPROBE_DEFER;
 
-	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iomem)
-		return -ENOMEM;
-
-	len = resource_size(iomem);
-	if (!devm_request_mem_region(dev, iomem->start, len, dev_name(dev)))
-		return -ENOMEM;
-
 	priv_size = slot ? slot->priv_size : 0;
 	host = sdhci_alloc_host(dev, sizeof(struct sdhci_acpi_host) + priv_size);
 	if (IS_ERR(host))
@@ -873,10 +863,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
-	host->ioaddr = devm_ioremap(dev, iomem->start,
-					    resource_size(iomem));
-	if (host->ioaddr == NULL) {
-		err = -ENOMEM;
+	host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(host->ioaddr)) {
+		err = PTR_ERR(host->ioaddr);
 		goto err_free;
 	}
 
-- 
2.43.0.rc1.1336.g36b5255a03ac

