Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426277;
	b=VAO3xvHSRn1hvHEP1/3Z9BfOY15phGwMzkej+hLQ1g9q0TKuCcNQJjP361JnUYCIt7zT
	 7VyjKGw0GEC6HJMnFupaJ6AbFdOsUAFqhcPNstFbzJkKnyJVyNvQh+OE76ngIm7u177ny
	 VUqCjHz0oADbiCX8RleZS9RGRu/9bjcpGGuPLFOxweKhlwkDbbL/eTd8/dY5G8N8bC+TK
	 kBjBiPy+Crcf8eNwxrCCTIXLnpFW7j/ET3hDBmzzziuBn/1W5F/3Pm7Wi80wBcdi1Br1k
	 c0qr6AgGLe9+W8ayhwzWuKIQWNX5ETBDVHZAdGqLd5biL++61TOAGEnIkFb1WzzYnOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426277;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=xyDSRZr2KlKUM6APRuIaI7oeA3fNNRMSJmTHG+3kfzQ=;
	b=L3mP4A1ToFSG4DY9eSL/GYzHVbiqudVph+xfj6AHnpPmfna+RaPMMurwEDTIXVOWBTCB
	 2KiCjoN87ZJhW1x6+MyqjdNuv3jiuRGWx909KLh7MHh8vWemTa7O+sJiSDwXrUzFbPvTK
	 mBX0j+RHhsKjtaKs8mPqFrJofwSQPRu0Wnh0L47OPsGryjki4quR0DXd7BDNP3c9cBftC
	 eVOBkddyS5Jf9qDwuuQ9dDd4xpOKzFYdT3kAoWNHrbCdVFHbNShhSKiPUmlLglk1UeMXv
	 bZpo6HhfoPkD1vlvLj8Xu1Mn5wmeIl/yaS04CbwAt+VC0wIv6jp/v7AZNJ2HTKO5HSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EbFI4J5+;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EC5606A31C
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 19:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56EC5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EbFI4J5+
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso1743848a91.2
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794426277; x=1795031077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xyDSRZr2KlKUM6APRuIaI7oeA3fNNRMSJmTHG+3kfzQ=;
        b=w8JNJ9cxO1M344/thi9XGjtLlrhmaYUk67hPOGysd1z8zqeWok5boOOfsKLkfD4wFQ
         Z05MRYKqLENA4fVbpp78DRuEyCI95wybrl+5+VUeM+IzsyerrKFaYIQ4qN9XCWHHhHsE
         AQiHyd3tBXCX+MdnJWtO+jr9VtktDrjMEA+fJjR256F5v1gV7diNoT+mYPbx/591qDa8
         Ad5Pg0ezG8QbTgcNpVgIf7A/sgehjf+LdVc+GEHwrskirFptYoFQKxfu9JkhgWH/OwPc
         cpCNi2ZYtJuOJykQE0tW85HwR870aQGuJDJ92DKCh1ShwOQCN1j7okFKy5Xj45YS3ICS
         Z4pA==
X-Gm-Message-State: APuU4Z+d40OHaQ+lFkyv+TcLTHcjlPGS3Q/3ks6fwajQbg+XbdZd2/Fu
	GMt7/E3gjGKg9cyjQGb8JRb41ngz8R+yli7pKMO4s1tkWVd1k2zuG8LyUV9iu93sKjzNSzBdEZD
	V3Bfj9hado0cnY7n9Lva9mTNEwOSIys1K3xjG/Ge9s88WGPtWKg71m1ptOzMm2UXkZ2Z38zVSfE
	z4X+MMSTPXJx7Epy5sBzznz+7405EbK1PaSkjYC3es4TrTobx7bm9dUIMVxgEy2HWFwBaJ+d+ly
	OigjE52hlQg
X-Gm-Gg: AYBFou08bDQb6UxLk7PFOEUF3SWQeIUVebfFngsRr4lShfxbH3m6MlCTQupgssSdTRb
	MOe1uhkbVi7r/t5iAWuyqDu4TrrUpPjljqIZMFpjlqHADJfKSfLndkscP6GP6GZnYOOyYE9ii+y
	IhVR/CHl0b+PwSWTW6AMduBjRQdhK4x90acFVVMU/Q0DBGrbBDNhME7fzzPO5Q6EafMqRI+iLDI
	ELygCMdD3Toz+tBAVC0LfkiL9T/6iFMf/N6/TuI2+/jDft0NPamvYFp6Oi5g4ygv9/lZdF9t5Y7
	764zRRc4lSZmEE8F5g6ivEXPpmvawpKlH/A4FOLuEUFCfl0VDY6j8L2umigR7ri+roxrKUoUqWp
	oQJVmCBlcLF5WVRvq0m729xdTfipG8Kl5iZGU2XF52jwysv+UubS4Ezr0xDSeUuobMpH7zF9vyb
	MlJoDP+/CElfbLRIF/PR+4UVP0qG1w0zyE
X-Received: by 2002:a17:90a:dfcf:b0:3ac:9a03:20bc with SMTP id 98e67ed59e1d1-3b182f858f5mr3465706a91.47.1794426276635;
        Wed, 11 Nov 2026 11:44:36 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b197c4ee96sm255306a91.6.2026.11.11.11.44.36
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:44:36 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36efb506f29so6721580eec.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794426275; x=1795031075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xyDSRZr2KlKUM6APRuIaI7oeA3fNNRMSJmTHG+3kfzQ=;
        b=EbFI4J5+mQB00rb8/c7a5KiKo22EjCWRSwFJ6OnPnJj976fixBoPIHHd7210gEsRF8
         sVpedTOFZQuNc1uTGSBE8fQKwVVh5kInsaDD1HADhi2uP0P/M0LpRmNxAVYLvEn9qM7Q
         sF88Hq0v2xGqgauwKW3AVAAMKYuxyrsRq12KY=
X-Received: by 2002:a05:7301:4908:b0:36e:3a0a:2953 with SMTP id 5a478bee46e88-37687512f63mr3469179eec.41.1794426274889;
        Wed, 11 Nov 2026 11:44:34 -0800 (PST)
X-Received: by 2002:a05:7301:4908:b0:36e:3a0a:2953 with SMTP id 5a478bee46e88-37687512f63mr3469133eec.41.1794426273979;
        Wed, 11 Nov 2026 11:44:33 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm17948013eec.11.2026.11.11.11.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:44:33 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
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
Subject: [PATCH v12 0/6] mmc: core: Keep the card powered across suspend when firmware needs it live
Date: Wed, 11 Nov 2026 14:44:20 -0500
Message-Id: <20261111194426.1652644-1-kamal.dasu@broadcom.com>
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

v11: https://lore.kernel.org/linux-mmc/20261030181034.3811225-1-kamal.dasu@broadcom.com/

Changes in v12:
	- Patch 4: Added Shawn Lin's Reviewed-by.
	- Patch 6: Moved the check for reset-card-at-resume without
	keep-power-in-suspend from mmc_of_parse() to mmc_validate_host_caps(),
	so that the host probe fails on such a misconfiguration instead of only
	warning (Ulf).
	- Patch 6: Propagate the error from _mmc_hw_reset() in mmc_resume(),
	instead of always returning 0 (reported by Sashiko).

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
 drivers/mmc/core/host.c                       |  17 +++
 drivers/mmc/core/mmc.c                        | 109 ++++++++++++------
 drivers/mmc/core/sdio_io.c                    |   7 +-
 include/linux/mmc/host.h                      |   1 +
 7 files changed, 112 insertions(+), 43 deletions(-)

