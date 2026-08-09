Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10427394EB0
	for <linux-mmc@vger.kernel.org>; Sun,  9 Aug 2026 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786263729; cv=none; b=gVevITGJctGvKKFA4GDRRDdarIJCT1qGSKHiflwfGC4HEpZ8y32MejO0jDJZxC4RIyy1I2OOCFTZB3+bdk4zp/TuZ3ng5MYg/GfXnozI+v1ggAqgyni7byEKEfEZd62Gt7rojPvQfhOZkTXzKow2BSJN+XkYP+gcSnDliGVenVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786263729; c=relaxed/simple;
	bh=ToO2wiGUtZCjTtVlzygVpSHOFWhJt+VIO2NIvbwWAgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmneEGwgTzr4nGcqVUB4QofPTtJiU35mz26vE/rjOhnK8IxcRaIbQpxNqqSIX/NJikGK7cENVhfYXMRK2Gtx0HCztJp/EQJ90dby+usEn3NiigjqS1Iy4Gf5VGx6ni9wuyF0Hvlai1J4mcmxDe/XDFI37qTYp9qgupuvMsRosjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnKFBLD4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnKFBLD4"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c20755e8295so167109766b.0
        for <linux-mmc@vger.kernel.org>; Sun, 09 Aug 2026 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786263726; x=1786868526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQgVXqJtEL23kHXezgXJ1DVoG/wIJDva/GES0KU8LJA=;
        b=TnKFBLD4lHbcGXOORzHdW0ysBAtUhg792JL1ctUNO+6TkVMBPh7AclvtsY+TbvV8oA
         9+m7CNM092hT9fDPpNod+dzfNSl4Vu5NMWBS3NYOjWLfEg40HffSLtPrMLclFAkmcTTL
         MuHZ/CTaGfKp1/wM2pWMYFDpZYFnCXy962VS1Oxk1V/M8ErEEMP4Rlh86IjnBQg2irL7
         0iKA14NoJsxWHPGb9jdLZgUjPId7I/EkbH0OgyyiYrq/EKpxTrf1Da2ETmAx+OXOS/2e
         emT6pVlf+rB7W6WDCw1ty8l3EAP1d4AlPx+cpJWzTBkqPq/OmDmhAsFmi3NunDwccomm
         129A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786263726; x=1786868526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQgVXqJtEL23kHXezgXJ1DVoG/wIJDva/GES0KU8LJA=;
        b=WG4pH1dmmVaKOWtvgIox2pOb1h987/jyS5FuLOxXAiKCjxSS5fMm+wxRAxWyb0j/lE
         cEU015RfcqYNWz4xrj4SRTQIUwRRgTDxw/CcXJacvHhVbncpbcgdzSQU3FCmKzYiaZT9
         CIN3pIROaravbya7eXN0wLGxZmA1STKMlgmVoVEl3wAH35NgbGsycluIhngQityn6Lim
         ZFPzc8hIYSn1SpdnzlOdHtLljR4JICdg1jiVhOTOYKcZLt+1HvARNn8ZYvhzGsHFi11/
         lNwjeM7TCWzQzKlDpi2RZc5XDr8RFizh0aCQH4INJg5TyKhp+DClG+Km2QywD2tI6+M/
         zGKw==
X-Gm-Message-State: AOJu0YyOGmzKqQ5F0Hy9hlDqFTL9PEhSjm32DeBPZwY81lTqERx/FoO6
	d4S8XbydmfvjL2p6A2qqlti6pVWtnBKyohPuKfGG1+OinIHRAuHDqN0vxy8PLg==
X-Gm-Gg: AR+sD12h24m2wL8DYU9JG3F9q4Tome3Q/gQyW/yH7Izs1qqeTn8YjlQx1PiWqAzZo4p
	ruSuCmhd7rhm0QjtbgMix9+w6eBBVpu8Sdo+a2TEX+vUajFHaMKP3b3DK+xbEji3qryQYedgfHR
	yCuKli5PCfjmrBNSdGl/wIlyCxsiYklv/pX/AkARATU7qb6V8FoPFNCZA3cvHMuNgZwpzizEbQv
	RwqpeJ/EZTkJwho/yVTXOwRauNnB+tBdSDUJCWUMnGrhx7GEfyVdVVnZMfKsRkpAT7nVFeR2lwu
	ytIN0vpay5OEbmZD0vPXvnMUkt9xlCnqHHWKEy1xpoeFPBUJR64/7h4+NtFfURsuthLe4INqfnK
	G79wqjxu1zU9SLCfQOgX9bd8uM0Dv7ESXchyiDojTL+RaeNKNA2sCYCuf7bbjPDI2QdhT74PR6g
	bLVXTCwL0NkP4HrTfZqi08Ggwoys5bkYopM2qIIZNVarSb85hAwxwgtAH1Vq+0uv4Mge5hUe/C6
	J7//bOb1e2tmg==
X-Received: by 2002:a17:907:3cc7:b0:c20:2164:2dd8 with SMTP id a640c23a62f3a-c208d50fe96mr532091866b.14.1786263726088;
        Sun, 09 Aug 2026 01:22:06 -0700 (PDT)
Received: from torstein-laptop.internal ([2a01:799:3a1:9700:1e75:8b0f:2e1:e0bd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c2080cc3b88sm226094066b.51.2026.08.09.01.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 01:22:05 -0700 (PDT)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: Torstein Eide <torsteine+linux@gmail.com>
Subject: [PATCH v5 0/3] mmc-utils: lsmmc: add 'mmc list' command
Date: Sun,  9 Aug 2026 10:21:50 +0200
Message-ID: <20260809082153.104311-1-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a 'mmc list' command to lsmmc that scans
/sys/bus/mmc/devices/ and prints a one-line summary per MMC/SD device
(device name, /dev path, bus type, manufacturer, product, revision,
serial number, and manufacturing date), and teaches the existing
register-read commands to accept /dev and /sys/block paths directly
instead of only sysfs device directories.

Changes since v4:
- New patch 2 ("Factor out CID month/year helpers"): extracts the
  month-name table and manufacturing-year derivation that
  print_sd_cid() and print_mmc_cid() each open-coded into shared
  helpers (month_name(), sd_cid_year(), mmc_cid_year()), so patch 3
  has a single place to reuse instead of duplicating (and
  miscomputing) that logic.
- Patch 3 (Add mmc list command): print_list_entry() now uses those
  shared helpers instead of its own copy, which fixes two bugs the
  duplicated code had: the month table was indexed 0-based while
  mdt_month is 1-based, and the MMC manufacturing year hardcoded
  "1997 + mdt_year" instead of applying the ext_csd_rev based
  base-year adjustment. Also removed a stray double blank line.

Torstein Eide (3):
  mmc-utils: lsmmc: Use external .ids files and accept /dev, /sys/block
    paths
  mmc-utils: lsmmc: Factor out CID month/year helpers
  mmc-utils: lsmmc: Add mmc list command

 Makefile           |   8 +-
 docs/HOWTO.rst     |  71 ++++-
 lsmmc.c            | 645 ++++++++++++++++++++++++++-------------------
 mmc.c              |   6 +-
 mmc_cmds.h         |   1 +
 multimediacard.ids |  16 ++
 sdcard.ids         |  23 ++
 7 files changed, 485 insertions(+), 285 deletions(-)
 create mode 100644 multimediacard.ids
 create mode 100644 sdcard.ids

-- 
2.53.0

