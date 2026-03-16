Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C03363C4B
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696209; cv=none; b=Z8gOy7D6Dprs/+F6W5/4QU42K0LP+3zsqFb6yLgGhWrlhTCR72yc9bV3dvzHE2IpUGeAP94iUTntaAmEMKH4rz+xSXvxtiTVcVAsqocHtcVTZH9gSip4hyJo6aMyQXc7KVnSKEDMFd/eLRHQYaz6MyqKyH9KBE5X8CAhK/URPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696209; c=relaxed/simple;
	bh=BubXRIrH9jXWU7pnIeIHWLpVgty8H56G7a4Ji70u71I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVKCJNWWN8sjoRIVXIcWMKnxpT9sSmeNVhm74tx8mXSon/2Xb6LQyTpgpHxb4OyIvIVGyYar+dJPGsn8m3eWiV/Vz+JkT6cMLfXVs+EPMA9dvH13/77BbUlkWUbtWtsW9oPR4kAnK9bi0XWKQQp6T5Sc5t1eET1yVaqpPCYv1Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4sGYr2w; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4sGYr2w"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a46260385so16294917b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773696207; x=1774301007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sjvzmQgy/8Ckk75vbFaJNAzoVMYK5jct8StBarmT1mw=;
        b=h4sGYr2wcVNvbH973CTgrvbt/x23GHY8qrDHjndjpF3kSrf2Z5Avgqh8CPSmhhfXK4
         tMnJEDmsgDQyCpoxZHHSuy/nGj+F8Hrpvy7fd4/6S+daHJUh5o+Ehukl5wBSCDMCy8dw
         Zmt+iiKKv+rpbIaBxfCxAb6wTycUZlpp/xFAZhsoWcQR5yqi+5bevk5urO2acqGi2z+Q
         bU8pJWJYTp8Q6iUjjH2+Fpt40GnqkbNnMaO+EGbCQaADfjyLERJX78a+Sloy1O5TfSYG
         aFSrOt4wSNUV16mPxFfN0FCF7TfAp+Z7lYjPISBA2EWSBcq5qrU8B+4mC+kVba9bf/2Q
         r3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696207; x=1774301007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjvzmQgy/8Ckk75vbFaJNAzoVMYK5jct8StBarmT1mw=;
        b=Q54M53chqy/OqWiEHZiGPmxl22iNVMu6ZrLciDi7U5Wu3mlnmwO7RRg6x4voNY508C
         Q2urvHSf3X2ZJYE9sECcZlUW/IC9PZvuXme+k0OpAnYci7BLNeMyliOmBWY8QOsHEsid
         JDq65SixTGI7rXztIyzZPn+MN1n9yGB49J6Bt6HjMM4xcXZ2h1G9nTWrrimeMwRvPtjz
         ZlNPE0KaOCx+3/PtGIzRaqDhQNt1irmAtmbIGISy6ZyeBf8pPBeXoJP8c4gwDaFxDqgK
         ZgDuaoIlsvGkTp5RYwemzYuvqruvUX6wykvwkgFTdopt7oSXm+sVw7MZdM8KLnnDcxYH
         2ibg==
X-Gm-Message-State: AOJu0YxP9RysFcgzGef20rlz/+qnAvAp4Ck6QqQbiuqetZ8XgeSEGWzk
	jJGQnmIGtGqCvv9Tdbr4L54iFjPukup/ScMtf2BiIABhf1x3ja3S8N6H8Zk0Uzsc
X-Gm-Gg: ATEYQzxjjx2uUE1mlhF18FBCfak3BCOMxxR5efXnCv20p2NovxtWwNi88fUd9jd+FFv
	LvNAyAZKT6/ff9K/DhBAVGeRnd9+cJb/LhAGLKXgO+8tEgubE3zGQM8d3tNYArZkXoIlyCDtKBC
	pqkOLmg0H8dko8rCWyAac2PUYwtqBBfLCPWeD5YVDCUuE0GTcFwkeQsnRO+mPGGPMu7nVAK3L9P
	aIEBShHQkjGnfRth1kc1cAWe5OMiK9GXZhHqrrcYuBAH6y3z6eZjxu7kgh9KK1pTrRjHKiMrMZC
	JQvhFPPwM0CYNb8kGJks1XwZOgrgtXEdmPK5FVu+Ld0V0lYc5l6ab028321ZOjOKes4fDbwtZka
	9W6907QwHI0w0rhsKN/RKJ3gF3B6BD2An5Ouc3qFGeAYP6o7YHLFci6lRYEViM4TN5uTUZYubCC
	1VFhyiekaWyoP8YE07A7EFxZ7nFdYb7dcrZq0FYwA=
X-Received: by 2002:a05:690c:3:b0:799:266:83a6 with SMTP id 00721157ae682-79a1c1bfb0dmr142394277b3.46.1773696206775;
        Mon, 16 Mar 2026 14:23:26 -0700 (PDT)
Received: from Starblazer007.localdomain ([12.206.154.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a5e1ae50asm8180437b3.2.2026.03.16.14.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:23:26 -0700 (PDT)
From: Nelson Johnson <nzjfr547@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	Nelson Johnson <nzjfr547@gmail.com>
Subject: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
Date: Mon, 16 Mar 2026 16:23:22 -0500
Message-ID: <20260316212325.4207-1-nzjfr547@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the long-broken SD slot on the Lenovo N22
(Model 80S6 / MTM 80S60001US) with Intel Celeron N3050 Braswell
hardware running Debian 13 and Linux 6.19.6.

The regression goes back to kernel 4.14. The Braswell SD controller
(PCI ID 8086:2296) is exposed by firmware through both PCI
0000:00:12.0 and ACPI INT33BB:00 at \_SB_.PCI0.SDHB.

On this machine the newer runtime PM and card-detect handling no
longer works reliably, and the ACPI path permanently defers because
its dependency never becomes available. That leaves the slot unusable
unless the controller is forced back onto the working PCI path with
machine-specific quirks.

This series does three things, all scoped to the Lenovo N22 DMI
match:

1. Disable the aggressive runtime PM/card-detect wake path for the
   Braswell PCI SD controller.
2. Bypass the broken firmware card-detect GPIO path and use polling
   for card insertion detection.
3. Prevent the competing ACPI INT33BB:00 node from binding on this
   machine so the PCI SDHCI driver can own the controller.

With these changes applied, the SD slot binds through sdhci-pci and
detects and mounts SD cards again on the Lenovo N22.

Tested on:
  Lenovo N22 Model 80S6 / MTM 80S60001US
  Intel Celeron N3050 (Braswell)
  Debian 13
  Linux 6.19.6

Nelson Johnson (3):
  mmc: sdhci-pci: disable aggressive runtime PM for Braswell SD on
    Lenovo N22
  mmc: sdhci-pci: force polling card detect for Braswell SD on Lenovo
    N22
  mmc: sdhci-acpi: exclude INT33BB:00 from ACPI binding on Lenovo N22

 drivers/mmc/host/sdhci-acpi.c     | 10 ++++++++++
 drivers/mmc/host/sdhci-pci-core.c | 33 ++++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 5 deletions(-)

-- 
2.47.3
