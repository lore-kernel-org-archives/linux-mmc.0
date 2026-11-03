Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701006;
	b=lD7XBj6zdXlvqXM92JScWYeOZENOM596k9W3i/sEbsCIW5zk8YzaoQl5A4fVfxU8KvLy
	 oxXN3vKYYzbMebSzibGHE3xiaqjAXEO9/EE7KYXrPY1J9mqez8Ck1fmA2/qxPKs48N8oo
	 i7ORBgGQqPzKzSTGfBOKs7TZ70zuho/cl6m6jzlY0sFtl1PgyKkfPwWiNQq3zvtCrYLIa
	 1PUPJH2LzjFc+8dloURuidBL1F4T9fK+9C+2MfWZxCaSAJ1ChRIIibV30rK6sfUJVbFty
	 p2X6ZNDzVj81qo6dg3aINPXeBTY+2T87Xb70gatHiinJIPrphJVwh74h0Wvmqa6kTAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AO+1v3uf2PG5kc86URqUg6dn1Nltq7/yDM8x6vv4Ubo=;
	b=EBqvPtoO2J3Q/NJazfTre5aq48Mbk+fQ0eFWMROix4AWB7KAZpfsw7GDgUb5xRnzKuKh
	 FfFvAY+jRW7LrPdGRAC8ezvAiQVC1STlEuxR9npy0cZ6Irgjh+E7SDM6ysV6YXr+NBuIb
	 KYRQbdZuSLcYAyglN/LuDG72JUBb+Il9eWZ6QLc6hCHqHqKlUklT9mXbwcxdII8hIxlP8
	 QtPn6YacVCeqX5M7MXIBVRolmSZD5vCRp5iVH+lidGx/5HK7t1wmIXkcHGa4UP5V/akCe
	 NvosPCA+Td7hLjfITPIgekazLFCTDW/bMT8WiQS9PovFZuTyNYz4GVbCGc/Nra5oahQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qg7R3vNy;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74B606A80E
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 10:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB74B606A80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qg7R3vNy
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso4991674eec.1
        for <linux-mmc@vger.kernel.org>; Tue, 03 Nov 2026 02:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701005; x=1794305805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AO+1v3uf2PG5kc86URqUg6dn1Nltq7/yDM8x6vv4Ubo=;
        b=qg7R3vNy8s70lD2fw2A2vSAJpTPycQTBTAPAL3SVg12+HzqCtYnUSwid3D/6oKXpwm
         AlG9qpgUkGd/5p/3Dkk6B5/N68mBKxJeYBVyBv1mL1Ptnvd0QigWvtMfBmw7vTT7qKVA
         QBZZw0HblKMcK9oxq7GT1cstsjxwbb3x8THf+nYKaBkESZaHt3nZmpfhiV9T+4vHPBMl
         6jxnFJrWex8BY7pE3PYgJdp/WBn+WbHu6vYAjS5yegpQZJJvW04W2vF2omiGPHUl7Hp/
         Hu9lwzLcX3i+6aMPr7FtPqBxiaMprBt93gnr0MAzBKsq0vrhJqTgLtRx/dMlx8f963gI
         UEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701005; x=1794305805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AO+1v3uf2PG5kc86URqUg6dn1Nltq7/yDM8x6vv4Ubo=;
        b=dtySGzeS2bq/AprgTARweUAGyFvA+sG1WaQbqkEudmRYeABusroO58JistSgvsAWa3
         DvsPJf2UPN5wgCMPxiXLM3GJ+c5kUAWN4ukEvGMym3qyz8w/wYVWJzdyTZ4HK6Law4jm
         EZq8/BOfCEDNBVVB73wXZEt8n7ePX/tYcuMv+tQKxkaL5w95lpVgNzasoBaMTOYuJjqO
         W16rrwWokqbDmHgwqD7rcLSEWVSIyC69A+eiM9TBu7i5ezIHeahW8T+f07PlXJZHdWQA
         bWPLegX/WL/HoXK977MJsaXfeY9c5gU6BByWydYPkIyhUPewMqsqhMT9T7CSd1p4G+fB
         wXkg==
X-Forwarded-Encrypted: i=1; AKwUvBwoQ7GHZdoXbt8QYJ02SIKSkkmbk8OAya4OePmzce8SPJIvl6XAFeiuOnnjI0H6SPtIO+acL0X85nk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LM0zcIFlW4YhvDAKbuimFiZXd8N0r2KuovEzfDHiC7fEoaYOX
	l2s7rnBLuYlH+1rA4wYE7NxabQpOz/YjkcVI570RNvltt9w3Kwi8eqkO
X-Gm-Gg: AYBFou2JwkQwkkMhekJB0UKLuBlezxb5SrQ1aWOPuKjGY5UMJfpPb8nCqaB7tO7bGsK
	QYp+5nL9IIlvP1HtjILMoJ18egX+sWBi42Nw22kH2XsO7SPwR/BaIW19hjOfe4W7R6AFeam6+NS
	POgtUCxL2zE3IOA204HGozyYRc7Es7ots2htysazI+pCW+gg254oDxZy/8U599wui0Q3UcnLNfL
	nNI7IX6tiCMX8mNFnCYpoasnv1f03m9H/GFGHhRFGkO4ebggTCYUNUWEEzvjC2ODlwhFfiTYFLZ
	GWySwqSykKGAhMrpKoDQLFOm7D0OYqWoI49kBwaCzmjTsSk4FeflEedz9aLsIGbVrBWWi0JLut7
	Af1dLrTvUxn685uT9/10ztp/ARzaCzBMRd2HVk3pUZad2KRcYOYa2DvvBdA8wFZvfA1Oe2uhNfx
	s5OcgWkxqb1g9zGQ/VZxHTbrR2KhgYEFnYyKIrfZT5sut60aUripdmzxU3lTLQ162o6N1972KUb
	9g2GUSoiInVRtbzfVt+fL2uQBfa9q2hNNG30z5qDqiiAN00f/q7rAqVrRYMMLSobjv+IITd5Hgb
	HeQdHwcfhq5zG4Yak0l6MC7O5ecFsr8RTmz2WVDpNbkVD2WIqVd+7zbDlztUqgpzj6jxd5lgzFk
	XX1ATPBnKxhHxUTAFA3s7YmJQKQ++aWCX0V1od7TUMN0IlBenvdqEBsTgaACTFecwG1oWl+gAjg
	==
X-Received: by 2002:a05:7301:fa4:b0:36a:713:a76b with SMTP id 5a478bee46e88-36a4236a5c5mr20608077eec.6.1793701004758;
        Tue, 03 Nov 2026 02:16:44 -0800 (PST)
Received: from arch-pc.genesyslogic.com.tw (2001-b400-e2d9-39f1-6373-5866-a392-6ad9.emome-ip6.hinet.net. [2001:b400:e2d9:39f1:6373:5866:a392:6ad9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1easm40304226eec.5.2026.11.03.02.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:16:43 -0800 (PST)
From: Ben Chuang <benchuanggli@gmail.com>
To: adrian.hunter@intel.com,
	ulfh@kernel.org
Cc: SeanHY.Chen@genesyslogic.com.tw,
	boris.chen@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	benchuanggli@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-pci-gli: Add Genesys Logic GL9768 support
Date: Tue,  3 Nov 2026 18:16:22 +0800
Message-ID: <20261103101622.213425-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The GL9768 is the successor to the GL9767 and uses a compatible
register layout. Reuse the GL9767 driver for the GL9768 by adding
the GL9768 PCI device ID to the device ID table.

Clear bits 2 and 3 in the SD Express control register at offset
0x940 when the driver initializes the device. This clears both
bits to zero, matching the GL9767 default configuration.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-core.c | 1 +
 drivers/mmc/host/sdhci-pci-gli.c  | 7 +++++++
 drivers/mmc/host/sdhci-pci.h      | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index a9000f3bd419..db0417238131 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1959,6 +1959,7 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_DEVICE(GLI, 9755, gl9755),
 	SDHCI_PCI_DEVICE(GLI, 9763E, gl9763e),
 	SDHCI_PCI_DEVICE(GLI, 9767, gl9767),
+	SDHCI_PCI_DEVICE(GLI, 9768, gl9767),
 	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
 	/* Generic SD host controller */
 	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index b55618566d65..66452ed8cd8a 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -245,6 +245,8 @@
 #define PCIE_GLI_9767_SD_EXPRESS_CTL			0x940
 #define   PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE		  BIT(0)
 #define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE	  BIT(1)
+#define   PCIE_GLI_9767_SD_EXPRESS_CTL_DETECT_1		  BIT(2)
+#define   PCIE_GLI_9767_SD_EXPRESS_CTL_DETECT_2		  BIT(3)
 
 #define PCIE_GLI_9767_SD_DATA_MULTI_CTL				0x944
 #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2		  BIT(5)
@@ -1354,6 +1356,11 @@ static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
 		 PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF;
 	pci_write_config_dword(pdev, PCIE_GLI_9767_SCR, value);
 
+	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value);
+	value &= ~(PCIE_GLI_9767_SD_EXPRESS_CTL_DETECT_1 |
+		   PCIE_GLI_9767_SD_EXPRESS_CTL_DETECT_2);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value);
+
 	gl9767_vhs_read(pdev);
 }
 
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index f38f0bd4165c..bcae29f8d8da 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -81,6 +81,7 @@
 #define PCI_DEVICE_ID_GLI_9750		0x9750
 #define PCI_DEVICE_ID_GLI_9763E		0xe763
 #define PCI_DEVICE_ID_GLI_9767		0x9767
+#define PCI_DEVICE_ID_GLI_9768		0x9768
 
 /*
  * PCI device class and mask

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

