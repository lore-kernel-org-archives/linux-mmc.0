Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464162B9BC;
	Fri,  6 Jun 2025 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749207693; cv=none; b=H5qYuU2JVCAdXGAzTEI/r6w9T9+qHtQQO+T1K1qphdtatuIkn1fDrwKdkFkgbiUoB/KEjLaAI+6uTESCCTDKZ23ac2rN049S1I/IVr7qHth+pMceiIie6v4Vo3pWCMzxFewrvj46Ov8TyiGFLxhz35M1rkdXEzYvAMAB4DhwAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749207693; c=relaxed/simple;
	bh=xT5xCkZ1JFFONaYP0IT32OFGyChvPSzHHY99QK6deuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OeeUP28aK92SeakHYgqeRMdcvshC4d0DuR3ArS1CiaZNodMfgAraCMwaWPo/kkBT1Il0+YBWijZARjb82No4w3hysOE+0FcyFtkjQGh6SVMDzkHMcS2klhuTI4zKUHI8+IqQwt6v5E+FrqPeb8VGWFfAdi9cgcW98ukhnQwbdGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mguw66Xl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mguw66Xl"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235f9ea8d08so13239515ad.1;
        Fri, 06 Jun 2025 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749207690; x=1749812490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDajbAe57kbFd3lsA+awvfcHj7NkUKCVzc3fJfrdtwM=;
        b=Mguw66Xl1nByGQFsakpywgxn9pOYoxEp2R+WuBTCKhrR1dW5ZBVeJeEFCthtWjc9WN
         d7DxT2fn3coYj3IXMChH8JKX33dPiKkPzoC4cJs54MtyBG2ELFkNDdicIthWGyK/FK6Y
         bTRfNyZjbC+IjPtVNpL/aHY/+5GHv03FYni6H4idlVATX1ltkkTIhZJuc5TVa+r543RK
         aC+GBQEH3fTMCtO1Xphq5IOfba8v2/p20i3fxRotty4izsdZTSLLZAm/2dkHuwI7hzeN
         xcqdl8yWEagtXDks+20dq3vUMY8eoRf0WPX7az7d3dyTDvlgHdl3XTlmMF9vWyXxHa3R
         TbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749207690; x=1749812490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDajbAe57kbFd3lsA+awvfcHj7NkUKCVzc3fJfrdtwM=;
        b=Q3pCZd6RJn+QNsazPTkiCzZ0vENod2zlf0oXQJeY0xTpVjtlQRjx33apDUIbtOh857
         P/Vj4Fuq3KIjlnGwoNwCmvC1SG86uGIYIOC8n4TvpPLdpEwTCgCvckzjGtQHX0cCH6DO
         GFK82LbXf7DJhkq1wDkd5rrVnki0LA0Mg1HgBoQ0wob1/yXEFB3tkxGAtXD+9k1Spm4K
         J8ZcNq/ZiwHUzfrn8sdNTkOdvB1oIC8RrtxQBq9dHZYQpuMvYoaQhppwDTMIpiDJhj2i
         ffZPV2oQa8cRXiXbQdoHEjLKW2wfWPUz2sRXxS1fC62eJCZLLS4Ftyd1Uh1ksD/xbQTM
         qqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1aEE/b/s50WWNisY63jpy4MlQgPSDzpX6SmNnt0Afvjo2Wj/SLLUudwl3TY4b5R76uNZg5LJwhDUGKaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8gycjU5OdXRvYY/XK0cPXZo036fj+hQDuGttxCG5mTpCQjoBO
	WjHLZCayPoli63UZX+ozDsDhyKquOq85/TFoONwwCyy11ODUlDpGlg8E
X-Gm-Gg: ASbGncsC6xGVbG3cDhIbj7lPTwyXnmgqlrntLHJKYnpL4rr1oPBtNwnwJUyFmn/tXw3
	gbSU1LFk8qoLtn8gSiJgsgOuyrA4lNH86ySpDRxf8oM4oLBwMiWcKbHQzSB36qmye0Qgy4/TC6J
	42M4SmO7/+TKTbhSBHpxITTApUbs/VxaF7viby2n4qPVOFB2fwo0q27sZwgTiN/BsjWhJP0y1df
	KsKmmwnpz3yFaWV5FgUwOgqYXZmleuKymQmVypqk2DNdh+gh3qOQVa68MlH3kXTdwth6Ur/6GN6
	vwFDIxHCNFqD5j77lc4Q9zSgM1zA+CxGmUUX1afR3zzRM/uFdBcYZEvv1Uq930i2tGoQCA==
X-Google-Smtp-Source: AGHT+IEuQ5XKtuQPYr1CK/mvEDG3WWgyFUsrOC+Ax+xUPhXLsT1tDc1xNFSLcRAlbvPTptb4pA5B5g==
X-Received: by 2002:a17:902:da4b:b0:234:a66d:cce5 with SMTP id d9443c01a7336-23601ed6398mr45797085ad.46.1749207690331;
        Fri, 06 Jun 2025 04:01:30 -0700 (PDT)
Received: from victorshih.. ([2402:7500:477:464b:b7fc:d546:e798:4fbc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603406aa9sm10095565ad.188.2025.06.06.04.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 04:01:29 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V3 0/3] Adjust some error messages for SD UHS-II initialization process
Date: Fri,  6 Jun 2025 19:01:18 +0800
Message-ID: <20250606110121.96314-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Summary
=======
It is normal that errors will occur when using non-UHS-II card to enter
the UHS-II card initialization process. We should not be producing error
messages and register dumps. Therefore, switch the error messages to debug
mode and register dumps to dynamic debug mode.

Patch structure
===============
patch#1:    for core
patch#2-#3: for sdhci

Changes in v3 (June. 06, 2025)
* Rebase on latest mmc/next.
* Patch#2: Separate the helper function in V2 patch#2 into V3 patch#2.

----------------- original cover letter from v2 -----------------
Summary
=======
It is normal that errors will occur when using non-UHS-II card to enter
the UHS-II card initialization process. We should not be producing error
messages and register dumps. Therefore, switch the error messages to debug
mode and register dumps to dynamic debug mode.

Patch structure
===============
patch#1: for core
patch#2: for sdhci

Changes in v2 (May. 23, 2025)
* Rebase on latest mmc/next.
* Patch#1: Drop the use of DBG macro and use pr_debug() instead.
* Patch#2: Drop the use of DBG macro in some function
           and use pr_debug() instead.

----------------- original cover letter from v1 -----------------
Summary
=======
It is normal that errors will occur when using non-UHS-II card to enter
the UHS-II card initialization process. We should not be producing error
messages and register dumps. Therefore, switch the error messages to debug
mode and register dumps to dynamic debug mode.

Patch structure
===============
patch#1: for core
patch#2: for sdhci

Changes in v1 (May. 16, 2025)
* Rebase on latest mmc/next.
* Patch#1: Adjust some error messages for SD UHS-II cards.
* Patch#2: Adjust some error messages and register dump for SD UHS-II card

Victor Shih (3):
  mmc: core: Adjust some error messages for SD UHS-II cards
  mmc: sdhci: Add a helper function for dump register in dynamic debug
    mode
  mmc: sdhci-uhs2: Adjust some error messages and register dump for SD
    UHS-II card

 drivers/mmc/core/sd_uhs2.c    |  4 ++--
 drivers/mmc/host/sdhci-uhs2.c | 20 ++++++++++----------
 drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
 3 files changed, 28 insertions(+), 12 deletions(-)

-- 
2.43.0

