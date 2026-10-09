Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310933B6D6;
	Fri,  9 Oct 2026 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565402; cv=none; b=ZbeWGIYWV7Kd+4urs73kmpGkkyJZViBZxq0ispp2X7CnTS4jexdbLEPurYNZ5d5UJzQWZ6O9UD5zuMulkTnf+BqIJ/jW3DdviA1azfyoRcjVXDV0BYTzbxTL0TgzPVv7GkpFCIJKqLgln6dWn69SLDUEO0fxLLcvjywLk2lf800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565402; c=relaxed/simple;
	bh=HltqgRNNIwZ9kFC+ixCPZue+iWoVKnB+5mRmJqNUMpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OEH29AISf5uFFYq+V2a7h6B9enWJMVhzZexDce9HaMP8tHniFJ03WJwHQ/Ih07Y0YQcUTAzIKWi7eBDeUVbt/+Wi5HzXCbn8psmuw0vXQyabKAoK9s9V/vwKPabcPdPVb1h6IWwVJn91NKMGOkiAPEPdNEjxrepn8NW9uAgcfqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRhCPFGo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRhCPFGo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13F38C2BCFC;
	Fri,  9 Oct 2026 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791565402;
	bh=HltqgRNNIwZ9kFC+ixCPZue+iWoVKnB+5mRmJqNUMpg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XRhCPFGotnryUHFQ/zJ4bOFcvAyRDDA56wT1UYT5MoN7WKOy3KMdM0wIALcBauz1y
	 z4a3o3An7qV/SgjszvbM466grpBzVm8g5rB40yH2qRBdcZ3JNgZMdG9sQdxGn4bWrm
	 UiKPb6njYYwr5beEoSiBYRbvO85f7Oip42KPKkXpmPbNk9NUTjWZlugfP6RqluOct+
	 5Q8dtke/stefgeM1xOdAsWnCRpyJMN9Xm1iLQAPhCW6uvbRE6PDG50Yk1lL3i6jiw0
	 gpuM1sM52Aspd2/5oWmoiofQ01fpJLvCFMJ3pVqR0xc+OQscoUJcnBuUPmfjY/iBhu
	 Oro7zLd9GRcsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5C2CA9EBE;
	Fri,  9 Oct 2026 17:03:21 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Fri, 09 Oct 2026 17:02:58 +0000
Subject: [PATCH v3 2/4] mmc: meson-gx: honour the busy timeout for R1b
 commands
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-meson-gx-busy-timeout-v3-2-67d0db3a8328@iav.lv>
References: <20261009-meson-gx-busy-timeout-v3-0-67d0db3a8328@iav.lv>
In-Reply-To: <20261009-meson-gx-busy-timeout-v3-0-67d0db3a8328@iav.lv>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=rOM57qbfW34prfjDB36/jDaeQJ2OUA+RMwJjtKE2R4s=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFkn5cK/tv2XUH12MTCwaLJAgHLnsUfFy7g2eRgF+N7c9
 H6V/BeujlIWBjEuBlkxRZYJhzRuZSy5+tffw/wBzBxWJpAhDFycAjCRSXMZ/vDHqiw58fjcNi6V
 fXtNFruyzDVWZ125MPTNKc71Dh/4jh9lZLiXvdpGJFG27thnjy0iScv/B7ZN/LLr7o05+rrTlAM
 ktNkB
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

From: Igor Velkov <iav@iav.lv>

For a command without data the driver programs a fixed 1024 ms into the
CMD_CFG timeout field, and for R1b the controller waits for the card to
release busy within that time. The core sends erase and cache flush as
R1b with busy timeouts of up to 60 s and 30 s, and the controller gives
up after one second:

  mmc_erase: erase error -110, status 0x0
  mmc1: cache flush error -110

Program the timeout from cmd->busy_timeout, kept between 1024 ms, the
fixed value until now, and 32768 ms, the most the field holds, and
rounded up to a power of two. The clamp comes first: MMC_IOC_CMD passes
cmd_timeout_ms from user space straight into busy_timeout, and
roundup_pow_of_two() of a value above 2^31 does not fit in unsigned
int. sdhci takes its command timeout from cmd->busy_timeout in the
same way.

Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/mmc/host/meson-gx-mmc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 06479ba38525..dd246ad63653 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -216,6 +216,20 @@ static unsigned int meson_mmc_get_timeout_msecs(struct mmc_data *data)
 	return min_t(unsigned int, timeout, SD_EMMC_CMD_TIMEOUT_MAX);
 }
 
+/* For R1b the controller waits for busy to be released within this timeout. */
+static unsigned int meson_mmc_get_cmd_timeout_msecs(struct mmc_command *cmd)
+{
+	unsigned int timeout = cmd->busy_timeout;
+
+	if (!timeout)
+		return SD_EMMC_CMD_TIMEOUT;
+
+	timeout = clamp_t(unsigned int, timeout, SD_EMMC_CMD_TIMEOUT,
+			  SD_EMMC_CMD_TIMEOUT_MAX);
+
+	return roundup_pow_of_two(timeout);
+}
+
 static struct mmc_command *meson_mmc_get_next_command(struct mmc_command *cmd)
 {
 	if (cmd->opcode == MMC_SET_BLOCK_COUNT && !cmd->error)
@@ -842,7 +856,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 		cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
 	} else {
 		cmd_cfg |= FIELD_PREP(CMD_CFG_TIMEOUT_MASK,
-				      ilog2(SD_EMMC_CMD_TIMEOUT));
+				      ilog2(meson_mmc_get_cmd_timeout_msecs(cmd)));
 	}
 
 	/* Last descriptor */

-- 
2.43.0


