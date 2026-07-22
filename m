Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB03DBD43
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2026 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754864; cv=none; b=t7HhcwxjPB9tKzXi+DNIU8Ca8oj8yArzGnDjfXz1nAksbEzzNfzCznjBjyf0gF2V6/0jmRdLf/llQdCWiJtb2fqsOkCbVvmS7ceR8rHWNSVpnmwbDary8XAIx7KUkngleLpt5rkUC7JRGMUTO1+to25HH+67jlDGTbJinS5PU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754864; c=relaxed/simple;
	bh=oJnIH0MtAzAIGJzqiw1ldDwDrauYNCmdAhG67LsyA04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mpfJBeerjVX3SRurytXsuSv6S4Mk7eQCEoy64G4ZCfNEy2w1sb9ZXlnoUFBj7oFlXq5kDhYEOqi6JplzSVkAyiPczL/VDZNCQHXbjMX0ukGz7F3FtwlryIjM0tumF69erjNmdm93aPQslUGRun+IDGx1gbFtopTcko2DtLhEJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cbHqQscw; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cbHqQscw"
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-6a198cdc4e4so4953600eaf.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2026 14:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784754861; x=1785359661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XNV5oaBeVpbugjgZQ41Bj0CNzlC166ofdHQsjDEoBTA=;
        b=XLMnj/QmYVQvqJGYR9w8fsnazv3L1BhS4mu9Xc2vyaD4dCXO6l66sMJ2WNiQf+io4N
         6BVMqJBghcOEiTeuArHb0dBNOd5T5qyns8slf/wSqDTq+L5bS3JgKK4/BJKpCAnBMXMe
         P3kptRXoqXIR73G4+mGbalswGA+lfKnoD97zbCh5HnQb7rpwIeeKAPdlQbQxM5Mbh/z7
         SCLwuB+SUd2BFUVYnqvbRE2rV97s6ePAgJKaYdBiwN2Jjws6iloASNIQrOvqjeTcDtro
         3NpJYI0XvhrWPA+WYizDk3+8D8t/bYZTYexZHEI6nKTlRA++0iS8QHZFMSwBfPcoebq1
         vSCA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5HYRJJbDmLNCRavHIZKiC57j1GB+SH3oRKIjyyl2cxfAZuR7ELmEjWqVSJoi96qH5sPDfas97RFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXXXyMOXWeqDsIDij1HamFAXiBawoPmGP+vCR9Pg4gegjW9Iwk
	2E2tr5QZVZspy3zAUNkK6BRDMcCSUM73eQZzcc5E/ULMlvBT5SwF30EsNqpjWO4CDnymwrye9bj
	NM9abIliIzi+HvOGtd8w+sJSBsP4i/uutel+cFXxv7M94YKCGgDnvxDAZOQ8UUPSFaRuXdODqVP
	rSGYTgw+cO4JCN8qiZbU3UV5u6k68kyrw7iQZ7RYjx5dGnEmTGZWvNgeEMZFNyo4jM7RUbi3XOC
	GkAoEpMyvS0
X-Gm-Gg: AR+sD10RzsuF6oEHd3KsqYo8J9kq41pO88m2CIBd6kRIHeqY8wIHUqgLk/uCD20K7fz
	K5Ml19zz5c3sp7/4gz0PJkXnpJ+bT2dYcwhQlJtvsjTMM/RxmS6bE1BdtoX4DzeOI7HNDxYEauT
	LE8kxkETE49MzNmInaXFgF/FvylrxPhHohOMI5i8EC61+e2srOjumAgrbFsEMnBJM4V8y4gtK+X
	kCA2qH4NHMzvUgUj6iYyTJGF44/IPv8/wHimhADTAkXTyGpQ8t1jXooeCbe6u7raamxtmzCu4ns
	LU6Uwk1y7eUAoY62Q9OvDE43OfOLpRj8R/zD6JBGMWv3SIydCmJ1sEKZxvyc1vN+pu8VZIF2cLp
	XBw4aaHy28hzVMCZamu599lfiLfQVe4vvVM3/XEwMnUze5Ye28k7pZtD1b9kSb7ofTbefeIMLal
	193Ezt7QRucaq6GWqEWHLVclFIuqAW9IIM
X-Received: by 2002:a05:6820:82c:b0:6a1:84ea:1e39 with SMTP id 006d021491bc7-6aad40d7c91mr57598eaf.38.1784754861490;
        Wed, 22 Jul 2026 14:14:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6aa7a6f7891sm197851eaf.19.2026.07.22.14.14.20
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2026 14:14:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f0c46bfb6dso350552386d6.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2026 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784754860; x=1785359660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XNV5oaBeVpbugjgZQ41Bj0CNzlC166ofdHQsjDEoBTA=;
        b=cbHqQscwn5K+fklloam3qISVIFryElrZpy4OTjQAY3kTCVjAxCL0Wj/mKYd/5xcXkV
         QVoxoSHfLnCMfTZSoBhnCoG2Sutnkue9PLLbNRYlYILG5UVdP7bSm4DcHgy+f1FIFaNP
         jEZX/6nYITirbDY3kAPvYg05SUoKpqxXsmbU0=
X-Forwarded-Encrypted: i=1; AHgh+RrkQfTIDFg09DP88x85Pnyg6pSdq/qKIbbfSCTtC/5gyNs02ypiAh2CpsIZABWQmyIoU7EIPpT9Fqc=@vger.kernel.org
X-Received: by 2002:a05:620a:4043:b0:92e:c118:18b5 with SMTP id af79cd13be357-93103b4cdf1mr33078385a.84.1784754860114;
        Wed, 22 Jul 2026 14:14:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4043:b0:92e:c118:18b5 with SMTP id af79cd13be357-93103b4cdf1mr33075385a.84.1784754859567;
        Wed, 22 Jul 2026 14:14:19 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f68a7fffsm253004785a.11.2026.07.22.14.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:14:19 -0700 (PDT)
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
Subject: [PATCH v3 0/2] mmc: core: Keep the card powered across suspend when firmware needs it live
Date: Wed, 22 Jul 2026 17:14:15 -0400
Message-Id: <20260722211417.3702709-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This is v3, following Ulf's review of v2:

  Link: https://lore.kernel.org/r/20260413180551.3683969-1-florian.fainelli@broadcom.com/

Background: on brcmstb boards with a Kioxia 016G01 eMMC, firmware
accesses the card directly during resume from Suspend-to-DRAM, before
the kernel's own resume path runs, in order to load boot code using
hard wired logic that is not field updatable. The card needs to stay
powered and responsive for that access to succeed.

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
  dt-bindings: mmc: Document no-mmc-poweroff-suspend property
  mmc: core: Add MMC_CAP2_NO_POWEROFF_SUSPEND host capability

 .../bindings/mmc/mmc-controller-common.yaml       | 10 ++++++++++
 drivers/mmc/core/host.c                           |  2 ++
 drivers/mmc/core/mmc.c                            | 15 +++++++++++++++
 include/linux/mmc/host.h                          |  1 +
 4 files changed, 28 insertions(+)

-- 
2.34.1

