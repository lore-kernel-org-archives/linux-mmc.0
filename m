Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7237EFE3;
	Wed,  2 Sep 2026 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336307; cv=none; b=ZfkPJFEtekX73JjQaTSjfZph2MSGke4tD4UBO5UGil7nvesdattusitfJFmxVGuC5W0h2/c0s0nf9Oes8Vpjq3GrMAZJkUI7MbzxDXCx6NxhsGM+cHv/lyHHhGc3thRx1FV8qCki87BW9nxXop23RbeHm6UMfpYqNjsT9vtN31U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336307; c=relaxed/simple;
	bh=TywnkrfNejt6BzR6cv7EHCSdNE4iapaJmw9uveBcbaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaF4PjvE+bPTPeaHr1C+he4WAQ3QTDZhlQwkN+JI9PfdpP1XW4TZwxPelbchQi2WsgmpuSGG5tIlwE4aylfxURYFxDg42SimGKEUQj9gkMwxoSwLOHHIL2lCxFNv0qniS7EGAzFT0hv0rU8ipw48blORXSijgvWuVAgsqKG4rek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZKdsy4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZKdsy4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062551F000E9;
	Wed,  2 Sep 2026 08:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788336305;
	bh=oOt6rzGyB9+dcVCWANgFL5IswuKEaIiQvhJRIFhDyWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VZKdsy4ezYtgdIoGNNvPFpCPEWFtOUJhXLtGk+hzU2rpgLgdLa86S/Gv+el2VBXBX
	 7qJGMZb3fW7F5cpQpe6+t9ogsbvPYEiBUad9XAUL7sL7wrq0q2VmvsgBBAhlSYAo9L
	 0207pVa6aExNtDCf/47ar1m36tHRXdJQBc8zPq/+I4l7SE8pHDMYKQ24gpbYHZLiYY
	 oOj8lEdkcpncfjXcDSuatozO2ZLDElK70Dtdh3QbF6+lbtyyWDpR60/dMwXJ1+COy5
	 MSTqijODXDytN09AeohRe7j62SgXTgmX2bURIUw67rkh09KMyk1Ikmby8ED20XaWFC
	 TOBnfsUMnm32w==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 02 Sep 2026 08:04:23 +0000
Subject: [PATCH 2/7] mmc: sdhci-of-k1: drop duplicated voltage settings
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-07-k3-sdhci-fix-v1-2-b15c5d0f64fd@kernel.org>
References: <20260902-07-k3-sdhci-fix-v1-0-b15c5d0f64fd@kernel.org>
In-Reply-To: <20260902-07-k3-sdhci-fix-v1-0-b15c5d0f64fd@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; i=dlan@kernel.org;
 h=from:subject:message-id; bh=TywnkrfNejt6BzR6cv7EHCSdNE4iapaJmw9uveBcbaw=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBql9iXmWeCcM3ycd95fOAQxxiCl2Tb/s3R1OYru
 lqOo5IK67GJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCapfYlxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+06wxAAoIwJiACs7alFPcjAN1xkJ/eHgS52onSDqrH1BvvPXNSP85XdbnCTu
 HWSeJZqkmUYHw62VgpnNo0BGzJ1tlVWLlVsPtjctxWOdO0x417o78cWD9Pirhii0L9EvbgX8eGY
 wkpjiNY6TNVTdBB3kwx5o3ZqotKKlBhFxDFJciDoNgI7gG8M+yIA1hCi54OT4PjKo969KJZrss2
 r0l0Z5zpe6ukNYxRAnIbwoeUZawVYAPTQcEihJdcLxPF8Cn2cYf7dzgbLejaDKKwcznD8Lq35sy
 H0jWG/vgxJF4G88zmcoiehL57wxnwTY2SGlHXdJk1uUA7hrSoX8xik8/PiyvOFtwV3g74JwgEaj
 onEzYdcTKyxMC5lnDk58UJpY1QbPP/+nUxD9pf3wrcW6sxlIVkfitTzozLjxXVk6QYZv+s5eG7H
 9p70sFzckmkBE6p5dsf0zhFrjxClhFYbx3jSlt5xNTDYnmnFQG1EU16W7XdyMFPBq/+8dTnHMQy
 dbWec12vYdwcsPAmaXIZcn/dffuyOPiH2GK63yPOo9V/LsB7T0UdjK2jUHHkTqupB1hh9oCXw7N
 EaA/PfSGP6dXYwmaGcYlWYetq7M9zX4YBV0QfrktU0pqYY/5g5w2m9JablMkgbuVSmjKfaHLSMr
 o9gYu9em+t9oX+OjJHHe6m1UHj6g4A=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

No need to set 1.8V Signal for non-SDIO hosts, it will duplicate
what sdhci_start_signal_voltage_switch() already handled there.

Fixes: e5502d15b0f3 ("mmc: sdhci-of-k1: add support for SpacemiT K1 SoC")
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 0916340d3265..afd9536f2368 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -195,9 +195,6 @@ static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned i
 		spacemit_sdhci_setbits(host, SDHC_MMC_HS400, SPACEMIT_SDHC_MMC_CTRL_REG);
 
 	sdhci_set_uhs_signaling(host, timing);
-
-	if (!(host->mmc->caps2 & MMC_CAP2_NO_SDIO))
-		spacemit_sdhci_setbits(host, SDHCI_CTRL_VDD_180, SDHCI_HOST_CONTROL2);
 }
 
 static void spacemit_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)

-- 
2.55.0

