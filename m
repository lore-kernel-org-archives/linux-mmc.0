Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7C42AF81
	for <linux-mmc@vger.kernel.org>; Fri,  7 Aug 2026 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100894; cv=none; b=N2BeZZRuBgR4fiJHJBFOtx8fLqdYoi0km1Vc9cui7KVFw6QJ7FtqGNPd9vQkRdQCcfBT7Jp/O3vBHFTOTCR2o7RE9PPzFFgnwvef3QD7mJk6eI8swXGcRGXbqmGIbrkxYR618vJhazAzQIJvL6fVRh74fZGfQun1oaOBtEKsHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100894; c=relaxed/simple;
	bh=ab4w8kAlsLeeZoPBf4+pwel3RUxwrQTDv2eg2AaFm3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLqrgs9D8UJaMH2rvImaRTCKxzkn2OEsPxehGQiCv5BsoYelCBRYV12YV/hMqxdrnlPntAt7mAyS3ECTWmKdbCuLFONyjhv56gqFut8u/d2/bp9EX8olVlwihDEbWCgURMbUQEIltgDxpHw5qE7oRGmqnc2M5peQK2rSopTjznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hSVOCwcf; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hSVOCwcf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6FF8D4E41139;
	Fri,  7 Aug 2026 11:08:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45926603F0;
	Fri,  7 Aug 2026 11:08:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4ACE911C37640;
	Fri,  7 Aug 2026 13:08:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786100882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Cl+MrkhTI98XR5CEBmWrLiHyfW5jBWSrkGOaLvL5f9Y=;
	b=hSVOCwcflpoE9WFuPxQtrI38oGIxWAO9geBNbdw9hNKKRS+20MG10sxS80WNtYfpDg9JWo
	kkIjddxRZtqn6S9p3MCwI2pgi3uvdBQ31rcuJZiyKk/UeiJwBsLvIsTKh4xhkNsiQ9S2j/
	0DnjeznS6Lh/g5+2ipqdy/F/cxPZ+IRG7P4kf7/3exEpNqJFd8GWTAA0uXlwuDGXdG3LYy
	ilvMHDCaRNiJJdk8ryX1EWTfYCRF608/y719qQyIuMo6BNW6NfzMqOyoeI5QQEj0gZ7wDY
	vidyHZm9eAnkJrT4iJJy+Tb02vcjXcmQ5zCn1wBDY0bz/lA0oLo4M/0UV25HOw==
From: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
Date: Fri, 07 Aug 2026 13:06:57 +0200
Subject: [PATCH v3 1/4] mmc: sdhci_am654: Move tuning_loop to local
 variable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-am654-sdhci-v3-1-acc91d7d7e50@bootlin.com>
References: <20260807-am654-sdhci-v3-0-acc91d7d7e50@bootlin.com>
In-Reply-To: <20260807-am654-sdhci-v3-0-acc91d7d7e50@bootlin.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
 Faiz Abbas <faiz_abbas@ti.com>, Judith Mendez <jm@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Pascal EBERHARD <pascal.eberhard@se.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2101; i=diogo.ivo@bootlin.com;
 h=from:subject:message-id; bh=ab4w8kAlsLeeZoPBf4+pwel3RUxwrQTDv2eg2AaFm3A=;
 b=owEBbQKS/ZANAwAKAQa+fFtWXslFAcsmYgBqdbyGasACcCgr3CUnpIQscMjNQACAA+9iU2CEf
 0p3Ow/piCeJAjMEAAEKAB0WIQTma35o1i1081e8B2UGvnxbVl7JRQUCanW8hgAKCRAGvnxbVl7J
 RZ8AD/wJlPwpve+fPu3KdmOzraDgc66RaJLC6huvcFxH1yP0oh5Pgce0whTqnowQQbAxzzOeM94
 l5JxOXVLYV+f09VseY83zRYhM7BYXbbSp1ZL7kvcW6Z6Wq2tFd946so8Pl8dKmi/m9AVQRS6UBM
 QP9b/wz4olViNabwYNniwq0i5LP0wVqhUxa7epJZWVVHXHwAd84JHs5nYdeaJwT6EWzdqQrrQDi
 uKNr1OKKGByva/bn3msutoCtfcWucjVqcMz6alB/7tMNjhWJ2Ljo+aDA7f5J6USvwgECT5dSgr5
 BJVHDlOXvBv7SAcgQe20KS/lu5H2lFETmX4ZUKVrpjWBwyzd30XXBlz4FNuEiq0A2vAuUPXr/Ly
 rXXzB4F5Atmekr9tkeYWk73WfRK4Wp16hjFAoyVF4DNaANyaQFMPF4weDsH284NwdOG8ME+thwu
 iOpPTkSjQnskYKupPfkp0/v9JpzvjJUZjWXUOWJJkcs3yyBdfv0NTncXxK6k0S9I97h8P004Qfw
 UzTnj3VKtV3Y+NCYv1ziTqEFhhpFA0yiPomQm4cZHcpLKzRHEOkh/byVzaAFLpej0Wb0D79zDqy
 x+WfYuauOikcr3XRGd5DEfEMJ+FRsGol8LuooGqw/abMUKlNheC2zRvMi+Nzgsd2/sLYi3qT5Ib
 PX6lQRkbVqpzBpg==
X-Developer-Key: i=diogo.ivo@bootlin.com; a=openpgp;
 fpr=E66B7E68D62D74F357BC076506BE7C5B565EC945
X-Last-TLS-Session-Version: TLSv1.3

The tuning_loop field in struct sdhci_am654_data is only used within
sdhci_am654_platform_execute_tuning() as a loop counter that is
initialized to 0 in sdhci_am654_init(). Since it shouldn't persist across
function calls, otherwise every failure expends its "budget", move it to a
local variable and remove the struct field along with the now-unnecessary
initialization.

Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
Reviewed-by: Judith Mendez <jm@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changes in v3:
 - Collect R-b from Judith and A-b from Adrian
Changes in v2:
 - New patch suggested by Sashiko
---
 drivers/mmc/host/sdhci_am654.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index d235b0aecfdb..35c3efd92112 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -151,7 +151,6 @@ struct sdhci_am654_data {
 	u32 flags;
 	u32 quirks;
 	bool dll_enable;
-	u32 tuning_loop;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
@@ -576,13 +575,14 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	struct device *dev = mmc_dev(host->mmc);
+	unsigned int tuning_loop = 0;
 	int itapdly;
 
 	do {
 		itapdly = sdhci_am654_do_tuning(host, opcode);
 		if (itapdly >= 0)
 			break;
-	} while (++sdhci_am654->tuning_loop < RETRY_TUNING_MAX);
+	} while (++tuning_loop < RETRY_TUNING_MAX);
 
 	if (itapdly < 0) {
 		dev_err(dev, "Failed to find itapdly, fail tuning\n");
@@ -806,9 +806,6 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	regmap_update_bits(sdhci_am654->base, CTL_CFG_3, TUNINGFORSDR50_MASK,
 			   TUNINGFORSDR50_MASK);
 
-	/* Use to re-execute tuning */
-	sdhci_am654->tuning_loop = 0;
-
 	ret = sdhci_setup_host(host);
 	if (ret)
 		return ret;

-- 
2.55.0

