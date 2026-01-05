Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA7D32548C
	for <linux-mmc@vger.kernel.org>; Mon,  5 Jan 2026 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767592976; cv=none; b=ln7d391lahp7i8L8EQR8tKqzZmq/FeH8lz34jx4SfSNrWwYD8WLZttitMdKqKth7JRrk/OMB4hJHp7uKtGY8KVFuMCl7mqYXSO8kcKQTuv6AFRb26CCWlTd+3hQZhnLr7S0G7kj0LS/y03Y68JScsJ8EPn2y+kC9WHJg+MVHD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767592976; c=relaxed/simple;
	bh=TjZ0jKbAPXqYFoV+5Ef2uzYrkI9/jkDXYyRnolUp0wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9Z/+1ZfkybE/hHOzLxzXytaPmC7gHmri3BgtiQDx0/hSz1gwMDM9BxUxZIomTT4QphslISAb79t+91hxjZiLoEQEuROhIRsSEC/pCURXYL+Y4PgZApOn+hSYFJ+vuNQASIO80yfhQUi03Ww9bqZwgzGa4TXp0lRaYJXI7xChBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QbCiuxUm; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QbCiuxUm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767592973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tKPZ3eLToROYAddzYBkGoAiIlgpb06BIwoIoHGkRDCg=;
	b=QbCiuxUmqIo6kucQ3VL52YKCTAttVh4LSu+wULxk/mYlCCbeQsF1UvH71c8DYRvUMs45IA
	1IyPTlpIaeFsclUMYOPn/T2i++R5MkdJ3VNJpaZfkf5qQws0wX6VgFZ2LUxHar1f0/HlFq
	dmfREecVl1xhO8WVXPYKwIVEfNj0WiI=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ricky Wu <ricky_wu@realtek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH 2/2] mmc: rtsx_pci_sdmmc: increase power-on settling delay to 5ms
Date: Sun,  4 Jan 2026 22:02:36 -0800
Message-ID: <20260105060236.400366-3-matthew.schwartz@linux.dev>
In-Reply-To: <20260105060236.400366-1-matthew.schwartz@linux.dev>
References: <20260105060236.400366-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The existing 1ms delay in sd_power_on is insufficient and causes resume
errors around 4% of the time.

Increasing the delay to 5ms resolves this issue after testing 300
s2idle cycles.

Fixes: 1f311c94aabd ("mmc: rtsx: add 74 Clocks in power on flow")
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 74ee8623ad4e..9e95c6000256 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -947,7 +947,7 @@ static int sd_power_on(struct realtek_pci_sdmmc *host, unsigned char power_mode)
 	if (err < 0)
 		return err;
 
-	mdelay(1);
+	mdelay(5);
 
 	err = rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, SD_OUTPUT_EN);
 	if (err < 0)
-- 
2.52.0

