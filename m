Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4096B3EB0E2
	for <linux-mmc@vger.kernel.org>; Fri,  7 Aug 2026 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132893; cv=none; b=trCnfpj7T95m5TYHfRQK9Y+JgXNYyR2pH70ESh2fboktJ5eR7mVuya/aQo7Xu+OtbN9lbSE3BGQ16U1x9q3sp6hJ6ZcIhAqZlwcjr5BAjgWwTFJJXYZr5m7GeWl/SrMhZ6qGwYoHrUmd3/5yzmwjj75KxdY7XeuFWkHOEzryTFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132893; c=relaxed/simple;
	bh=uu0TuG830TDAd8HVpkzQtAJNBwlyK6DtxfvW6vWgrkA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eya6gn6E7rAfO/rvLCOZNMzYxR84gX4IxQwGzUALRKZqQreO8bAPnGYpT8scaCZNFnE3qr7sMbg7lxsEQXzOiMvDsI+ApWO6gjADkjm6YuU50tTr8Nvrg82/IXyat2cMkc7RB/9vb/mHTnOhLZxZSKy+cm13mHUY4RjiIU6/Q0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dkn471c6; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dkn471c6"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2736369a91.0
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 13:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786132889; x=1786737689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8BHthRSdGciBTrHXenwgfzAOH/9DlLCYoqKmsO1zixc=;
        b=cGkkBh/k1Q5y4oRikCp39uozRKQ/YXQKFp750Utt7n8I1bkIsnwBYkh7u28HZiF/Jp
         kKUBXYUUJs62Tvpzsy0ieRV796UH7xhhXeHUK0EmW+bsPAp62JsthY7bHOwKw9Gkp09n
         u7l37nHVSXgJoWOBEdMbB1C12a/0FVlRBhblldzhQQd81sYe0ayRyc4khMX1PC4+eKpZ
         bZhH/doZdVNpMhLfj30rQosknGkauK9Y2Saeoj2k0A6K7a4ly1zoLaFb7iJYFnitbtbs
         CsJ07NLmAen7wTwLIMvBqp8TXPawWpOsIMEKOdPg4hzpFOdUDtVBKyMPqKfmveE+Uydv
         DBeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0FBgzpJQWD1TkyEgOURbuqzJM68O5SozjCgL0SO7wB6lnKd+Dkkx02A7K7DAhvP/Xi8Vfj4Or7hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX6o+sJvjigiXeNXBO0SzFRqbXvUXpvZM4F+/PrTdYkRy8TDuO
	BI/vrArvZVgE72U7IfIYYWut5Yr6k+5o94RQn7S3Qxcs30DMx0iM6GHydcWQ3Ftr+YumWOk7hTx
	f3BEKrC5WQmhztblUB2zC7icrs/YbcTMYQmdr9+5IkdM9UO7S9HM6sroKdV+z0PGiipitY1HZVC
	ngAfK7TJXr7CcaWBDPcifm/A30VxtRh8zPuDU55BgEAgHUyso0EENLcDeyIBziDFpA0OuLXgrZ0
	4bBdoBJgzgw
X-Gm-Gg: AR+sD13oiia83e9qmevqBUJ2nQehWKxNQcAMf4HLMuNRRtwKEmbm0YUp/GXTw7eztGR
	2kJsX2glrqLNx0arEcGDC0HEHLnwf7NBp8MkRmJlFxMzKDelmw+o1/WISX3AWmPAUwtLOpYft1w
	5KERflIUZesI9wG7M6mJr7BZUrb4SVnXjJnAuN1lmq8lVRQopYUPNR8BEul+iNkqBUPXs+9e6+N
	maav2xSJmek4y7c2udi7cvHtmrmzypJwu4vk1QnQ0vyhM3+RSEDHxrkWrf4nR/ZthUJhxdDE9bf
	yXXknmGgCq4UqHFED7XGjijQiUdXuV2z/tqVN2tYMUHUA+8iM4N+H5ygZOOL7EHrArES5070YfL
	sXPN9rOHSzl1BBGP4T9H0DvzNJ+iNpfbgxhOEjjWudgS2U9rNlGmVWXV5gevcMZRs4la9t/nNha
	xA+CwxzLxfRy9bHQ1LPj7u3SEMef7Zrg==
X-Received: by 2002:a17:90b:35c8:b0:38d:adae:4866 with SMTP id 98e67ed59e1d1-39282494777mr2644260a91.21.1786132889315;
        Fri, 07 Aug 2026 13:01:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-392825d6e6bsm349383a91.10.2026.08.07.13.01.28
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2026 13:01:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9309af14fd7so356682585a.1
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786132888; x=1786737688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8BHthRSdGciBTrHXenwgfzAOH/9DlLCYoqKmsO1zixc=;
        b=dkn471c62GO2/J7nq5EBHWVbSgmApM8LVF7nZ8L6Sb92rCarMN5DHGuaS5N+LCP85T
         J7fWVXNP4WQ1dnNjl7Hz5pOWX+E27b/SDS3cKOA2n7orvOv+cwBycB2SnnpfBDJRAwlO
         Yas9849LEm1MuMCCTZczApjw1YDJ9Fg4ktodg=
X-Forwarded-Encrypted: i=1; AHgh+RrQhVY3bRl7sl//oIjSDEp8Qel0DJeeuUBYIaVzWy6FarCXhYTFB8rNBlcObgXjJngqDBqIKcUO+zs=@vger.kernel.org
X-Received: by 2002:a05:620a:aa15:b0:930:9783:9910 with SMTP id af79cd13be357-936798a4e92mr281100985a.40.1786132887918;
        Fri, 07 Aug 2026 13:01:27 -0700 (PDT)
X-Received: by 2002:a05:620a:aa15:b0:930:9783:9910 with SMTP id af79cd13be357-936798a4e92mr281085985a.40.1786132887151;
        Fri, 07 Aug 2026 13:01:27 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366dc51b43sm225839185a.0.2026.08.07.13.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 13:01:26 -0700 (PDT)
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
Subject: [PATCH v8 0/3] mmc: core: Keep the card powered across suspend when firmware needs it live
Date: Fri,  7 Aug 2026 16:01:18 -0400
Message-Id: <20260807200121.2590202-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This is v8.

Background: on brcmstb boards with a Kioxia 016G01 eMMC, firmware
accesses the card directly during resume from Suspend-to-DRAM, before
the kernel's own resume path runs, in order to load boot code using
hard wired logic that is not field updatable. The card needs to stay
powered and responsive for that access to succeed, and since it is
never power-cycled, it also needs to be reset before the kernel
reuses it after resume.

Changes in v8:
  - Sashiko's AI review of v7 found a High severity issue on patch
    3/3: the keep-power fast path marks the card suspended without
    powering it off, but the pre-existing early exit at the top of
    _mmc_suspend() for an already-suspended card doesn't account for
    that -- a shutdown, unbind or undervoltage event landing before
    the card's next real access (which is what lazily triggers
    _mmc_resume() via runtime PM) would hit that early exit and
    silently skip mmc_poweroff_notify()/mmc_power_off() entirely.
    Fixed by reselecting the card and continuing into the normal
    power-off sequence in that case, instead of a bare early exit.
  - Sashiko also flagged a Low severity gap on patch 2/3: nothing in
    the schema enforced reset-card-at-resume's own stated pairing
    with keep-power-in-suspend, so a DT could set it alone and still
    pass dt_binding_check. Rob Herring asked for this to be addressed
    on the list. Added a dependencies entry for it.
  - Patch 1/3 is unchanged from v7.

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

 .../bindings/mmc/mmc-controller-common.yaml | 10 +++-
 drivers/mmc/core/host.c                     |  2 +
 drivers/mmc/core/mmc.c                      | 71 +++++++++++++++++++++++++++++++++-
 include/linux/mmc/host.h                    |  1 +
 4 files changed, 81 insertions(+), 3 deletions(-)

-- 
2.34.1

