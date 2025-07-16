Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F854221F38;
	Wed, 16 Jul 2025 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662624; cv=none; b=lWqdILpDl1jBuQZkOc8gcEew+ir++vQ959CVeqVvX51/SSPX831ZpI4fk4CF78JoKyUxBIEveVwF54MDo9BWcg0DMpwG1n0WNWL3E+krcOjl5kR8K3V12eziuKmVMNXU4jFPJfYDCcE9LITuvRLVz6frmzDfeEMSZh9k1B2or4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662624; c=relaxed/simple;
	bh=DSS12tYkb9gpA8k48tPe3Spyi8HtEl2WRA7zK0gVzOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e0+q9AkQjvZGKWhRorM2XZvXFmhY1BSsnvPBl2ttM0SGD0fnr2aoCfPqP7RXmxM5qu13YCtTbxvWagGaq9Uu1vn+Q1cjLgXaxirlAjlLMjO3PII3vfMjpCg6+8vT/RRUZPtjTBOM4N1tX1ZIEFH+TC0kRtZiinD5/ZxK84j29sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYvD4Q1X; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYvD4Q1X"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-748feca4a61so3691452b3a.3;
        Wed, 16 Jul 2025 03:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752662622; x=1753267422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqHz3LAqr/WfrRthPIXWiwm5tyxxKiyEt4eW0IKFByc=;
        b=MYvD4Q1XBExEVUo93hxLnOy47mwvE+qvuENuTl04Ssfl6hG622WYGIsDpYbySfKSLg
         O6TtEnhzksjgrK02CGnrpPzba9XQrv67wqIZ+lTaQGApRa8Co00AL0LEYs7SFe1MWVmv
         M+PtdiEQPVfPgZLuB4tskA6HxSJSiUMHwFr3hPdUxZzMQQtQ2AJQtrsCLkuJnxiyrVUM
         e57nKKl9VMpXjncAyzoTDeeAbCqnUeHQIFQXN3YvdtSbF/P/ypgE9OyP5SAH98OD5Ju4
         UQwmCIdHcp/Pxv94LO0kNRirrAQLEVHI1p6m6UnHzL5ZIJGd4BwZIAuWzSbHu1c4ZIwD
         UWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662622; x=1753267422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqHz3LAqr/WfrRthPIXWiwm5tyxxKiyEt4eW0IKFByc=;
        b=eJnuIkjV7PLpHabEDomqe95qugLmn89VqYENrsROrRy59gTkextjMWjqEEZjwYDOL2
         jmq4nipfP9uoObCT7U5atC3yHhLetgeq6g4kRiNs8vYBQ7nVLpgzS1Lbm21UvOStL3cj
         Ek0tMvdubaY1omWZZDmf0DmsbpXNTuTblxsd/2HUe30JxEN3tD8vAr7TP93bnjYut/O5
         20yu9bOM6R52kMhGSzu9ErVTSNDkedh56IZryAoK9jSZvLLCjoFUTxk/cGIgHs7ImZDi
         p25gqQ6YVRrLykx9Zm8qYkLs50vr+tEKUTPZe/bRQa5mmot1lOuEt69U2DF/sXOQARIQ
         81tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt+KNGv9JpyEOE7ylNJsFgp3tvQt4X2M1C6A4x7OWbRgo8BJGfscKkVTgDj86U32YA+wYcWQoysP4xJwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbigMPhtpjOuJRDGsh3nALu5RPXLrzk07vBHYHQqgPWkGKdyLk
	CFxiEVLLygor4/IS434iMedh7bXnuDYdAk6iq3vUMbL3f9bZSmvnUtba
X-Gm-Gg: ASbGnct48FuOqQUpkwL2mDl52rXh/eKUZsomZdmMP/93nbcrX1r5yGmiacqhPiNs0Ps
	3w9dIh8AwbvX68UpsdLtHjeZtRSFljVNk9cWoo0LrIidSDtCw/x3qQYxqA7UmrqE6kXqCtDHcYd
	jfo29fyXuIuOBnzLJFtSwYqkBzL0Owu1BSSsiAnEP3MaMmFKxfu7C7WjrwyFjVSEhImbZzBef/0
	OaTqy5iR0NMsbUAr1QC48+/jU7xqsjxJLItN07KY0+DiEzGeYS5cSlgIJjRKjSiVRMGHYMJTJDL
	aA0eCLVIFXiOT3dVWxJfYtXBEhKgkgX5Z/Kchf0M0xNGlqtw7UjmFVmp9bU/8iK7naZCYet2GaP
	9QEFzsc26CuX68ZBeeYGaGCDbIOhu0GVvepXQMtFh
X-Google-Smtp-Source: AGHT+IGtF7p5vbbiq8GwYN/PJMWf0axj8zu/NbAS1y+ksEiP135eXQg42/kcUxDpIMMltw/Yl2cNJA==
X-Received: by 2002:a05:6a00:14d0:b0:74e:aa6f:eae1 with SMTP id d2e1a72fcca58-75723e744d2mr2950355b3a.14.1752662621615;
        Wed, 16 Jul 2025 03:43:41 -0700 (PDT)
Received: from victorshih.. ([2402:7500:486:ad4c:7324:5bd6:835d:4ac5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f856fdsm13914933b3a.144.2025.07.16.03.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:43:41 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V1] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER
Date: Wed, 16 Jul 2025 18:43:34 +0800
Message-ID: <20250716104334.44020-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Due to a flaw in the hardware design, the GL9763e replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9763e
PCI config. Therefore, the replay timer timeout must be masked.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 4c2ae71770f7..eb3954729a3c 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1754,6 +1754,7 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
 static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
+	int aer;
 	u32 value;
 
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
@@ -1780,6 +1781,14 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
 
+	/* mask the replay timer timeout of AER */
+	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (aer) {
+		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
+		value |= PCI_ERR_COR_REP_TIMER;
+		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
+	}
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
 	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
-- 
2.43.0

