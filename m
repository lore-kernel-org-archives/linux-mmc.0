Received: from mail-m32113.qiye.163.com (mail-m32113.qiye.163.com [220.197.32.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789A378807;
	Fri, 23 Jan 2026 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162051; cv=none; b=n1b5qQ9OaM2KVbIsfK9UEoweJOkjmkXww//wF+O5DpzvAh00kp4rUf6yqe4AUCL5urLVjGtwTO25ex6cCWyqJ1bOtgF4RU8ZIzglUdSgB2/xSQLP9o/2WNfSZXMVVGRI95gl967kBrtHFWnPvMYsLka3pXvzjcbxg5dODc0jQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162051; c=relaxed/simple;
	bh=TgqjGSBDS4fukKqWVEzUQA6gmLfSKp1G+5MDfdU9qOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deQZlcYLIKsxG60klcFWP55XYAU0Lfa9flvyCm2lWWiqCNNiZETIribRlWHVG37/ot3dc81bp6sHOm/DsPK2VKJyYEtCmYDBXkjOKVHyewBojfmPFN96nL5N5/yD1pM3E//e0VGEl1gT76AjK2JYy2oqHKEu9J7wryH/LEqmbZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=PzvIHpSC; arc=none smtp.client-ip=220.197.32.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="PzvIHpSC"
Received: from albert-OptiPlex-7080.. (unknown [112.65.126.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31bc9a766;
	Fri, 23 Jan 2026 17:53:52 +0800 (GMT+08:00)
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
Subject: [PATCH v5 2/6] mmc: sdhci: allow drivers to pre-allocate bounce buffer
Date: Fri, 23 Jan 2026 17:53:38 +0800
Message-ID: <20260123095342.272505-3-yangzh0906@thundersoft.com>
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
X-HM-Tid: 0a9bea46453109cckunm2b675df11c3da1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTEMfVh5DSkgYGEpLSkNDTFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSklVTU5VSklNVUpNSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
	tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=PzvIHpSCmK66dnvT0ft3KvRFx+FVWMdDumgNLodw9BVs7lOxgoh81nvrT0KCoMJqz8L8eNyIwfuNB4bhONpWIZ+G0AqA5JJ2/vOyG4Oe+e+C4AEHLXBTQEPxAJOG/Vf8H7+gucus8ETIsdzOM31xnEvN7A3xPAMbrfZaa7eEadA=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=gJkNXHiazd0dwH31jEBkLazzm2uWsRVuYgNsDwicVtY=;
	h=date:mime-version:subject:message-id:from;

Allow platform drivers to pre-allocate bounce buffer by checking if
host->bounce_buffer is already set before attempting allocation.

This enables platforms with specific DMA constraints (such as 32-bit
DMA on controllers that cannot access high memory) to use their own
reserved memory regions for the bounce buffer.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>

---
Changes for v5:
- Split from platform series per Arnd's feedback

Changes for v4:
- New patch suggested by Adrian Hunter
---
 drivers/mmc/host/sdhci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ac7e11f37af7..dc5960e72a38 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4193,6 +4193,12 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 	unsigned int bounce_size;
 	int ret;
 
+	/* Drivers may have already allocated the buffer */
+	if (host->bounce_buffer) {
+		bounce_size = host->bounce_buffer_size;
+		max_blocks = bounce_size / 512;
+		goto out;
+	}
 	/*
 	 * Cap the bounce buffer at 64KB. Using a bigger bounce buffer
 	 * has diminishing returns, this is probably because SD/MMC
@@ -4241,6 +4247,7 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 
 	host->bounce_buffer_size = bounce_size;
 
+out:
 	/* Lie about this since we're bouncing */
 	mmc->max_segs = max_blocks;
 	mmc->max_seg_size = bounce_size;
-- 
2.43.0

