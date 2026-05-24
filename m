Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80725B0BD;
	Sun, 24 May 2026 02:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779591241; cv=none; b=D5Z54NH43ODOLzavMsw1E00h8spCoLmjX0VzMatozg8igegEoPQFPHQA3PQRbgY1scU01xL9trQS0h9nwYdgz+FI68/6orBImibBu2oHVhOkt67s8Tw2mGaDao4hQw0sITtsW5trctm43z/K7ROHI49bVMh/jasYqYeSGVU8+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779591241; c=relaxed/simple;
	bh=zya11ymlfeI6BirUzv4Ve0stXEqYRkY+LlmLOwVNQr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txubYsh5cI+PN1/4EJWo20pd0obpXf8Ckk9gp/mooAinkqyHb43TYDgQD6ib6rsxxg2fqr+1e5TtGlJ+gGF7RE+P4uvI7epv20fwSeiBfE55OLJx9i0I4W/zOPJogB0Pb8dIt/CVjgdx/WoCSprNfVf5KwanfkLeBLhukIUicCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3DpMsvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3DpMsvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FC51F000E9;
	Sun, 24 May 2026 02:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779591240;
	bh=yh9wsZTCe1A1UJZLuMG4mK85J3fx8gIBkF4pAyt4V9U=;
	h=From:To:Cc:Subject:Date;
	b=S3DpMsvcDATrHllwG4AxJPrJEVarf3tEgtWdmYGTZpUGs4LPWmfyed8bQbB9xkO2w
	 EHUjTK61kHBakPw5oS5cSk4xJAcwrTV32LhWfzFthzYFBuFZFLPaauLR84KkP38qTY
	 1K09loQIRgO79MrbYro1JxyGFNVJLaQwOWvkFb7crvP/ruEtJJKUmSam639RT4LiIv
	 jC28wzA7D5+NuIMIQ7Dd8VaAoVScobCxoudk61ACwl2Qaz+tOdA/1y8EV25KIiEVx6
	 ZOvK/Cvo4IPaTdt5X33Na28iACZU7/IlLJ9rtacheRM/u3kyY5p0obwsHOA2JLsH3T
	 2F+G0xw++PlTA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci: add signal voltage switch in sdhci_resume_host
Date: Sun, 24 May 2026 10:34:55 +0800
Message-ID: <20260524023455.17677-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I met one suspend/resume issue with sdr104 capable sdio wifi card (with
"keep-power-in-suspend" set in DT property):
After resuming from suspend to ram, the sdio wifi card stops working.
Further debug shows that although ios shows the sdio card is at sdr104
mode, the voltage is still at 3V3. This is due to missing the calling
of ->start_signal_voltage_switch() in sdhci_resume_host().

Fix this issue by adding ->start_signal_voltage_switch() in
sdhci_resume_host(). This also matches what we do for
sdhci_runtime_resume_host().

Then the question is: why this issue hasn't reported and fixed for so
long time. IMHO, several reasons: Some host controllers just kick off
the runtime resume for system resume, so they benefit from the well
supported runtime pm code; Some platforms just use the old sdio wifi
card which doesn't need signal voltage switch at all, the default
voltage is 3v3 after resuming.

Fixes: 6308d2905bd3 ("mmc: sdhci: add quirk for keeping card power during suspend")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

since v1:
 - add Adrian's Acked-by
 - add Fixes tag

 drivers/mmc/host/sdhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 605be55f8d2d..e3bf901b10aa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3836,6 +3836,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 		host->pwr = 0;
 		host->clock = 0;
 		host->reinit_uhs = true;
+		mmc->ops->start_signal_voltage_switch(mmc, &mmc->ios);
 		mmc->ops->set_ios(mmc, &mmc->ios);
 	} else {
 		sdhci_init(host, (mmc->pm_flags & MMC_PM_KEEP_POWER));
-- 
2.53.0

