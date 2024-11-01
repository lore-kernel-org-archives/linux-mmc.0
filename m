Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D3315B547;
	Fri,  1 Nov 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456089; cv=none; b=DZF97tCbrET41btzQKAQeTfmeSYwVbLEwvu6Vk/T5OgJhNiSkjAd/AwOaSz8IAvBa1PkYGqoFOkx7Lr8NgSvtt6QQDwQnfuEMAbo9UsQtbnCGeqQv8HU9ke7PgKlJubr3ENIr8lh00AAlEo6Mvt8NXuf5sKopD59PaqqJTAJP2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456089; c=relaxed/simple;
	bh=gOtRUzBBjAMr9lOHwIInIW2ETDv9377pSLdr5cMAv5w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sd1dZ+Acm474J4+PjzcpY8wSrmikOn7mJTVV0AghSGGgNSpvAZBIeWaWW0PV5HfOJrvlR/YJ9TcCVTc6GUsKpejWE1csUAjPEkdSokweImhRXUNgAOcx5w/L4PqljElGKgb8Uh9ckY2VSA5O4B31Ydi6xHJ2rhe2ApKFNiIQJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dv4IthZw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dv4IthZw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730456088; x=1761992088;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gOtRUzBBjAMr9lOHwIInIW2ETDv9377pSLdr5cMAv5w=;
  b=Dv4IthZwzNAA27FrK7/hGaQr+exU8sP2ccSkI6A520qockOioW5FPKnz
   a6LgUD/93wyFI3Snk6AUgFD2fDulDTIzNAojwD73DTgLFE08lSMbJiNH0
   jjX+T8mBh3N32PXI7vk9m/yrQNavWMKPBXbz0rihB2s+KlXzlDSC2oT9v
   cXFiH2+jBpCh/WvoUE071LjbHnFK7U7Xem0gkD5Zbv6DU5kPdAmdATqdt
   bmyjJ0/nMIFd9tRVZP2DYqfS4L7+fkIdTGVNNlCDkx/YCvCN0EvnZndgh
   Awy1YouQJbK66sFBA/p7QvQVNt3XuBs5+6DUs58WDt0LnI0OCjC0mwSWE
   g==;
X-CSE-ConnectionGUID: nTTElTwITbSc/l6HBGYDyA==
X-CSE-MsgGUID: XuvQY5RcQga9f0OGjAUInA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41319313"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41319313"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 03:14:47 -0700
X-CSE-ConnectionGUID: XVbt0zTgSXSSSlG3/lY1Ww==
X-CSE-MsgGUID: WX/ctoxkSIOz+T7XPQn24Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83355127"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 01 Nov 2024 03:14:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9D3741AC; Fri, 01 Nov 2024 12:14:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] mmc: sdhci-acpi: A few cleanups
Date: Fri,  1 Nov 2024 12:11:30 +0200
Message-ID: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few almost independent cleanups for the driver because of
new available APIs.

In v2:
- added patch 1 to solve compilation error (LKP)
- split patch 3 out of (previous version of) patch 4 (Christophe)
- added patches 5 and 6

Andy Shevchenko (6):
  mmc: sdhci: Use EXPORT_PM_FN_NS_GPL() for exporting PM functions
  mmc: sdhci-acpi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and
    pm_ptr()
  mmc: sdhci-acpi: Remove not so useful error message
  mmc: sdhci-acpi: Use devm_platform_ioremap_resource()
  mmc: sdhci-acpi: Tidy up ACPI ID table
  mmc: sdhci-acpi: Don't use "proxy" headers

 drivers/mmc/host/sdhci-acpi.c | 92 ++++++++++++++---------------------
 drivers/mmc/host/sdhci.c      | 14 ++----
 drivers/mmc/host/sdhci.h      |  2 -
 3 files changed, 40 insertions(+), 68 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac

