Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFB279D0;
	Thu, 24 Apr 2025 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745466374; cv=none; b=fHpX+bHdG3lztZLDAzme6YMzUJ39GRQtL6z2puGb0wSo54m+xauEiLXkVIiwnYRXUvqs1WZU8BHJUoLhxWGTJ7mxGEt2eZ65tgjxs1OqMdUUxgcz88UhuzZJl5H4PKhgZegSYXaqhX5Z//cpYCTFnhGGlwJyAGaqZePVtOh2+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745466374; c=relaxed/simple;
	bh=2Td0AwsHkUVXDPsjyguJ9OY3/fBE9LakHh4ZmZh77ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z72xl2FitjwKZQVS5O/9XMtPsNSUZharqfaDxqoKEHD1RmbZikVrsyXquMtRAdQFrmelPaqmE2jIZO3lgPVF21GRQnYq/vIB6wma2YIBPrhqf1+kLKnSoenWpowDO0N+DRMHlvJc2cl/+WF3PLwZa0WVinSAR6ANHQeCQU5Du/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wNqPmEV4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wNqPmEV4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=nDtHf9Db7AVpWkb0XrbJTdjcy64DwhugRpM3MfPBnyk=; b=wNqPmEV4b2sTEuEWQ+w4fjzAh0
	LhMLp9WtNviJ/HJg/fiWXJZZ+wT/XN0156FNKWNj/PPHDQAZ/FSUHsN57c4GIQA+8dlNqk3k7WWvR
	lplSeD7wKaV6v50689BqV+WGL66+2HhKwlCH742aSYDzCcHqKkQS8Gt1S7Q2TlWveRXU4vGwxl2nf
	ATHefg7YQoRfM8AA4j2TJBTq5yDnorqiqMzOkJzX7atWDu3x79gpUYrwBdGi4p1+eZ7A1+hfeHzMV
	0JyDrFj2mORaa1EjYYXXq4fkTyCOECImGqRyncGqeZQDCqEQLmutg60fAXkb8sM/UQzTIoIrEE+nc
	XbOtwf5g==;
Received: from [50.39.124.201] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7nXP-0000000ClR3-1k3D;
	Thu, 24 Apr 2025 03:46:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Luke Wang <ziniu.wang_1@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Haibo Chen <haibo.chen@nxp.com>,
	imx@lists.linux.dev,
	s32@nxp.com
Subject: [PATCH -next] mmc: sdhci-esdhc-imx: fix defined but not used warnings
Date: Wed, 23 Apr 2025 20:46:10 -0700
Message-ID: <20250424034610.441532-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warnings when CONFIG_PM=y and CONFIG_PM_SLEEP is not set by
surrounding the 2 functions with #ifdef CONFIG_PM_SLEEP.

drivers/mmc/host/sdhci-esdhc-imx.c:1659:13: warning: 'sdhc_esdhc_tuning_restore' defined but not used [-Wunused-function]
 1659 | static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
drivers/mmc/host/sdhci-esdhc-imx.c:1637:13: warning: 'sdhc_esdhc_tuning_save' defined but not used [-Wunused-function]
 1637 | static void sdhc_esdhc_tuning_save(struct sdhci_host *host)

Fixes: 3d1eea493894 ("mmc: sdhci-esdhc-imx: Save tuning value when card stays powered in suspend")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Luke Wang <ziniu.wang_1@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: Haibo Chen <haibo.chen@nxp.com>
Cc: imx@lists.linux.dev
Cc: s32@nxp.com
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20250423.orig/drivers/mmc/host/sdhci-esdhc-imx.c
+++ linux-next-20250423/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1634,6 +1634,7 @@ static void sdhci_esdhc_imx_hwinit(struc
 	}
 }
 
+#ifdef CONFIG_PM_SLEEP
 static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1688,6 +1689,7 @@ static void sdhc_esdhc_tuning_restore(st
 		       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 	}
 }
+#endif
 
 static void esdhc_cqe_enable(struct mmc_host *mmc)
 {
