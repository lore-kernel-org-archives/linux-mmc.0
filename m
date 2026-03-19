Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A934DB7F
	for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946789; cv=none; b=A5QSqnHppXewECtrL4TFzM1uRRqmhpD6kes0rp6IsouADJsSrM5hbyG8jyQHm2+qFfefDwbelM+sG0xYDICUa7oVaO3qBIpULznS2hbedNoWh0haq+RCWj2naPC6dm352iic9iNo7s3WTVUzI+mczMNlac+8DjfrmRzsqdDERLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946789; c=relaxed/simple;
	bh=FnxdsuQXUTvyacSk+dcrrReJL6u/1dUhYM9K+W8MMXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZmVLPnW5pVVArlm4A905kvUq+Z38YJYM4o5ld/3glYLi+Y9BnrBioXxpN9fXzr1kzMRjzAdIzcg59B0hfZgQMWxm3Q445BWPXX8gAXWwL9twTyfgEGs5nGuJOYvCGCKRYqbW8lezeieIbQJAeAz7FEspLmuU9WjXwPtQ1SeN+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MbT/SbYJ; arc=none smtp.client-ip=209.85.222.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MbT/SbYJ"
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-94de68feaf4so658886241.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 11:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773946787; x=1774551587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3ZJX9NLZ/BKZJqOUM4h0Pny6PBYTKzSd7gx1+lxC/Q=;
        b=VAxf2yUjcsRTCm/jIXYA2+LTAB9o/bkP36VjAyulgoeq4carf1KQV3pAkzzEasP4Ql
         vLXYs+QJUrABnujhhYPMLbj27WKXTjUgKk2tP9grduv1MuUBquajMBsRkSNpDoP3pQOx
         p982Hb5wnyeiY3ZUv41aN6asRX1HHv3cMcTHqABm5Fua/9RZn3OdPSC3UGXlTjIl3usU
         YSd2eVfeIBsl+46vWdYH0eFreH6MAJ5iGZVf9JZnbTlnCqPpzbLci6paG65cAhNfnHnR
         UnuNW8zaKNjo6n85eHauw6ibYVcUzqiW6OL8ZimSHAn2Gr0Z96s1fWfDAo3fm91GJZ9e
         obqA==
X-Forwarded-Encrypted: i=1; AJvYcCWCS6kp1+RQHGdnFx74FQpJptaYWsIy34fq/qS0tHhY0ZQmcOj7qRwj1F2Wnoh9dJWW6xFrsrkWr5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzevUPwgk5703RaI6zcWOX0e0BsLaqw+1UF1gjzw7bAMUDb8If+
	C56GzlFoXeBFflPt9l6O4OzMfqjMfLSv0K6NQeUiBUQ+20myqp09N18jd9ODBZXrkCEn8FHhsWb
	+N+Bknzv7oCp7WnSKTULp7tfi5kIWEZ+2sSFyp+pXds6NihJWYNardwpJVol6aBTTr0TmgIYJ2E
	tfbevqEsjjK5fyHrmgu5EYd5u2RmjzsIf2x3eT+4DkgHTrLs7oDa3Ics52EfbnmIWMA5+z11h0Z
	2kg/ZZNteKv
X-Gm-Gg: ATEYQzzCodgxB/xL8cDGJ81QoM5lkCFtB7i55yPhrtQGsCeIfRdEl6QJYuTTI4NEey9
	dcn2H/K5L9y/e8YvwqPfM3WsO7BgmZcWMhJzquWLMZTT/Y6RpqpTuSWTV4OBCmVr2wvhK0a5D30
	dWvZkx10bNQKVolbhOkWydXqCcMOQihSU4aK4MJKgUMU6RodsLEXkaU7Rx6MK6BH82E6JM3jwxm
	qDTsOHDutsTl1K+nKVEWIgYSVaVLNdNyWgX6PJgtbntzeRV9J7m97H2Ee8RsS2tX3eSQzx7AOY0
	lFVehTwUNBpNEOiGvp/eXkkOP9evDGq5emtzMKhrQIlB6NCdCM1eA48IMrpH5HQ6DtJM+/jpZPG
	UB9Z8l263Bz0+9drToBTvAnw0LLJP9lV8kwGF7FG/q0sWFDQpdUJKB/SsRaHCuRCD4FK9Vf0RTD
	MhUChNBtRiU5kzXbFr71PiSrNiKYDt4W4HuJMvZ5EBhugTgiTfj0kf209w
X-Received: by 2002:a05:6102:3e29:b0:5ef:248b:d533 with SMTP id ada2fe7eead31-602aed24487mr317048137.31.1773946786570;
        Thu, 19 Mar 2026 11:59:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-95103420225sm551353241.8.2026.03.19.11.59.46
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 11:59:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so917813eec.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773946785; x=1774551585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f3ZJX9NLZ/BKZJqOUM4h0Pny6PBYTKzSd7gx1+lxC/Q=;
        b=MbT/SbYJuPHKgl16v9KCOMYNvmVeIq1FjuCOHxHc7CMUt/HMon2bCvSWRDTkFnh2lw
         DL3Piwb927gQmTjRGQmRKonDY30XrhVj2Z0JkBzpBR3StkjdqKGgH6xHNR3Zb89n5BVJ
         n33pfnUXDK7FYsngtE6LCY7XvPJ1xidt2U1qE=
X-Forwarded-Encrypted: i=1; AJvYcCVwDKBYnVf9L0kMLU5Z4F1+qbtl3NzK0cBnEjyNaE/KaDtwgOhqQ//2LGH5EJjgWIrTo7DhVpYkrLg=@vger.kernel.org
X-Received: by 2002:a05:7300:b54a:b0:2ba:6fbb:5e7f with SMTP id 5a478bee46e88-2c1097ae747mr266163eec.35.1773946785290;
        Thu, 19 Mar 2026 11:59:45 -0700 (PDT)
X-Received: by 2002:a05:7300:b54a:b0:2ba:6fbb:5e7f with SMTP id 5a478bee46e88-2c1097ae747mr266140eec.35.1773946784631;
        Thu, 19 Mar 2026 11:59:44 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55834a0sm9607220eec.14.2026.03.19.11.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:59:44 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kees Cook <kees@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v3 0/4] mmc: Add pstore backend for crash dump storage on eMMC
Date: Thu, 19 Mar 2026 14:57:01 -0400
Message-Id: <20260319185705.1516950-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=[UTF-8]
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series adds mmcpstore, a pstore backend driver that enables
persistent storage of kernel crash logs on eMMC devices. When the
kernel panics, pstore captures the kmsg dump and writes it directly
to a dedicated MMC partition using polled I/O with interrupts
disabled.

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
other CPUs are stopped and may hold locks.

Patch 2 implements these panic-context operations in the SDHCI host
controller driver: draining in-flight requests, polling for
completion, and making the command retry path panic-safe.

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
with kmsg, pmsg, and console pstore.

Previous submissions and related work:
  RFC v1: https://lore.kernel.org/linux-mmc/20221216212738.7928-1-kdasu.kdev@gmail.com/
  RFC v2: https://lore.kernel.org/linux-mmc/20221222185948.12717-1-kdasu.kdev@gmail.com/
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
 drivers/mmc/core/core.c      |   23 +
 drivers/mmc/core/mmcpstore.c | 1512 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     |  164 +++-
 drivers/mmc/host/sdhci.h     |    6 +
 include/linux/mmc/host.h     |   12 +
 10 files changed, 1806 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mmc/core/mmcpstore.c

-- 
2.34.1

