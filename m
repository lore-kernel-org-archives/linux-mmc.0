Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB6613A258
	for <linux-mmc@vger.kernel.org>; Thu,  2 Oct 2025 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439083; cv=none; b=ebH1STw8GCFffUn2J5f1XCqKuTyWX0hsz6qG0zpFkIz8i+Bq9uJv/zT67iJkNTMfxysGWBp2cg7lBlDYBaIeZx8SXZArbZ5Y1/lgJiAFdM6Ri1CtQYj9nlvIzij9rWCR6/mhb29IQ0S/i45Lw3bBY2C/FdwLBOPhz85V5HqBac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439083; c=relaxed/simple;
	bh=wQ1CYAjiFcO9931vPI1LjA3++HAVRuOZx4J5E9bcb2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jdt3tUsfcOVq7QnktYwv5srSBjL8sfBEvXlvkrs4w9UpW8HiRFGSFUmAyiLe7c2F57I0nOXdivubFxRa9L4u5dg0LhKIWydXJeEyBq3YL5xcqwO6ZfkUA4YTv/Rpapwd6clzSvf6hwQBwWXuLCnArsjnuXfPe9gpv4SdyXS1pYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OFISdMeO; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OFISdMeO"
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso1528793b3a.0
        for <linux-mmc@vger.kernel.org>; Thu, 02 Oct 2025 14:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759439081; x=1760043881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2UQeXeCdd38LZjkJTP74V8I/AwlCwJ5vjuI4bPLac8=;
        b=vKVIAl0j8AIfvWNgVeLvMpOQB3XNsmtt6gXDLtIhrB6x37fyXpl3dJhO0HtCySzC/7
         Ookt+xS6Xq2gzIqj2vGZfDb+uMjcq/pdJbPkjRZ5IQbGJ4uSAQ6Chi4qwN3xhL5zrvtD
         MXKHJpIAGvwcBTAsOOORqvykrMUSwb9SSKVX4UJ0BiYTSVAXyvRoVy3DMg9Xwr6K4KN0
         iFCDr1hA1SoiytfMtzjmCxkVy+F8CpJJE6QY747sKg7NZQW0cIw5RapWp8t/R1X6h0eg
         iMLXQfdB/7wHyLZeH7zavkO7a7y6Uxyovi0kPGlFbylecsEzKNAXMMKEKCsmIhkOVSf0
         kmcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaun2raPwW2rDsVlvk8W0oBQfHXvJgrJt71rrYeC2Fj1uI90BgzP+CImXL/kYNBsqG73lNKl4o0hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhI6hVUuUdQnF8WxzCpUs9hrODeIqmiprb168hkdlxJfk1e/3i
	hdl0vdn+ditw++9/lu05+nK4eaOvC14QWfw1vkxwxwvh9dYHIv4NisnXacJe8/EUjqBa21z9C5q
	anwUM1gkDaqsUERxXbfVUgufYtEdo4MywanWm4AI566MtaRksC8GDnRuA4/S5Xu0hzvP5UwY+tW
	42cJ38jj9JCm0NpK1r6O3htd0CnkUBQCeKhw3On+j1evxOxhhp0Jz7d2FoNhM6WyDWM8Dno8jK3
	7UI2yfR3HUZ
X-Gm-Gg: ASbGncv/6MfNCayLCkzHYcJJIsz2cgPyBmDNPHGxKhke5DyY+LmYpmDFakGwZ8kDv85
	4NcVYdI0XYxIBOth0GY7JebICA9NNhaEOPL3rRxEmHuScg3B3b20W0GJxpteBMYaVIOkY5tCVqA
	FN2kY98Cvwuay1qJ00JYPs6umuIymNsyNGorwBirf/F9b6m/hBL3Fiv/g7Iv1FFxnw07/+y9C1j
	jJ6OMK0/37wMMNcoQ0lxmAcmLjrZBoS29AdEDWlC198qu04kBllNt4YwATCHEJ8opusFqgXjo/Z
	iBbWL2Pycp9jN/vhuTTSK8URZj+zquH+yymV7rbqeF8PcmuDKMGN1znstqpssrE2qEPZukkeCh1
	rPxwH/+9B5MIJGfEyHb7RaO2sKtg/ncTrxTjjMo70sdJqwyeUoxYJIRLZFJxzoR93G9FfI+8l2O
	4lxtSj
X-Google-Smtp-Source: AGHT+IGLvSloZN9rz7Q1Ot5ySAqEGN+pD4Hy61WA/iP+ZA54x6OY7LQsv857Shn6ro0lFyz4ZSjf8OAT8yx0
X-Received: by 2002:a05:6a21:3382:b0:2e5:c9ee:96ed with SMTP id adf61e73a8af0-32b620da92bmr925721637.43.1759439081316;
        Thu, 02 Oct 2025 14:04:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b6099b98526sm151910a12.14.2025.10.02.14.04.40
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2025 14:04:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e36f9c651so9693815e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 02 Oct 2025 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759439079; x=1760043879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2UQeXeCdd38LZjkJTP74V8I/AwlCwJ5vjuI4bPLac8=;
        b=OFISdMeOfvEKfVtKZGfW3hrRgSBI40m3XgVOdaOCvidXH0/6AyvdqtPti0z0cWhOtk
         GKz3SmMG7NFPshYmzDJjoOOWU1kIg0kEa7o3JoUzPhyT8fRQ/rxEuhR8YxpdyPH696uC
         UUPqL8KsrbM1Sty+5iIvxPRoswBFsyw1wlYik=
X-Forwarded-Encrypted: i=1; AJvYcCV0VOV4WPCt4sNnViuHukI4KxnPUZekyy6tPviZnxlRxd7AnFIiNBFCnVohOfbKY01VCFvWvAmdRGs=@vger.kernel.org
X-Received: by 2002:a05:600c:5304:b0:46e:5df3:190d with SMTP id 5b1f17b1804b1-46e7110ef5dmr4793865e9.11.1759439079339;
        Thu, 02 Oct 2025 14:04:39 -0700 (PDT)
X-Received: by 2002:a05:600c:5304:b0:46e:5df3:190d with SMTP id 5b1f17b1804b1-46e7110ef5dmr4793685e9.11.1759439078875;
        Thu, 02 Oct 2025 14:04:38 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c4c0321sm61711295e9.8.2025.10.02.14.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:04:37 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 0/3] sdhci-brcmstb SD host controller SoC specific enhancements 
Date: Thu,  2 Oct 2025 17:04:23 -0400
Message-Id: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

sdhci-brcmstb HS200 configuration for BCM72116 and PM register save restore
changes applicable to various SoCs. 

Kamal Dasu (3):
  dt-bindings: mmc: Add support for BCM72116 and BCM74371 SD host
    controller
  mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200
  mmc: brcmstb: save and restore registers during PM

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   2 +
 drivers/mmc/host/sdhci-brcmstb.c              | 159 +++++++++++++++++-
 2 files changed, 153 insertions(+), 8 deletions(-)

-- 
2.34.1

