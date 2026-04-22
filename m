Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33BD26AC3
	for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776891088; cv=none; b=aoDHaWe343xB1O0OrsX8ezKh18bS487Npm/FaXaGVetS8h/LK+YlF4oUXKGjaCtozUY34pgAbAOcLFpfrkpiUOscjCRiq6/Lx4/LxfERGf9OOSY1c7btRpIuIRxqV+Ll3WeqrbEY4I6uNNmrkEodr1HjidzDJUQxA+RNCNLsTqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776891088; c=relaxed/simple;
	bh=1GMiI8COB+BglJJihwQr7e8bXjaXq6zK8yFVARs3Q/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=C+Vp8ldKt1o5hpgYnDmXicBZ1yMcPg0QphzFMNLMRF1NOCh7KjlLZBcoMmPzjLYjuizrYnat8alcs4+tS7VuMTf8AQ0t27mrd7q8khdVtvM4Vs189rmxdrWM293HuGdttpLNv3RBowl4m4HvQI9WlofZsjlnRR+ukSXozK/n7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eEBHFeNb; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eEBHFeNb"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8a15ebb3abbso83400406d6.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 13:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776891086; x=1777495886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXZnxNybTo7ztMKi330f3Bpew5CPkTtcRTpNIozXPrQ=;
        b=iv2GxkepgsGCzrHyag/YBjHTXswkh/KU7yWKQ8kVEp+tw3njMB4noiFq2LxE48teoa
         mNvtSXG7AvetlBO+jqlpt6tQDUPgZOx7b7u8Joj1Uu72s1mZ2m5JuQWJM5ZOhihYRYIb
         nGLyyCQ6fb8uGTuczq5Je6wlTUP+WF5AxWYmbI7/0FmINCp0sZaYGh8zzm151xfMbR4P
         9KAoJD1AdTxjF50Vv4unR6lVaOo6UJ0YJMi+uj2ShxwX1EKffvBYxg0Kyl62OzdZE3MG
         5YGFNM4uiyu59puZY8qBUbe+ZeTOA0h8Q6GOVKljRv9F1R++a2gBacUkurKDhIUC4czx
         6sJA==
X-Forwarded-Encrypted: i=1; AFNElJ9HmY3K+fD35Xd3NM6CzQGATE1bsIktpH0JkfNUo7NbhhUOuek9iMFsljXf95w9JpzARWI+Q/Jp1sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdfmLgTt1YKLfdXoinVYnOGrDkULWp+gmL8xJVhMx2Lb40DBOi
	LUHeyJ3e3CHYzDYtATK9liCLYPWRNXPnyIaOKqhvIX9FGm7rF9yHuKgxOlbOU/Z8tE0xUtAuMme
	AU2MukSrxz4N8kKxWyV+0kSCrNYcwG6pFK8Mfi71B+ztxv7QBGDlj9iAjbaJisK09YJvy1rvH89
	2y9KsciXvmv/Qy26gp0o5Al+5nPJSEYW4aVLHI+zentoGixFDzzk8PFOcNpeUTnm833HGFfnuZm
	6q19IuzBE5q
X-Gm-Gg: AeBDietmG1njTNp2dq1pbMJdM51+Z9T7bonMmzG4j5/yjPK2A+iTKUBfSRKgMwFexhk
	zhqckV8c6WuodR4apvBzauWcS+dHr/yT+oH987kCftlVEBp2OHRh1g89HguCThiBqZrlZQbtXRf
	vh+Tq2ub1fhJzYx4gk5s4ABmko19TLKaFgriSbbQcho5EMqgXutLbl37ycWN+jOz8hKujoiCdtb
	owErHGSWKE6aADpcGZDn4FLLUZHrBX9Pyx3NeU7km5VlM18agX0jrI1AIFr13wgmiCBUVBqqB/M
	nX1pN1wgu/NjnC07Q0/+BM80fOzWoVYsja3KQXqt3TXhxfF9YaMD8HAxfbSO9PHOviNsO12+a0n
	muCs2sFesG7jzXFhEEWusbGyvdfRIs4p9w6PtClInQJywTxsicjrZBxyh6EK9wMGi/q1ugLm4ze
	xRD/jTiRokavfg7d8aDV4S7h+0ItzBPL2rePWQHn54gWxYaxM7OnjRNquUvCI1D0IL
X-Received: by 2002:a0c:fec5:0:b0:8ac:a6a5:1f41 with SMTP id 6a1803df08f44-8b0280cdd3fmr288278546d6.27.1776891085383;
        Wed, 22 Apr 2026 13:51:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b02ac63370sm12699926d6.8.2026.04.22.13.51.25
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2026 13:51:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8aca6420fe3so73345176d6.0
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2026 13:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776891084; x=1777495884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXZnxNybTo7ztMKi330f3Bpew5CPkTtcRTpNIozXPrQ=;
        b=eEBHFeNb+TfWz42J9O2r/fAo5IDRa0zHZctjHSzPz9GFB3ZkiHg2q9W4DcTABU+ZHV
         4By7erdnl6xuc7keZ4b5nwn5yTyxK0Xns4Anm29mcHYQS4a8+OySlmiGbhuHLnFGodra
         oh5jfprhpOWG9F6pJkLT71wDEdcxHrn9MVVEY=
X-Forwarded-Encrypted: i=1; AFNElJ/gRQmhjKQJtGh5F2BW+KgpIVqvy9GF1AN1uAFy/zEx9jKrckvlQuPUYnogAa3n1/TWB/JrRkzjjzI=@vger.kernel.org
X-Received: by 2002:a05:6214:598c:b0:8ac:a4f9:da76 with SMTP id 6a1803df08f44-8b0280cdc7bmr381918226d6.26.1776891084576;
        Wed, 22 Apr 2026 13:51:24 -0700 (PDT)
X-Received: by 2002:a05:6214:598c:b0:8ac:a4f9:da76 with SMTP id 6a1803df08f44-8b0280cdc7bmr381917916d6.26.1776891084078;
        Wed, 22 Apr 2026 13:51:24 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae88d5fsm171453486d6.39.2026.04.22.13.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 13:51:23 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v5 0/4] mmc: Add pstore backend for crash dump storage on eMMC
Date: Wed, 22 Apr 2026 16:50:49 -0400
Message-Id: <20260422205053.3392395-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series adds mmcpstore, a pstore backend driver that enables
persistent storage of kernel crash logs on eMMC devices. When the
kernel panics, pstore captures the kmsg dump and writes it directly
to a dedicated MMC partition using polled I/O with interrupts
disabled.

Changes since v4 (addresses Ulf Hansson's feedback on the v4 panic
host path, linux-mmc):
- mmc_panic_claim_host(): log claimed, runtime suspend, and
  ongoing_mrq before claim; always call panic_prepare() when
  implemented so the host can drain or gracefully terminate
  in-flight requests, then force-claim. Vendor controllers may
  supply their own panic_prepare for platform-specific cases (1/4).
- SDHCI: reference panic_prepare implementation; longer drain/reset
  timeouts; document panic helper return values in kernel-doc (2/4).
- mmcpstore: single prepare/claim path; panic_complete() after
  panic_poll_completion() on panic writes (4/4).

Changes since v3:
- Fixed kernel-doc warnings reported by kernel test robot:
  - Added missing @param descriptions for sdhci_panic_prepare(),
    sdhci_panic_poll_completion(), sdhci_panic_complete() (patch 2)
  - Added missing @sect_offset param doc for
    mmcpstore_do_request_internal() (patch 4)
  - Fixed kernel-doc function name mismatch: mmcpstore_read() ->
    mmcpstore_read_zone() (patch 4)
  - Added missing @disk param doc for mmcpstore_card_add() (patch 4)
- Removed unused 'offset_bytes' variable in
  mmcpstore_register_for_card() (patch 4)

Changes since v2 (RFC):
- Rebased onto v7.0-rc — no longer reverts any existing MMC core
  or SDHCI changes (v1/v2 accidentally reverted recent upstream
  commits due to being based on an older tree)
- Removed all erase/bitmap tracking logic — MMC/eMMC is managed
  flash and does not need erase-before-write; the pstore_zone
  framework handles zone management internally
- Uses standard MMC core request path (mmc_start_request) instead
  of hand-building mmc_request structs; panic-context I/O is
  handled through proper mmc_host_ops callbacks rather than ad-hoc
  code in the driver
- Added panic-context ops to mmc_host_ops and sdhci_ops for clean
  separation of panic and normal I/O paths
- Fixed deadlocks caused by spinlock contention during panic
  (lockless mmc_panic_claim_host using WRITE_ONCE)
- Fixed data corruption in pstore recovery (zlib_inflate failures)
  by letting the normal sdhci_request() path run instead of a
  custom panic request handler
- Added PM suspend/resume support with eMMC re-initialization
- Supports module loading or builtin loading of the driver
- Added MAINTAINERS entry
- Split into 4-patch series for reviewability

The series is structured as follows:

Patch 1 adds panic-context operations to struct mmc_host_ops and a
lockless mmc_panic_claim_host() for use during kernel panic when
other CPUs are stopped and may hold locks. Host drivers may replace
panic_prepare with vendor-specific code where needed.

Patch 2 implements the SDHCI reference panic_prepare (graceful
termination of in-flight work, then polled completion paths); other
MMC host drivers use the same mmc_host_ops hooks with their own
panic_prepare where the hardware differs.

Patch 3 adds mmc_blk_get_card_by_name() helper to look up an
mmc_card from a block device name, used by the mmcpstore module
path for card discovery.

Patch 4 adds the mmcpstore driver itself, which registers with the
pstore_blk framework and handles panic writes, PM suspend/resume,
and dual-path registration (direct probe hook for builtin,
mmc_blk_get_card_by_name() for module). Also adds probe/remove
hooks in block.c and declarations in block.h for the builtin path.

Tested on Broadcom STB platforms (ARM64) with SDHCI controllers,
verified panic dump recovery across multiple panic/reboot cycles
with kmsg, pmsg, and console pstore; also tested with concurrent
I/O stress before panic.

Previous submissions and related work:
  RFC v1: https://lore.kernel.org/linux-mmc/20221216212738.7928-1-kdasu.kdev@gmail.com/
  RFC v2: https://lore.kernel.org/linux-mmc/20221222185948.12717-1-kdasu.kdev@gmail.com/
  v3: https://lore.kernel.org/linux-mmc/20260319185705.1516950-1-kamal.dasu@broadcom.com/
  v4: linux-mmc (same thread as v3; superseded by this v5)
  Marvell MMC pstore attempt (2020):
    https://lore.kernel.org/linux-mmc/20201207115753.21728-1-bbudiredla@marvell.com/
  pstore/blk documentation:
    https://www.kernel.org/doc/html/latest/admin-guide/pstore-blk.html

Kamal Dasu (4):
  mmc: core: Add panic-context host operations for pstore backends
  mmc: sdhci: Implement panic-context write support
  mmc: block: Add helper to look up mmc_card by device name
  mmc: core: Add MMC pstore backend driver

 MAINTAINERS                  |    6 +
 drivers/mmc/core/Kconfig     |   12 +
 drivers/mmc/core/Makefile    |    1 +
 drivers/mmc/core/block.c     |   56 ++
 drivers/mmc/core/block.h     |   18 +
 drivers/mmc/core/core.c      |   54 ++
 drivers/mmc/core/mmcpstore.c | 1511 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     |  173 +++-
 drivers/mmc/host/sdhci.h     |    6 +
 include/linux/mmc/host.h     |   12 +
 10 files changed, 1845 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mmc/core/mmcpstore.c

-- 
2.34.1
