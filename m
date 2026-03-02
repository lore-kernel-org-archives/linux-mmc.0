Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66041160B
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464437; cv=none; b=Xx2GKpBsSI9Mb2+Ou3em1fk/yiwL0M2ZZ/HAQHSgxp/PkvLcsYn+ytdwsHzobnDgdCEAN1+q019C9JDTAitJP2bd5NMm53KupHMlyIdTfYCIzRe1rbellFh9ClxQg9tPTqmnOj/eEvdjG3n6JIvGovG9VE/m7a214Vo/xvTdmEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464437; c=relaxed/simple;
	bh=SX99H5nWyHLgqEfAA8y8YXcLLBYPw3yIqFfWFk7yuwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DXT0Nj96itJtDdXLjaAjU+gRi5GXUCim85revxXbVRgWFVLn9DwWIVWgETX9Jf2RVrHOeEQCXn55ECjzMPfNCeIcLs/q7bmdkIGpxYb951yn71laqDcLgPQ1nPhuN7SAMjLKRB/G2sqEfidPyxEv3geO9fQL/yuM/iSoerkz0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMcxR6Gi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMcxR6Gi"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4833115090dso47404545e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 07:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772464434; x=1773069234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPno2RjoHZxgUnIZr6lB0hz/wV8TjU09ZahXKQxHzqQ=;
        b=nMcxR6GikrAIBr1jHaFwGnIgSyIpLkVtQ9cWEoR7BRDncP64+upobB6gCOYD3aBNut
         XXoyeJkguFIwsIgrvpg1FSa8NdxfEghSbneMJIBlpC9RbD511hjbL/3c8b13tw94f5fE
         U/pgWVPnkcD/2/FsJwDI/OUBD5EREFJ7dYcNqVYeGAvLjPeiftzBulcyyvN/EN4blM9v
         k2gnKd+uZ3ol5Z8dG8PWzKkSCgvmtCS01wPwgxFz4k6D33JxOV3Cqd4cmo4leMZLyyc2
         5MqiFpjpPOMdO3dE/DXdnqTZ3+bGzi//RSQgxOIFPnLW/M99dOOO4B2tAxRuhgAmAQId
         0jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464434; x=1773069234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xPno2RjoHZxgUnIZr6lB0hz/wV8TjU09ZahXKQxHzqQ=;
        b=AigBg6A4xHjM4vH09zZiwRJenfINqmR/a9vdsuWOiBjGo1D+u240gsTEit9NRAC4kk
         AL71XqEjpQ4DTAcTLmvWW5qUHVurLDWuQrwj8COAVuXUKWtqB5sEB3/WWXYJA2URnwQd
         E7QBA0imPOU70goaFpHUilnOsOMHJ2NvWQFrcPembdozB5hsQnGNbKaaPx+ps5wsHGNS
         tU6mSBj8DZiZ9dr0+bp+SAEG+BG49gU5FoMLwPw4b/6LVpN9V+oCMUuCw2OMh/8Dr6I1
         hapglZSAD1N7CTAD8pB0z4FPhZcAUNvBOClIkly9I7Mt5IwSypgK0qjXjc8r/WHPB+yW
         2c/w==
X-Forwarded-Encrypted: i=1; AJvYcCUFefJuioN7BXFnqVSb4xZvwz+ftyb1wqnIIfycWER+xth9Wr26fQqs5/d9NmtjfeUCkKpH+h5q/ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5p19aYXUAhjMk9mpjMTbS/z68JQCazHjWGNzk2Cp87hICixj
	Tjx9LpGTfxxQ3HQbDSo88fJirtvTm8Bm9jkNPDrtSku2QvMVXLyZfbGJ
X-Gm-Gg: ATEYQzzLc/fBy25ahFOkxV3CRRSaLhOprIxObb5S5kSnzPSGvu/HreL84LsZ0ioEWBZ
	VSsF+bbEtvSXEVQ/3w2kE/chHoge0wGBdPV8hqQoblXT9H1dfzInoU0a4KQpC3ndaAPhPXyPpIO
	C4YP5DWCSPdBgcsqvfXVcqlVd2v48yxl1UF4Jk5dhy3AYIHT+GILXw7bLx0hikyTHMZlRBHaT58
	XJWR3b4FgCpC2GDfw2tcHSR7CW0gPAq8okds7RYQOlKPGbqRrN7zCWTrnVVDQHv3oelT1BROvCX
	V9I+1KGwQAMRjxhuV/vlCvnWeA8qvKCMnNF2FFGQVXYvO7DBePBlloBliPGKc1k8gmIHLqauHEa
	71nPfRTKg1Z65mJ6h7uDldbAmWkxa0WJD5bk9l9XNKsHT3tGZm6v82nOtpCdOfe6laF/HulU/S/
	pXA4zGakM524r0+zmqgoIXolZxGlKT1c73E53lv4tIcxncrTBi8OVMElAzWSDHEHiZZvI+tu90m
	hW0
X-Received: by 2002:a05:600c:b86:b0:480:4a90:1b06 with SMTP id 5b1f17b1804b1-483c9c196a5mr205940835e9.34.1772464433577;
        Mon, 02 Mar 2026 07:13:53 -0800 (PST)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm437240265e9.7.2026.03.02.07.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:13:53 -0800 (PST)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 02 Mar 2026 16:13:24 +0100
Subject: [PATCH 03/10] mmc: sdhci-of-k1: add regulator framework support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-orangepi-sd-card-uhs-v1-3-89c219973c0c@gmail.com>
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
In-Reply-To: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

Add regulator framework support for voltage switching operations. This
enables proper PMIC control for UHS voltage switching between 3.3V and
1.8V signaling levels.

- Add regulator supply parsing
- Implement voltage switching callback
- Enable mmc regulator framework integration

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/mmc/host/sdhci-of-k1.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index b703b78282ed8d89183c816477c149c0a565618a..c260cb89704ae7a25bec0f07831d495553405bbd 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -216,6 +216,12 @@ static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
 			       SPACEMIT_SDHC_PHY_CTRL_REG);
 }
 
+static int spacemit_sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
+						      struct mmc_ios *ios)
+{
+	return sdhci_start_signal_voltage_switch(mmc, ios);
+}
+
 static inline int spacemit_sdhci_get_clocks(struct device *dev,
 					    struct sdhci_pltfm_host *pltfm_host)
 {
@@ -291,6 +297,12 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
 
 	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 
+	ret = mmc_regulator_get_supply(host->mmc);
+	if (ret)
+		dev_warn(dev, "Failed to get regulators: %d\n", ret);
+
+	host->mmc_host_ops.start_signal_voltage_switch = spacemit_sdhci_start_signal_voltage_switch;
+
 	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
 	if (ret)
 		goto err_pltfm;

-- 
2.53.0

