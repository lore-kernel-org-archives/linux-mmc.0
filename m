Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6A2153E1;
	Tue, 29 Jul 2025 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772298; cv=none; b=F1MVGWUM8BNmqa5KZ662VjqCU5llAuiiLCOQ8/A5jY3iIDuYf3SHFQSfW3nnWwwu/eomRNx63MyZuL5N/r47sRholD4TO8frqQtNMsikPksUcOQYxhgSVvAT2vuvNBHtQNqGP8howb8KuTV/3sAAEbpDw6ZBu6CNJiuJq2kpDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772298; c=relaxed/simple;
	bh=HFl17PPvzuvXhIOtPrn8qyQIp2Ap0lRnp19YF57ICvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlrOVmwMuan/1rnUVj5pvkmgQErOwqQIsu/JRkwCzH4prQIbWfvKr1//KEXYtXC+I0keH1lCXC+65PhYamUOYQByGR8W6Tj4/VkMRNHMMIXBwsfMswrgqA3IUNldHn4pDfh7Pd9JNxiHb86DBvEcIbeiUGc8lpd7DWEr/sK3DH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPfOpdyb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPfOpdyb"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73c17c770a7so5700308b3a.2;
        Mon, 28 Jul 2025 23:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753772294; x=1754377094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p7TUxeEXOqamhVqjUcYOMPkNiolKX448Ui0FRdpDnyg=;
        b=HPfOpdyb2q1Y+XiLoTF5ZlcnhvF3F03bMHjmwj46+R9AoPuxdFP9AUeougDQ4OnKWE
         wcPyEnSdIt/TeGqcu+b0gS97ZAmU3Z4QD7V8h9PF2hVPEUJqae4PLWYdKZXTxIDrW+SI
         AR4HdP5PK8eToE4VHifso93hfWcAnoqaAcBDc/D87oTYU3pSvXjOIDv2FkImvsDMzeNJ
         AGaIVrg8jEmwDg059rY3LRgotlB4A4PUFl+snl0z/J28RodV3sFtePCfsaapysvxXt/d
         bEoOWo8jzPgFqKg68Uy4UEUsb5eygGd4qzQA5RchnSz+2/N7ktK6glH3Tzutpj7h/Xdz
         wbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772294; x=1754377094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7TUxeEXOqamhVqjUcYOMPkNiolKX448Ui0FRdpDnyg=;
        b=JbyDWsv5RwqgYCFTQtecA33sXx6Iugw5e8tRhsTQclE4WiNPGC9VSqhqWjGq6VuP9i
         zZqSQLNjzbeX4yFk6L0d93QErTr9M84hPGfAfuTjL2sC39m5GDDpO2/aXSPdoT8Y1ijP
         NQURRaZw1p6i88YnOk73M48c+w7o+A64QjzD/b/hyqXVMZ5Epdio9R/0wB/Po9VcOcG9
         W23shwMvcUGumJi5PTWfPsVk/p6O74Aqio/Aj5dRHhRY+wbZA0dygCYI8goID0TlDXH1
         7+rUnqDko4WJcECAPe1TyD1IAlpozEdVJa/Ocp35kPWKJBJURjXmvFSEIqQvSEp4QWlY
         yN5w==
X-Forwarded-Encrypted: i=1; AJvYcCVGnxKcwwpP7p81EOoy/oCdNrkKrxCEOg/yK/ElyViE7mwYRTVCJV20SxjCw727FPErgyyfs0u76K0CyNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZZsx4/FEkNxttgDuqTXezZSy1KT85kU38+XhJipMOCVB4Z51
	6nt9d61qNE68i4MwpAw/W//wWBOPB7rXqAwzLMtQwnvFcyVqifGTcaCP
X-Gm-Gg: ASbGncv3gX9TJfv8mMHwnNdeP5iOG+2h4wQ1nKJz8EZ2h6vuepCY/Uf7G1mjDM7cOPr
	xcZdm5sMAHHGuX5BD5B65Z/xOhtN2tPa2tFK0BDUM6USCXSKcN2eePhMecW5kSGA1nJSlUllzn0
	paPnNqhn0Ay20Wj5fGF7QY5HclLWAr5pTRSJa6Em8ki0pdkXIlNw4GBPMu1GbWIlHqabZKWb5GM
	ldyvQugM7qzDF9p5m01d1oJWk6Ke3DDYomHcCOogC5vtTD0LU5TxDEz/3spjFrO3IuiqMj6yPMg
	xoxlvYDk1AdhEKy1Nm/VB5VT4ui6gUViWkSQFHqZqqzqzOAhjwaU1N+tSuuuO6TXlpKP/W+9nSq
	RBirtQvpyRvkIN2vJJXAcDQ4gcyx1cw==
X-Google-Smtp-Source: AGHT+IGZg/O64U7GJ05V3vEuDohCUIWBhBNvKeiPXaobiyPpq9FCuHDXGaxhXujSqJeyQpU0w/jGxA==
X-Received: by 2002:a05:6a20:2588:b0:238:351a:6443 with SMTP id adf61e73a8af0-23d704283d7mr26153710637.46.1753772293799;
        Mon, 28 Jul 2025 23:58:13 -0700 (PDT)
Received: from victorshih.. ([2402:7500:469:65dd:c998:3a8e:c481:6cd7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b420df76dd8sm758066a12.19.2025.07.28.23.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 23:58:13 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V3 0/3] Mask the replay timer timeout of AER for GL9763e
Date: Tue, 29 Jul 2025 14:58:03 +0800
Message-ID: <20250729065806.423902-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

These patches add a sdhci_gli_mask_replay_timer_timeout() function
to simplify some of the code and mask the replay timer timeout of AER
for the GL9763e chipset.

Changes in v3 (July. 29, 2025)
* Rebase on latest mmc/next.
* Split patch#2 in V2 into patch#2 and patch#3.
* Patch#1: Correct the wrong parameters in the
           sdhci_gli_mask_replay_timer_timeout() function.
           Add new message to the commit message to explain
           why it has a stable tag.
           Add fixes tag to the commit message.
* Patch#2: Add fixes tag to the commit message.
* Patch#3: Add fixes tag to the commit message.

----------------- original cover letter from v2 -----------------
These patches add a sdhci_gli_mask_replay_timer_timeout() function
to simplify some of the code and mask the replay timer timeout of AER
for the GL9763e chipset.

Changes in v2 (July. 25, 2025)
* Rebase on latest mmc/next.
* Patch#1: Add a sdhci_gli_mask_replay_timer_timeout() function
           to simplify some of the code.
* Patch#2: Mask replay timer timeout of AER for the GL9763e.
* Patch#2: Rename the gli_set_gl9763e() to gl9763e_hw_setting()
           for consistency.

----------------- original cover letter from v1 -----------------
Due to a flaw in the hardware design, the GL9763e replay timer frequently
times out when ASPM is enabled. As a result, the warning messages will
often appear in the system log when the system accesses the GL9763e
PCI config. Therefore, the replay timer timeout must be masked.

Changes in v1 (July. 16, 2025)
* Rebase on latest mmc/next.
* Mask replay timer timeout of AER for the GL9763e.

Victor Shih (3):
  mmc: sdhci-pci-gli: Add a new function to simplify the code
  mmc: sdhci-pci-gli: GL9763e: Rename the gli_set_gl9763e() for
    consistency
  mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER

 drivers/mmc/host/sdhci-pci-gli.c | 37 ++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 16 deletions(-)

-- 
2.43.0

