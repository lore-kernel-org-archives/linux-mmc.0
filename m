Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356DE2EA749;
	Wed,  3 Dec 2025 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762350; cv=none; b=tiNp6K30y+Tl2k344zqs+wOEZNP7qezYo0NWmDthPAaQfTQF5apqgoXuFj07XpVUcveWw+qLVlm86+k8C4AexRvbqPO42u3X9k/o6z7Q3YrtKO9FbSWkRL1LzcjNJ8NQYQk12jn5uczeSLJaDPEOfQEPqwQEUmDaKLfIJxV7r8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762350; c=relaxed/simple;
	bh=ahjRyiyy4S968JVuF+EhGfPwRd1ZGT+Km4oxLletDsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DvPVx0l/e0EZzrvuyP4UUYc6MQpSX/hvE4yAm2Cs+wezl5c60eG3p9ym9VVj4BnRi0sme575MYzL2R0SZAdwEC2OA5HF6oZTMyVuDe46G8FawZeqKpTksn+m5KMqJUQtiSTSVg7O00jehNtghnRW1YYwpJeeq5GZGC2Gsl3X4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iJn0iSWE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iJn0iSWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764762346;
	bh=ahjRyiyy4S968JVuF+EhGfPwRd1ZGT+Km4oxLletDsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iJn0iSWEQmtFsbubE3gmj/Ic4HB8XEFrxrutItAOSZPJk1hxyLk8YcqaMoX4kafrK
	 EMTV5ahylVkRhWZ15NkNCmx7rMEm224FVu5E9WmdZHym47b+7z/3CW8O9DOmX1753p
	 ppZd62GnfzQGm7PdbED361aJ4letvhbjjiFxMrTaM84SdUQ8r9VqEbFdrB3bZnl3Hi
	 OiJIbDk1W9ACEVfKmjC38jpKzADSbSrfiv54Qp/rOkfHVED0eiKN7Vskp7jmozjoZh
	 ihaf46vl2biX9vUeIuLuCzTGodYN/xHSdiz+/9ADxvAr2kyTfA0O8V9RKZOLqPjBTj
	 IhyJwe2ipYl6g==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B54DA17E13F1;
	Wed,  3 Dec 2025 12:45:45 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 03 Dec 2025 12:45:35 +0100
Subject: [PATCH 2/3] mmc: mtk-sd: add support for SPM resource release
 control
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-mt8189-add-mmc-support-v1-2-f5ce43212fe9@collabora.com>
References: <20251203-mt8189-add-mmc-support-v1-0-f5ce43212fe9@collabora.com>
In-Reply-To: <20251203-mt8189-add-mmc-support-v1-0-f5ce43212fe9@collabora.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Wenbin Mei <wenbin.mei@mediatek.com>
Cc: kernel@collabora.com, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764762344; l=1669;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=ahjRyiyy4S968JVuF+EhGfPwRd1ZGT+Km4oxLletDsI=;
 b=I0kjEvvw1OQmZ7oj5gQdhB1Ho/OdyfiGdvfiBs3audUDZdLcvg19Po5Bnc42qT2rlji4W25OE
 izn4aDlrQI/AD+Tv1sC/zgZ4deRXQfM9lktB2rw/Iy/e7RJljjas8lb
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The MT8189 SoC has in the status register an additional bit field to
release all System Power management (SPM) resource requests.
In preparation of MT8189 SoC support, add its use in suspend callback
and a support flag in the platform data.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index daed659f63f6872423edd755478f0ec57e7742b4..4ce596d616409646613748086476c58d8b7b8de9 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -203,9 +203,10 @@
 #define SDC_CFG_DTOC            GENMASK(31, 24)	/* RW */
 
 /* SDC_STS mask */
-#define SDC_STS_SDCBUSY         BIT(0)	/* RW */
-#define SDC_STS_CMDBUSY         BIT(1)	/* RW */
-#define SDC_STS_SWR_COMPL       BIT(31)	/* RW */
+#define SDC_STS_SDCBUSY			BIT(0)  /* RW */
+#define SDC_STS_CMDBUSY			BIT(1)  /* RW */
+#define SDC_STS_SPM_RESOURCE_RELEASE	BIT(3)  /* RW */
+#define SDC_STS_SWR_COMPL		BIT(31) /* RW */
 
 /* SDC_ADV_CFG0 mask */
 #define SDC_DAT1_IRQ_TRIGGER	BIT(19)	/* RW */
@@ -448,6 +449,7 @@ struct mtk_mmc_compatible {
 	bool use_internal_cd;
 	bool support_new_tx;
 	bool support_new_rx;
+	bool support_spm_res_release;
 };
 
 struct msdc_tune_para {
@@ -3296,6 +3298,10 @@ static int msdc_runtime_suspend(struct device *dev)
 
 		__msdc_enable_sdio_irq(host, 0);
 	}
+
+	if (host->dev_comp->support_spm_res_release)
+		sdr_set_bits(host->base + SDC_STS, SDC_STS_SPM_RESOURCE_RELEASE);
+
 	msdc_gate_clock(host);
 	return 0;
 }

-- 
2.52.0

