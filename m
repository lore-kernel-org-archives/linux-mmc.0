Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B83CB2E6
	for <linux-mmc@vger.kernel.org>; Wed, 29 Jul 2026 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356070; cv=none; b=ptxoqOgelcLCX9g+6FYMvvpGL38w33KcAwLs0wps1rEI4npDdTqB0IL0goA2p5ztZd7Vmr5uemcTKFh5EPybpEIgGL0Z2uQ8c/rumkk9jeVo6N0PwvUUss/d9LKGEc1a55gtWYpPVmhTt5QpbBCjK8FGq5PZuFAzmvnoMwIiZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356070; c=relaxed/simple;
	bh=dNibn9+fRRxAz+bSl+iGvhTZbe1S1JvPG2WY/u6Qyeg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aq/gaAPQle2hVWxaVHL/q0Q3EYMLDQq+9WISWvp4hlhQSCYp+q96HXQjU1VP/ieAdedv3xJy4X7XD/0UbHbsUGWsXKR5fC7UuQAPPMY7+imcIUFFNMzzhfUDHTFHTmGxydFv5OyiZ4OowCK3fdgH76SxyXXSxp3hvKahJZwqShc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KLAT7xGN; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KLAT7xGN"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-92ed3993c1eso86756185a.1
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jul 2026 13:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785356067; x=1785960867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q8cg7db2G8jIu7Q9xqei7Xa543QGG7fv2VU1Z8dI/3U=;
        b=BSQs8SzT57TJ/8Xi4bdWVGQN0Dv4iMybFr2lA3NDaHL1C7Jwa0IKBgCCSfIoGNrgcu
         +MxHXEBUtUqo20+M/vQU7TNb8I+RkfdLuj36rWse4JQgBW8bYEfpF45P/xo2Y2czVno8
         uzgoq+j4/lDoO+pHPSa8OzZb4diPuUlqmpAo8YlVgp07etm3cHPBon7wkurAI0PiIn8c
         9JAPDp6cYhbmw976AgdPipKQWJFMLPHnUb1qkoM85fy4jwAF7qlg6tSPmoj3HXtXjapc
         6Z1kl78Pz412L7xpAWf7nkHn/Cs6+splf3cXnOoeSrk0gthFXWJj6qrqxGjqpjGvEVVk
         ZY3w==
X-Forwarded-Encrypted: i=1; AHgh+RqDcwQcmJoQOwi2qIhmgXVCNN/Rb8i9L7+3KEDsQw+6iVKRlWuGkbf/haHAAXl/KA9xSHDOoJuFfnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9b1AEkitPcpGVA3gNfrRPvoMR2YSNTJ/hoTy8VGKV5AHlcOtc
	bYFB+kzkcsg/xKc9zQIYa71EWkyR6zvoEqRqjV3Wwmfei5dg5bBQnuX1bdxKh40gkV2mmm5FNeF
	X31sEE6gCdZUtNJtFxyggJsF/kjmpr/pwFaC9/U6FxPhxud9MeooLGfAey4ChyOdbSo+CPCtDz/
	/kdgDUf35yD1eGpYog9iLe4EKNIMybiJwQMp/PDwSwzgpGpAFEzKqrUjGoCvQyrWRdCGJ/10SYp
	C7V/6W95Sbk
X-Gm-Gg: AR+sD12wGG1rMFJ5m4BH7Od210nLamXuJljfffo4ahBnWjkunZvQv9q5YZhSdV38toJ
	LFCDbAL/8wFsdDxNK/4TvjmDzkjZJHdfgo3UajkS7SQt+vfTnKTn5oPdLEZy8trCaeGbUpf7hOI
	w8O5nOZXgB8d9ksyo7mOGv9LRJp1K6ebNN3Pdrywb+E+5JOBM/1NRFKlvI+vPL7koEikU5+BBdk
	+BsvkwxbmSjpD0YMRHQ4Lme8rbvXfHVEFlxe5r0ljCMmZDeckEBdTwwUlTh9Iha/ooOaQY+u/pv
	0ZexneuN7yVdsxuSTPN7alXsG3E+p0+l+nVhFI0Mo56oUOxhr23TaOBGq/Ev0mIXRwJqiwq/af0
	V3fhNyQHupFaosD2ao42oL1JYPMjCY6oE86HXlvX7bvuQQyWFhaLAsEjVHBoN9MX2Xqo/ggpU7Q
	juHzQPHdCS+MIohGnETlmcFDbd7tcy3LQ0
X-Received: by 2002:a05:6214:29c5:b0:8ff:b592:f0ce with SMTP id 6a1803df08f44-9083013272emr4729436d6.2.1785356067283;
        Wed, 29 Jul 2026 13:14:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-9081dd1530fsm2373626d6.23.2026.07.29.13.14.27
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2026 13:14:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-907e49dbae8so12453536d6.0
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jul 2026 13:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785356066; x=1785960866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q8cg7db2G8jIu7Q9xqei7Xa543QGG7fv2VU1Z8dI/3U=;
        b=KLAT7xGN3zCGZ0XuY/1YFG3dwgTEk/fgJRRQa9Wzqu/x21cQZXM8rc7C51NzVTstKB
         Yod+MxN/3f8/b0eVCVOuCSTzKCWmhYKG9Ni28Vn8wpi1IaYailKx9gpxdCRvOce9OVSs
         N/wZtWSEUhwjDoWheOoO83VnVJyexcuNVQ880=
X-Forwarded-Encrypted: i=1; AHgh+RoFN4I/OrNOf7B7LgM9/mfu949xzqi62YKSmuNmsqQ2UlHL5JFr+M8IvFRM1PzQnSbOJXYdBzLBqLw=@vger.kernel.org
X-Received: by 2002:ad4:5f05:0:b0:8e9:f62b:8fa0 with SMTP id 6a1803df08f44-908302562d3mr3904196d6.53.1785356066508;
        Wed, 29 Jul 2026 13:14:26 -0700 (PDT)
X-Received: by 2002:ad4:5f05:0:b0:8e9:f62b:8fa0 with SMTP id 6a1803df08f44-908302562d3mr3903896d6.53.1785356066008;
        Wed, 29 Jul 2026 13:14:26 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd8cb0dsm32033066d6.48.2026.07.29.13.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 13:14:25 -0700 (PDT)
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
Subject: [PATCH v5 0/2] mmc: core: Keep the card powered across suspend when firmware needs it live
Date: Wed, 29 Jul 2026 16:14:18 -0400
Message-Id: <20260729201420.4047677-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This is v5.

Background: on brcmstb boards with a Kioxia 016G01 eMMC, firmware
accesses the card directly during resume from Suspend-to-DRAM, before
the kernel's own resume path runs, in order to load boot code using
hard wired logic that is not field updatable. The card needs to stay
powered and responsive for that access to succeed.

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
 drivers/mmc/core/mmc.c                      | 30 ++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

--
2.34.1

