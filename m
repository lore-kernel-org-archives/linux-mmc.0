Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383869;
	b=LxKJhggY6WZ/mh3g1jrzXdldrIuHnJw/d7N7s5BDtmXZrqGWg7vxSAhZsMqeEhJKUyrF
	 zh0KF9uPgAyQmQH7BKYCAHsGRlqADjTZdXcFT88ke8z3OmAjNmrYzx9SeIVCff9/Wspa0
	 6ssd7SeuvmbJUpiCNjoX45OJuQ6/s1jkrlFI/l6T46zzXOZUJfdBFWNZquZ/e5Upk+mgo
	 vJyyA9Lj97C8Rw3GXxDzXYEYAQpb0T4Fqa8Zt+krqJCzvwl6Gt03YBswv2Lkqr2zBgW4r
	 hrCuzwqV/iqXmeKHEvCVUBByDWZSveVSqRd7OLgK0ozvMqwr2REjTNSwycP0A6di77A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383869;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=ENwKWbPNvS8Z4Ya5TukwYEHVlcVz+1SrF/4rTtdeRYE=;
	b=cZgVWEP6EO5U3mxmnq8ifgOy2T1WyGp0+0sJWzQQyaa6Aatl+JnCSgNkiKEDYZU3N/H4
	 DLlM65z9G0w4VF2DtMK6Bz6KI4vN5mG5HPbTYl9Nh7GoKugB7h4lEnt3SCNdCgAVBsIUF
	 3JO1WG3vwmV7mqRletXV5Rcdg0tP10x2+nRAymshY5B2q4SM6mlC2KzuIxh2acMkYJ4Sr
	 a9+1eNrDF3Kh8h29KAqGfOa1suok8wzBQYXvdBOscrddP97sX1zcTLWh29l6NE/p37/CF
	 AxRAoYxhjKQ5saG25OZCkB3Cu+2rap3Pt8VGmOj/LvyZtEYMqLelQFzMvC2OzmwcDGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=O6g7inPs;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D78606A31C
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 18:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74D78606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=O6g7inPs
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so434439a12.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793383869; x=1793988669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ENwKWbPNvS8Z4Ya5TukwYEHVlcVz+1SrF/4rTtdeRYE=;
        b=2KNyMBSOTmpLbWn5GirPSKwkh8H2wYUqQ6ZO8jl7G1njVGP8snwxENNMmH9mB8cqwt
         lv6Vdnw7pwdvxmgWzjb7mCELdDXy3dTKS4vDqLsD7yy+gvmdlppdX7bp7zOI41tgd1Jc
         OM4QSqV6nzqZI+1tU2DfkfdF+llF4iClshgAzoiVaxFcgYI7thZF8Pvx788PHJqPfpEs
         X80IYaK8rFFnUl/TO4UaL4+m30eTPkCv3yqwzglNcglpkmBV2yuapITcTBvUabeGbvW2
         TR+AlIjP9MBBjGlCg/UI6j1c/ExOPMLkqf7Bx0IljOnsskdeoMrm/BOkixt/Lu0UmBoO
         QyXQ==
X-Gm-Message-State: AFq9FYJZDHKkSzPCJpir+Iezu0Pc/GHH5YhENcrqn1C+PY6NESsYemXE
	AuTMSlamKxS605L4knOma1GrNDis2Iz3qICZ44yg8o4lohOj50pnOqln8qjbUshLatHcGerdEY/
	Wa3z0viYH08+0CYolx7SndnQKf9dqUy+AnHkQoQxLNmn84s8Viwin2Jwu7hmFh4rEYTdMeNAmDB
	sYZoH3uuVXXD10wCzq9uDBmHU1cigsUPf+e5RYFKJK6P3WYnCgbQsucvGya42oOfFenei8uXo8V
	lcTPQ/2GTjk
X-Gm-Gg: AYBFou1aZUV7ltgMeIh1xMkLspMftTMeaKsuFryHkZJLp+JqwA8ugvDzwmUvOgfgULI
	s79vPpaDZm3JVBWL0Mx5wuNMCUDlfhf9Z/ErmTQxzRzLwQuXzlhaON2tY6SLcynZXyyc7Lz7uYE
	ZOYfReUOpzSuN18FSMofI2ES8yxscDey91DrQT9lOgcO/Sz+ybE5t89q+SjmiBDjScaLdl2H1yQ
	9gT2bQCq48GheJTmShENa17jXu8PUFRmL4LddOy7ZP8XY0rJjrNOikVpewCtbztZMVGtR68Wpnf
	dvulnDzMY6ANbbV59zAbOfJGu2/1eUDuX/Tw2TwxPIPzzRLNTGeeNl49uQ5fq3Y7oD96ZOIdK4W
	I8On3DeicRqJZ/wvwHk0pIWkKN4PsYiN3HZxMzy5+I/1tWJnVgB9JZNotanBasGU520yTRmYrUC
	9qp5kfOpvD/32wieNvnBtijmWPSnxYRa6T
X-Received: by 2002:a17:90b:2891:b0:3ac:7c52:fb04 with SMTP id 98e67ed59e1d1-3ae897ab44emr2460355a91.44.1793383868689;
        Fri, 30 Oct 2026 11:11:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae845baad9sm2349301a91.5.2026.10.30.11.11.08
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 11:11:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3552883bd19so4058372eec.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793383867; x=1793988667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ENwKWbPNvS8Z4Ya5TukwYEHVlcVz+1SrF/4rTtdeRYE=;
        b=O6g7inPsa2sBGHGQP5cDT3OAyadExj8upGxR7d4Hku4O0gWwAtO5++imE5XdD9yQp5
         cTruTy8yp+bKnBIZoMfywZKmngTXRiTmEzGoD4jULhqFch4R4c4nn5BJboAr8kfQzcxo
         32AepDN+/hsSgd/eKC/2Ao1FI6AhKBj0QZWDQ=
X-Received: by 2002:a05:701b:4784:b0:165:4b88:abc2 with SMTP id a92af1059eb24-1ac5b5ee632mr5419044c88.26.1793383866990;
        Fri, 30 Oct 2026 11:11:06 -0700 (PDT)
X-Received: by 2002:a05:701b:4784:b0:165:4b88:abc2 with SMTP id a92af1059eb24-1ac5b5ee632mr5418989c88.26.1793383866189;
        Fri, 30 Oct 2026 11:11:06 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm9974062c88.11.2026.10.30.11.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:11:05 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v11 0/6] mmc: core: Keep the card powered across suspend when firmware needs it live
Date: Fri, 30 Oct 2026 14:10:27 -0400
Message-Id: <20261030181034.3811225-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Background: on brcmstb boards with a Kioxia 016G01 eMMC, firmware accesses the
card directly during resume from Suspend-to-DRAM, before the kernel's own
resume path runs, in order to load boot code using hard wired logic that is not
field updatable. The card needs to stay powered and responsive for that access
to succeed, and since it is never power-cycled, it also needs to be reset
before the kernel reuses it after resume.

Ulf's v10 posted patches 3-6 and I'm resending the whole series, as requested.

v10: https://lore.kernel.org/linux-mmc/20261027144051.249211-1-ulf.hansson@oss.qualcomm.com/

Changes in v11:
	- Rebased on the mmc tree's next branch.
	- Patch 1, 2: Resent by the author to complete the Signed-off-by
	chain, with the DT list and maintainers on Cc.
	- Patch 3-6: Added my Signed-off-by as the submitter.
	- Patch 4: Keep the comment about suspend methods being serialized, by
	moving it into mmc_set_host_pm_flags() (Shawn Lin).
	- Patch 5: Also split the cache flush out of _mmc_hw_reset() into a new
	mmc_hw_reset_recovery(), used for the ->hw_reset() bus op, and renamed the
	patch to "Move and split reset functions for eMMC" (Ulf). The flush is
	redundant when resetting at system resume, and failed with a timeout,
	printing "mmc1: cache flush error -110" on every resume.
	- Patch 5: Dropped Shawn's Reviewed-by as the patch changed.
	- Patch 6: Claim the host around the card reset in mmc_resume(), as it
	sends commands. Without it, WARN_ON(!host->claimed) triggers for every
	command sent during the reset.
	- Patch 6: Warn while parsing the DT properties when
	reset-card-at-resume is set without keep-power-in-suspend (Ulf).
	- Patch 6: Dropped Shawn's Reviewed-by as the patch changed.

Tested on a brcmstb board with the Kioxia 016G01 eMMC, using "pml -d"
(S3 suspend/resume):

  keep-power-in-suspend  reset-card-at-resume  Result
  ---------------------  --------------------  ----------------------------
  no                     no                    Enters suspend, board resets
                                               at resume
  yes                    no                    Enters suspend, board resets
                                               at resume
  no                     yes                   Suspend aborts, -EINVAL
  yes                    yes                   S3 suspend/resume works

Kamal Dasu (2):
  dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
  dt-bindings: mmc: Add reset-card-at-resume property

Ulf Hansson (4):
  mmc: core: Add option to keep an eMMC powered on at system suspend
  mmc: core: Split sdio_set_host_pm_flags()
  mmc: core: Move and split reset functions for eMMC
  mmc: core: Add support for resetting an eMMC at system resume

 .../bindings/mmc/mmc-controller-common.yaml   |  10 +-
 drivers/mmc/core/core.c                       |  10 ++
 drivers/mmc/core/core.h                       |   1 +
 drivers/mmc/core/host.c                       |  13 +++
 drivers/mmc/core/mmc.c                        | 105 ++++++++++++------
 drivers/mmc/core/sdio_io.c                    |   7 +-
 include/linux/mmc/host.h                      |   1 +
 7 files changed, 105 insertions(+), 42 deletions(-)

-- 
2.34.1

