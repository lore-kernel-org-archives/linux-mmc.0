Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEC4232368;
	Fri, 25 Jul 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440787; cv=none; b=OkddrYrLtUV/QIezvwQ4kAQAhUx8CLx0/z88Ux70QUifFGrzbx5vnxs844L9etCLObl77jawNVL+Bz3hT++oSHL1WsfRtAkZYHEmMII7kj8gxurxT/b99w7Wt7Bz7EqXXpE6S6fCrgi2bXRcqFO/k9VRODfzKGoDbwGJcCKti3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440787; c=relaxed/simple;
	bh=K5nRHWuRanqMIDVnVUCQC+PRrIh2Qh6WU+RMIjQnqBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATFgng6GFHge4Tx6Rs1dNqNQ6o2rBvkiMhvbskr3qDuWi0DUdpH30ESIBtxuczWPM90EQ/+EHQ6LnI+YQGFeAcGia911fzVzeQ/hZGZ3NXehVrVuv6CYzXjuppv79fo4mPdR2cnDq6KqJaFJKGzhFBmRk+Ym7S4dYVNo9IBN9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVs4Plwe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVs4Plwe"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23dea2e01e4so25220185ad.1;
        Fri, 25 Jul 2025 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753440784; x=1754045584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vjc5lzhZHIYpBQyg5ZKX6eF1+MNM3eEwhaFtxtCRRjw=;
        b=SVs4PlwemsdPr5iiwTvfst38QhF7A/ySBDgp1iDYoQ8yMZY59GQ4OwusECF/rZe3Zw
         4MKrsVbNvUECKfQkw/vVeyiGJKxE2BYv/dVqM1+bo5XHv1WCfwT54LXzFdtTQOOFgZNg
         GSiMRHPIFo7Cf6wqAM74mh+qmvz+sZFcndjQ65QmQ83NMFUHUQxnQLoIpAhdKugjuiX2
         C6G+9QXqc2wk2sSAhtzflyjdWUmRfNB7iSVDiLMz1nvZ/5tNk8um9BLBKLAfl6nWKfXg
         IvFk/oxsbpeN+7MuLibV1OaVJnyVanVP0FcCaX+YsmW5ZFuzU/cLMl3eO715hkYE6qVf
         3oXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753440784; x=1754045584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vjc5lzhZHIYpBQyg5ZKX6eF1+MNM3eEwhaFtxtCRRjw=;
        b=YQk4WcjGIfK3J+7qz9YFBPNNFmst/80st2l1iffscTUiAqRk4ccgPbHMBvjw4XzOLM
         zOuzGCQh5X3xSfKCZHnU3OCym+QpdQAgn1taRvOEXj1ZTK+RBWRvufZIXcu4i3JEgJmv
         2EQccTpaDB9wewaws1Et2H+Iqy8ZulQZYvI70T2EXID+NiNZgenNw2zBHyk1tdAInIDA
         Lb7CDptHaPRViDsOnm/O7XHbyN2Vevr53kZ3dyZiNhPfZ1bi2e83LGCNy7ChK02V/o4O
         TtBOferA5AAXWq0E3Q8DrLsXieWtAmzQNWzZKnvBb1W5C3Q8ytODonAcl3iiTG/oN7o9
         GG0A==
X-Forwarded-Encrypted: i=1; AJvYcCXMWymwPXxN1Vq2HLXY5IwVQE8QHPfcBvXUYSWd37qBlGzOYr2MyFptfGjw4khgXgNclqzQkTCS5GloGl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOhxOxwQrdZb0p0cSepQiIyS0hDHjRt1GR4Yh0xKmJqKZjsoJ
	c+tw23wr0BSU/r3dv3bIOJve8zu9Mrl7mpYls0jEn3V8oNfntLcOXF1e
X-Gm-Gg: ASbGncttje4R6cFTRtLXo4EPxIKLYHjfjBE9q2Ygp7j2tcwKc527SHJUYcyVizkLtLB
	pbgdOc1rc9nQP+ywNJLOrLCz26kU8HmZDru/e0LGNNlcVdU/SZ38I9Z4kSCSRRdEJ/9tpAu0Qo7
	qNlpD+6WD0JUB4YsxklE3b7m+ZUtA+IArZgJkynst7MtcRGBEKnBbZgn53+iDbxICqb/BJECcpj
	NeLD3OzXbneS/Ulzi6lGMWxKaInnEfjAstLQJu+aWwa8MARIfJiFOoa1RVXKt2M6M8SLxLFWoLc
	GTzX9SNI5nfUkQKCZc72/Ktct2pHGXfbRh6x3rnkRS0JTtgstdfiPitysArlNLeDxO1hJQn/qYW
	kAfSmIzYA2JT/88/WG+XpQzIVF3N5Mg==
X-Google-Smtp-Source: AGHT+IEipZK29iWdlFEe3x/qCvskw2fTkhiSwVQdc9IaIWUfFjSWWIAhrZ8bSxTjuIr5YMpLC19hKA==
X-Received: by 2002:a17:902:cecd:b0:23d:ddf0:c93b with SMTP id d9443c01a7336-23fb30e297bmr22346825ad.37.1753440784299;
        Fri, 25 Jul 2025 03:53:04 -0700 (PDT)
Received: from victorshih.. ([2402:7500:469:65dd:ea7a:c5ba:93df:8ba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6628c603sm3307314a91.14.2025.07.25.03.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 03:53:03 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V2 0/2] Mask the replay timer timeout of AER for GL9763e
Date: Fri, 25 Jul 2025 18:52:54 +0800
Message-ID: <20250725105257.59145-1-victorshihgli@gmail.com>
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

Victor Shih (2):
  mmc: sdhci-pci-gli: Add a new function to simplify the code
  mmc: sdhci-pci-gli: GL9763e: Mask the replay timer timeout of AER

 drivers/mmc/host/sdhci-pci-gli.c | 37 ++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 16 deletions(-)

-- 
2.43.0

