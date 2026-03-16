Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570E3644A4
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696212; cv=none; b=gG5moJON5FaRwdzRSSTTWSesK0sJ2PQJehLAQUP6SaQqA016A6zG74rWu6uVD7MGvvbiRKh5rge9In8O6z5/1o7xMeEAPQsOK4XjDmWCG52u5P7UyRS+BFFio/RcsVCYQ/QyYqJofkE44p5MtXz89+692RvGWanHwnLg9qxDY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696212; c=relaxed/simple;
	bh=2RsJL0t1x+LA5QxProbAY1L/TtcDXI8svTgv7Mh4LOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swL5oZIigKA+1GxZuqarPN2LmRWjDVefMf1IRPmjI7UkEu/XXeY+TNTIinIg7jgH0tCy9qIKRH54X7lVl8QUyx6DFv5+SXgPGbPtdbkQ9hWZr1GOCj0WN531QM5FVgcwVf8mPrPZZeDPEqc+BQ0P7UaYmfJa8HRvCiodGd0DVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVPALnm4; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVPALnm4"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7986e538decso41536017b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773696210; x=1774301010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLrfaneZpDj4kvHatpxOSBJrX776h3FiGSHy0ZNsfNM=;
        b=aVPALnm4RfDCtiZnLPazyfN80VotR/OCexT48ddA82gdEbU3lT8kC9RyYL08qwNPtc
         J5qd66rNBn7MImcmAzsdydOHrRBbUzW85cZxar7Lx2dUeABqhan2/4awPWVwsvAGwxYO
         /ph7IagVj3lB/WRWQft0Bh27lDDMwpgCjXnpmtmg20vVELb1otCIUK6RuYBdCazFTHvi
         pu1lXEAidXAvaQeNIrki8v0nriznBoNUJuwO2FBA97UZBlPdZ7ldBk99oSvrd1ikYN9X
         0GVnjpuHM8mzQnCksUt1xqJWO/se83GVAV8Mh+xXFp6hHAe7crBFxRP39oHGhXZ7VH7A
         OTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696210; x=1774301010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RLrfaneZpDj4kvHatpxOSBJrX776h3FiGSHy0ZNsfNM=;
        b=IgIvuhr2f4+aB3gKE9yAx8FKL9PauTN0M/mxLX+MprgXQoOMrnm9VaTeApuTJD1v0V
         fRiE8LYQmoTnGJGLXgFJjvfRN0ozSjxvmRjv4598IiMiPvEoXVwgHHj1Vsqrd70Ka7Uv
         1tj+t0fRE0V3aI/2zyxD4jhPQZNR7Gz/oFhpXfSgvEzJG9PZ7JTiCCFf8bChDjYx9Nb5
         ata8v3/A1BgKoQI+0fFq/9dfgp03fFeQYfbQ8WbMzzkydn/gn3ZRSc1kSmy5F+MWrjzm
         nZp/9/l+mnHenp5RhQV72xEX4SB71Q9/a9ycPZRxxPocd1jAz9fY31pKQ3GnqWVqpk7Q
         rZrw==
X-Gm-Message-State: AOJu0YznFUtwgEom7/1Ckr1iNKKV3+67RHGUv8QejUy24IsFUWaogyZW
	p/uqF4O+akAO4pbw0+2ByCM0l2PKhtRFZFRc+iHxMjZKedLvsypjZckLfmxNTlS+
X-Gm-Gg: ATEYQzxy94i4OTZFnFZ6kppUTpUkltv8ZrllqwtubMgagY1P/C1sCL+8rBSL9+uNwo2
	kZAGZP64xX2hPPVpE+d3+fwJF3hNQV9oStUjcNdvTXx1vj4ISVOWmSX0XMpnAjG5pdWNbLMdsMT
	hS0n0vyhtvwji0Puyh2ptVqMjALwCH+QzErq3sKR38EX6GCgN5LQAdMZiHmV/czi4Kbq14Kx3n/
	LOeakfbuSlWi6el0ZvrMNCfrp/C70miRgwlzFirfbE/4QZGn8PZvLrUzYq4GvYqGEdiw0snSyJr
	sg8VcB7RVxFNFmudIcE1bSVdUK7zHxaltcWrhOi+GAYZ14iHM7RbyBonlhjHOxgz/tA80vbqmhp
	Is1n97D4vyk3MxoxTtkAp5kCdTqGa5xyhRSWDqNyfsEqJlGZuhnozUl47saTb6ZHQ+kKWI10227
	mT9EOkxZhQrJsWr163yhbtOuoYWSpQx3aYOMArp40=
X-Received: by 2002:a05:690c:13:b0:798:6756:31cd with SMTP id 00721157ae682-79a1c1dd661mr150455747b3.53.1773696209804;
        Mon, 16 Mar 2026 14:23:29 -0700 (PDT)
Received: from Starblazer007.localdomain ([12.206.154.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a5e1ae50asm8180437b3.2.2026.03.16.14.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:23:29 -0700 (PDT)
From: Nelson Johnson <nzjfr547@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	Nelson Johnson <nzjfr547@gmail.com>
Subject: [PATCH 3/3] mmc: sdhci-acpi: exclude INT33BB:00 from ACPI binding on Lenovo N22
Date: Mon, 16 Mar 2026 16:23:25 -0500
Message-ID: <20260316212325.4207-4-nzjfr547@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316212325.4207-1-nzjfr547@gmail.com>
References: <20260316212325.4207-1-nzjfr547@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the Lenovo N22, the firmware exposes the Braswell SD controller through both PCI 0000:00:12.0 and ACPI INT33BB:00. The ACPI path for INT33BB:00 never finishes probing on this machine and repeatedly defers, which leaves the slot in the broken ACPI path instead of letting the working PCI path own the controller.

Return -ENODEV early for INT33BB:00 on the Lenovo N22 so that sdhci-acpi does not bind this machine-specific firmware node. That leaves the controller to the PCI SDHCI driver, which is the path that works once the N22-specific runtime PM and card-detect quirks are applied.

Scope the exclusion to the Lenovo N22 DMI match so other INT33BB systems continue to use the normal ACPI handling.

Fixes: 6cf4156c0988 ("mmc: sdhci-pci: Enable card detect wake for Intel BYT-related SD controllers")
Signed-off-by: Nelson Johnson <nzjfr547@gmail.com>
---
 drivers/mmc/host/sdhci-acpi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 84c705460..3badf1c87 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -814,6 +814,12 @@ static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(struct acpi_device *ade
 	return NULL;
 }
 
+static bool sdhci_acpi_is_lenovo_n22(void)
+{
+	return dmi_match(DMI_SYS_VENDOR, "LENOVO") &&
+	       dmi_match(DMI_BOARD_NAME, "N22");
+}
+
 static int sdhci_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -834,6 +840,10 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (id)
 		quirks = (long)id->driver_data;
 
+	if (sdhci_acpi_is_lenovo_n22() &&
+	    acpi_dev_hid_uid_match(device, "INT33BB", "2"))
+		return -ENODEV;
+
 	slot = sdhci_acpi_get_slot(device);
 
 	/* Power on the SDHCI controller and its children */
-- 
2.47.3

