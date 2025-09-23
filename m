Received: from mail-m32118.qiye.163.com (mail-m32118.qiye.163.com [220.197.32.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B8C30DD24;
	Tue, 23 Sep 2025 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609968; cv=none; b=Pzku2L/UuhcSmaG4sKqFpjMF8AKVZahJCybeYytsZDhKjxBoMnh6aQtrbWR2qazKzpPyCb4Fu8g8HN1WdkK2nY8mVCMZ6Dt1qGMAW2Sy7kjzJWM0/UxnhAPp9NmkfuJjIbSOmkxlCuCmEU0e4pJ1bhucB9ErtC9bkLtV4fnEBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609968; c=relaxed/simple;
	bh=DySTBlwx8SxAqSzT6Ick6Jr1zhm5KCXfBY5QxqKIbyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EcHiPDgfdgXFzYxc+rw16K3Ca/ZI1dVB/g0AW1CatROEdCZB+A0JtskcZyqW75r0YiFjFDT3/wbDd0TYIHrtURVJFyzQjRcmx3rT94+Voxt4o6E/OO6gzUMsNPDIf55xamSBrc/is3lv0jqv6EDg69wntl26YSaGzBxHifPEVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=V2V4U78C; arc=none smtp.client-ip=220.197.32.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="V2V4U78C"
Received: from [127.0.1.1] (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 23bdebff2;
	Tue, 23 Sep 2025 14:10:36 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
Date: Tue, 23 Sep 2025 14:10:12 +0800
Subject: [PATCH 6/9] mmc: sdhci: allow drivers to pre-allocate bounce
 buffer
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-v4-patch-final-v1-6-2283ad7cbf88@thundersoft.com>
References: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
In-Reply-To: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ge Gordon <gordon.ge@bst.ai>, 
 BST Linux Kernel Upstream Group <bst-upstream@bstai.top>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
 soc@lists.linux.dev, Albert Yang <yangzh0906@thundersoft.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758607828; l=2071;
 i=yangzh0906@thundersoft.com; s=20250814; h=from:subject:message-id;
 bh=DySTBlwx8SxAqSzT6Ick6Jr1zhm5KCXfBY5QxqKIbyw=;
 b=ix7Cn5PKa7gJNY0yDsFsWNW8nlAWEJhuVied4sPs3/t6HoDAE1rrDpPzL4sWN7KI3HOEa6wER
 xtlQvg6W2SxDUlvOWg09hjIBfy1okIjtpKO7HdTwkcnk6W89rj64E43
X-Developer-Key: i=yangzh0906@thundersoft.com; a=ed25519;
 pk=bEcgALL9KpUg/m7zH44r50xa/re91dI9SA0vGV1/bu4=
X-HM-Tid: 0a99753204e409cckunmfc27e25b4e02ee
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSkkaVhpISUIZHksfGE1MSFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=V2V4U78ClyaDeCqDoYNIU6wni98ujkNU0fsI8Q634rn082Fjc6DyzYXjtUdnJHdQx2SOkllDk4xgZX2twmtmBI7Qa1EQGUFLDhlOJlojggJ02tl2G76z0jtUrSXTH9wAKzdJKcxaIxLarDBw5/eLdDdyRj84YkJoUJwhfz8B60g=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=4zdOECm9UDt4mSRVWdAJlFg918s9UR2BUDdjk/GLuac=;
	h=date:mime-version:subject:message-id:from;

In sdhci_allocate_bounce_buffer(), add an early path that respects a
driver-provided pre-allocated bounce buffer (host->bounce_buffer).

If the buffer is already allocated by the driver (e.g. coherent/SRAM
buffer needed for platforms with 32-bit DMA constraints), just compute
max_blocks from host->bounce_buffer_size and jump to the common "out"
path to set mmc->max_*.

This enables platform drivers to allocate the bounce buffer before
sdhci_add_host(), avoiding starting the host without the buffer ready
and aligning with the guidance from review.

No functional change for drivers that do not pre-allocate the buffer.

drivers/mmc/host/sdhci.c (sdhci_allocate_bounce_buffer): Handle
pre-allocated bounce buffer and fall through to set mmc->max_*.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/lkml/2b23bcb9-abc7-4667-b939-a19ecae935a2@intel.com/
Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>

---
Changes for v4:
- Add new patch by Suggested-by: Adrian Hunter
---
 drivers/mmc/host/sdhci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3a17821efa5ca92c6c29141d8fcb9ebf58355cc7..03fbe30cb205e16b924481caa44f0979d230f380 100644
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

