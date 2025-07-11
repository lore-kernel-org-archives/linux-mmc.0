Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A92ED866
	for <linux-mmc@vger.kernel.org>; Fri, 11 Jul 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248550; cv=none; b=rueeAg092mph3JIYOMSTrBVeD8kFbIgkMsDB7vFBfLRAUCsYGVQwwjpHteLynNJUAeFf7U3ZeP5PIlFMfzkjfqXVPFrm+geSVcAJsMOFaLixwncgxG2i5xIDj264pQ9kvPD4iqNBWRHIM4z1KVzXTWfXAaMBAoQdXFVRd9Qnykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248550; c=relaxed/simple;
	bh=p0QT4HPaY8OBtTEZP93RtyKH7AZULc6D1K35xfZC+fY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aR3ZFIAlyNx9+GCDgDRVw1GySziaOFZRUCSKOrk8ClQfmNaBFUDtk0vmgKFDuzxLqsDJ7YbDTEMxEEgDuZ61VvOnj3MgU8RT2PZJ5OkllxYnekeZZolNlPcyNK21ZuA7VJtom70fMvx2iu57hDRV3N46HCly6dgzAaZ58bNulto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IgLLuKsJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IgLLuKsJ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747e41d5469so2461591b3a.3
        for <linux-mmc@vger.kernel.org>; Fri, 11 Jul 2025 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752248548; x=1752853348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUwufIkKlgwPmaoI7EtkILOQ2opwehMJ+nCT/MIXFWY=;
        b=IgLLuKsJ+ZdAXWukZ1LeM5iq4bn05qezw/cYJXSBFnR4nvtGpHJv0cI/uojRkNe2jQ
         GBSR6JyehL5tvQ2XFHvszQ82U/mXJGKE7VCGjqIb18KzSzIvklGbvqSW0yz73w3VV/5l
         U+KoESFtIa5GavgsVpXEu6hRdS7hJY9b+uONs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248548; x=1752853348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUwufIkKlgwPmaoI7EtkILOQ2opwehMJ+nCT/MIXFWY=;
        b=cqJxPjahNDe3GhnH0UFgQ3ZMv0e3AWl6CMVAC2a1E4RavFy9bP1TPbPr1QHWCek/WN
         HQkbXR7/v04PVIYFB8/KqPCRYwhXKCJr9n/8KH2OZb8oJusqr44kTC0VA2zSLFMqDNWK
         aeG1VMTC9/HzMk35uLdDk8a7xM7GATFDeTvWqg4ruDFlb8al16tJLqyl14mbv5baGan+
         FY1oop/3+N++zPBg2usV1mWJn5II2eSBGtxURkYu3jNLAq1tpT4zxsy6oNmLuidMraOC
         h8yjGX/WBY9d8RV3kDGHdvKR2R1B0uEWJP6yPKQPTf4MqQuFwXSPFA28BRTReKasYGU/
         QPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMa/ffexWM0riiJjMQ4sOS8btaWdzve3zcrFTxMgyQWfxHnXEwihG2eZHnFq+1qUL6lNkHoGNo66E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQMTsDuWHhpO4dbqf7SsfFkhHBEehTlV9O66+wLs6oSE5Nut/p
	9zvxsI+qh1FLcTsv7TuynXMaMXQPtC7f9z2MVrUaQKbloRoEKJRKqtELLCX4MsE9gA==
X-Gm-Gg: ASbGncuKhoHeX5c8eamxerPfwCuRnL5l7t0bnsiiA/RgweqNyXf3tO/oOzGkhFHMGZf
	h7blXEitukomkxE9NtcjAI19XwOTTmtTaI48hKGMEpfB1D14Yp76vWookFjxhDPfj2dYq4MmlcN
	G1nJrxELvAcud/2SuUpllgngnGjPUxVUVCeQbX+YUQBOf16ioAaNIyg/yhbN4Qizt1i/EBXwyic
	VYnvNW1yl+4NKGyB5Yj3vnwNzQ5QlKA1/8DW1Z3hXSiYBsRVWgJTF27Z6O7LOUcFr76OH5+NeIz
	8/LgECVyWdqheRvc4ClAhjN2ztO1gbVsS8LffUoJMIi4PFroi3A5JN9L5hNSUrcTAsCovxA8jNZ
	soeGMLBsNXu3Pq8kylM0F3KEXwQOdJncqrWxSh/vaNT+BdPKuzOyUbDBxoA==
X-Google-Smtp-Source: AGHT+IHFZKUgGL0wxuQrtMVNJArFfFZ4ZiEznQy74X/s9Jn/0gsJzLOGIMGF63s8wwcASQkDocGp0g==
X-Received: by 2002:a05:6a00:1743:b0:74a:e29c:287d with SMTP id d2e1a72fcca58-74ee244a366mr5107688b3a.11.1752248547651;
        Fri, 11 Jul 2025 08:42:27 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5ccesm5762420b3a.27.2025.07.11.08.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:42:27 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	kamal.dasu@broadcom.com,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [PATCH 0/4] mmc: sdhci-brcmstb: rpmb sharing by claiming host for TZOS
Date: Fri, 11 Jul 2025 11:42:16 -0400
Message-Id: <20250711154221.928164-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support to claim host for TZOS RPMB access and synchronized
access to the controller hardware using hwspinlock framework.
To achieve this Linux OS and the secure TZOS make use of:
- shared hardware semaphore register
- a set of SDIO shared work registers and
- IPI interrupt registers 

The currently running OS that needs access to the controller puts itself in its
slot of work register and if its next in line it can try to grab the hardware
semaphore and complete its mmc requests. The shared work registers indicate next
in queue to access the controller, and current agent in the queue. Next agent
queue state is changed under the hwspinlock is owned by the current OS accessing
the controller hardware before release the semaphore, send and receive IPI
interrupts between linux and secure world are used to indicate completion of
transaction to the waiting OS. TZOS has its own RPMB driver which accesses
partition when it wants to read/write RPMB frames. Current implementation
assumes Linux and TZOS as the two work agents.

This patchset is an alternative method to initial RFC patch:
[PATCH RFC 0/3] mmc: sdhci-brcmstb: Add rpmb sharing support	
https://lkml.org/lkml/2025/2/6/1711

Kamal Dasu (4):
  dt-bindings: brcmstb-hwspinlock: support for hwspinlock
  hwspinlock: brcmstb hardware semaphore support
  dt-bindings: mmc: add brcmstb share register and hwlocks reference
  mmc: sdhci-brcmstb: rpmb sharing by claiming host for TZOS

 .../hwlock/brcm,brcmstb-hwspinlock.yaml       |  36 +++
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |  29 ++-
 drivers/hwspinlock/Kconfig                    |   9 +
 drivers/hwspinlock/Makefile                   |   1 +
 drivers/hwspinlock/brcmstb_hwspinlock.c       |  98 +++++++
 drivers/mmc/host/sdhci-brcmstb.c              | 243 +++++++++++++++++-
 6 files changed, 413 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
 create mode 100644 drivers/hwspinlock/brcmstb_hwspinlock.c

-- 
2.34.1

