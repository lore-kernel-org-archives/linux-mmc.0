Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630862;
	b=M4uNDbvG8ND8AgVVmq0VRtIIonW5hdnMYmaAdliTJ+ZK4n9sLMiKVVcfjdqFzaVgUzu4
	 9PcDNBYNwBdKgu3QCHWDD7NrxpLDwiOWcC6JrMstQTcUfXvia+qkqltS0A+lYGHDb4xqj
	 UtexSVOn4gXdcHjx+hvlW3ihwEL8pnWrUYT8HkBn692gEScVkc4r36IaVW0zFCCQsEGB2
	 ACxRGrXY5euZuNa/OSfEdARlyFspWWyAUm7M+rP17/Z9rnzvuseElzFMshOBJosxOAIUF
	 evHWEtdIEJSuLcFc1qOVT3wO4Ca8JUgCz4rv7d2Nmp81+5NvdEg3KgaDCbmCljQAqVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630862;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=S/F4REHKnNGd2R1KVdj00UINXhvcHz2K31NhQDQ/pxI=;
	b=WTipuWZzRQ0nd6ziqBpVP4iONB2ZqUOEAiAnmiKwMbw1tjVe6dqXeBXTxaRoTSQw3RR0
	 Zu4ZPQngvdILEO198YpTKjZkMHhQzZ7Yxn57DBo+vStg/Bk2v107LOrY53epj7LQOUUD/
	 NbBWyRymw2Z2cHkuAeINqwg8A8aAjao9G8WSvnr2N39QJjzp8AGKIPDeHo1gdni05pOkr
	 3yOuJ4NylV2f+IpTQzgW4AkvQ3zOH5Zmz0kYL2g8KRoFFADzOT+mxNWJXfUzthP9lJO7m
	 Cn76eq0NZ/JJEgM8UoQcY4vBd1+RZgFVVxgb9jUDcERYiLD+tHt9C9SzqD/x8P0kXKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="Tekx5b/H";
	arc=none smtp.remote-ip=209.85.216.100
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE9C606A31E
	for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 18:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FE9C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Tekx5b/H
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3b4021b572dso3869018a91.2
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630861; x=1796235661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S/F4REHKnNGd2R1KVdj00UINXhvcHz2K31NhQDQ/pxI=;
        b=eIpVjgoIbeh8LeST6AdoT7hBH+srSbNhBVXkoebr/ZWG+2ywvZ3jgjUEsSEOrmsr/a
         1RDaHjWMXxRfOlOPBi5IYUEOAy2ZaoUoa6cpjBsIstsIqdPzK6mxyV8dP40Bgbr8D6cq
         SeDimAxOJgJI0y764aiAyNtPxqrSH9Zsj+cOyf6sxmpMzqxDpr1QiVnzRT8Z2hKmd/l7
         7FbAbldHGJcjhQNdmOsG7eZTNjgRMplq9HGngv/FtmY0n2VZ1jbYG6lDoG9l3LhlfGcC
         /06gTosbkB+IZk407/RMiPRBfim+DvZiSuimnJpxwS7Q5hZyOK2zeemmh2pZgAJdOoSO
         XyDg==
X-Gm-Message-State: APuU4Z9H2tqHMf6HnHvE3YKm8e+gdccQ1THvFli+81L5DjvghDfDwNjd
	HxrojWQcGQhS02rpjynmuoSgDhImWcocvUXxtHx95AupISEwA9h+EuCvTCRz2vLzumWl0T5Vesp
	QSYmAXMrjxWYrXrrhjeAPqE6Xzp6QTI6ptnIA2UfjcdRc2MGmMNxhI9hshjCYhZjLTvw639Q7hz
	HDWD7cVyNzcltsk36CLyYlimdSYf0EG47//nSD9N/85aTjs6+C2NZQK3i6zWxYnD3Ud386wA1RC
	helVRwlHvvf
X-Gm-Gg: AZFdTZeCjSKZPOyWQc6jik05EITo+wkI1ici4ZOLEWJ3rSI5yPpVl1Isy3t0KVQua7J
	EKhAdxG6QzzcORGqeEBL+KcKKnJXPfY/4w5F7DUuvKxFlfHusachqauxXqdjB4/81qTS0x9+/Gt
	il7xnyRy/jCpD5k2A2Fi5uPrZBIcGtRAG/G9QWqnVhbZxZ0XfS2UwPKpHXjkJ9O2aRn6zfadnuK
	K5GoW4k+9bsVcEsSnFboJHipyqZlJZujPixbcrQc406pSlKFj34JKabFA02jYAZhwbSHaVthwI3
	qR3huP6iYB5igfl4NSJpQmA4ltFJ522/IQIsCQlR6ihpMArKYDooA4PsGCMAgG+7k7IZAJh/ftx
	UxjkRE9fzudGBpilsoyy6bQz0anIbQ55/hexm71v/j92zJAVb0Sc33a6Qq2/wXk2YUC5ZMQhi5c
	gAHeYC9bPQj+48BhcbogibZfXQwxOF3zK8pt8=
X-Received: by 2002:a17:90b:5546:b0:3b3:c44b:b779 with SMTP id 98e67ed59e1d1-3b41c935639mr19299806a91.46.1795630861497;
        Wed, 25 Nov 2026 10:21:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b40625d66bsm13874623a91.4.2026.11.25.10.21.01
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2026 10:21:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9496ff065bcso831844985a.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795630860; x=1796235660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S/F4REHKnNGd2R1KVdj00UINXhvcHz2K31NhQDQ/pxI=;
        b=Tekx5b/H5985aMceRVG3RA4Mj9KOy9Dp9Zua4cPcQRjE8rYrjgkncF3ird+QeMhrgW
         5TNcD6KAcTQtghmqsHS6uSzVVvvU7l9GTEuqzruzlyZZkmVXtZ2871NLlG+0lhuPIDOW
         rW2ktbeIJuxkmO+q93GdnRhSCdBSizQxAEtQA=
X-Received: by 2002:a05:620a:4713:b0:93f:31bb:e3c with SMTP id af79cd13be357-949bab1060bmr3347960085a.68.1795630859970;
        Wed, 25 Nov 2026 10:20:59 -0800 (PST)
X-Received: by 2002:a05:620a:4713:b0:93f:31bb:e3c with SMTP id af79cd13be357-949bab1060bmr3347951485a.68.1795630859301;
        Wed, 25 Nov 2026 10:20:59 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38322csm1375419285a.17.2026.11.25.10.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:20:58 -0800 (PST)
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
Subject: [PATCH v14 0/6] mmc: core: Keep the card powered across suspend when firmware needs it live
Date: Wed, 25 Nov 2026 13:20:47 -0500
Message-Id: <20261125182053.3915833-1-kamal.dasu@broadcom.com>
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

v13: https://lore.kernel.org/linux-mmc/20261113211143.3759154-1-kamal.dasu@broadcom.com/

Changes in v14:
	- Patch 6: Clear MMC_PM_KEEP_POWER in mmc_host_class_complete() when
	MMC_CAP2_RESET_AT_RESUME is set. The flag is set in
	mmc_host_class_prepare() but was only cleared in mmc_resume(), so it
	stayed set if system suspend was aborted after prepare (reported by
	Sashiko).
	- Patches 1-5: No changes.
	- Tested with CQE enabled.

Review feedback addressed so far, including Sashiko's AI review comments:
	- v14, patch 6: MMC_PM_KEEP_POWER is set in mmc_host_class_prepare()
	and was only cleared in mmc_resume(). It is now also cleared in
	mmc_host_class_complete(), so it doesn't stay set after an aborted
	system suspend.
	- v13, patch 3: CQE is turned off explicitly when the card is kept
	powered, as the cache flush may not send any command that does so.
	- v12, patch 6: An error from _mmc_hw_reset() in mmc_resume() is
	propagated instead of being dropped.
	- v12, patch 6: reset-card-at-resume without keep-power-in-suspend
	makes the host probe fail in mmc_validate_host_caps(), instead of only
	warning, as the card would otherwise be powered off and system suspend
	refused (Ulf).
	- v11, patch 6: The host is claimed around the card reset in
	mmc_resume(), as it sends commands to the card.
	- Earlier series, before Ulf's rework: Sashiko noted that the DT schema
	allowed reset-card-at-resume without keep-power-in-suspend. Patch 2
	keeps the "dependencies" entry that enforces the pairing.

Tested on a brcmstb board with a Kioxia 016G01 eMMC, running S3 suspend/resume
(pml -d) with the DT properties set as below:

  keep-power-in-suspend  reset-card-at-resume  Result
  no                     no                    board resets on resume
  yes                    no                    board resets on resume
  no                     yes                   host probe fails with -EINVAL
  yes                    yes                   resumes, card re-enumerated

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
 drivers/mmc/core/host.c                       |  26 ++++
 drivers/mmc/core/mmc.c                        | 111 ++++++++++++------
 drivers/mmc/core/sdio_io.c                    |   7 +-
 include/linux/mmc/host.h                      |   1 +
 7 files changed, 123 insertions(+), 43 deletions(-)

