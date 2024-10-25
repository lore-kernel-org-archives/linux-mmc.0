Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09321BF2B;
	Fri, 25 Oct 2024 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836066; cv=none; b=c3aojPPhlT/iX6b7UTabguTUpdbw7pIPBnRUpixE60p7U6h9HPJpxsdZIbCFajZPMFIdU5AGsha+u/FonOa+zdbLLwimosook0Re1QhwzHrVxmCp3eOW0WfKw2rDS3644Abv/aO+ISZuGSZTTjngidygY0Or6E1DYy9HRo270cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836066; c=relaxed/simple;
	bh=OS0UVRvlt1s9coimwIHuyfG3Bm4e+hCBpF+aO3huxw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iI1348Reeg3nolVIBoZekehLLVWm7gHdUSZiSKL4bKhcq9DNFYMAvF8ErGvU8U2In74fLS01iNqo+ngRqosQo6H+U+FWi0v9TzdOnhZMyPTXl+nl6VyPqMDmzRUP62X3rtsZpb0eU8wgzSOFmBwT1VwvhD2SDr7O9A7yJKQ4T8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey7ssW+G; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey7ssW+G"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso1119386a12.0;
        Thu, 24 Oct 2024 23:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729836063; x=1730440863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cHsltCjYk2l8xbGPXpxva0UoOStLYFhJUfhmHUZULaA=;
        b=ey7ssW+G+esUXbbi01g6SD2XUWeVr69LV47BWl2rvVP6597TxD18w/LAQPvrIrU6K9
         //V2Xy6Mj55aLr2S9hhqrv23bW8rxWDs53nCCewtZye91NxcLoOakH/kGb702STwAW2j
         x5bv1eQza43n9VBHEaviLsGcV/fiaymMmtCUGjbwaAKeXZs8uVl6mv2p+oGMBN56Abnl
         o10BhejZJoH5HD5Ab/hpfrHjIXjdZEIn9cW1ANkQpCwvaUh53D+uzd3YGqpQRDvNAt9b
         KYUCMQ4iD6wL9PFsoqJapshj8KEcYd2tLXYhUemBmezpewMiDw3Bphc2OX5A21dhr1nD
         ezTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729836063; x=1730440863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHsltCjYk2l8xbGPXpxva0UoOStLYFhJUfhmHUZULaA=;
        b=d0L9dOYsP5m/H8pGV2C+mGaLQO/Tf3CCBDezEa5Vv2VB1/9YrjcJoVw4gPw6eKL7G3
         ZJypiL1vu6q6nytNd9mJoJkKj+wiTCak8b6all/JwYOObLqJlkGqyRPJIbdyqx/3OfQK
         D8Xue+N2Ih2Bn09uk/HTKF4+sJaRSDIz1uU/97BFg+bzJcziI6q6zg0qo+BqjJiuhcjK
         D9kPE3fvAwvpcHmcVawiA52I+BCPWiFXhqfkotKy0Z66llQ1J/NFkzliwm+cgyKfaLbO
         2W7SKETP7lDZJm9IcmYe7cuZQsqY6kHkSPCMUBk1+Pu2FE/Zid0ysHPNbdXHVtc3p7Jf
         Pqbw==
X-Forwarded-Encrypted: i=1; AJvYcCVy9Dbf4bt+OwIgkZRTns0LSvgO0q+jFK+Uz/t5/NPKDOo4SVwGfvmYsN1ZlSxt9YJlgkXS15BkuIMz@vger.kernel.org, AJvYcCWpqyEq/mhl7mkMoff+E2M1WVi/MdaY0TCeSZ0/PvY/X87u4hNLT6R3LdJqmv+ul5TUO6GbZJ8ye0ufUQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3dZmZYI1wM11iv15nIPMvXSYOBBUyx4saCAoq17IJwJstAN8y
	XZi6dKqyhWS/j8XZb/GtMs3pnrnmhd0Qgy+5yDXfW6frq5OuhHs9KcA5Ww==
X-Google-Smtp-Source: AGHT+IHNBMW8srxqG4xJuBBdWY52yy2dbGfJ2RwXjMtKa47S+m3uV66e2GjLQDwz+nLf178+BZGbVw==
X-Received: by 2002:a05:6a20:9f89:b0:1d9:761:8ad8 with SMTP id adf61e73a8af0-1d9889975a9mr8988513637.21.1729836063025;
        Thu, 24 Oct 2024 23:01:03 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a3c024sm363557b3a.192.2024.10.24.23.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:01:02 -0700 (PDT)
From: Ben Chuang <benchuanggli@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	victor.shih@genesyslogic.com.tw
Cc: greg.tu@genesyslogic.com.tw,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Lucas.Lai@genesyslogic.com.tw,
	benchuanggli@gmail.com,
	victorshihgli@gmail.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: sdhci-pci-gli: GL9767: Fix low power mode on the set clock function
Date: Fri, 25 Oct 2024 14:00:16 +0800
Message-ID: <20241025060017.1663697-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

On sdhci_gl9767_set_clock(), the vendor header space(VHS) is read-only
after calling gl9767_disable_ssc_pll() and gl9767_set_ssc_pll_205mhz().
So the low power negotiation mode cannot be enabled again.
Introduce gl9767_set_low_power_negotiation() function to fix it.

The explanation process is as below.

static void sdhci_gl9767_set_clock()
{
	...
        gl9767_vhs_write();
        ...
	value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
        pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <--- (a)

        gl9767_disable_ssc_pll(); <--- (b)
        sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);

        if (clock == 0)
                return;  <-- (I)

	...
        if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
		...
                gl9767_set_ssc_pll_205mhz(); <--- (c)
        }
	...
	value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
        pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <-- (II)
        gl9767_vhs_read();
}

(a) disable low power negotiation mode. When return on (I), the low power
mode is disabled.  After (b) and (c), VHS is read-only, the low power mode
cannot be enabled on (II).

Fixes: d2754355512e ("mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for GL9767")
Signed-off-by: Ben Chuang <benchuanggli@gmail.com>
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 35 +++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 0f81586a19df..22a927ce2c88 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -892,28 +892,40 @@ static void gl9767_disable_ssc_pll(struct pci_dev *pdev)
 	gl9767_vhs_read(pdev);
 }
 
+static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, bool enable)
+{
+	u32 value;
+
+	gl9767_vhs_write(pdev);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
+	if (enable)
+		value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
+	else
+		value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
+
+	gl9767_vhs_read(pdev);
+}
+
 static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct mmc_ios *ios = &host->mmc->ios;
 	struct pci_dev *pdev;
-	u32 value;
 	u16 clk;
 
 	pdev = slot->chip->pdev;
 	host->mmc->actual_clock = 0;
 
-	gl9767_vhs_write(pdev);
-
-	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
-	value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
-	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
-
+	gl9767_set_low_power_negotiation(pdev, false);
 	gl9767_disable_ssc_pll(pdev);
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
-	if (clock == 0)
+	if (clock == 0) {
+		gl9767_set_low_power_negotiation(pdev, true);
 		return;
+	}
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
@@ -922,12 +934,7 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 	sdhci_enable_clk(host, clk);
-
-	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
-	value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
-	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
-
-	gl9767_vhs_read(pdev);
+	gl9767_set_low_power_negotiation(pdev, true);
 }
 
 static void gli_set_9767(struct sdhci_host *host)
-- 
2.47.0

