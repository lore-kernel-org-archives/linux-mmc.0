Received: from mail-m49212.qiye.163.com (mail-m49212.qiye.163.com [45.254.49.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575318B0F;
	Fri, 23 Jan 2026 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170592; cv=none; b=uHz3bm3uPWhLaDBQOJ1PMZMmR5Z16Cj+sw7c+vnEQl7BJaBeXkU3KNJF9i2cjubXarXGwHkqRTMFyBK219Grp8CMKnEuDjCR08NLuKRkgYMJA1bOHKTW/1HI/HWKgPoLIG+fY/9ZE+wgJS/ipGvjtv8l57dnfpXNkGdsBcWkJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170592; c=relaxed/simple;
	bh=5b+EqFVBinWJKb0EnQmnHGSfuLFUwA5RDPzOHE/pCAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZF+0bLSaAdAxxAix39qJOM3q3oD63R2ewDqjGllbEuTu/c0Y78OLHAevKuyjKVfWhK+LlI1/YpKIjeMNt+NDXPepS0ZPM7ujlRp9U53P7x2D+u6IbYgXVCGVNRfKoVH2O4e+MILIyZwn+3KysaDQBqrA6HP+hz5c7S/3t6QnzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=WP/u8Kwx; arc=none smtp.client-ip=45.254.49.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="WP/u8Kwx"
Received: from albert-OptiPlex-7080.. (unknown [112.65.126.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31bc9a775;
	Fri, 23 Jan 2026 17:53:56 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ge Gordon <gordon.ge@bst.ai>,
	Arnd Bergmann <arnd@arndb.de>
Cc: BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v5 6/6] MAINTAINERS: add MMC files to BST entry
Date: Fri, 23 Jan 2026 17:53:42 +0800
Message-ID: <20260123095342.272505-7-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123095342.272505-1-yangzh0906@thundersoft.com>
References: <20260123095342.272505-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bea4655bf09cckunm2b675df11c3dd3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDThhPVhlPHR9OGU0eHR1CQlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSklVTU5VSklNVUpNSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
	tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=WP/u8KwxJExyov9NG3WKDd5xGRSRKPcmAaXaUKvTKPS1xI43q9Z/yXvzqi1T4WnYuNjlBVlo4wmY1F2hIh9O2e8xwbtQPY6w4v6cTSwP7J4x+PTnFyfcXhPOfudd63Drtmk7WMSbhBkeBpC/4sDNiUhkhmARLK2JXut6FSdxpBk=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=cGm0MWwkBdQUJ6VMHylNjNY5VUzuxOyf/oKBwqDK+ZM=;
	h=date:mime-version:subject:message-id:from;

Add the MMC device tree binding and driver files to the existing
ARM/BST SOC SUPPORT maintainer entry.

Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>

---
Changes for v5:
- Split from platform series per Arnd's feedback

Changes for v4:
- Changed driver file name to sdhci-of-bst.c

Changes for v3:
- Consolidate BST maintainer entries

Changes for v2:
- Initial MAINTAINERS entry in platform patch
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d044a58cbfe..dc7f716f9811 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2596,7 +2596,9 @@ R:	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/arm/bst.yaml
+F:	Documentation/devicetree/bindings/mmc/bst,c1200-sdhci.yaml
 F:	arch/arm64/boot/dts/bst/
+F:	drivers/mmc/host/sdhci-of-bst.c
 
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Andre Przywara <andre.przywara@arm.com>
-- 
2.43.0

