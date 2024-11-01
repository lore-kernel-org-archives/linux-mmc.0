Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BE015CD79;
	Fri,  1 Nov 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456091; cv=none; b=auS8CXOvgfPo7ocJwJDX86H4410bCbGmzFAmKU4q1vP6YIavZ02hMJzHdoWQVeF6pvouRrGYLBLPJEMKJP6IrVeekcnFiuFVlVq6XBUlbvrwcRHvXrLpF8xZEZVMPut3lscTj91+72yDm/YlUaZCUtcNxeCOu/LAMdFwCbSLato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456091; c=relaxed/simple;
	bh=/Ry/rhneHzO67eKiUEYUc3v+cRjG9wMg1M/PNgw3zNc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a33MVxgU7olDncbexBDFp42G93gJu5KVOo1Lf7OD282Kjrk6+JfvKpe1P1WE+c0fnil2cYBatsZ0dEzU8gtrP5JgBVWxMC51bwzASnhF77bQsvHjf+cLWR9kx7TqrcUv8tXfkNmXBue6A6boG3dCNOtYUMLKG/npEkLHGrtLjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHRPErHd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHRPErHd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730456090; x=1761992090;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/Ry/rhneHzO67eKiUEYUc3v+cRjG9wMg1M/PNgw3zNc=;
  b=cHRPErHdawnAeDrgzDtguh7scC4itiKmjjl0aRdtV5USeeuv8Zyipr2c
   HqYN1v7xAJJoUrJiapFO3EepYxtpO2R1jGhQqE66fGXK9wBRRi58KUHDp
   UR2LWQHVtCn0AOtlFmNdpxW75ek6AIgkRXx2zBAUZjF2rfIGAhWmOiuNF
   0iBFxvRv/++FHOze98/p/EC1iKQZfXR/thWUDg8uvD6pDEJzgkKnqTfpy
   wzOVvVrU8pXOLhAuv7/+KisOcQu1ozuOPVlHgZlU8Z/eTaGmxGjVX8dKR
   x9gos2LkpuPVy4xXHuTnaShHPs5nNRFUwcIs8qCVP+h2qa9bpfhgy+Ye4
   A==;
X-CSE-ConnectionGUID: j5GJ8EbnTFq4xZ1CcK002g==
X-CSE-MsgGUID: 2ixBuG6LTpaWKxK23+pg+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="41615773"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="41615773"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 03:14:48 -0700
X-CSE-ConnectionGUID: uTNBC3DbQxCHRDzZ8rlY4A==
X-CSE-MsgGUID: nuzI/wSPRHmn56OjpgPZJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83737447"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 01 Nov 2024 03:14:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C8AA0357; Fri, 01 Nov 2024 12:14:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] mmc: sdhci-acpi: Remove not so useful error message
Date: Fri,  1 Nov 2024 12:11:33 +0200
Message-ID: <20241101101441.3518612-4-andriy.shevchenko@linux.intel.com>
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

First of all, this error message is just informative and doesn't prevent
driver from going on. Second, the ioremap() on many architectures just
works on page size granularity, which is higher than 256 bytes. Last,
but not lease, this is an impediment for furhter cleanups, hence remove
it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 5241c5c26891..f861e9a3a911 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -849,9 +849,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	len = resource_size(iomem);
-	if (len < 0x100)
-		dev_err(dev, "Invalid iomem size!\n");
-
 	if (!devm_request_mem_region(dev, iomem->start, len, dev_name(dev)))
 		return -ENOMEM;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac

