Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1051E311C07
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311593; cv=none; b=ghDKQl1qBghX812US1v6ev8sHH0qFc8x12vlvyNRfJOqYqdWdBc8C5FKUUQD3Ww7VmdCiIZ2aviSYKtJoZV5Sert5WbBTLGuOcxKteAQo2ftLzbsVJXzu300CCsoc+Iz03E0eNfpB5XcMnjPAkGaJzbNOjfQMWbePa/ar+SDTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311593; c=relaxed/simple;
	bh=+hV0vQQ2qccegCAb9oQyV62O6SKN6X4yQBpfcmEKnnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r3ylzQPIITX5Ssb6isuNoqoHcazjeoFvoAmz6jef6xPrqi+JTOVNjNRuI7mmf3Bn5Kgr7V82Y9vim/8xzV8F0GLs/PvP+xWGrC++gyhwyRp+PWwoLtNdi8lggO458G2Q0l9f+tvtgY5PfPhIglWq6Ygn36ABqL1er6FNtAWwF8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kf/QXJtg; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kf/QXJtg"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2c7c61b5292so63628575ad.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 11:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784311591; x=1784916391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TzgfqCvjoQZnveGpPF7MFJ2MVCAWx2MGGUIgss3Wdts=;
        b=Q93XAkqXUUwaonz9jqHbJ2OwCm3lL3r6GsEqAObV+vb/jY+BRUBG6g5x0HNUhCgo58
         arxGsc6RZ5MDdK50/VWgHntUMwIxMPR5Y5BJEoHyRnyyfrUU/U+A5zpKk+itbDBheAfn
         c0iRqlfn9BuaC8rqna9LfZH1G2Ri74SEo+aPN4Y4jsR35bHjx8VHYrYTWcVAszjXQ+RK
         FesbRVqW+/Eh5PUEmkBMR+FkL6K0bdsHuJZYXdY6jqHdBjTEL7ruZ1bdede5Zm7eeV+8
         EYJjRZNK/py6nOd0hMT6ACYzQBWSrJxzlfB+DGtfMGGsGFmi3wvPBmx9TcmAwC2R5LLE
         lipg==
X-Forwarded-Encrypted: i=1; AHgh+RoDQiYHAukzys58zn4WbI2dOfvLSexAXDzbEB7EQ74cIPzMZ5P2OEDTbNU9HgX4hwZjeni/CIULP2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/Skj1Y4DEKs6+398lrjy/PqD/6IZlRvouFRqrhNVPuPwTicx
	AAQ0dUhLu7UpzuPQz2WFVvulbuZl7LUZ78I9lLA/2iBwirXOkSJNZTwhsbZICGYO1nn4nB5FNPV
	fOrwEnxJOj2Q4qQj6S085jGX3eiYPDj4WzeXzPGwu41oIGagfTgBk0NMff1ZobQuEIBOTIsY7F8
	wTNNhwSxAMmjs2rdLJO62qy3r+nrnJWkTOQfrW1d1PuJhivkwpGUkAj8KwRLxLewdsbUbaSqHCn
	+voSjOsizVZ
X-Gm-Gg: AfdE7ckx6c9z9PkEKFVKzJWvUHpyn3whyGUzuhCAW/mUZw9UtuS3jzTGJAsXp6PUePI
	PMl5OIGb3Q2hpJXGjRH71Uh5XJOhCg3cDl1/e1kGiMoEsYM9+DOe5yYddPcOvkXaGNwuDHhwXSi
	2nA+2qZ7veESHilMVzXdv4oZ6tpjElfD/Gwyz3ZsdvSiYmyMA7H4znIF4dj3GmHiwOH2KER8poC
	KKkoF4aooP+ziZPshqAjOL52lZqFc41wenXUdvQ9uhrc9J8DOO+IjHG11xFxrdh+yeTcir5tGsZ
	rcqCnt6CdECfIyPFHFyKSWBbKhNBIiAB1batQkrsacb4+NSK+CzVpgecomBWVfI1kt+Vd8Uqnx1
	0DQKpc2ZyniI6+xatli2vrpZvyR5rXKBGewnp/afYjhP0uSJu3MoQw9itMKiVaieq0mpcaMDMVl
	vMn+qVU1XX8SVm8GJKHzuFSPL2HKeB3z7k
X-Received: by 2002:a17:903:181:b0:2c9:97a9:2098 with SMTP id d9443c01a7336-2cf349fa514mr41944565ad.44.1784311591158;
        Fri, 17 Jul 2026 11:06:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2cf344ca67esm2167365ad.20.2026.07.17.11.06.30
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2026 11:06:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8fc6b670b4bso65389006d6.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 11:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784311590; x=1784916390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TzgfqCvjoQZnveGpPF7MFJ2MVCAWx2MGGUIgss3Wdts=;
        b=Kf/QXJtg4ZPT43THpMyP6ntKSrXuECkPTKWeMGwbPUCMWUOPA3G2jCUVwn+iy0VuoJ
         3k17dk2/QSDsV9WU4hO8UH8g1zEUGiLdAR4liHVxu7613lJXHwT/v0SC0bSfbdNsQJnD
         iVzcB5hAozn/gBR/S9juPC08kkpRFhqEuVbPM=
X-Forwarded-Encrypted: i=1; AHgh+Rp0kWYEa4VJVU8+gAERnxJr9eoMuTm+YiVDZd8YeHuK2Ze5Ek/uppGJb0NGMERZdFHCoU92LPNY4is=@vger.kernel.org
X-Received: by 2002:a05:6214:2387:b0:8ec:a010:9af9 with SMTP id 6a1803df08f44-907783b332cmr41216986d6.40.1784311589849;
        Fri, 17 Jul 2026 11:06:29 -0700 (PDT)
X-Received: by 2002:a05:6214:2387:b0:8ec:a010:9af9 with SMTP id 6a1803df08f44-907783b332cmr41216276d6.40.1784311589265;
        Fri, 17 Jul 2026 11:06:29 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077856002esm23175896d6.11.2026.07.17.11.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:06:28 -0700 (PDT)
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
Subject: [PATCH v2 0/2] mmc: core: Add a host capability to skip SLEEP for cards with a broken resume
Date: Fri, 17 Jul 2026 14:05:34 -0400
Message-Id: <20260717180536.1757204-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This is v2 of Florian's original patch:

  Link: https://lore.kernel.org/r/20260413180551.3683969-1-florian.fainelli@broadcom.com/

Background: the Kioxia 016G01 eMMC takes ~10ms to exit SLEEP (CMD5)
instead of the ~1ms it advertises via S_A_TIMEOUT, which can be
problematic on systems that resume from Suspend-to-DRAM by first
pulling boot code from eMMC using hard wired logic that is not field
updatable -- if the card is still asleep when that logic reads it, it
resets the board. The device stays powered throughout suspend-to-
DRAM (no software-controlled VCC/VCCQ regulator toggling on this
path), and the CMD0-before-resume sequence follows the JEDEC boot
spec, so this isn't something the kernel's resume ordering can fix
on its own.

v1 addressed this with a card-level MMC_QUIRK_BROKEN_SLEEP quirk
keyed off the device CID. Ulf pointed out that a device-specific
quirk doesn't generalize well and suggested a host capability bit
instead, settable from DT (or derived from a compatible string),
mirroring the existing no-sdio/no-sd/no-mmc properties. Oleksij
separately noted that quirks registered in mmc_blk_fixups[] are only
applied once the mmc_block driver probes, which is too late to avoid
a race against an earlier SLEEP/poweroff triggered on an under-
voltage path -- a host cap resolved in mmc_of_parse(), before any
card exists, sidesteps that ordering problem entirely.

This series implements that direction:

  - Patch 1 documents a new "no-mmc-sleep" DT flag property.
  - Patch 2 adds MMC_CAP2_NO_SLEEP_CMD, parses the DT property in
    mmc_of_parse(), and has mmc_card_can_sleep() honor it.

The actual board DT change (adding "no-mmc-sleep;" to the affected
brcmstb eMMC controller node) will follow separately once this lands,
since that DT lives outside of mainline.

Changes in v2:
  - Dropped the card-quirk/CID-match approach entirely in favor of a
    host capability bit, per Ulf's suggestion.
  - Added a DT property ("no-mmc-sleep") to set that capability,
    following the no-sdio/no-sd/no-mmc precedent, per Ulf.
  - This also resolves Oleksij's concern about mmc_blk_fixups[]
    being applied too late to close the race on an early
    SLEEP/poweroff path, since the host cap is resolved in
    mmc_of_parse() before a card exists.
  - Reworded the rationale in patch 1's commit message and binding
    description per Florian's review.
  - Added a Reported-by/Closes tag crediting Florian for the
    original bug report.

Kamal Dasu (2):
  dt-bindings: mmc: Document no-mmc-sleep property
  mmc: core: Add MMC_CAP2_NO_SLEEP_CMD host capability

 .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
 drivers/mmc/core/host.c                                   | 2 ++
 drivers/mmc/core/mmc.c                                    | 3 +++
 include/linux/mmc/host.h                                  | 1 +
 4 files changed, 14 insertions(+)

-- 
2.34.1

