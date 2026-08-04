Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588F43D500
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875907; cv=none; b=MleN7qodr3xVFP4XHBb7g+w8odcgE8h5SP/poCLkCgJHIbLE9XdRXcEUWE7XS27O58q3kMjbCbn2O5GIjcNobJSVuE0+pjflamcB0/XUzYeX0hojHxTtHo7fKId5og0RCSQ3dzH7W6UMRGapv+hUp2tBAmQixlui6F9vzG/5xgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875907; c=relaxed/simple;
	bh=R5Qnv70P5N/IFzuqDWY904MEeXroycu6O4z9BGFiyQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cz4ppiA5FxHpyxMK7/flA++RVkMmspZ5iii3INrwX+9CAl/JYZ+wHulFFngv5iKtH6skT534m5NgmP0AlalzMh4MrdmtPDxcI0D+N+3+t3EW7jG2kc1ESeTWvQ3dIeCHaayl8pY0AzMuKBXHcoB4XF8qsHTr1Bbsm6PIO67SkZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RLNLoRYM; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RLNLoRYM"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cbb973e6749so236113a12.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875906; x=1786480706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RifdID+ubAjNrEP9gKUm/CCi/duq76C23UHVDTetxoc=;
        b=DauL6zeMxBRXYlx7dEDkImd6n+AiHnapTDhOf3WmdRydOgifKJGj5OzcV4QCUXNtFo
         FHwG+pnqXt1ynhFaWmFGXN341jVx5ywUxFxijfV5CQ0FVTJHcMwHVb5WXuMbhs0M49ZL
         P3dJYC8+VdObpuykpkSjpwjMhChRgFNqARRezqXyvXjcNOq48xMdqW5BPPpwvBP0jJZd
         byfB8CHgCCUV5ax/hrLDqIbLhS014AAreNxpPr8ylU7TtMMZL4/PDrdbo+XD5AHK+ogI
         yI9QS4Y1T7bCjKfeNjQWqNCFAeSzNS92UloM711mvWAiNb8Gp0DTRQ1EmkeWu+voyytc
         n8TQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqt9nsY1JxGrjswixMYTb5xFlUpkpv/DDN0jbpmjN7GFO8D8Q7ltkWyR18Zj4ZCttwpjmlQLF/u+mU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt1bgpcmqb9Is2S0KcM0NRfj4zYkYhgeVl8j5oWhAsbFUDNHAo
	ZOLf1XLuYc3CawC/cjJJ0hCL3YfAIM2UpLudAndtVnlzzgoLf4xVODisZVfSy6D6S1T+XsUu8F1
	divPG/8Y2iCRqXytCzZwXM3P5Arrv97wVCE6PLcttuG+baSSsm6msMGW/kxdQAv3dyZOCqfhiGr
	vruL/BadHHAv8KEo31h5QQqN24odUcEd0CWwxa2Vk0rNmXeWGD06pDCjHhmYyzFuqA0fPN+TUGG
	8hRtsM14TVP
X-Gm-Gg: AR+sD12gXN+jUyLWkMg/fghwPA+2MC+gMukDwOT7eWkdiNQvG5gTiz8WfqIl2J8lbne
	94DPzSRqyO0/ovusWV/0jRdaZkPpTfbrOU4kjbVIk9fJZ/AJWp1Y+XMO33CRNaldEf7OTGpsqL9
	lu3hH5VXneY5T7Bk21iu+z66ZPUrzsz0fFAKGykaqBoOrXpJbACYLYQdJ706aYNRjs0+eKIq9iw
	TnLnPGXMWVv0CJRGZNzeVmpkC9VXgu8/8FAnDExf2BH4NRmKAIAWmt2gUBuAI6zAGMl6Wwr/GVt
	qCdDYvOZLaMLfywCdgYFm76lfrkU729DZ6/hMQYMzBA7usoGLutN/gsYfAb3jVhd0zxEjQZAy9w
	BtcAaHJ3vLzy0wYtihMGLQ3s0haABkghK4emZW2+CDTl+pBEbD0BczIuCv/diMrURYvtvwKlohh
	EU3VmCQdIjTzSGKHEgr7YFL06m3DsyMlUn
X-Received: by 2002:a05:6a20:4314:b0:3c3:89ce:b5bc with SMTP id adf61e73a8af0-3cb85e28fd0mr1456313637.15.1785875905547;
        Tue, 04 Aug 2026 13:38:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cbe709273a0sm50415a12.9.2026.08.04.13.38.25
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2026 13:38:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930a098ea19so30637285a.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785875904; x=1786480704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RifdID+ubAjNrEP9gKUm/CCi/duq76C23UHVDTetxoc=;
        b=RLNLoRYMP7UjAE/aw19tImWOtEMwjA/Qx0swy+fgPpDbQ9hBU3K7yIYHyhGy2YUUIK
         9N/igmTab9grxLVwoNTXFAWjIL/9h70m0TwW8IOMRk6sPYmhs0+JagCZXjwpZk09zR+v
         MRlx3Gx6Iyy1XInr5L2yKgOnt9KwOxzyBqv3M=
X-Forwarded-Encrypted: i=1; AHgh+RoRgQ387Q/iQgxPvtBXxmarES4diImsifN5U0ykKgZhoXsl34nBdAApvgoLZgYJnGFkwua7JDrqYx8=@vger.kernel.org
X-Received: by 2002:a05:620a:8012:b0:936:4955:e5ef with SMTP id af79cd13be357-9364955e630mr106756285a.22.1785875904045;
        Tue, 04 Aug 2026 13:38:24 -0700 (PDT)
X-Received: by 2002:a05:620a:8012:b0:936:4955:e5ef with SMTP id af79cd13be357-9364955e630mr106749285a.22.1785875903436;
        Tue, 04 Aug 2026 13:38:23 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a52dbeesm11089085a.30.2026.08.04.13.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:38:23 -0700 (PDT)
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
Subject: [PATCH v6 0/3] mmc: core: Keep the card powered across suspend when firmware needs it live
Date: Tue,  4 Aug 2026 16:38:15 -0400
Message-Id: <20260804203818.881765-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This is v6, and grows from two patches to three per Ulf's review.

Background: on brcmstb boards with a Kioxia 016G01 eMMC, firmware
accesses the card directly during resume from Suspend-to-DRAM, before
the kernel's own resume path runs, in order to load boot code using
hard wired logic that is not field updatable. The card needs to stay
powered and responsive for that access to succeed, and since it is
never power-cycled, it also needs to be reset before the kernel
reuses it after resume.

Changes in v6:
  - Split keeping the card powered and needing a reset before reuse
    into two independent DT properties, per Ulf: extending
    keep-power-in-suspend beyond SDIO (patch 1) no longer carries any
    brcmstb-specific rationale, and a new reset-card-at-resume
    property (patch 2) covers that instead. brcmstb sets both; SDIO's
    existing keep-power-in-suspend users are unaffected.
  - Patch 3 (the driver patch) reflects the split: the
    mmc_set_clock()/mmc_set_initial_state() reset moved out of the
    suspend-side fast path and into _mmc_resume(), gated on the new
    MMC_CAP2_RESET_AT_RESUME, matching reset-card-at-resume's name
    and description.
  - Also per Ulf (raised on v4, applies equally to v5): dropped the
    mention of sdio_set_host_pm_flags() and how Linux's SDIO stack
    happens to expose this at runtime from the binding description --
    that's a software implementation detail, not a hardware/platform
    description.

Changes in v5:
  - Patch 1: added Krzysztof's Reviewed-by.
  - Patch 2: only set host->pm_flags |= MMC_PM_KEEP_POWER after
    mmc_deselect_cards() succeeds, instead of unconditionally before
    it. Otherwise, if the deselect fails, the card is never marked
    suspended, _mmc_resume() takes its early exit, and the flag never
    gets cleared -- leaking it for the rest of uptime.

Changes in v4:
  - Dropped the no-mmc-poweroff-suspend DT property and
    MMC_CAP2_NO_POWEROFF_SUSPEND host capability entirely. Krzysztof
    pointed out they described exactly the same contract as the
    existing keep-power-in-suspend property (don't power off the card
    across suspend/resume). Extended keep-power-in-suspend's scope
    beyond SDIO instead, and reworked _mmc_suspend() to check
    host->pm_caps & MMC_PM_KEEP_POWER directly rather than adding a
    new capability.
  - Gated the fast path on pm_type == MMC_POWEROFF_SUSPEND; it was
    previously unconditional, so it wrongly skipped the required
    power-off/notify handling during shutdown, unbind and
    undervoltage as well.
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

Kamal Dasu (3):
  dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
  dt-bindings: mmc: Add reset-card-at-resume property
  mmc: core: Honor keep-power-in-suspend/reset-card-at-resume for (e)MMC

 .../bindings/mmc/mmc-controller-common.yaml |  9 ++++++-
 drivers/mmc/core/host.c                     |  2 ++
 drivers/mmc/core/mmc.c                      | 33 ++++++++++++++++++++++
 include/linux/mmc/host.h                    |  1 +
 4 files changed, 44 insertions(+), 1 deletion(-)

--
2.34.1

