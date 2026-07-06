Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E838B124
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352451; cv=none; b=nw/cxyLbYm8yOqBXrYIOym2FBzaDix3fF4dHLBu15qhhODm5ZJdO2Tk0b8VzK9x3SmKlvV7NoT+u54HyiOk5IC9P2t++LGmjo/cZtn6YdXrZ9oujqJZS38/bvwGi/tnjMfD3RGHGoeJ97hidPC/gWtK7yDt3rlDJeyRriSfzE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352451; c=relaxed/simple;
	bh=gUbam2X1zBZL9uSpYxqgwz7Rq6Dxn12/yakuXDqO3EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+5MGNF/EFcFum3o9GqVyzHE6I8Rs4qgtnllfHnCJ+6fa3f7RVsJzquZTPyMCC4SbaiopWxbvfuwebaf4q207I4T9Npv5gnIQIafrqVrFkWFGMzweZ4LknC8U99j1fvlc98OB/XicK/O6HeB9//NrQihb5loljUtRl39mvPgYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=id3r42N6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="id3r42N6"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c00f74baso19638625e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1783352447; x=1783957247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kt3WYRWrht+2ylbL4M+X6SQZM1BEsWSxUIBF7uW5bIk=;
        b=id3r42N6aiIu972GNWL5s1iIcDIA2h/NmVq7ctr0QVvdWQxyjtLP9GotqqAEv/R8C7
         bvmQhQkUMyIYZMUCpLGb8TaKfMdZyL+ayscTfBy0xSOavP6YXVWrpXU8plMoBRIz0zvK
         zjjxhL6KocyAy3tE0IFQ2QAG+6icYVccfClVjMCJjL50sf/5ok+m3kfhI110z30Q8XAc
         vs4VfMyGmuZPDN3I77gZWbC3QsW070932J6ARKmMmq1CUet5BZo0+4avjS6L2PFpebY0
         WBMEYdfHtl/LA7Z4WpZIP0JnfwNK5Dri+4OtOB98hhDXLGOgMM58B3gdBZI6og4vvqzi
         kYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352447; x=1783957247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kt3WYRWrht+2ylbL4M+X6SQZM1BEsWSxUIBF7uW5bIk=;
        b=iGhEdlhOanOXBVVHZgUPspu7dDug1t/4HQtf4lmFtWz6STdU7PZMCFJNlpSOtyCuw2
         +ZbA5InogV9qe3rvuxUDB3DZEpBn3UrAB6tbnJn5/VEEm0PXj93ONhzb6+wb6l/Edjsw
         t3xgUUd22cwcH7y5eFmSLYwBuhArPXV9HpJAtHCvMm1enr25ykVD37nBUg2dNGVp4UdH
         NcJ8iRwClIxOUqJ0Cpt+aYMBJXU2aaE6jGrkO3SdBvp35ilN+4aNb0OvWiJ8j0wAFN/j
         KsQ3t9/jAOyIBDX9+bPKtH5KGK8GdSxEXzd7pkWWAp2szIB6WZG5SHuy69gPuFX8MAYM
         6aPw==
X-Forwarded-Encrypted: i=1; AHgh+RozqNHN+CXTou/UGynWI34RmjAH4QjZessifvErVyFRD9fZI93wxD8UuCLPJLqI8NfEoE3sUNuO2EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRNdIfO5itrsQYFZJLrg4uG9K4RC/9tLeZRiA/gniavcf7ZAI
	xJRCbelQ/XUleA23hTABtVvtRUmA4MoMtGw7s97f9tDDzS/nCWSIRUpms9AuifB6c0f82oUSDic
	GIuc=
X-Gm-Gg: AfdE7ckTOzxKBmmfYxfyT4H4vR9Kt3MyicCzhiq7/vUFJcpV01K+xeGjZh5VQi2swno
	DR9M7jTCPLRvvq40Fx3WmZZzFkovVXjdi7h6Sz+Ho3A5Oen6q+BvgK12x62N7O7JB7vtGgM2gza
	g1hLFTsSzLP3WIwdzXq5sGUDMUBVj8uKuXOBe4K9ZIei1GH5JZ13CDJPZDHJapP3AoXfHweGKK1
	bG1wQzCe9cbdzdqHUOMQ4wiE0crrqumRO6NDAUIcnx7U0nzqRrxjGAStEDn7WK5HCrygPPiEVzu
	M8nOxM+xWNoUy9qGeflgiSbaI2MwiLuY4W6xxUOiM0bPc5IQLOslmPRgHb8xQAVagDihd0x9FRR
	0j2xnqQi90G1KmBps544ZQ4DD6diL4D8O+bZBaAJW8UoMkcxoD5xGO2rZrYJiVRhHIonefCbqh3
	83rMzgwizPFu8f1RtRVYPfYVPBgRmOLPfqXzDcxweGSAouBJIfAvtdrRE=
X-Received: by 2002:a05:600c:8b66:b0:493:a7fd:15d6 with SMTP id 5b1f17b1804b1-493df08b4camr12721185e9.9.1783352447174;
        Mon, 06 Jul 2026 08:40:47 -0700 (PDT)
Received: from horizon.localdomain ([150.228.6.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce03fa1sm283699005e9.11.2026.07.06.08.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:40:46 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ricky Wu <ricky_wu@realtek.com>,
	Sean Rhodes <sean@starlabs.systems>,
	Lee Jones <lee@kernel.org>,
	Roger Tseng <rogerable@realtek.com>,
	Dan Carpenter <error27@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] rtsx_usb: fix tray-reader false card detect and autosuspend
Date: Mon,  6 Jul 2026 16:40:42 +0100
Message-ID: <cover.1783352430.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the empty-tray detect loop seen on a Realtek RTS5129
USB SD reader, while also avoiding USB register accesses from the USB
runtime autosuspend callback.

Compared with the previous RFC, this no longer qualifies media by issuing
SD/MMC commands from ->get_cd().  The rtsx_usb_sdmmc child still reports
the raw card-detect state initially, then lets the normal MMC rescan path
probe the media.  If an initialization command times out before a card is
attached, the SD child suppresses the raw SD_CD signal until the tray/card
detect line drops again.

The parent rtsx_usb change removes USB I/O from runtime autosuspend and
keeps only the existing Memory Stick autosuspend deferral based on cached
card-status bits.  Raw SD_CD is not used as a parent autosuspend blocker,
because this reader can assert it for an empty tray.

Runtime-tested on a StarLite Mk V with Realtek RTS5129 (0bda:0129), using
these changes as a matched rtsx_usb/rtsx_usb_sdmmc/rtsx_usb_ms module set
on Linux 7.0.0-27-generic.

Device enumeration:
  Bus 001 Device 003: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 Card Reader Controller
  /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/12p, 480M
      |__ Port 004: Dev 003, If 0, Class=Vendor Specific Class, Driver=rtsx_usb, 480M

Card inserted:
  mmc0: new UHS-I speed SDR50 SDXC card at address 544c
  mmcblk0: mmc0:544c LX2TB 1.82 TiB
   mmcblk0: p1

Deep S3 with the card inserted:
  PM: suspend entry (deep)
  ACPI: PM: Waking up from system sleep state S3
  PM: suspend exit

After resume, the card remained visible:
  NAME         SIZE TYPE FSTYPE MOUNTPOINTS
  mmcblk0      1.8T disk
  `-mmcblk0p1  1.8T part exfat

Empty tray:
  mmc0: card 544c removed
  /sys/bus/usb/devices/1-4/power/control=auto
  /sys/bus/usb/devices/1-4/power/runtime_status=suspended
  /sys/bus/usb/devices/1-4/power/runtime_usage=0

With the empty tray left inserted for about three minutes, no repeated
MMC detect attempts, command timeouts, or USB reset churn were observed.

Sean Rhodes (2):
  misc: rtsx_usb: avoid USB I/O in runtime autosuspend
  mmc: rtsx_usb_sdmmc: suppress false CD after init timeout

 drivers/misc/cardreader/rtsx_usb.c | 26 ++++++++++++++++++++------
 drivers/mmc/host/rtsx_usb_sdmmc.c  | 13 ++++++++++++-
 include/linux/rtsx_usb.h           |  3 +++
 3 files changed, 35 insertions(+), 7 deletions(-)

