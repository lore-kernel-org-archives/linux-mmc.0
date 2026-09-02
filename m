Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932139F18A;
	Wed,  2 Sep 2026 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336314; cv=none; b=TEgNjA6CHSu05COzqO9KCU9dv+2d3Fsj+7to/MyXS0DQVRyRzXkucW5yMNaTZ6y7beuaL32clggAG0wb8FKYPfbmdevbMgHzn0bQbmdtrpJe/k3OmXldq/t/eqTiU01Lofzl716QAm1FZot8Mqg2Oy/AxTp7GHabwnkcHz7wIUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336314; c=relaxed/simple;
	bh=SH9UI8A6iNatLp3NjWnuaSxPVUbO96xv+noIo6rn0/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i2UX14BtpiOXj3ejucj4b1cSNjXp7/hBYGjBlZoq46ave7q9RgALUdltbLQEAGIYlz8eHFM8Xxsw3eR+BuJUCseEfRnj+Jnf3Rj2T7G116GxatrLrG1BuNva8TPj4Qa7+6dLXznC9Pj5R24kimYgVoTZJoIFap/v4kawhnRhjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcV1fCpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcV1fCpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C15C1F00A3D;
	Wed,  2 Sep 2026 08:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788336312;
	bh=POmWOknNtTO/bFj1tOVGoSaF82mOopdrhB/HoyO6q9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FcV1fCpwLiSaXYRxlMf0DXaT7DyJ70mcfwu32BA0GH1LFj1LOgK1L76JUQbcJ+N7D
	 V2DztpwkbYO9VAuqt0WTzmgdgUdV4gkms4uXlIVa160uKvzbLUlHY02qu1/4a5bxje
	 ZnG8vACEEV4U1wIxCWzaW2lF4MV2rKDx4tBB6SQDciw3o5sQmW1uyScogYsH/qowo3
	 ByqHGIxdUQ1SIfeos81IrpoAlLFT/Eaf1TUD0d723YgarGJspp5qN0n2mFQAVirn2L
	 SnWiCd9JpDrVwpdGQlUhAqB8eQ4s3wwl62eT+WbCJGlEb7IRQoEMBc9zjXbSVe/e6v
	 eDoK+ycsWh5DA==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 02 Sep 2026 08:04:27 +0000
Subject: [PATCH 6/7] mmc: sdhci-of-k1: Improve RX tuning window
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-07-k3-sdhci-fix-v1-6-b15c5d0f64fd@kernel.org>
References: <20260902-07-k3-sdhci-fix-v1-0-b15c5d0f64fd@kernel.org>
In-Reply-To: <20260902-07-k3-sdhci-fix-v1-0-b15c5d0f64fd@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=dlan@kernel.org;
 h=from:subject:message-id; bh=fxIltcJX5Uwnq3dNxRUoyfBOhLTw8pBZO1fExcD0Xrk=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBql9iknDWofrDWeNlh+AiDVUT/uohKMRltmkQ7G
 tU5ZNSEZ0SJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCapfYpBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+18jw/+IsClSoXL1iuwryIUbeeMdJqr3eSUcezMiUhCiVZ0ulvN0d4jGikzk
 LGs1uxoCBN6kqD6Xy7RB68+0TJ22sjvPxDQlDKevgZsa1XlYq3G9cfFYAroiXtHkZyJ9W9Tw6Tc
 nB4Yr434vzRuC+ZHzAb+41xSpSoU8Dlg3DzTzfCcj5eTyQniYO3H5p06JXcjbGUaMg2b3VcSy1E
 PQUxskHTxOgSruQkNOlx7roPoJm6OtlWb8wUHMV8M8tEyLotUNRnSzIUlbUHnkquOfQp62MiBq0
 8cWutal+oIrM0uUAe+dcO8PDBT2Ylyb/poaWr1/Dd5FpCGGDeGhEXWGpOJBKlpl+4DHd/xLJqHn
 jD2jYPEDPegn1p5NH91PB0V0trnlc5nRfDrby3JqeJbgp5WsxAev8Utp+STggeGnXoSYMtIgM94
 QjMcJxh1It7LBNvsoUnrM0f1DtForTLocQeqT3mu1Uss8I1oRaWFl6Giz7woaOX4uq2HaFmni0c
 CpDhaNMTuTUnpmzZ3CGnJlo3FiWBahQGMrNI8HIjiFTW/KTa2vl5soHX0ZGkVzFQEqm9yBFftPQ
 VBofRkEQvNOVpICPCVt163ZlL44TSD2rWSDLTZncdDUlYWLi8Ahn/GwZtdoovTbz5iT2d4nF+fA
 RQVAFG9Nnrivu/lw0zZx0pWre2byxY=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Long Wan <long.wan@linux.spacemit.com>

Raise the minimum delay codes of RX tuning window from 3 to 50, to more
accurately retrieve a valid configuration.

A window of 3 codes wide leaves no sampling margin, which will result
tuning tests reporting success on a configuration that drifts out of the
window under thermal or power variation.

Fixes: e9cb83c10071 ("mmc: sdhci-of-k1: add comprehensive SDR tuning support")
Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 257c954ce587..a07e7db0853e 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -314,7 +314,7 @@ static int spacemit_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 		max_pass_start = current_start;
 	}
 
-	if (max_pass_len < 3) {
+	if (max_pass_len < 50) {
 		dev_err(mmc_dev(host->mmc), "Tuning failed: no stable window found\n");
 		return -EIO;
 	}

-- 
2.55.0

