Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A231618C
	for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038824; cv=none; b=dQiRvNbl9BMy9lzl3jIapqKE4hYpM+lRnBg/XfRFZbmjRWIU3aUlaCfaAOmxOrIfpaLSTEtoc/RYTGPuPyMFBJU+daFGLMAAvKjjeUrTBIcFNqSGb9pn/Iw6UYwZbjeS/LGVTm23QN8ymkkXSnSrzS+ldfw6s+TLzb80UwLly3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038824; c=relaxed/simple;
	bh=wS979EO0vwJHg6vU7g42rIzDKmM4W1oixNntOxmLr5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YRKdDLI7rbN707bPwnQZVre+rjKQEdmHHnSUPKZ0BDpfeD5noMMwU7e64I2KzkrgrpSnWY+Au2jNH+NH+LOo8ngt3UJWmAPLrqs2YrZ8eRWiAtkbmm10nOw/K8dJd9Kh1mgWxmK7uPNABCZ46P0QIW165H9acSr0vmVccCW/LsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nv0hy+wC; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nv0hy+wC"
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-56cc67e01deso856900e0c.3
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 13:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774038822; x=1774643622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87xjxVKGisyDqJa6XXx558fMYLadgP7GMHUKjcy6ZyQ=;
        b=bZzjV4kxlNpg62y4XqlYKA1g37IIiejicS9Rgnmk/5R2dSmoj7cs7YPFjLFw9uSXZ2
         C7ndPnH0lbEyOcOozbFvWUESeTqsAqZzcMu9NDwTkd1GdFMXSFaYR7pFSSbrLSlKtxN+
         kDlTfGJOPk6zgiw00YR+2R7IHw+llXC2wY9t4/KE7G0UtEep5nr+240yPlXzUGqZG68Y
         qRQWPtuCT7+rQ5V7oOah8j9DKm3thXT2OQxtqwXlRBMMsUB0OxsXs92pEnWocoZX870Y
         0mkStCUlsXIepxUi77RwiT1Q3hFJmQ7FnZ3k9S/wSROIMUkfBG6MPFbdCRv4EmWlhuEy
         no8g==
X-Forwarded-Encrypted: i=1; AJvYcCUiXDvK1PcpvapjA9pz1em6zbznIHS+rDSQ2Du5eE796EULidMRSeIncTHUSKU7HRMjo7BRwpTyiRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7eo3rcwCCDZizdLULLdQJcMk9DV0KjLyuuNM7BpNwyJz1SCh2
	bbPUcg8GArkfjg4zhCcXhHhgspHSm3gLJP9zNU+EWHq7R45fCRpoSjpUoV9v3LSHBVT+hM4VKbf
	kkvzZkIqiiI7J4qJ+cKiRGagfj5Gp6Nd17QSh7z3lpS5CTecvHcXgbA+L3n3ZTaGd31gtvlbeHs
	bQBDUNtGWZOcSuOcY7Rt1rtuHxHvCAzGqMuvXn24sparNb0z5V2R2dMhcfWQ+ROQk5lyRohZ/Kv
	I6P5vZPSUPY
X-Gm-Gg: ATEYQzx3Neyep8XZdOUYYrwgb+baHfeHSP3qiLHo7dBKQoe1FN1J19VgQzWeSc9FL72
	htDaE6TV3T3XSkPuC+HoxGSy1ENJrpyThOxy3hf1BsnDSnw4m5+0pQPPhco7jDalz2WcBSFXb/+
	uy8z1PnSq2+cpmpTLnsWw8lBmxCszjDa0Pult+8N9ZdiKYhzL1ZEiDmiMdyJ4U59RfWt2S/LwNB
	6ylrFsrSaFRqntmMrfZ3B/m0xjUex+o23Y0rZJT3g37P4Ljv95Csb80nHLynsyMwAnO+RwBSLb6
	pBsozlx9ECMSthx2k223EzeVo5TCzmg01Pz6Xy2+JNi5mUo/z2/LYrtOSlrrCvIV0ECFieBuuLL
	ZQ8uvj0ILHJGPrVDS/gI0RhV5oDsXFCoptSDaVJOPR9bMlBJ73QZxg6a7BJdCmssLivNhbyvbDj
	Aer++Bt0dI9bcOkjQiNvEe7OlQSijdQbN9ZJmj+bNiWP+hvxQMGkXGdX8Y
X-Received: by 2002:a05:6122:3214:b0:56a:ef89:3504 with SMTP id 71dfb90a1353d-56cde31dec3mr2234782e0c.4.1774038822366;
        Fri, 20 Mar 2026 13:33:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56cddb6e2basm519026e0c.1.2026.03.20.13.33.42
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 13:33:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb52a9c0eeso1018593385a.2
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774038822; x=1774643622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87xjxVKGisyDqJa6XXx558fMYLadgP7GMHUKjcy6ZyQ=;
        b=Nv0hy+wCBEJN7fgxiY3GwWlKU/W918qBJjRjoO4LdXSxTwwzb1qsUxschM4gP3/OMN
         6Abi4E7FZFLjTKgOdRl2Vmb4eqE8Yfv5Bi2GlvtJP0LmniwOhzRI7f+T3b4qg6Ina6Pc
         u29PxLLNoeWsLTH3JvvuWSoOWLOEe2tsp5TCc=
X-Forwarded-Encrypted: i=1; AJvYcCW0SBrl6VBsovvgLzZnmPDAHyvn5HOESCrKUAxL4irkgAJ44b4YPz8YAdyASdBeSstKn4DuuaQBRN4=@vger.kernel.org
X-Received: by 2002:a05:620a:460b:b0:8cd:9863:331f with SMTP id af79cd13be357-8cfc7a79f50mr675886785a.0.1774038821762;
        Fri, 20 Mar 2026 13:33:41 -0700 (PDT)
X-Received: by 2002:a05:620a:460b:b0:8cd:9863:331f with SMTP id af79cd13be357-8cfc7a79f50mr675882085a.0.1774038821148;
        Fri, 20 Mar 2026 13:33:41 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8fb9c10sm280699985a.19.2026.03.20.13.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 13:33:40 -0700 (PDT)
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
Subject: [PATCH v4 0/4] mmc: Add pstore backend for crash dump storage on eMMC
Date: Fri, 20 Mar 2026 16:32:45 -0400
Message-Id: <20260320203249.1965044-1-kamal.dasu@broadcom.com>
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
  v3: https://lore.kernel.org/linux-mmc/20260319185705.1516950-1-kamal.dasu@broadcom.com/
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
 drivers/mmc/core/mmcpstore.c | 1519 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     |  169 +++-
 drivers/mmc/host/sdhci.h     |    6 +
 include/linux/mmc/host.h     |   12 +
 10 files changed, 1818 insertions(+), 4 deletions(-)
 create mode 100644 drivers/mmc/core/mmcpstore.c

-- 
2.34.1

