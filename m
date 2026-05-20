Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC703DE439;
	Wed, 20 May 2026 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285424; cv=none; b=lhmWSl/FMKEoeUxfNs3OetDinQ6r7cWqKCLcf7idE0tUWbOFvPEXbr2gpj1aR8Cc226iSYwr1WlvNMdQuQbc0euZAM+yzWqZAgZdL0BA7Gpu6IeIo7kOogf0u6Ob+ID06a77CrgVX8Recpj7HLLUzh4d+wsPG5K6HBXyqfdEhZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285424; c=relaxed/simple;
	bh=PGq13c8Yl3aImdEFJHzlZFqlDS4HaVJrXaW/Q+x2eII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eAJvO1e3koGKsSxC4iUvsnkFESCT9mZX1EOyj4ZN07qxEZNq9wAmYjewSdi0LcyYK/9W9/aXR3EedVjtNyp0DIhQIapPmaRe0tbrqOHI4tt6F3veEt1e1ajxzB56vL+EIqYIJbiqRN4ULESl61ZNTSvkPkJDwjhZMI4g4UoOpE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVMeuY3r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVMeuY3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1A81F00896;
	Wed, 20 May 2026 13:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779285422;
	bh=1zVI7Ke8HHxHGHvIU3WSnSi7BZCnbi1ujVzV4vxzPb0=;
	h=From:To:Cc:Subject:Date;
	b=MVMeuY3rmThvzAsH0cQfyPLVNZSJGAnlX1EYiPybuMMN6MQKoIDV5nNKukYAZkrix
	 LxqC8Pv59ndTpu30N5ViXm5NQVFAs1HbKJ5O2tJSBpYRBnDF+sBQXoooh9XWxC4pui
	 wiis8zxf5L1NPOBee5OrAIrtPbDUbKOeIORQmG6YchIWGbOXbRvJFS2SVc3Wk8BuoF
	 wWBEljbJ5t+rUl/IfZnmz/5OHQ943fdAs1HNd0IJpLa2KN8EcqcqLgtON5L/teTXkZ
	 bP1OFEiI0MAbBITcXJrpfzp3eQZKueJpzdE8wJnjxTGB5Y3NkcZCIaMsM5v0ev3O+Z
	 MITd6+9dc4ooA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci: add signal voltage switch in sdhci_resume_host
Date: Wed, 20 May 2026 21:37:58 +0800
Message-ID: <20260520133758.14427-1-jszhang@kernel.org>
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
long time. IMHO, several reasons: Some host controllers just kicks off
the runtime resume for system resume, so it benefits from the well
supported runtime pm code; Some platforms just use the old sdio wifi
card which doesn't need signal voltage switch at all, the default
voltage is 3v3 after resuming.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
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

