Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397278;
	b=YqNZ4dEciTyyBhI/Qm6D70gSxfvynjzi+nqN/y8VS5L0HehMyqvhkCp1Lv2xO8mHS4pj
	 89os6msZq2u667OlXvhPw9DVfSWSZSvxilpZ2HQlefKC7F6WyZeXh85/sX1pUy9+d7Z5A
	 MbUUy5bH3yueXZExQLXSMafP6whRIY9ROHwtcG7JcTSzF/kzRfJqZsBjohrOnYWoyBhKq
	 WcQn2aM02+TDNNeRCd6JlOL8rLx1duvixEGlaDT8RkvqZM04hYZ2uQp+qTFFd27azEjpu
	 chOcsO/yuYxYLwbFI7gNNarcJDll0JHaibvvjxzZOlIMPIpTex1PUeLx4gfIBoQ/GHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397278;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=qJLnpzBdDvSSAoILaAVEaPeTNJiYyTIY+1V0RNSuyBI=;
	b=yQX9SZz6wsxAG87J18aV3ihcJav5hyLXqfdsib9apWMiPzQG+FdDygmYJ3s4zfUP2sj0
	 Mzx7hjX0chIr/6YqCCdx5K42j4WW3Cb69OssHQcLQwr7XNxzP388tc46MbKT27CTsNzSA
	 S+kEM/u7Dszqr5IBOROirCp2RRk1EycjGLcpydwNjD+DcstBOOUdCbqGK0za7GDP2YohQ
	 D930/SyoshuxQ4TPVUkzddMbyDQqhCitN2A8O6QyUjfO3rv+fKz1uO/3P6ej5tBDGD0JQ
	 23eelubumgZR2DSHbyS8LLRRIq67EHMeRGYtS888LDrpoETrDglIgki29CWhWc8rSGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=CWx+wXNf;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60E606A31E;
	Fri, 30 Oct 2026 21:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D60E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=CWx+wXNf
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5D4EA10C09B;
	Fri, 30 Oct 2026 22:54:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793397271; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=qJLnpzBdDvSSAoILaAVEaPeTNJiYyTIY+1V0RNSuyBI=;
	b=CWx+wXNfQf9XQkAogInTZgRusncfRZFc34fhAEwItQl9pzzNdNeOPxiieTbvhqmYI4XhIf
	rt53hkH4UFsl4hnkeYHOF1T5Lq4W21AeC218bpr8ua887h3G2mlWypdVyY6tthwEp6+Eem
	ogS9w87RPIh58KmF7Htfd82VwGez2C+kF0qmtqKkv2lkMQQaGxqztkjxFYDRxsB/+gm/VW
	gcNDd0/jjCR/SUhK/ir+JajpAFI+jjQKLMNOCjrpHc/vtiJeavY+7/K4qth3g43FPaVkYj
	kt8hMeKO1wfFgCF5j/IxYTy9lHzmWJ37P0/Mlip8CSL2XuSjXezFcm3oZZfR5A==
From: Marek Vasut <marex@nabladev.com>
To: linux-mmc@vger.kernel.org
Cc: Christophe Kerello <christophe.kerello@foss.st.com>,
	Marek Vasut <marex@nabladev.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	kernel@dh-electronics.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] mmc: mmci: stm32: handle mmc power up
Date: Fri, 30 Oct 2026 22:53:38 +0100
Message-ID: <20261030215427.488298-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Christophe Kerello <christophe.kerello@foss.st.com>

Manage MMC POWER UP state like MMC POWER OFF state. In case of low
power use cases, it will avoid random initialization timeout. This
fixes a failure to switch DDR52 eMMC to 8 bit mode due to -EILSEQ
returned from mmc_get_ext_csd() in mmc_compare_ext_csds() called
from mmc_select_bus_width() after Standby1 suspend/resume cycle.

Fixes: 46b723dd867d ("mmc: mmci: add stm32 sdmmc variant")
Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>
Cc: kernel@dh-electronics.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
---
Marek: Update commit message
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 9dc51859c2e51..659a5040729e9 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -368,7 +368,8 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host *host, unsigned int pwr)
 	if (dlyb && dlyb->ops->set_input_ck)
 		dlyb->ops->set_input_ck(dlyb);
 
-	if (ios.power_mode == MMC_POWER_OFF) {
+	if (ios.power_mode == MMC_POWER_OFF ||
+	    ios.power_mode == MMC_POWER_UP) {
 		/* Only a reset could power-off sdmmc */
 		reset_control_assert(host->rst);
 		udelay(2);
-- 
2.53.0

