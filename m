Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604307;
	b=CaMr2jBXGX5wpw99VZydWkc/XIHdOhDzMTJneW6P7AvaJEUgtSwU9ET/96A5ba7wNaW+
	 B2tm4PWP+uYNEI8QKqYT9IL9rta5ZVEB+8jOpbo7kwEqiNldqJVTwiBvBqbUgerwbppsy
	 WrnIOryeseBAoU9IgGp83/UJtmL8Em7xBb8efM0Jjp/AZt8kYRUJ4GKXW5/8N7tWUnlDG
	 OGKj4fLmLtvTV0vlurF5xSkSnjTP4jZ2k6+MrwjtmM+yTCE9/xtWgf0RPtnzr8NU8AD+A
	 S80D7ysbZH8ynMzxFaXNeSpz3U8zbUT7P/vVQDwx/I+hh65fKoxX+hXNXuQWJL7zCHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604307;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=ZvOnUOZcONBTIseV0f2LwHujYr13Bq9i7b0+n3syXFs=;
	b=Uj2p2KLAenwj6DBRVrp9qAj4EyDpf8uoBZ2c3vbtjakyntvDjVcTo3+sAH7KXHgeFBJ/
	 QmW7FVlmQtK5EXEctLqOwY8GwjfGCkEfPgRIyjoIuzDqJTrBzIEjCxEBG2oNXgiq2rwCF
	 gEtZqPyRSdtNfic+dwS9Ka2TvW6EznETdB7Bz+8gxnwnyXq8zPER4yUIsiq+2bc/CPcs1
	 VQl8FInIEBhSj2w4htGBNahWZeLMJfijV5DeF4kjIE8h2E5e/JtqUaK5o+Ca965TsligP
	 /KaHnFwE5Uxv9Pu4L0tNi/sEPHo3u8J725fyU08tI65NrmEaV2veTD5sI9g6tzuuiKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=F0SKBf1Q;
	arc=none smtp.remote-ip=209.85.217.99
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDF4606A8AB
	for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 21:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FDF4606A8AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=F0SKBf1Q
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-7d2bf046ceaso2096755137.3
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604306; x=1795209106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZvOnUOZcONBTIseV0f2LwHujYr13Bq9i7b0+n3syXFs=;
        b=Zt/8T94tJtRBG4DTUrVdhnRxCrBTg7LAKGAbTq5MGQHoq2hvDvGochvJX48LJs5Fa/
         jLB9mXSAUc8Xj/0TD+rY1A9iEznq9W48aybaabYa+i48inz5FSeoYtnAT3RpBAE6wAJZ
         bMsH8Tnb+9kVpA/G1OOXszgTGejgeS+ERn423wpWFjVX2nNwIOMeMiOrYgNmVpsS6JYn
         c7gg+DUaKVaODyjat8Gv2wHLo6rZMPFBAkzGzGmGQRc3wk+bCPCNy4s0H6LZXJ+RMEIZ
         OX+Vbqi6cQRl2iiuayFTaLXJAPBwQC9F0MPsU1DgYhZJkCaYHaen1HUz8WRJ06HBAQti
         DEzg==
X-Gm-Message-State: APuU4Z8nZ1vuZH9f52SlcjCRB0Pbjg1SKPIAfo7otuISytFdAYM0+GRa
	k4SGaTSKA172j+SduuaPfpfWPH+kpwQ+UKSAo3fmog5hKTHhCGbFiJdnPXlo93ZFsTpx4X2DqdS
	nVmhGiJRSNgQkhWJCvNkjn4zwXuX6qroPfn/2qekjMIQphjfAb8pY9Lgd6KBvjKn9DPmX72xJD6
	bPNMFwCEAPTVjSACu+fob/MwoLmgjP+cmcMDkctQ5Gjdf46JneSHWUHxpUVRwtRTrpsAmlPmwSv
	C7w0B8SIuL6
X-Gm-Gg: AYBFou2Bod6MbmZKhoBhEsZZfdC7EyQSD34iP4s7ET07NUCLMmWA7iaBgcQaG1WTKeT
	uiSZpPtFeLPZsFQJqi1eph/5rZuHVn2L1Z419xOCepoe0XX6WnK+VXBSB3KZuWFbmOWGACLA+1c
	YH0+OAb7twqNOzXJm0NU2ZdXB5VtoYl2gOdFFKkSfRWeYjJwTotkkboq/Xjxqe/+wOqjwnN7pCS
	QdYDzpjKDTdq6UXJd4xC0pPwXV4NChTCWEDJUGbWErxH16x73DGVyk5R8pFnUuFZhNR9a1uskKa
	jLDFVANBmiaI/UQyrmH1mOTKByISDq3wB5zvJxCB4D/jlhg9o4vk2CQIDH0wccqDJoYQbOCjP2m
	y3lXCkz2PdCFpbZOQTCjg2vhbqlVORVyxQrGhGFljUJ1qRHsfkQ4UCS0aCCa8sttmK33+cpdmfP
	WZVNicZd8qoVwAoH3sD4P93Y4wkE1xEh90Voo=
X-Received: by 2002:a05:6102:4421:b0:7c3:a1c6:7a13 with SMTP id ada2fe7eead31-7d64d767355mr1647756137.16.1794604306078;
        Fri, 13 Nov 2026 13:11:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-7d64c5115cbsm105763137.24.2026.11.13.13.11.45
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 13:11:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91f0f4c70cdso20872126d6.3
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 13:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794604305; x=1795209105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvOnUOZcONBTIseV0f2LwHujYr13Bq9i7b0+n3syXFs=;
        b=F0SKBf1QUuOWrFeqja5JFMQbodKUWFsPUD489DnLz6Rrxq27HJFDHBe2J2vX72SA+p
         0tLk7xECgMcjs2Wh+uVRDlfYc6XzHRG7mcD69gqLR86kdU40nHS/vIeVvkhHWSmBHHKW
         hTzYXOxzE8qfJu/q7rcAJIJy9BQlcYNLZ2MN8=
X-Received: by 2002:a05:622a:844f:10b0:55c:bc0:63cc with SMTP id d75a77b69052e-55c0bc06e03mr15406851cf.6.1794604305586;
        Fri, 13 Nov 2026 13:11:45 -0800 (PST)
X-Received: by 2002:a05:622a:844f:10b0:55c:bc0:63cc with SMTP id d75a77b69052e-55c0bc06e03mr15406431cf.6.1794604305090;
        Fri, 13 Nov 2026 13:11:45 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d73206sm29027626d6.25.2026.11.13.13.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:11:44 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v13 0/6] mmc: core: Keep the card powered across suspend when firmware needs it live
Date: Fri, 13 Nov 2026 16:11:37 -0500
Message-Id: <20261113211143.3759154-1-kamal.dasu@broadcom.com>
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

v12: https://lore.kernel.org/linux-mmc/20261111194426.1652644-1-kamal.dasu@broadcom.com/

Changes in v13:
	- Patch 3: Turn off CQE explicitly when keeping the card powered at
	system suspend, as the cache flush may not send any command that would
	do so, e.g. when the cache is disabled (reported by Sashiko).
	- Patch 3: Kept Shawn's Reviewed-by, as the only change is the CQE-off
	call.
	- Tested with CQE enabled.

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
 drivers/mmc/core/mmc.c                        | 111 ++++++++++++------
 drivers/mmc/core/sdio_io.c                    |   7 +-
 include/linux/mmc/host.h                      |   1 +
 7 files changed, 114 insertions(+), 43 deletions(-)

