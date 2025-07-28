Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4C22370A
	for <linux-mmc@vger.kernel.org>; Mon, 28 Jul 2025 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690965; cv=none; b=MHB4RKu1itQksDJUkYUgpWcP8BTyAnACH9RuABtlN0e31QpBn+jDzQr+GfPP3PLjJbm17a9UMBI57l/ofmP2340bd0f9oP8rpvKHMhA4gnSv9DXU2ELp/K5kdahnuZnnEKwuOLtEXEwfzdX8tqTOxJ7k/xiLWp3c6Y6LXcsZrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690965; c=relaxed/simple;
	bh=eqXJAyemxslRuGIDD136BAaHfDsyjhRPef7H+3e1gKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EerX60XW2V2FGZ8ZpJdRRNEnJ9fRypsjEW/3gjstwbRy388s5eCyiNTLPQSabQfmD+JiroYTPVCcHQAixLN8knyA1pDPsmmNjcvX/gFGAybO1RwG+EbjfbNckLizCokYIVb4iHaJnFVwuGilrz9oV4U+Mcdt7AVUqP8fs3ntVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 548BD1A202E;
	Mon, 28 Jul 2025 10:22:42 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 14FF01A15C1;
	Mon, 28 Jul 2025 10:22:42 +0200 (CEST)
Received: from local (lsvm11u0000469.swis.ap-northeast-2.aws.nxp.com [10.52.9.123])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AEE141800079;
	Mon, 28 Jul 2025 16:22:40 +0800 (+08)
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
Subject: [PATCH v3 2/2] mmc: mmc_spi: multiple block read remove read crc ack
Date: Mon, 28 Jul 2025 17:22:30 +0900
Message-Id: <20250728082230.1037917-3-rex.chen_1@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250728082230.1037917-1-rex.chen_1@nxp.com>
References: <20250728082230.1037917-1-rex.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

For multiple block read, the current implementation, transfer packet
includes cmd53 + cmd53 response + block nums*(1byte token +
block length bytes payload + 2bytes CRC + 1byte transfer), the last
1byte transfer of every block is not needed, so remove it.

Why doesn't multiple block read need CRC ack?
For read operation, host side get the payload and CRC value, then
will only check the CRC value to confirm if the data is correct or
not, but not send CRC ack to card. If the data is correct, save it,
or discard it and retransmit if data is error, so the last 1byte
transfer of every block make no sense.

What's the side effect of this 1byte transfer?
As the SPI is full duplex, if add this redundant 1byte transfer, SDIO
card side take it as the token of next block, then all the next sub
blocks sequence distort.

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

