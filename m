Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10482471CF9
	for <linux-mmc@vger.kernel.org>; Tue, 28 Jul 2026 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265407; cv=none; b=D27bOpolYzNSY1JcHAny3Azv8ir/8nlz/9SRXBQRUuAIFk+jY/Zp5Ma0zQeHb5Jc/easpFIo3NmnqdWcorWbRiGEcSlS9D6wUKexf8Ltf2kvKsY230gYZCJxQyovdTtM8/cR/ZO2P48CoNyeM5+ZLe77ZsGaYkmVsFFadCCN/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265407; c=relaxed/simple;
	bh=1lRR871VJrXi9CdE5wjzgROnvgD8zT1RlB/Mt3ecGWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RkHLTD2i70nkLOp0mMQ7bAjTNjOO9QhTVyTwTOR59m2oCzBvD+ik1jt9yh33payTwyx8prkQVvnOPydR4CLYbCRIp3UmT5UVGbAL1uc7IiaXDSw1MSmcfDF8IMoXIhwtfnVFuWoOwlYBbnpzyjTwAYdKjNNKib1NFnQvEfVtgzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O+wwuKr8; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O+wwuKr8"
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so160718b3a.0
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jul 2026 12:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785265405; x=1785870205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=06R0C5Az4WbwaNLd3vMNncYkeUGQ09VjFTKgkN5pTMs=;
        b=ectiIu0oPRR0i0ufuy6IqjyVJXM8dYD9DhoYC505GL/UYkS28ypweuXYcxPZ5XneSr
         EYMvHLJmQOoLr5rSn3W9D24ad7hGX6q37DZv6TuceNMeZ2qsfNvsDZMX6cT1C8KeyPYH
         lRb6szrecPMO6HY/J3dJoclWAhYWHtFuYbffxXvc4v8KbQVqKMhle2LgYJ1evwSFTuj1
         7LHNwwhf7fwQnlm8WjXKWwNQLjQa6s1jKxB5cS/DKZIuCMNfwHrVPhwIvQJ2gqEK2Rto
         +F6lAQQwpVTQMnbah58a8+pGQxpiKLdK+VuSDoeLaq5PA67ji7Wkfe9AIGNUr15wWi2Y
         56Fw==
X-Forwarded-Encrypted: i=1; AHgh+RqXhpXm6HphIoc9Q0QIwSrsknHe4KxmK+b/XtcppRmXmwECw+BS1SccSnzUjvzJNWW1ALJRzZmdRA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhDNeHFqDPPh9NIltOwnC0tg1mhEdvI53NEhB/O36o9ssyqdIY
	GMvbBiezZFpVb0u09d3jdrVM6xbs2NdlkRlsGcebrkUR2z0iXUcLlqL3GPNet2R5R7dh/07Pk1N
	vs0ChcRNV5tRgVJfj4V7Q7as/pVDtR2MvenBqPv8xN2BD1cu/CEyl00828h6TAUYSUFN0vLvm4Z
	lyHyfoXtsX1Bw1d4ss2irrHCVOAD9Z5KJeucAiS0WbSODaL6z7QJWW2c3IUh7tEZ2cfIskqhHXH
	3N42cHWi0ly
X-Gm-Gg: AR+sD11xgGlDS6FFD2BhZ5nTHrbxPEiT4ryucveX0JNiE/Mx1gX73wi7YCxTpi5n6Yb
	nZWLOl/02r6WXVrLE9Q4HC+F/QtmqtLWuwBNnpmnKgH0iyeTN1zdiUZ0Ix3p7FbB94gKYvHk19g
	+Xv2emgehvApt9I9XDzAY2PcN7rxC5AAhFw3BTl4ogbtRjID+z6U+vEMDhcwYysMjyNu1/ZnBga
	IFU6tT4YasR2vxGwHgNukgVa5Y6hOub/n7T8bvYNKwGLczgg/tcON3ZFN6P2GFYwggLztcqEVXv
	ufRHuLJpJMTccq8Rsf7HR1pfIrcBAcYA05Ra7q2G+h7NY/OD9xKwoNhh8C03u92Ft234mBJ3z3F
	BDT/0RaRa/BGb00bhRsSWBBjwDDG7F1IK47tT/zcOj9Jb6KbmLIpVzsvDs+ndr7s41nPRxlUak+
	pWjG6b0+/8UZEg07jhqlSzuWHrStC/4bcJ
X-Received: by 2002:a05:6a20:cc9a:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3c8ba487718mr4323094637.33.1785265405201;
        Tue, 28 Jul 2026 12:03:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-31504b74a06sm29954eec.12.2026.07.28.12.03.24
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2026 12:03:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-907a1e04111so2103476d6.2
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jul 2026 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785265404; x=1785870204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=06R0C5Az4WbwaNLd3vMNncYkeUGQ09VjFTKgkN5pTMs=;
        b=O+wwuKr8UEd+uAncaxmyRjNXFLjw0cHhfNG6eIGXbRmoNw98nj2/ZNDXIytjXcISWX
         G140fZIvAqZyPShkMCckfu0KCEvcbKReKCbd7mzXCj6/N8KF0KFwS5gSPvaF2U3z5eum
         PzKhmsuPPLs5LHp1Og/ZRJY5gOJQOmjo8H1L4=
X-Forwarded-Encrypted: i=1; AHgh+RqLXboTcTHquZQC1/B727qd+yOYpLPt3eR8O87FbPaT3RjXzKl/K9KZeSHy/8Vat5/Gqa5/W4ulbu4=@vger.kernel.org
X-Received: by 2002:a05:6214:33c6:b0:8f2:940e:2406 with SMTP id 6a1803df08f44-90816fbcfeamr40134386d6.2.1785265403475;
        Tue, 28 Jul 2026 12:03:23 -0700 (PDT)
X-Received: by 2002:a05:6214:33c6:b0:8f2:940e:2406 with SMTP id 6a1803df08f44-90816fbcfeamr40133526d6.2.1785265402810;
        Tue, 28 Jul 2026 12:03:22 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd8b21esm5502856d6.46.2026.07.28.12.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:03:22 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Avri Altman <avri.altman@sandisk.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] mmc: core: Keep the card powered across suspend when firmware needs it live
Date: Tue, 28 Jul 2026 15:03:12 -0400
Message-Id: <20260728190314.2325906-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This is v4.

Background: on brcmstb boards with a Kioxia 016G01 eMMC, firmware
accesses the card directly during resume from Suspend-to-DRAM, before
the kernel's own resume path runs, in order to load boot code using
hard wired logic that is not field updatable. The card needs to stay
powered and responsive for that access to succeed.

Changes in v4:
  - Dropped the no-mmc-poweroff-suspend DT property and
    MMC_CAP2_NO_POWEROFF_SUSPEND host capability entirely. Krzysztof
    pointed out they described exactly the same contract as the
    existing keep-power-in-suspend property (don't power off the card
    across suspend/resume). Extended keep-power-in-suspend's scope
    beyond SDIO instead, and reworked _mmc_suspend() to check
    host->pm_caps & MMC_PM_KEEP_POWER directly rather than adding a
    new capability. (e)MMC has no per-function driver to make the
    dynamic sdio_set_host_pm_flags() request SDIO uses, so this reads
    pm_caps -- the DT-derived, fixed platform characteristic -- not
    pm_flags.
  - Gated the fast path on pm_type == MMC_POWEROFF_SUSPEND; it was
    previously unconditional, so it wrongly skipped the required
    power-off/notify handling during shutdown, unbind and
    undervoltage as well.
  - Reset the host to its initial bus state (mmc_set_clock() +
    mmc_set_initial_state(), the same helpers _mmc_hw_reset() uses for
    a non-power-cycle reset) before marking the card suspended.
  - Set/clear host->pm_flags |= MMC_PM_KEEP_POWER around the suspend/
    resume, mirroring the SDIO convention, so host drivers can tell
    power was preserved if they need to.

Changes in v3:
  - Reworked the fix in _mmc_suspend() (drivers/mmc/core/mmc.c) to
    skip the poweroff-notify/sleep/power-off sequence entirely.
  - Renamed no-mmc-sleep/MMC_CAP2_NO_SLEEP_CMD to
    no-mmc-poweroff-suspend/MMC_CAP2_NO_POWEROFF_SUSPEND.

Changes in v2:
  - Replaced v1's card-level MMC_QUIRK_BROKEN_SLEEP quirk with a host
    capability and matching DT property, per Ulf's suggestion.
  - Added Reported-by/Closes tags crediting Florian.

Kamal Dasu (2):
  dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
  mmc: core: Honor keep-power-in-suspend for (e)MMC in suspend/resume

 .../bindings/mmc/mmc-controller-common.yaml |  7 ++++-
 drivers/mmc/core/mmc.c                      | 30 ++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

--
2.34.1

