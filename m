Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881090;
	b=MUfs/BI1PTWC1vMMrn8rAOpclNNW8CoYO/N6DdZOsQR3B3DEk8NlF2MpnOEUSBLU0bgy
	 PJm72uKNbOm1Vu0xf+cqbDAoiXUfX7+1b6DAewY4prq4Oumphnj7uLongQHXdS3l/k6Pq
	 2gm+3fLz6KLICsURJ/0ndDpqz/fvxpmh58zgq5c3+qaVyx8jcqDW3y1d+Lp5fhsBmfHtJ
	 Yqq5dvWjoGinOUfoP+kYK/jpHulrmuL0T9A/L5e6ChMbVMKasWW1Mwg5S3CgtYpORaJFA
	 RzFGSokSB9o05gw3rq+v3pGbqDHBOB3wAoCr3GBrrjMQiDKZXpfAEUWRcYsaBLRa/WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881090;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vpUJEjP9x2su6rUsdB/qg950nFELOqFmn3iPrfPBO6Q=;
	b=vJz3r+3KTnOPNHFN8mFvbVXkKB0dnO47RUSes0ZvV3YIq61t/QAGVTYHN5bzM7XvAS79
	 JnZ/JWKowfic9+PJ6e3CBoYJ/cQbjZVN0vuLiF1I5Uku+d2n9cHqmowrurYWEZyR01Jb8
	 UMGzSnrkllABLGI5ZEeTcXF1WJ4WGb3HORlFO6W8yjTpBlL08gIA3Vq2Q8fc/Zi2RXpOo
	 o2qNgcHsdCfmJt7R5FWVUMuNrjr2K7BhV7X1GuLoD0lt7rcB639p8u1KAFdPC75ypoagZ
	 bznDU8MOspuo3sP4nr3/EFwI9sxchl2rAPnEDwi+XV2Jmurl8x/fNNk5e4sGHi3+2Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="yAf6e/Da";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88509606A31C
	for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2026 02:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88509606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=yAf6e/Da
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=yAf6e/DaQkzfXcqAsVFSJJGqUbUZw5J5+TsZ6KlMyo97xOyC0DLlJSV95XGGgyOl1ujEvB8HBRKYk
	 lwXAULxeksP0mbJYDqAcOtHXIc00slqEumyWVKBf2g5pgxLp2y0ygvbogH3hALn4NifFnGpqZOSohQ
	 kgyp+L/EQOPcU3Y8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16afbb63f272-dfb66;
	Tue, 17 Nov 2026 10:04:48 +0800 (CST)
X-RM-TRANSID:2ee16afbb63f272-dfb66
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46afbb63ab5d-9ef9c;
	Tue, 17 Nov 2026 10:04:43 +0800 (CST)
X-RM-TRANSID:2ee46afbb63ab5d-9ef9c
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: Aubin Constans <aubin.constans@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mmc: sdhci-of-at91: handle clock enable failures in set_clks_presets()
Date: Tue, 17 Nov 2026 10:04:46 +0800
Message-Id: <20261117020446.19927-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.24.4
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

sdhci_at91_set_clks_presets() enables hclock, mainck and gck but ignores
the return value of all three clk_prepare_enable() calls.  It returns 0
even when a clock could not be enabled.

The function is called from the probe path and from the system resume
path.  In both cases the caller continues to use the controller even
though the clocks may be off: probe proceeds to sdhci_get_of_property()
and sdhci_add_host(), and sdhci_at91_runtime_resume() calls
sdhci_runtime_resume_host(), which accesses the controller registers.
Accessing the controller without its clocks can hang the bus.

Check the return value of each clk_prepare_enable() and unwind the clocks
enabled so far when one fails.  hclock is enabled first and is needed for
the register accesses inside the function, so it has to be checked as
well.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 7c4ac65f24..8acf2ddf58 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -173,8 +173,12 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
 	unsigned int			clk_base, clk_mul;
 	unsigned int			gck_rate, clk_base_rate;
 	unsigned int			preset_div;
+	int				ret;
+
+	ret = clk_prepare_enable(priv->hclock);
+	if (ret)
+		return ret;
 
-	clk_prepare_enable(priv->hclock);
 	caps0 = readl(host->ioaddr + SDHCI_CAPABILITIES);
 	caps1 = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
 
@@ -223,10 +227,21 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
 	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
 	       host->ioaddr + SDHCI_PRESET_FOR_DDR50);
 
-	clk_prepare_enable(priv->mainck);
-	clk_prepare_enable(priv->gck);
+	ret = clk_prepare_enable(priv->mainck);
+	if (ret)
+		goto err_hclock;
+
+	ret = clk_prepare_enable(priv->gck);
+	if (ret)
+		goto err_mainck;
 
 	return 0;
+
+err_mainck:
+	clk_disable_unprepare(priv->mainck);
+err_hclock:
+	clk_disable_unprepare(priv->hclock);
+	return ret;
 }
 
 static int sdhci_at91_suspend(struct device *dev)
-- 
2.24.4



