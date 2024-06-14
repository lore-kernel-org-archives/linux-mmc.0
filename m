Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36331494DE
	for <linux-mmc@vger.kernel.org>; Fri, 14 Jun 2024 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352072; cv=none; b=dQ+lO/llkRUxmSgwABCoYpRSajU6xTu6vye0mtRbrzErkjZxXGgRPDNjVPaByLuCRmf+kZNIMbto0735q3RTvqM5wkM8RFSxRZjt4uu/YN4cjUJrgmr091gXNdmLMNL+oTUm8PLwTkRm4lqI6oZJTzpwr9Bhu2JTAz7q4sX5qfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352072; c=relaxed/simple;
	bh=Bf7MglloFeVYrQSvzT/J3OdZFypAEtYpro+g8b+R6J8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HZkVJud8O5bKP4RMmd4SLzzbU+x+DKdbaUCo0o/+NefgHJLf65cxJRJfiK7+YQTf/mo8fezvuS39ngovNhfV6AdOVQBc874GQiqCjHNXox5dTHb+qgyBwr2ms8Yx1gvuHBkTbOrGwVN8wV4XK6IOn1xYCZz6MRZ+0Q76SUaXeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1vvPIvE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1vvPIvE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718352071; x=1749888071;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bf7MglloFeVYrQSvzT/J3OdZFypAEtYpro+g8b+R6J8=;
  b=l1vvPIvEj4TcJ55Q3Loi2MKjiiBQx9S/ZrJ11EFsLYWi3xJc51Cu7+hX
   TQtxv9orY5kmwbJOulifELtppJHVzsoyrYnFYJzizS4fQZfDJEwimBinW
   ygbc6qF+udxwDuRd93X0gFCLeX0KFniiPe+TB6JRn/KmQrc61Pg5AIlXl
   nndz3IB34+qqHLzdV3YELOcielOCbFTEFKieKK7VhXC2vZM62rQWw1LqY
   TNNuBxBaWwly0QPrT4Ri0WyXeHKiC3uvyXxIoI3zgI/qkrEGZXo/sKPPl
   29lgxd6ZS6dv3zKfehEJnn/RtR7jtKN/dDkJYAdylR3piIy+hpN6QkORm
   Q==;
X-CSE-ConnectionGUID: lw7c7TtvQ6Ka6ewdExsUvA==
X-CSE-MsgGUID: Yvsv3BCrQOuj6wfUN9QvUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14962008"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="14962008"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:01:10 -0700
X-CSE-ConnectionGUID: QQ7TT739Rg2xjYD++qFpMQ==
X-CSE-MsgGUID: //1kSkVwSje/fOrmPD1F0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="45382869"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.248.10])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:01:08 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Subject: [PATCH 0/3] mmc: sdhci: Tidy-up write-protect handling
Date: Fri, 14 Jun 2024 11:00:48 +0300
Message-Id: <20240614080051.4005-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

There seemed to be some issues with sdhci write-protect handling,
although no reports of them actually being hit.  Here are 3 little
patches to tidy things up a bit.


Adrian Hunter (3):
      mmc: sdhci: Do not invert write-protect twice
      mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro()
      mmc: sdhci: Eliminate SDHCI_QUIRK_UNSTABLE_RO_DETECT

 drivers/mmc/host/sdhci-pci-core.c | 27 ++++++++++++++++----
 drivers/mmc/host/sdhci.c          | 54 ++++++++++++++-------------------------
 drivers/mmc/host/sdhci.h          |  3 +--
 3 files changed, 42 insertions(+), 42 deletions(-)


Regards
Adrian
