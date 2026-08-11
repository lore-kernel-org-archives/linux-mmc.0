Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65D3B7B6E
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466298; cv=none; b=EKXwcvpWloSv1LXXIhS23c9vZwYm0jlPJ6tSjDrBXO4g1IpubBec3BlBM4VCSOWmILGN+RtZtAaSZ/aRCJ93aEfmEYw6T1oLxWksNbIiFy/UayYyGN73pi2KIcczockhncwRvPNPUDW363XqOFe9eLh8baYPR+RR881sWingFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466298; c=relaxed/simple;
	bh=P2Uzx6dPa+dcFtng72LIW6pxwYbo5EbJy35fZWrdUMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EE2UXALUawdj3B6VC19OlzAc3S0X0SVSbDilJF7B4pPn24IFHtO5hnNXSt37R4UBstnyVVvykV1OL1Pv84Bn3mxhDk9ssAbTYvrIZ7JEQNylmEIDskpmO97CqEFiU9KyW3ecMiarZ8wyfoivWgUZO+bFvyMhzIy1a8Gt7+EY12w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ol0Mkqv5; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ol0Mkqv5"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2d032846c95so1795915ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 09:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786466296; x=1787071096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NMY+Wp48XPw/snfiSUx3rL4yhi49I2t039aK3r7Kk+E=;
        b=EsfbqoeA/G7vCBYDLcDrp6Ii115kicQk1M2KR2m0BmmZMLLKGwXaxOg4qytuobeJBb
         HdHiBdXRP//eiL22j2h97T/3H5mLUjXLTvJYlnaRrX8eRdx+bR9ku8n9MyDxMy+zJDsO
         pBKJGd3PH7qObS0Ozn/lQvWf6cyVp4UNrj4UPZ4PnNPvR3x9XndQirQLLz0n8XS7cteX
         9xmxDkau//QHGifgzHIbzgpQbvElxAjnT9Wz1vLF1dHzPApXyA5m2oRn3rQerF/Dyvwb
         RLm3XUNq6EMi0l1kPZeFgUqNDIzI5Muu4ead8cjcoAVdqg+r9A6nUTGwySHXxXO/Yhsn
         r5Lg==
X-Forwarded-Encrypted: i=1; AHgh+RrdyNs+C4WXCjBAGg/K4Wxg71jVCgSBZ0Vdx8hf5hnerRS4YGlx4jLiendZFFdT6S8HPNzAWlvkQew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxldnkxTskLZRCgFYVrpG1I964LDfan3ltfSj74VBFpTKO5imp6
	4sM5fEzvOcveC1LncLODlFSVJqQBi4uSFBefQxAYG8VUouJQph4aaxbuERPpyTMBYuhGrFuOItl
	yQAm8+FPoJduYYcnKGkESBrZCvEOF0Xp2xfxK6bmw0FceRBW3G6TLEX9g5ZirVBzFgk71Nhs+I7
	FxR2iJkqDlNcFKSOC1bEHYoHfy+101Rgury8ipE0lWAEvtolaib2SLZWyH1SrTiomA9yjDLPv/7
	VcCPce/n/MR
X-Gm-Gg: AR+sD11MquNrtxPypX2saapsm3BIlL6eakp0+y0Ddd2q0uLzn2F5eV2+r0alXF2RZXy
	wdmcE37aRUMoV+MSt2meQWNtjRt+AHSvkuy7Ob1gTLcZcG3beozF6FVkOtmaZrtbatWfAGstXZV
	b5I1eRg7794ARmUamaa1luDwQ0sKfOovFxAkoJdSiGlLHdMzvRr7oC0MAHw2YVXhFMfDz5pH0Wz
	3wu9TubF+0WhWCEKSy7XjvgA1zXwICiY/JaOGXMMKuyFEsUkQqhvBcgNKwuvmRutHmXSrP4sOYD
	6nbxu5tjwuItp3+jOyop5H3hUjlL+loZktwUe9mGOUUVAkLHZ7q6YYGLDKYqkoWTh9HMpuf5FUr
	lkoyL7fFbrQwwX0PVQrhZn3a1uMMBFJ7E+a0WmNaR8oL8sW2L05uXWPUQIFfKOgAwMskgdeSQf2
	VuCTIiINbyJlayk9T8Kikj87EcnbkheQ==
X-Received: by 2002:a17:903:350c:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2d3177f6e83mr57298465ad.7.1786466296017;
        Tue, 11 Aug 2026 09:38:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2d3162a039fsm215845ad.36.2026.08.11.09.38.15
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2026 09:38:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1a97644aso1072531cf.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786466295; x=1787071095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NMY+Wp48XPw/snfiSUx3rL4yhi49I2t039aK3r7Kk+E=;
        b=Ol0Mkqv55rZ5/1AJZzBC4B3nsr84d3VsfoJMqVm0MAvTy6Ssd/InuCtrxAVZfNqd5V
         bDfHHnkmh1BRlN1ywFfUPpL6wTQoVUZMtocPPs3uGu4B1aQ4MefqoHfG6HIfUA5MIlix
         vmYGiDX1eotpI65b9PLVMRdkMyUKO16TdO/0Q=
X-Forwarded-Encrypted: i=1; AHgh+Rq/hdiLWPEvm3aWPF+1HdYC/b7AxbSIVNVWIwkJkOB3amDIumCYUCxu/I3tcKLP78x+QNaF253ScmQ=@vger.kernel.org
X-Received: by 2002:a05:622a:38f:b0:517:8711:d46c with SMTP id d75a77b69052e-52d58673f48mr40543351cf.31.1786466294438;
        Tue, 11 Aug 2026 09:38:14 -0700 (PDT)
X-Received: by 2002:a05:622a:38f:b0:517:8711:d46c with SMTP id d75a77b69052e-52d58673f48mr40542571cf.31.1786466293763;
        Tue, 11 Aug 2026 09:38:13 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d57c3c09bsm14427981cf.25.2026.08.11.09.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:38:13 -0700 (PDT)
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
Subject: [PATCH v9 0/3] mmc: core: Keep the card powered across suspend when firmware needs it live
Date: Tue, 11 Aug 2026 12:38:07 -0400
Message-Id: <20260811163810.1599747-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This is v9.

Background: on brcmstb boards with a Kioxia 016G01 eMMC, firmware
accesses the card directly during resume from Suspend-to-DRAM, before
the kernel's own resume path runs, in order to load boot code using
hard wired logic that is not field updatable. The card needs to stay
powered and responsive for that access to succeed, and since it is
never power-cycled, it also needs to be reset before the kernel
reuses it after resume.

Changes in v9:
  - Sashiko's AI review found two more High severity issues in the
    same shutdown/undervoltage fallback added in v8:
      * Calling mmc_select_card() straight after finding the card
        still marked suspended assumed the card would respond to
        CMD7 as-is, but that's exactly the assumption
        reset-card-at-resume exists to distrust -- firmware may have
        left the card unable to decode commands at whatever
        clock/timing was negotiated before suspend. A CMD7 timeout
        there hit "goto out" and skipped the power-off sequence
        entirely, the same failure mode this fallback was added to
        close in v8. Fixed by resetting the host to its initial bus
        state before mmc_select_card(), the same way _mmc_resume()
        already does before touching the card.
      * Even with that reset, mmc_select_card() can still legitimately
        fail (card genuinely gone). The code still unconditionally
        "goto out" in that case, skipping mmc_power_off() entirely --
        but mmc_power_off() is host/regulator-side only and doesn't
        need a responsive card, so there's no reason a select failure
        should leave the supply on indefinitely for a shutdown or
        undervoltage event, or leave pm_flags/suspended state stuck
        retrying the same failing select on every later call. Fixed
        by falling through to mmc_power_off() directly on select
        failure instead of aborting.
  - Patches 1/3 and 2/3 are unchanged from v8.

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
 drivers/mmc/core/mmc.c                      | 98 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h                    |  1 +
 4 files changed, 108 insertions(+), 3 deletions(-)

-- 
2.34.1
