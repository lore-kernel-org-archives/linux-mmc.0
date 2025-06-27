Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D9219E8
	for <linux-mmc@vger.kernel.org>; Fri, 27 Jun 2025 02:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750992656; cv=none; b=ALDqu2YXdchpb5iCgQbDAzNfeAzZkS69ElFv2KIbDBxPLeC2teqbo4ij4s6w0+IkboLjrtE3oIaMCziA9dW+PaP70rhQ1U6rIgERdypdI45AQdE0vdwTyy9wd5ZKRttMcRSEN3wBcP4tHiQxdMiopjyEyPsg+YlnMZ4j19Zrdf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750992656; c=relaxed/simple;
	bh=wtdQHLdtNfQbbZaR3WOmh6GSRNMjh/xhLIu3l6GEFVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Adza1OuCOlMGnNgX/PB72llOPl4q/qlBefR/ZQtj/rOuNeIU0qISlTW15E0ibfrsfk3sIgfHCwN4YdkCgUddGErN6fnibAR2xEFL16uR357xyES/f0nY3Dm0nItivCJMFAWP2O0Dp1H0l5vn5fu+EIZAqUyIYLwH/TyckLmDKsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DF98520244F;
	Fri, 27 Jun 2025 04:50:52 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A61C720244D;
	Fri, 27 Jun 2025 04:50:52 +0200 (CEST)
Received: from local (lsvm11u0000469.swis.ap-northeast-2.aws.nxp.com [10.52.9.123])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DA527180007D;
	Fri, 27 Jun 2025 10:50:50 +0800 (+08)
From: Rex Chen <rex.chen_1@nxp.com>
To: ulf.hansson@linaro.org
Cc: conor.dooley@microchip.com,
	bartosz.golaszewski@linaro.org,
	viro@zeniv.linux.org.uk,
	linux-mmc@vger.kernel.org,
	avri.altman@wdc.com,
	shawn.lin@rock-chips.com,
	adrian.hunter@intel.com,
	wsa+renesas@sang-engineering.com,
	rex.chen_1@nxp.com
Subject: [PATCH 2/2] mmc: mmc_spi: multiple block read remove read crc ack
Date: Fri, 27 Jun 2025 11:50:32 +0900
Message-Id: <20250627025032.1192873-3-rex.chen_1@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250627025032.1192873-1-rex.chen_1@nxp.com>
References: <20250627025032.1192873-1-rex.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Multiple block read doesn't need to read crc ack, so remove it.

Signed-off-by: Rex Chen <rex.chen_1@nxp.com>
---
 drivers/mmc/host/mmc_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 47443fb5eb33..f42d5f9c48c1 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -563,7 +563,7 @@ mmc_spi_setup_data_message(struct mmc_spi_host *host, bool multiple, bool write)
 	 * the next token (next data block, or STOP_TRAN).  We can try to
 	 * minimize I/O ops by using a single read to collect end-of-busy.
 	 */
-	if (multiple || write) {
+	if (write) {
 		t = &host->early_status;
 		memset(t, 0, sizeof(*t));
 		t->len = write ? sizeof(scratch->status) : 1;
-- 
2.25.1

