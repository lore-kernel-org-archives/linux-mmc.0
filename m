Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04677E6
	for <linux-mmc@vger.kernel.org>; Thu, 22 Feb 2024 00:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560060; cv=none; b=BYph4ZQGQ4AnkUZ7VLgOTcGOEImD+XwK+3vnXflyHVArEic4kmAXdg6zQ8//pLr3q6t6lBXzfmY++/mQpqmg/04cDqe+Asg3PAvp7QwPCigk27RGPzFUhguiij7S4llS72UwRerqVt1CYzU6hmaxz9QlZTg8vYA/2RdLU9Wf8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560060; c=relaxed/simple;
	bh=dBZqLq2JOkI1sc2+c2AsT7N79DcI+Fbj6CFaWyZGmZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sIlG7fTKMQTzsH0tZekh+uoY3mVq8Gur4K0DwoHRpsJd3iA5PJX0sykvMfQnIsgK/XUQUrZoxK7cZXfAWljtvby0Sri0Svv2xQTSkWChTFw1g6/5oGNih5iFZqoYFaT4NuYmTL0I0Mbvj8LdOhatAmMheSZYfUlo0MOoaEznKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KNnv7w9M; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNnv7w9M"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3566c0309fso868026366b.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Feb 2024 16:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708560057; x=1709164857; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zs9GpOa+Z9sJ5swlHRXtthwWBphPVbB6adU9CAjqlxI=;
        b=KNnv7w9Mg+yPx6cwhmWxvLFsLYDSvlScsNFVNreAcMN3Veob0PAGUhrdklScvSiNYj
         1pwaSP6gBVbIFrWHpB/LLbByQJw455RSrXCEY6KAy5+u0DK4LeyRhBDKM2iqYhc5UVlI
         tm92YoiCx8e2bRBzZEfdJdR3lghtapFfUPZ59WkYnfo2OYGztAn5zfzMBHPLES+Tq8yh
         ZgPmHJQG27NibfJEhUscc8qaF6Xj8FIrNU1T6Am7T7PQc3qZtIFyX/oCnFWk+er6PImT
         XP3MJSsmNSizmFoQGg/H7L4z3kVqN04CUm25ev/EUA8RLjpcdJEhdMZ2WsusN2ORciBx
         VHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560057; x=1709164857;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zs9GpOa+Z9sJ5swlHRXtthwWBphPVbB6adU9CAjqlxI=;
        b=iq5GnFCvviHA1/PKNRdJRqg87Sg/UemwvEyGXjYGmdRJlald+XygaeEpQIPmaAGwPw
         1ePhom31q9ddEujbGNu/k4MolcLoUClDIcg0a8CXcBK/p9IG1nuL3wmwwSj//cIGEO17
         pQJRr00C85schOwpq641NBH81gVZKIDKNxZ2a6DeTtmoPnuhozkKweBAMZ/2/0I2lFTD
         oG3csQX7iHEd7kHVUVoxYV2HbHf70NScn2c5a4p5frye10mz/E+Ox/7OXdqSvf5n208r
         FUC2CguL55G/ntMp1HT7gqGlg/qDyr78qrKupyCvOzDXnHqCDaA8dbWSuCPsclPklq8s
         GlOw==
X-Gm-Message-State: AOJu0YxUb1eg8RhcIfUtSRcZp6xSKju0fXW8PeRmwpnY6OAiVf6GHhpM
	gUI127e9bfps26P+tItJL7w0VrcaW7TWnu1tvZ8qk8oeatxjwDAOXkdK6+E8O64=
X-Google-Smtp-Source: AGHT+IFZ//3SEMGtyM+yNGR4TzaY6tUk9ULOUs3EhlAlHIQzTmqQ9pgY9B3EJ7ocrI4zNT+g4NrINQ==
X-Received: by 2002:a17:906:5955:b0:a3f:721f:a7ac with SMTP id g21-20020a170906595500b00a3f721fa7acmr493442ejr.45.1708560057107;
        Wed, 21 Feb 2024 16:00:57 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170907188800b00a3e0c8f4afbsm5250616ejc.110.2024.02.21.16.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:00:56 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2024 01:00:54 +0100
Subject: [PATCH] mmc: sdhci-esdhc-mcf: Flag if the sg_miter is atomic
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-fix-sdhci-esdhc-mcf-v1-1-fb87e04ca575@linaro.org>
X-B4-Tracking: v=1; b=H4sIALWO1mUC/x2MSwqAMAwFr1KyNhCDqHgVcVFqqln4oQURinc3u
 hoG5r0CWZJKhsEVSHJp1mM3qSsHYfX7IqizOTBxQ8yMUW/M8xoU5QNuIaL31HKgjnsisOWZxLL
 /dZye5wUnRqv6ZQAAAA==
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The sg_miter used to loop over the returned sglist from a
transfer in the esdhc subdriver for SDHCI needs to know if
it is being used in process or atomic context.

This creates a problem because we cannot unconditionally
add SG_MITER_ATOMIC to the miter, as that can create
scheduling while atomic dmesg splats.

Bit the bullet and make the .request_done() callback in
struct sdhci_ops aware of whether it is called from atomic
context or not, and only add the flag when actually called
from atomic context.

sdhci_request_done() is always called from process context,
either as a work or as part of the threaded interrupt handler,
so this will pass false for is_atomic, and the one case when
we are actually calling .request_done() from an atomic context
is in sdhci_irq().

Fixes: e8a167b84886 ("mmc: sdhci-esdhc-mcf: Use sg_miter for swapping")
Reported-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-mcf.c | 8 ++++++--
 drivers/mmc/host/sdhci-pxav2.c     | 2 +-
 drivers/mmc/host/sdhci-sprd.c      | 3 ++-
 drivers/mmc/host/sdhci.c           | 4 ++--
 drivers/mmc/host/sdhci.h           | 3 ++-
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
index 1909a11fd065..7b0686701c6e 100644
--- a/drivers/mmc/host/sdhci-esdhc-mcf.c
+++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
@@ -297,8 +297,10 @@ static void esdhc_mcf_pltfm_set_bus_width(struct sdhci_host *host, int width)
 }
 
 static void esdhc_mcf_request_done(struct sdhci_host *host,
-				   struct mmc_request *mrq)
+				   struct mmc_request *mrq,
+				   bool is_atomic)
 {
+	unsigned int miter_flags = SG_MITER_TO_SG | SG_MITER_FROM_SG;
 	struct sg_mapping_iter sgm;
 	u32 *buffer;
 
@@ -312,8 +314,10 @@ static void esdhc_mcf_request_done(struct sdhci_host *host,
 	 * On mcf5441x there is no hw sdma option/flag to select the dma
 	 * transfer endiannes. A swap after the transfer is needed.
 	 */
+	if (is_atomic)
+		miter_flags |= SG_MITER_ATOMIC;
 	sg_miter_start(&sgm, mrq->data->sg, mrq->data->sg_len,
-		       SG_MITER_TO_SG | SG_MITER_FROM_SG);
+		       miter_flags);
 	while (sg_miter_next(&sgm)) {
 		buffer = sgm.addr;
 		esdhc_mcf_buffer_swap32(buffer, sgm.length);
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index b75cbea88b40..c1b49c2feea8 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -120,7 +120,7 @@ static u32 pxav1_irq(struct sdhci_host *host, u32 intmask)
 	return intmask;
 }
 
-static void pxav1_request_done(struct sdhci_host *host, struct mmc_request *mrq)
+static void pxav1_request_done(struct sdhci_host *host, struct mmc_request *mrq, bool is_atomic)
 {
 	u16 tmp;
 	struct sdhci_pxav2_host *pxav2_host;
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index bed57a1c64b5..a2b244e13451 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -411,7 +411,8 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 }
 
 static void sdhci_sprd_request_done(struct sdhci_host *host,
-				    struct mmc_request *mrq)
+				    struct mmc_request *mrq,
+				    bool is_atomic)
 {
 	/* Validate if the request was from software queue firstly. */
 	if (mmc_hsq_finalize_request(host->mmc, mrq))
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c79f73459915..3c6a9ba573cc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3184,7 +3184,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	if (host->ops->request_done)
-		host->ops->request_done(host, mrq);
+		host->ops->request_done(host, mrq, false);
 	else
 		mmc_request_done(host->mmc, mrq);
 
@@ -3639,7 +3639,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			continue;
 
 		if (host->ops->request_done)
-			host->ops->request_done(host, mrqs_done[i]);
+			host->ops->request_done(host, mrqs_done[i], true);
 		else
 			mmc_request_done(host->mmc, mrqs_done[i]);
 	}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a20864fc0641..c2ff327e2c96 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -666,7 +666,8 @@ struct sdhci_ops {
 					 struct mmc_data *data,
 					 unsigned int length);
 	void	(*request_done)(struct sdhci_host *host,
-				struct mmc_request *mrq);
+				struct mmc_request *mrq,
+				bool is_atomic);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 };
 

---
base-commit: 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
change-id: 20240222-fix-sdhci-esdhc-mcf-aa062c072800

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

