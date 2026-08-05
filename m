Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795B3EC6AE
	for <linux-mmc@vger.kernel.org>; Wed,  5 Aug 2026 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785968711; cv=none; b=gabyod9u7FPcXoH+DG1BBhUzvI//U1asv1iJUJ2AWDBWVsbreGEZB4lHQianEEr5GVAyKOe7slzoqb81/CQCJb9ZwZWMvHOTo78aXo94Ji49ijvs0OilL+wLpC2MF9eMtSg60Ftchu1IRTYu3VQdHxSMOvimsx1vn7Ug/oA1amk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785968711; c=relaxed/simple;
	bh=2Ef44NE5I8djkdFS1NYlRhhkHaypMUdPqBMQ9jn9zpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VNIUjacASOJ63sFXSTbYIaD/mvt03N0NWDIjt15uGtjjYEkpY9KP/uqvzU2rloFH8D+ChMlK3f3KDLJXnp/kiHSDmFGr8+Z+nntNlUDxvZCArCWU5HFbnj40oo8RJwMuFxjATfEN41LOQgpOUGPZPF8tTuQ1mxgRcotIAEEhE44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BFhn7pnS; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BFhn7pnS"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so1843372b3a.3
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2026 15:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785968709; x=1786573509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hLRncDuyKwOflu/6tMTLfOctGqnwhO/BaelPc17xZZ4=;
        b=PbvHamWvRSGiTA8/eJ9LIkvAmU5Hyxu6H726rErSiikaULgUbhAF7IE3ch/TtKHmS8
         vzCGZL8Q3z7Uc1vdFrjUAp9G1+uAq0l6Z1YcJ/7zAHFREuBmI86KUBRFZnTBx8+UgvAO
         lfOi6JKv3rM99ZO8M75Scvywq7j+vgi486AKTMh1BiJDSR1gfjc4QPFAublRlMaMFmDZ
         Ax6Ix6q3dAjRZ4luw+qboRHbHWNA73Oxm+O8wvPKkwAtqPPSettQP3Rco8J7IyqzRdsS
         h/AFepqk0qqHFFpY9y/OzS7RuJc2wm+zXbqMVifyiK2bKZwexDPz33FpZnjzez3w96fk
         ky1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqRe5IT9EbrD39fqoudrLrxERDiWDK4Au+83bZGV3Cwc52I886qiaSqAiYuxAAbQUKLq4Jv+mMOrIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7WprtiWLThXUDFXIugIUSkst56TxAvvQ1Y72qrw4/XQQxRqse
	S7/ym2uuAp93WeuxYz9jlt0PpVoazrIVdaXqXX8QNPvNLjB2cUiwthTqRiBe10wyyc+6OFcdI2C
	vIVnNO5K+cmn9C2KNgL0fkvuYgSws+Q0GRhEZf1f1ZyGcMDLcbdDirZ6uHoTr7Bs1SwcINV/H09
	3qdSLP8WiYRutMzpy6WLj3uWYRD5CijRvfT5IO+KNP/QhiUv5VBRIfhnda12LJlkWVIBAuQ1mCt
	Bdsdm27A2mK
X-Gm-Gg: AR+sD10udAzBqwaEvZDOzvnyd6FKShNcDhRkE1jO2O2UTmVj84dfzqESxIagjGsCCYW
	z0FREJcCIBsOBTnYeBUHkCDkLcdl1RNhCpB21G8csmPSp90PGjAJAWAcNDF6l3k/7oer41xL+w1
	WYOh4btlOhsRmW6wHd1M9RW4O16bFsVWRlc3Eqo/3t+xBMJtDAkwUKIkr9wXh+XsO/SEEiQ0Vku
	FKTEHFGLmIlQuopmEjHrQeoqc0OLQWQbiJwBo6lBJD02EfWDbZzCCvu7cM6v2YtETtjJ+pWMwmJ
	yj9P0QQA9cap4y+o+rvTbtMTd/kvUPK/0isiPEQlD5QmwpX0v7hN1jPzPJiI+0alN3LFitA9KYE
	imSSzXxwlf8DOjc7KkvkFhraRasHUkw2IuZEm5f32mC304Gdut9yRVAYs+1PIVR9emxtLw9sKYF
	KfW7oSi/YCPpT07V+EQBUKTprf8BHWvKb9
X-Received: by 2002:a05:6a00:4519:b0:847:968d:b101 with SMTP id d2e1a72fcca58-84f2e03916amr12400877b3a.21.1785968709426;
        Wed, 05 Aug 2026 15:25:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-84f4508ca5esm86304b3a.0.2026.08.05.15.25.09
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2026 15:25:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb733fc5024so1994072a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2026 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785968707; x=1786573507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hLRncDuyKwOflu/6tMTLfOctGqnwhO/BaelPc17xZZ4=;
        b=BFhn7pnSSxmpAQXqc0lsjN5Lzi0lit8qe9emwHWlamZCMDPd3ayAgrfWeTI89yAQWb
         WgL38B8AOcenzCEcDMHLO4uTP1Bkngxpg/v+uBWJc83BHIcNDgLibr0ySkoCfVLMmG+r
         C8+xvU8sssw+Ef55Yk1kwFU3uHfvF9tML5w9g=
X-Forwarded-Encrypted: i=1; AHgh+Rp8mNlezSFNePK3o8CQnS8zoiTij0AfCmpvRylSEa3DbLVRNcN3ienJVNC4bYmLZfXwFM/421wsS6Y=@vger.kernel.org
X-Received: by 2002:a05:6a20:b598:b0:3c3:a024:1360 with SMTP id adf61e73a8af0-3cb85eaad12mr12458331637.28.1785968707541;
        Wed, 05 Aug 2026 15:25:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:b598:b0:3c3:a024:1360 with SMTP id adf61e73a8af0-3cb85eaad12mr12458280637.28.1785968706986;
        Wed, 05 Aug 2026 15:25:06 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158676f579sm18526160eec.20.2026.08.05.15.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 15:25:06 -0700 (PDT)
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
Subject: [PATCH v7 0/3] mmc: core: Keep the card powered across suspend when firmware needs it live
Date: Wed,  5 Aug 2026 18:24:57 -0400
Message-Id: <20260805222500.2567801-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <y>
References: <y>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This is v7.

Background: on brcmstb boards with a Kioxia 016G01 eMMC, firmware
accesses the card directly during resume from Suspend-to-DRAM, before
the kernel's own resume path runs, in order to load boot code using
hard wired logic that is not field updatable. The card needs to stay
powered and responsive for that access to succeed, and since it is
never power-cycled, it also needs to be reset before the kernel
reuses it after resume.

Changes in v7:
  - Sashiko's AI review of v6 found two real, complementary bugs from
    treating keep-power-in-suspend and reset-card-at-resume as fully
    independent in the driver: keep-power-in-suspend without
    reset-card-at-resume left mmc_power_up() no-oping on resume,
    which hangs on real hardware (confirmed); reset-card-at-resume
    without keep-power-in-suspend drove the clock and bus lines ahead
    of mmc_power_up() while the card's supply was still off from a
    normal power-off. Patch 3/3 now requires both capabilities
    together for the suspend fast path, and gates the resume-side
    reset on pm_flags (only ever set when the fast path actually ran)
    rather than the raw capability. Verified on hardware: the
    previously-hanging combination now falls through safely to a
    normal power-off/power-on cycle, and the paired-capability case
    (brcmstb's actual configuration) is unaffected.
  - Patches 1/3 and 2/3 gained Krzysztof's Reviewed-by; their content
    is otherwise unchanged from v6.

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
  mmc: core: Honor keep-power-in-suspend and reset-card-at-resume
    for (e)MMC

 .../bindings/mmc/mmc-controller-common.yaml |  9 ++++-
 drivers/mmc/core/host.c                     |  2 +
 drivers/mmc/core/mmc.c                      | 47 ++++++++++++++++++++++
 include/linux/mmc/host.h                    |  1 +
 4 files changed, 58 insertions(+), 1 deletion(-)

--
2.34.1

