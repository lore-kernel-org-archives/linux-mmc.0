Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF74125A9
	for <linux-mmc@vger.kernel.org>; Sun, 15 Mar 2026 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773533204; cv=none; b=Ts3m21ycm0GWtUeDLF9WqxTN7KhIQhsOo11jBPBFLvOCp0PT9+xU2mIuB4e3rMHyuVxDwbAuE8Lxw2lTC9DYp206EfpN6QvIze7YI7NDSxQSQmOa26+XFzgJS6lR9Uu25SQwUO10h1gO+kAHrRBVxO41X/JVE8PJVnqejKOlwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773533204; c=relaxed/simple;
	bh=jobja6h8hu+3WXBKG8Tq9y2rLWUV3c7ythLBLqoBGys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n0o9jeYvG9eBS0YvBuBPZ1VtfNBrLsW1gt0YFQnj6103I2+dRBUmfhCzmRU7uAt5++ZN+RihNbBYcEL4Tcb7wRR62NDiZd63ykX51oQKVEHw6m2DuEmWC9VbdUe2B3ZLYANwUD6L5U6XIe/oEFD5V+YU+S+E/Zd7GpHKSrjGrTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdTBLXXq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdTBLXXq"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so3835345f8f.0
        for <linux-mmc@vger.kernel.org>; Sat, 14 Mar 2026 17:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773533194; x=1774137994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJHIQbLzq5ipMBJXUF0EbMFTALUots8iCxBKs65xd1k=;
        b=FdTBLXXqMjkdwa/JSdwhALY4Vdjut6btPiO7hbBVmR81vv+spotL3mtM/0n7MHOI42
         uM+q25Ud4VBXnZ05F4g85g7PVXjdrtWNSw1wStokTilaXWH4MzbylK4G8BuOqmHjlk6A
         Pe8HzrU7aiwVNParRaNZxY3ueWPfWhBcDvmk/XpsLf6YPJpLNIxkp/2Q6CGeCeTfybzm
         H5z+4pbog+6WMeGKdkPkM0bO7LRd59fR46yhH63ZsbTR88IixfCbeZNmZTgDUeUVuSpR
         MZQjei3xEQqkwjmN6/4Q7XgzJ9CFNf4VTZKVKtMwiqotNNHw+qJ6ODzaEWUfvlW1Dz7X
         N8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773533194; x=1774137994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJHIQbLzq5ipMBJXUF0EbMFTALUots8iCxBKs65xd1k=;
        b=S87YI8J26J5dDmaSqOP6macGhjHY4ogCK61X2egRVS+P8Uf+LWcOS/GRXpVc8SnzAz
         7E+cto+q/1jcyHSMgZaLCYp6czFAADT3VMXcCAe68zvpcxVtDM/WQjbBdnpHd1pqJU5E
         mj1wjur39S59QBiQOc8O5xV+gSalqyYzaGDfMyL6D9f9ZIxRLM2UAbWbuPwgmMv2/Uh8
         RQBYElvxSlvDLEu4EK0gRyxrifxxpFS+dnpdy8o5/iSUg3bs0BXlOQqo21s56n10RUkE
         BWh6ddHBmIu6ScAaKo80teSKCErbk1W5vT1Tc8jJG1cVCDFB1VZ5SHtJI5x54rVHwI86
         dMyg==
X-Forwarded-Encrypted: i=1; AJvYcCU6BKDTlGMMk86KgxKoBZpIbP/yvQq58RcAz1tPZrw6drUcG7gX+gXXlyj3MgAkrE9J9VDbzBtr+c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJxdjmhtgzsPLyYrbZZfXv2w67nYOcr17EbafMurp0oDamkHsa
	zw/K0GmIopk8VAekQsmUlfiRhgThYjn7pcCe8bdBtt9CvwGjbnNWOWwp3igszIhKOFI=
X-Gm-Gg: ATEYQzzjGFpYt6Oo0GzaAMbfo6avbSjJu4aJ3cRLj115EQmQeXV2wgd3e8ZCutQA6/P
	/J7QNQJ8yTIAlaIRiiKsYPUngf8azVTZJGY3iPblR66onuNE1HO4n9eW1XsR44J0IPIrTwJ/fYD
	ICuoLHtqdt8iZxE9rAcVEx0i9zCW9LyhC4+coetMkes5pwKnMSZk9vBNwssEZ2Tgp+RYcaNllD1
	650YbMNKMitryg8mxJ/v/wZvyoadK9qj31WCyw8S+pru/1MOX0IDK04TBGZnZjUWVBWx22tSCeG
	c9JJlg5B6I8sF/t3Kzy/jDhwrx9Ppa/SuUPdf0hYkGp83qFFNAKavX4Kjb67q74U/EU24PxgmDF
	g2lEmWbX6Ks+bLhBOT3wCV0MNH/ylivDWi9KONQOdh4PT+fyYvVHeGlPfWlrBYwKQif5tXyDlJ+
	pcpFOG4FUotzKON/UxY06H+kYhpyPX6bRnNA==
X-Received: by 2002:a05:600c:1f8b:b0:485:3c66:e21d with SMTP id 5b1f17b1804b1-485566d2fa1mr141329655e9.2.1773533192412;
        Sat, 14 Mar 2026 17:06:32 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485419c2930sm658854135e9.0.2026.03.14.17.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 17:06:31 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: torvalds@linux-foundation.org
Cc: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] [PATCH 7.0-rc3] Consolidation of sdhci-imx and Rust PinInit optimization
Date: Sun, 15 Mar 2026 01:06:26 +0100
Message-ID: <20260315000627.29888-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Consolidate sdhci_imx25_data and sdhci_imx35_data SoC data structures to
eliminate redundancy and prevent symbol collisions.

Implement the PinInit interface for the Rust rnull block driver to
support in-place initialization of QueueData, enabling zero-copy
allocation and reducing stack frame usage.

Optimize iwlwifi MSI-X interrupt affinity distribution for Intel 11th Gen
i7 processors to prevent CPU0 from becoming a processing bottleneck
during high network load.

Fix MMC Manufacturer ID for Kingston and add guards to quirks.h.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 drivers/block/rnull/rnull.rs                  |  101 +
 drivers/mmc/core/quirks.h                     |  271 +
 drivers/mmc/host/sdhci-esdhc-imx.c            | 2203 +++++++++
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 4377 +++++++++++++++++
 4 files changed, 6952 insertions(+)
 create mode 100644 drivers/block/rnull/rnull.rs
 create mode 100644 drivers/mmc/core/quirks.h
 create mode 100644 drivers/mmc/host/sdhci-esdhc-imx.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
new file mode 100644
index 0000000..454ab80
--- /dev/null
+++ b/drivers/block/rnull/rnull.rs
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This is a Rust implementation of the C null block driver.
+
+mod configfs;
+
+use configfs::IRQMode;
+use kernel::{
+    block::{
+        self,
+        mq::{
+            self,
+            gen_disk::{self, GenDisk},
+            Operations, TagSet,
+        },
+    },
+    prelude::*,
+    sync::{aref::ARef, Arc},
+};
+
+module! {
+    type: NullBlkModule,
+    name: "rnull_mod",
+    authors: ["Andreas Hindborg"],
+    description: "Rust implementation of the C null block driver",
+    license: "GPL v2",
+}
+
+#[pin_data]
+struct NullBlkModule {
+    #[pin]
+    configfs_subsystem: kernel::configfs::Subsystem<configfs::Config>,
+}
+
+impl kernel::InPlaceModule for NullBlkModule {
+    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        pr_info!("Rust null_blk loaded\n");
+
+        try_pin_init!(Self {
+            configfs_subsystem <- configfs::subsystem(),
+        })
+    }
+}
+
+struct NullBlkDevice;
+
+impl NullBlkDevice {
+    fn new(
+        name: &CStr,
+        block_size: u32,
+        rotational: bool,
+        capacity_mib: u64,
+        irq_mode: IRQMode,
+    ) -> Result<GenDisk<Self>> {
+        let tagset = Arc::pin_init(TagSet::new(1, 256, 1), GFP_KERNEL)?;
+
+        let queue_data = Box::pin_init(QueueData { irq_mode }, GFP_KERNEL)?;
+
+        gen_disk::GenDiskBuilder::new()
+            .capacity_sectors(capacity_mib << (20 - block::SECTOR_SHIFT))
+            .logical_block_size(block_size)?
+            .physical_block_size(block_size)?
+            .rotational(rotational)
+            .build(fmt!("{}", name.to_str()?), tagset, queue_data)
+    }
+}
+
+#[pin_data]
+struct QueueData {
+    irq_mode: IRQMode,
+}
+
+#[vtable]
+impl Operations for NullBlkDevice {
+    type QueueData = KBox<QueueData>;
+
+    #[inline(always)]
+    fn queue_rq(queue_data: &QueueData, rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
+        match queue_data.irq_mode {
+            IRQMode::None => mq::Request::end_ok(rq)
+                .map_err(|_e| kernel::error::code::EIO)
+                // We take no refcounts on the request, so we expect to be able to
+                // end the request. The request reference must be unique at this
+                // point, and so `end_ok` cannot fail.
+                .expect("Fatal error - expected to be able to end request"),
+            IRQMode::Soft => mq::Request::complete(rq),
+        }
+        Ok(())
+    }
+
+    fn commit_rqs(_queue_data: &QueueData) {}
+
+    fn complete(rq: ARef<mq::Request<Self>>) {
+        mq::Request::end_ok(rq)
+            .map_err(|_e| kernel::error::code::EIO)
+            // We take no refcounts on the request, so we expect to be able to
+            // end the request. The request reference must be unique at this
+            // point, and so `end_ok` cannot fail.
+            .expect("Fatal error - expected to be able to end request");
+    }
+}
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
new file mode 100644
index 0000000..d736bb4
--- /dev/null
+++ b/drivers/mmc/core/quirks.h
@@ -0,0 +1,271 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  This file contains work-arounds for many known SD/MMC
+ *  and SDIO hardware bugs.
+ *
+ *  Copyright (c) 2011 Andrei Warkentin <andreiw@motorola.com>
+ *  Copyright (c) 2011 Pierre Tardy <tardyp@gmail.com>
+ *  Inspired from pci fixup code:
+ *  Copyright (c) 1999 Martin Mares <mj@ucw.cz>
+ *
+ */
+
+#include <linux/of.h>
+#include <linux/mmc/sdio_ids.h>
+
+#include "card.h"
+
+#ifndef CID_MANFID_KINGSTON
+#define CID_MANFID_KINGSTON	0x70
+#endif
+
+static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
+	/*
+	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
+	 * This has so far only been observed on cards from 11/2019, while new
+	 * cards from 2023/05 do not exhibit this behavior.
+	 */
+	_FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
+		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
+		   MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
+
+	/*
+	 * GIGASTONE Gaming Plus microSD cards manufactured on 02/2022 never
+	 * clear Flush Cache bit and set Poweroff Notification Ready bit.
+	 */
+	_FIXUP_EXT("ASTC", CID_MANFID_GIGASTONE, 0x3456, 2022, 2,
+		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
+		   MMC_QUIRK_BROKEN_SD_CACHE | MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY,
+		   EXT_CSD_REV_ANY),
+
+	/*
+	 * Swissbit series S46-u cards throw I/O errors during tuning requests
+	 * after the initial tuning request expectedly times out. This has
+	 * only been observed on cards manufactured on 01/2019 that are using
+	 * Bay Trail host controllers.
+	 */
+	_FIXUP_EXT("0016G", CID_MANFID_SWISSBIT, 0x5342, 2019, 1,
+		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
+		   MMC_QUIRK_NO_UHS_DDR50_TUNING, EXT_CSD_REV_ANY),
+
+	/*
+	 * Some SD cards reports discard support while they don't
+	 */
+	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
+		  MMC_QUIRK_BROKEN_SD_DISCARD),
+
+	END_FIXUP
+};
+
+static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
+#define INAND_CMD38_ARG_EXT_CSD  113
+#define INAND_CMD38_ARG_ERASE    0x00
+#define INAND_CMD38_ARG_TRIM     0x01
+#define INAND_CMD38_ARG_SECERASE 0x80
+#define INAND_CMD38_ARG_SECTRIM1 0x81
+#define INAND_CMD38_ARG_SECTRIM2 0x88
+	/* CMD38 argument is passed through EXT_CSD[113] */
+	MMC_FIXUP("SEM02G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM04G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM08G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM16G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+	MMC_FIXUP("SEM32G", CID_MANFID_SANDISK, 0x100, add_quirk,
+		  MMC_QUIRK_INAND_CMD38),
+
+	/*
+	 * Some MMC cards experience performance degradation with CMD23
+	 * instead of CMD12-bounded multiblock transfers. For now we'll
+	 * black list what's bad...
+	 * - Certain Toshiba cards.
+	 *
+	 * N.B. This doesn't affect SD cards.
+	 */
+	MMC_FIXUP("SDMB-32", CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BLK_NO_CMD23),
+	MMC_FIXUP("SDM032", CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BLK_NO_CMD23),
+	MMC_FIXUP("MMC08G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BLK_NO_CMD23),
+	MMC_FIXUP("MMC16G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BLK_NO_CMD23),
+	MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_BLK_NO_CMD23),
+
+	/*
+	 * Some SD cards lockup while using CMD23 multiblock transfers.
+	 */
+	MMC_FIXUP("AF SD", CID_MANFID_ATP, CID_OEMID_ANY, add_quirk_sd,
+		  MMC_QUIRK_BLK_NO_CMD23),
+	MMC_FIXUP("APUSD", CID_MANFID_APACER, 0x5048, add_quirk_sd,
+		  MMC_QUIRK_BLK_NO_CMD23),
+
+	/*
+	 * Some MMC cards need longer data read timeout than indicated in CSD.
+	 */
+	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_MICRON, 0x200, add_quirk_mmc,
+		  MMC_QUIRK_LONG_READ_TIME),
+	MMC_FIXUP("008GE0", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_LONG_READ_TIME),
+
+	/*
+	 * On these Samsung MoviNAND parts, performing secure erase or
+	 * secure trim can result in unrecoverable corruption due to a
+	 * firmware bug.
+	 */
+	MMC_FIXUP("M8G2FA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("MAG4FA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("MBG8FA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("MCGAFA", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("VAL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("VYL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("KYL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("VZL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+
+	/*
+	 *  On Some Kingston eMMCs, performing trim can result in
+	 *  unrecoverable data conrruption occasionally due to a firmware bug.
+	 */
+	MMC_FIXUP("V10008", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+
+	/*
+	 * Micron MTFC4GACAJCN-1M supports TRIM but does not appear to support
+	 * WRITE_ZEROES offloading. It also supports caching, but the cache can
+	 * only be flushed after a write has occurred.
+	 */
+	MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN | MMC_QUIRK_BROKEN_CACHE_FLUSH),
+
+	/*
+	 * Kingston EMMC04G-M627 advertises TRIM but it does not seems to
+	 * support being used to offload WRITE_ZEROES.
+	 */
+	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+
+	END_FIXUP
+};
+
+static const struct mmc_fixup __maybe_unused mmc_ext_csd_fixups[] = {
+	/*
+	 * Certain Hynix eMMC 4.41 cards might get broken when HPI feature
+	 * is used so disable the HPI feature for such buggy cards.
+	 */
+	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_HYNIX,
+			      0x014a, add_quirk, MMC_QUIRK_BROKEN_HPI, 5),
+	/*
+	 * Certain Micron (Numonyx) eMMC 4.5 cards might get broken when HPI
+	 * feature is used so disable the HPI feature for such buggy cards.
+	 */
+	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_NUMONYX,
+			      0x014e, add_quirk, MMC_QUIRK_BROKEN_HPI, 6),
+
+	END_FIXUP
+};
+
+
+static const struct mmc_fixup __maybe_unused sdio_fixup_methods[] = {
+	SDIO_FIXUP(SDIO_VENDOR_ID_TI_WL1251, SDIO_DEVICE_ID_TI_WL1251,
+		   add_quirk, MMC_QUIRK_NONSTD_FUNC_IF),
+
+	SDIO_FIXUP(SDIO_VENDOR_ID_TI_WL1251, SDIO_DEVICE_ID_TI_WL1251,
+		   add_quirk, MMC_QUIRK_DISABLE_CD),
+
+	SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
+		   add_quirk, MMC_QUIRK_NONSTD_FUNC_IF),
+
+	SDIO_FIXUP(SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
+		   add_quirk, MMC_QUIRK_DISABLE_CD),
+
+	SDIO_FIXUP(SDIO_VENDOR_ID_STE, SDIO_DEVICE_ID_STE_CW1200,
+		   add_quirk, MMC_QUIRK_BROKEN_BYTE_MODE_512),
+
+	SDIO_FIXUP(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8797_F0,
+		   add_quirk, MMC_QUIRK_BROKEN_IRQ_POLLING),
+
+	SDIO_FIXUP(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8887_F0,
+		   add_limit_rate_quirk, 150000000),
+
+	END_FIXUP
+};
+
+static const struct mmc_fixup __maybe_unused sdio_card_init_methods[] = {
+	SDIO_FIXUP_COMPATIBLE("ti,wl1251", wl1251_quirk, 0),
+
+	SDIO_FIXUP_COMPATIBLE("silabs,wf200", add_quirk,
+			      MMC_QUIRK_BROKEN_BYTE_MODE_512 |
+			      MMC_QUIRK_LENIENT_FN0 |
+			      MMC_QUIRK_BLKSZ_FOR_BYTE_MODE),
+
+	END_FIXUP
+};
+
+static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
+						 const char *compatible)
+{
+	struct device_node *np;
+
+	for_each_child_of_node(mmc_dev(card->host)->of_node, np) {
+		if (of_device_is_compatible(np, compatible)) {
+			of_node_put(np);
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static inline void mmc_fixup_device(struct mmc_card *card,
+				    const struct mmc_fixup *table)
+{
+	const struct mmc_fixup *f;
+	u64 rev = cid_rev_card(card);
+
+	for (f = table; f->vendor_fixup; f++) {
+		if (f->manfid != CID_MANFID_ANY &&
+		    f->manfid != card->cid.manfid)
+			continue;
+		if (f->oemid != CID_OEMID_ANY &&
+		    f->oemid != card->cid.oemid)
+			continue;
+		if (f->name != CID_NAME_ANY &&
+		    strncmp(f->name, card->cid.prod_name,
+			    sizeof(card->cid.prod_name)))
+			continue;
+		if (f->cis_vendor != (u16)SDIO_ANY_ID &&
+		    f->cis_vendor != card->cis.vendor)
+			continue;
+		if (f->cis_device != (u16)SDIO_ANY_ID &&
+		    f->cis_device != card->cis.device)
+			continue;
+		if (f->ext_csd_rev != EXT_CSD_REV_ANY &&
+		    f->ext_csd_rev != card->ext_csd.rev)
+			continue;
+		if (rev < f->rev_start || rev > f->rev_end)
+			continue;
+		if (f->of_compatible &&
+		    !mmc_fixup_of_compatible_match(card, f->of_compatible))
+			continue;
+		if (f->year != CID_YEAR_ANY && f->year != card->cid.year)
+			continue;
+		if (f->month != CID_MONTH_ANY && f->month != card->cid.month)
+			continue;
+
+		dev_dbg(&card->dev, "calling %ps\n", f->vendor_fixup);
+		f->vendor_fixup(card, f->data);
+	}
+}
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
new file mode 100644
index 0000000..9cfa267
--- /dev/null
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -0,0 +1,2203 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Freescale eSDHC i.MX controller driver for the platform bus.
+ *
+ * derived from the OF-version.
+ *
+ * Copyright (c) 2010 Pengutronix e.K.
+ *   Author: Wolfram Sang <kernel@pengutronix.de>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/pm_qos.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
+#include "sdhci-cqhci.h"
+#include "sdhci-pltfm.h"
+#include "sdhci-esdhc.h"
+#include "cqhci.h"
+
+#define ESDHC_SYS_CTRL_DTOCV_MASK	GENMASK(19, 16)
+#define ESDHC_SYS_CTRL_RST_FIFO		BIT(22)
+#define ESDHC_SYS_CTRL_IPP_RST_N	BIT(23)
+#define ESDHC_SYS_CTRL_RESET_TUNING	BIT(28)
+#define	ESDHC_CTRL_D3CD			0x08
+#define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
+/* VENDOR SPEC register */
+#define ESDHC_VENDOR_SPEC		0xc0
+#define  ESDHC_VENDOR_SPEC_SDIO_QUIRK	(1 << 1)
+#define  ESDHC_VENDOR_SPEC_VSELECT	(1 << 1)
+#define  ESDHC_VENDOR_SPEC_FRC_SDCLK_ON	(1 << 8)
+#define ESDHC_DEBUG_SEL_AND_STATUS_REG		0xc2
+#define ESDHC_DEBUG_SEL_REG			0xc3
+#define ESDHC_DEBUG_SEL_MASK			0xf
+#define ESDHC_DEBUG_SEL_CMD_STATE		1
+#define ESDHC_DEBUG_SEL_DATA_STATE		2
+#define ESDHC_DEBUG_SEL_TRANS_STATE		3
+#define ESDHC_DEBUG_SEL_DMA_STATE		4
+#define ESDHC_DEBUG_SEL_ADMA_STATE		5
+#define ESDHC_DEBUG_SEL_FIFO_STATE		6
+#define ESDHC_DEBUG_SEL_ASYNC_FIFO_STATE	7
+#define ESDHC_WTMK_LVL			0x44
+#define  ESDHC_WTMK_DEFAULT_VAL		0x10401040
+#define  ESDHC_WTMK_LVL_RD_WML_MASK	0x000000FF
+#define  ESDHC_WTMK_LVL_RD_WML_SHIFT	0
+#define  ESDHC_WTMK_LVL_WR_WML_MASK	0x00FF0000
+#define  ESDHC_WTMK_LVL_WR_WML_SHIFT	16
+#define  ESDHC_WTMK_LVL_WML_VAL_DEF	64
+#define  ESDHC_WTMK_LVL_WML_VAL_MAX	128
+#define ESDHC_MIX_CTRL			0x48
+#define  ESDHC_MIX_CTRL_DDREN		(1 << 3)
+#define  ESDHC_MIX_CTRL_AC23EN		(1 << 7)
+#define  ESDHC_MIX_CTRL_EXE_TUNE	(1 << 22)
+#define  ESDHC_MIX_CTRL_SMPCLK_SEL	(1 << 23)
+#define  ESDHC_MIX_CTRL_AUTO_TUNE_EN	(1 << 24)
+#define  ESDHC_MIX_CTRL_FBCLK_SEL	(1 << 25)
+#define  ESDHC_MIX_CTRL_HS400_EN	(1 << 26)
+#define  ESDHC_MIX_CTRL_HS400_ES_EN	(1 << 27)
+/* Bits 3 and 6 are not SDHCI standard definitions */
+#define  ESDHC_MIX_CTRL_SDHCI_MASK	0xb7
+/* Tuning bits */
+#define  ESDHC_MIX_CTRL_TUNING_MASK	0x03c00000
+
+/* dll control register */
+#define ESDHC_DLL_CTRL			0x60
+#define ESDHC_DLL_OVERRIDE_VAL_SHIFT	9
+#define ESDHC_DLL_OVERRIDE_EN_SHIFT	8
+
+/* tune control register */
+#define ESDHC_TUNE_CTRL_STATUS		0x68
+#define  ESDHC_TUNE_CTRL_STEP		1
+#define  ESDHC_TUNE_CTRL_MIN		0
+#define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
+#define  ESDHC_TUNE_CTRL_STATUS_TAP_SEL_MASK		GENMASK(30, 16)
+#define  ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK	GENMASK(30, 24)
+#define  ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK	GENMASK(14, 8)
+#define  ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_OUT_MASK	GENMASK(7, 4)
+#define  ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_POST_MASK	GENMASK(3, 0)
+/* strobe dll register */
+#define ESDHC_STROBE_DLL_CTRL		0x70
+#define ESDHC_STROBE_DLL_CTRL_ENABLE	(1 << 0)
+#define ESDHC_STROBE_DLL_CTRL_RESET	(1 << 1)
+#define ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT	0x7
+#define ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT	3
+#define ESDHC_STROBE_DLL_CTRL_SLV_UPDATE_INT_DEFAULT	(4 << 20)
+
+#define ESDHC_STROBE_DLL_STATUS		0x74
+#define ESDHC_STROBE_DLL_STS_REF_LOCK	(1 << 1)
+#define ESDHC_STROBE_DLL_STS_SLV_LOCK	0x1
+
+#define ESDHC_VEND_SPEC2		0xc8
+#define ESDHC_VEND_SPEC2_EN_BUSY_IRQ	(1 << 8)
+#define ESDHC_VEND_SPEC2_AUTO_TUNE_8BIT_EN	(1 << 4)
+#define ESDHC_VEND_SPEC2_AUTO_TUNE_4BIT_EN	(0 << 4)
+#define ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN	(2 << 4)
+#define ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN	(1 << 6)
+#define ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK	(7 << 4)
+
+#define ESDHC_TUNING_CTRL		0xcc
+#define ESDHC_STD_TUNING_EN		(1 << 24)
+#define ESDHC_TUNING_WINDOW_MASK	GENMASK(22, 20)
+/* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
+#define ESDHC_TUNING_START_TAP_DEFAULT	0x1
+#define ESDHC_TUNING_START_TAP_MASK	0x7f
+#define ESDHC_TUNING_CMD_CRC_CHECK_DISABLE	(1 << 7)
+#define ESDHC_TUNING_STEP_DEFAULT	0x1
+#define ESDHC_TUNING_STEP_MASK		0x00070000
+#define ESDHC_TUNING_STEP_SHIFT		16
+
+/* pinctrl state */
+#define ESDHC_PINCTRL_STATE_100MHZ	"state_100mhz"
+#define ESDHC_PINCTRL_STATE_200MHZ	"state_200mhz"
+
+/*
+ * Our interpretation of the SDHCI_HOST_CONTROL register
+ */
+#define ESDHC_CTRL_4BITBUS		(0x1 << 1)
+#define ESDHC_CTRL_8BITBUS		(0x2 << 1)
+#define ESDHC_CTRL_BUSWIDTH_MASK	(0x3 << 1)
+#define USDHC_GET_BUSWIDTH(c) (c & ESDHC_CTRL_BUSWIDTH_MASK)
+
+/*
+ * There is an INT DMA ERR mismatch between eSDHC and STD SDHC SPEC:
+ * Bit25 is used in STD SPEC, and is reserved in fsl eSDHC design,
+ * but bit28 is used as the INT DMA ERR in fsl eSDHC design.
+ * Define this macro DMA error INT for fsl eSDHC
+ */
+#define ESDHC_INT_VENDOR_SPEC_DMA_ERR	(1 << 28)
+
+/* the address offset of CQHCI */
+#define ESDHC_CQHCI_ADDR_OFFSET		0x100
+
+/*
+ * The CMDTYPE of the CMD register (offset 0xE) should be set to
+ * "11" when the STOP CMD12 is issued on imx53 to abort one
+ * open ended multi-blk IO. Otherwise the TC INT wouldn't
+ * be generated.
+ * In exact block transfer, the controller doesn't complete the
+ * operations automatically as required at the end of the
+ * transfer and remains on hold if the abort command is not sent.
+ * As a result, the TC flag is not asserted and SW received timeout
+ * exception. Bit1 of Vendor Spec register is used to fix it.
+ */
+#define ESDHC_FLAG_MULTIBLK_NO_INT	BIT(1)
+/*
+ * The flag tells that the ESDHC controller is an USDHC block that is
+ * integrated on the i.MX6 series.
+ */
+#define ESDHC_FLAG_USDHC		BIT(3)
+/* The IP supports manual tuning process */
+#define ESDHC_FLAG_MAN_TUNING		BIT(4)
+/* The IP supports standard tuning process */
+#define ESDHC_FLAG_STD_TUNING		BIT(5)
+/* The IP has SDHCI_CAPABILITIES_1 register */
+#define ESDHC_FLAG_HAVE_CAP1		BIT(6)
+/*
+ * The IP has erratum ERR004536
+ * uSDHC: ADMA Length Mismatch Error occurs if the AHB read access is slow,
+ * when reading data from the card
+ * This flag is also set for i.MX25 and i.MX35 in order to get
+ * SDHCI_QUIRK_BROKEN_ADMA, but for different reasons (ADMA capability bits).
+ */
+#define ESDHC_FLAG_ERR004536		BIT(7)
+/* The IP supports HS200 mode */
+#define ESDHC_FLAG_HS200		BIT(8)
+/* The IP supports HS400 mode */
+#define ESDHC_FLAG_HS400		BIT(9)
+/*
+ * The IP has errata ERR010450
+ * uSDHC: At 1.8V due to the I/O timing limit, for SDR mode, SD card
+ * clock can't exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
+ */
+#define ESDHC_FLAG_ERR010450		BIT(10)
+/* The IP supports HS400ES mode */
+#define ESDHC_FLAG_HS400_ES		BIT(11)
+/* The IP has Host Controller Interface for Command Queuing */
+#define ESDHC_FLAG_CQHCI		BIT(12)
+/* need request pmqos during low power */
+#define ESDHC_FLAG_PMQOS		BIT(13)
+/* The IP state got lost in low power mode */
+#define ESDHC_FLAG_STATE_LOST_IN_LPMODE		BIT(14)
+/* The IP lost clock rate in PM_RUNTIME */
+#define ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME	BIT(15)
+/*
+ * The IP do not support the ACMD23 feature completely when use ADMA mode.
+ * In ADMA mode, it only use the 16 bit block count of the register 0x4
+ * (BLOCK_ATT) as the CMD23's argument for ACMD23 mode, which means it will
+ * ignore the upper 16 bit of the CMD23's argument. This will block the reliable
+ * write operation in RPMB, because RPMB reliable write need to set the bit31
+ * of the CMD23's argument.
+ * imx6qpdl/imx6sx/imx6sl/imx7d has this limitation only for ADMA mode, SDMA
+ * do not has this limitation. so when these SoC use ADMA mode, it need to
+ * disable the ACMD23 feature.
+ */
+#define ESDHC_FLAG_BROKEN_AUTO_CMD23	BIT(16)
+
+/* ERR004536 is not applicable for the IP  */
+#define ESDHC_FLAG_SKIP_ERR004536	BIT(17)
+
+/* The IP does not have GPIO CD wake capabilities */
+#define ESDHC_FLAG_SKIP_CD_WAKE		BIT(18)
+
+/* the controller has dummy pad for clock loopback */
+#define ESDHC_FLAG_DUMMY_PAD		BIT(19)
+
+#define ESDHC_AUTO_TUNING_WINDOW	3
+
+enum wp_types {
+	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
+	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
+	ESDHC_WP_GPIO,		/* external gpio pin for WP */
+};
+
+enum cd_types {
+	ESDHC_CD_NONE,		/* no CD, neither controller nor gpio */
+	ESDHC_CD_CONTROLLER,	/* mmc controller internal CD */
+	ESDHC_CD_GPIO,		/* external gpio pin for CD */
+	ESDHC_CD_PERMANENT,	/* no CD, card permanently wired to host */
+};
+
+/*
+ * struct esdhc_platform_data - platform data for esdhc on i.MX
+ *
+ * ESDHC_WP(CD)_CONTROLLER type is not available on i.MX25/35.
+ *
+ * @wp_type:	type of write_protect method (see wp_types enum above)
+ * @cd_type:	type of card_detect method (see cd_types enum above)
+ */
+
+struct esdhc_platform_data {
+	enum wp_types wp_type;
+	enum cd_types cd_type;
+	int max_bus_width;
+	unsigned int delay_line;
+	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
+	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
+	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
+	unsigned int saved_tuning_delay_cell;	/* save the value of tuning delay cell */
+	unsigned int saved_auto_tuning_window;  /* save the auto tuning window width */
+};
+
+struct esdhc_soc_data {
+	u32 flags;
+	u32 quirks;
+};
+
+static const struct esdhc_soc_data esdhc_imx25_35_data = {
+	.flags = ESDHC_FLAG_ERR004536,
+};
+
+static const struct esdhc_soc_data esdhc_imx51_data = {
+	.flags = 0,
+};
+
+static const struct esdhc_soc_data esdhc_imx53_data = {
+	.flags = ESDHC_FLAG_MULTIBLK_NO_INT,
+};
+
+static const struct esdhc_soc_data usdhc_imx6q_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
+};
+
+static const struct esdhc_soc_data usdhc_imx6sl_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
+			| ESDHC_FLAG_HS200
+			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
+};
+
+static const struct esdhc_soc_data usdhc_imx6sll_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_HS400
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
+};
+
+static const struct esdhc_soc_data usdhc_imx6sx_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
+			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
+};
+
+static const struct esdhc_soc_data usdhc_imx6ull_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_ERR010450
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
+};
+
+static const struct esdhc_soc_data usdhc_imx7d_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_HS400
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
+			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
+};
+
+static struct esdhc_soc_data usdhc_s32g2_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
+			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
+	.quirks = SDHCI_QUIRK_NO_LED,
+};
+
+static struct esdhc_soc_data usdhc_imx7ulp_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
+	.quirks = SDHCI_QUIRK_NO_LED,
+};
+static struct esdhc_soc_data usdhc_imxrt1050_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
+	.quirks = SDHCI_QUIRK_NO_LED,
+};
+
+static struct esdhc_soc_data usdhc_imx8qxp_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
+			| ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME,
+	.quirks = SDHCI_QUIRK_NO_LED,
+};
+
+static struct esdhc_soc_data usdhc_imx8mm_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
+	.quirks = SDHCI_QUIRK_NO_LED,
+};
+
+static struct esdhc_soc_data usdhc_imx95_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
+			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
+			| ESDHC_FLAG_DUMMY_PAD,
+	.quirks = SDHCI_QUIRK_NO_LED,
+};
+
+struct pltfm_imx_data {
+	u32 scratchpad;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_100mhz;
+	struct pinctrl_state *pins_200mhz;
+	const struct esdhc_soc_data *socdata;
+	struct esdhc_platform_data boarddata;
+	struct clk *clk_ipg;
+	struct clk *clk_ahb;
+	struct clk *clk_per;
+	unsigned int actual_clock;
+
+	/*
+	 * USDHC has one limition, require the SDIO device a different
+	 * register setting. Driver has to recognize card type during
+	 * the card init, but at this stage, mmc_host->card is not
+	 * available. So involve this field to save the card type
+	 * during card init through usdhc_init_card().
+	 */
+	unsigned int init_card_type;
+
+	enum {
+		NO_CMD_PENDING,      /* no multiblock command pending */
+		MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process */
+		WAIT_FOR_INT,        /* sent CMD12, waiting for response INT */
+	} multiblock_status;
+	u32 is_ddr;
+	struct pm_qos_request pm_qos_req;
+};
+
+static const struct of_device_id imx_esdhc_dt_ids[] = {
+	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_35_data, },
+	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx25_35_data, },
+	{ .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
+	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
+	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
+	{ .compatible = "fsl,imx6sl-usdhc", .data = &usdhc_imx6sl_data, },
+	{ .compatible = "fsl,imx6sll-usdhc", .data = &usdhc_imx6sll_data, },
+	{ .compatible = "fsl,imx6q-usdhc", .data = &usdhc_imx6q_data, },
+	{ .compatible = "fsl,imx6ull-usdhc", .data = &usdhc_imx6ull_data, },
+	{ .compatible = "fsl,imx7d-usdhc", .data = &usdhc_imx7d_data, },
+	{ .compatible = "fsl,imx7ulp-usdhc", .data = &usdhc_imx7ulp_data, },
+	{ .compatible = "fsl,imx8qxp-usdhc", .data = &usdhc_imx8qxp_data, },
+	{ .compatible = "fsl,imx8mm-usdhc", .data = &usdhc_imx8mm_data, },
+	{ .compatible = "fsl,imx94-usdhc", .data = &usdhc_imx95_data, },
+	{ .compatible = "fsl,imx95-usdhc", .data = &usdhc_imx95_data, },
+	{ .compatible = "fsl,imxrt1050-usdhc", .data = &usdhc_imxrt1050_data, },
+	{ .compatible = "nxp,s32g2-usdhc", .data = &usdhc_s32g2_data, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
+
+static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
+{
+	return data->socdata == &esdhc_imx25_35_data;
+}
+
+static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
+{
+	return data->socdata == &esdhc_imx53_data;
+}
+
+static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)
+{
+	return !!(data->socdata->flags & ESDHC_FLAG_USDHC);
+}
+
+static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
+{
+	void __iomem *base = host->ioaddr + (reg & ~0x3);
+	u32 shift = (reg & 0x3) * 8;
+
+	writel(((readl(base) & ~(mask << shift)) | (val << shift)), base);
+}
+
+#define DRIVER_NAME "sdhci-esdhc-imx"
+#define ESDHC_IMX_DUMP(f, x...) \
+	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
+static void esdhc_dump_debug_regs(struct sdhci_host *host)
+{
+	int i;
+	char *debug_status[7] = {
+				 "cmd debug status",
+				 "data debug status",
+				 "trans debug status",
+				 "dma debug status",
+				 "adma debug status",
+				 "fifo debug status",
+				 "async fifo debug status"
+	};
+
+	ESDHC_IMX_DUMP("========= ESDHC IMX DEBUG STATUS DUMP =========\n");
+	for (i = 0; i < 7; i++) {
+		esdhc_clrset_le(host, ESDHC_DEBUG_SEL_MASK,
+			ESDHC_DEBUG_SEL_CMD_STATE + i, ESDHC_DEBUG_SEL_REG);
+		ESDHC_IMX_DUMP("%s:  0x%04x\n", debug_status[i],
+			readw(host->ioaddr + ESDHC_DEBUG_SEL_AND_STATUS_REG));
+	}
+
+	esdhc_clrset_le(host, ESDHC_DEBUG_SEL_MASK, 0, ESDHC_DEBUG_SEL_REG);
+
+}
+
+static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
+{
+	u32 present_state;
+	int ret;
+
+	ret = readl_poll_timeout(host->ioaddr + ESDHC_PRSSTAT, present_state,
+				(present_state & ESDHC_CLOCK_GATE_OFF), 2, 100);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc), "%s: card clock still not gate off in 100us!.\n", __func__);
+}
+
+/* Enable the auto tuning circuit to check the CMD line and BUS line */
+static inline void usdhc_auto_tuning_mode_sel_and_en(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 buswidth, auto_tune_buswidth;
+	u32 reg;
+
+	buswidth = USDHC_GET_BUSWIDTH(readl(host->ioaddr + SDHCI_HOST_CONTROL));
+
+	switch (buswidth) {
+	case ESDHC_CTRL_8BITBUS:
+		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_8BIT_EN;
+		break;
+	case ESDHC_CTRL_4BITBUS:
+		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_4BIT_EN;
+		break;
+	default:	/* 1BITBUS */
+		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN;
+		break;
+	}
+
+	/*
+	 * For USDHC, auto tuning circuit can not handle the async sdio
+	 * device interrupt correctly. When sdio device use 4 data lines,
+	 * async sdio interrupt will use the shared DAT[1], if enable auto
+	 * tuning circuit check these 4 data lines, include the DAT[1],
+	 * this circuit will detect this interrupt, take this as a data on
+	 * DAT[1], and adjust the delay cell wrongly.
+	 * This is the hardware design limitation, to avoid this, for sdio
+	 * device, config the auto tuning circuit only check DAT[0] and CMD
+	 * line.
+	 */
+	if (imx_data->init_card_type == MMC_TYPE_SDIO)
+		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN;
+
+	esdhc_clrset_le(host, ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
+			auto_tune_buswidth | ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
+			ESDHC_VEND_SPEC2);
+
+	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
+	reg |= ESDHC_MIX_CTRL_AUTO_TUNE_EN;
+	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
+}
+
+static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 val = readl(host->ioaddr + reg);
+
+	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
+		u32 fsl_prss = val;
+		/* save the least 20 bits */
+		val = fsl_prss & 0x000FFFFF;
+		/* move dat[0-3] bits */
+		val |= (fsl_prss & 0x0F000000) >> 4;
+		/* move cmd line bit */
+		val |= (fsl_prss & 0x00800000) << 1;
+	}
+
+	if (unlikely(reg == SDHCI_CAPABILITIES)) {
+		/* ignore bit[0-15] as it stores cap_1 register val for mx6sl */
+		if (imx_data->socdata->flags & ESDHC_FLAG_HAVE_CAP1)
+			val &= 0xffff0000;
+
+		/* In FSL esdhc IC module, only bit20 is used to indicate the
+		 * ADMA2 capability of esdhc, but this bit is messed up on
+		 * some SOCs (e.g. on MX25, MX35 this bit is set, but they
+		 * don't actually support ADMA2). So set the BROKEN_ADMA
+		 * quirk on MX25/35 platforms.
+		 */
+
+		if (val & SDHCI_CAN_DO_ADMA1) {
+			val &= ~SDHCI_CAN_DO_ADMA1;
+			val |= SDHCI_CAN_DO_ADMA2;
+		}
+	}
+
+	if (unlikely(reg == SDHCI_CAPABILITIES_1)) {
+		if (esdhc_is_usdhc(imx_data)) {
+			if (imx_data->socdata->flags & ESDHC_FLAG_HAVE_CAP1)
+				val = readl(host->ioaddr + SDHCI_CAPABILITIES) & 0xFFFF;
+			else
+				/* imx6q/dl does not have cap_1 register, fake one */
+				val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
+					| SDHCI_SUPPORT_SDR50
+					| SDHCI_USE_SDR50_TUNING
+					| FIELD_PREP(SDHCI_RETUNING_MODE_MASK,
+						     SDHCI_TUNING_MODE_3);
+
+			/*
+			 * Do not advertise faster UHS modes if there are no
+			 * pinctrl states for 100MHz/200MHz.
+			 */
+			if (IS_ERR_OR_NULL(imx_data->pins_100mhz))
+				val &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
+			if (IS_ERR_OR_NULL(imx_data->pins_200mhz))
+				val &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_HS400);
+		}
+	}
+
+	if (unlikely(reg == SDHCI_MAX_CURRENT) && esdhc_is_usdhc(imx_data)) {
+		val = 0;
+		val |= FIELD_PREP(SDHCI_MAX_CURRENT_330_MASK, 0xFF);
+		val |= FIELD_PREP(SDHCI_MAX_CURRENT_300_MASK, 0xFF);
+		val |= FIELD_PREP(SDHCI_MAX_CURRENT_180_MASK, 0xFF);
+	}
+
+	if (unlikely(reg == SDHCI_INT_STATUS)) {
+		if (val & ESDHC_INT_VENDOR_SPEC_DMA_ERR) {
+			val &= ~ESDHC_INT_VENDOR_SPEC_DMA_ERR;
+			val |= SDHCI_INT_ADMA_ERROR;
+		}
+
+		/*
+		 * mask off the interrupt we get in response to the manually
+		 * sent CMD12
+		 */
+		if ((imx_data->multiblock_status == WAIT_FOR_INT) &&
+		    ((val & SDHCI_INT_RESPONSE) == SDHCI_INT_RESPONSE)) {
+			val &= ~SDHCI_INT_RESPONSE;
+			writel(SDHCI_INT_RESPONSE, host->ioaddr +
+						   SDHCI_INT_STATUS);
+			imx_data->multiblock_status = NO_CMD_PENDING;
+		}
+	}
+
+	return val;
+}
+
+static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 data;
+
+	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE ||
+			reg == SDHCI_INT_STATUS)) {
+		if ((val & SDHCI_INT_CARD_INT) && !esdhc_is_usdhc(imx_data)) {
+			/*
+			 * Clear and then set D3CD bit to avoid missing the
+			 * card interrupt. This is an eSDHC controller problem
+			 * so we need to apply the following workaround: clear
+			 * and set D3CD bit will make eSDHC re-sample the card
+			 * interrupt. In case a card interrupt was lost,
+			 * re-sample it by the following steps.
+			 */
+			data = readl(host->ioaddr + SDHCI_HOST_CONTROL);
+			data &= ~ESDHC_CTRL_D3CD;
+			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
+			data |= ESDHC_CTRL_D3CD;
+			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
+		}
+
+		if (val & SDHCI_INT_ADMA_ERROR) {
+			val &= ~SDHCI_INT_ADMA_ERROR;
+			val |= ESDHC_INT_VENDOR_SPEC_DMA_ERR;
+		}
+	}
+
+	if (unlikely((imx_data->socdata->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
+				&& (reg == SDHCI_INT_STATUS)
+				&& (val & SDHCI_INT_DATA_END))) {
+			u32 v;
+			v = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
+			v &= ~ESDHC_VENDOR_SPEC_SDIO_QUIRK;
+			writel(v, host->ioaddr + ESDHC_VENDOR_SPEC);
+
+			if (imx_data->multiblock_status == MULTIBLK_IN_PROCESS)
+			{
+				/* send a manual CMD12 with RESPTYP=none */
+				data = MMC_STOP_TRANSMISSION << 24 |
+				       SDHCI_CMD_ABORTCMD << 16;
+				writel(data, host->ioaddr + SDHCI_TRANSFER_MODE);
+				imx_data->multiblock_status = WAIT_FOR_INT;
+			}
+	}
+
+	writel(val, host->ioaddr + reg);
+}
+
+static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u16 ret = 0;
+	u32 val;
+
+	if (unlikely(reg == SDHCI_HOST_VERSION)) {
+		reg ^= 2;
+		if (esdhc_is_usdhc(imx_data)) {
+			/*
+			 * The usdhc register returns a wrong host version.
+			 * Correct it here.
+			 */
+			return SDHCI_SPEC_300;
+		}
+	}
+
+	if (unlikely(reg == SDHCI_HOST_CONTROL2)) {
+		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
+		if (val & ESDHC_VENDOR_SPEC_VSELECT)
+			ret |= SDHCI_CTRL_VDD_180;
+
+		if (esdhc_is_usdhc(imx_data)) {
+			if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
+				val = readl(host->ioaddr + ESDHC_MIX_CTRL);
+			else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING)
+				/* the std tuning bits is in ACMD12_ERR for imx6sl */
+				val = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
+		}
+
+		if (val & ESDHC_MIX_CTRL_EXE_TUNE)
+			ret |= SDHCI_CTRL_EXEC_TUNING;
+		if (val & ESDHC_MIX_CTRL_SMPCLK_SEL)
+			ret |= SDHCI_CTRL_TUNED_CLK;
+
+		ret &= ~SDHCI_CTRL_PRESET_VAL_ENABLE;
+
+		return ret;
+	}
+
+	if (unlikely(reg == SDHCI_TRANSFER_MODE)) {
+		if (esdhc_is_usdhc(imx_data)) {
+			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
+			ret = m & ESDHC_MIX_CTRL_SDHCI_MASK;
+			/* Swap AC23 bit */
+			if (m & ESDHC_MIX_CTRL_AC23EN) {
+				ret &= ~ESDHC_MIX_CTRL_AC23EN;
+				ret |= SDHCI_TRNS_AUTO_CMD23;
+			}
+		} else {
+			ret = readw(host->ioaddr + SDHCI_TRANSFER_MODE);
+		}
+
+		return ret;
+	}
+
+	return readw(host->ioaddr + reg);
+}
+
+static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 new_val = 0;
+
+	switch (reg) {
+	case SDHCI_CLOCK_CONTROL:
+		new_val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
+		if (val & SDHCI_CLOCK_CARD_EN)
+			new_val |= ESDHC_VENDOR_SPEC_FRC_SDCLK_ON;
+		else
+			new_val &= ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON;
+		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
+		if (!(new_val & ESDHC_VENDOR_SPEC_FRC_SDCLK_ON))
+			esdhc_wait_for_card_clock_gate_off(host);
+		return;
+	case SDHCI_HOST_CONTROL2:
+		new_val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
+		if (val & SDHCI_CTRL_VDD_180)
+			new_val |= ESDHC_VENDOR_SPEC_VSELECT;
+		else
+			new_val &= ~ESDHC_VENDOR_SPEC_VSELECT;
+		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
+		if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
+			u32 v = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
+			if (val & SDHCI_CTRL_TUNED_CLK)
+				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
+			else
+				v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+
+			if (val & SDHCI_CTRL_EXEC_TUNING)
+				v |= ESDHC_MIX_CTRL_EXE_TUNE;
+			else
+				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
+
+			writel(v, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
+		}
+		return;
+	case SDHCI_TRANSFER_MODE:
+		if ((imx_data->socdata->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
+				&& (host->cmd->opcode == SD_IO_RW_EXTENDED)
+				&& (host->cmd->data->blocks > 1)
+				&& (host->cmd->data->flags & MMC_DATA_READ)) {
+			u32 v;
+			v = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
+			v |= ESDHC_VENDOR_SPEC_SDIO_QUIRK;
+			writel(v, host->ioaddr + ESDHC_VENDOR_SPEC);
+		}
+
+		if (esdhc_is_usdhc(imx_data)) {
+			u32 wml;
+			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
+			/* Swap AC23 bit */
+			if (val & SDHCI_TRNS_AUTO_CMD23) {
+				val &= ~SDHCI_TRNS_AUTO_CMD23;
+				val |= ESDHC_MIX_CTRL_AC23EN;
+			}
+			m = val | (m & ~ESDHC_MIX_CTRL_SDHCI_MASK);
+			writel(m, host->ioaddr + ESDHC_MIX_CTRL);
+
+			/* Set watermark levels for PIO access to maximum value
+			 * (128 words) to accommodate full 512 bytes buffer.
+			 * For DMA access restore the levels to default value.
+			 */
+			m = readl(host->ioaddr + ESDHC_WTMK_LVL);
+			if (val & SDHCI_TRNS_DMA) {
+				wml = ESDHC_WTMK_LVL_WML_VAL_DEF;
+			} else {
+				u8 ctrl;
+				wml = ESDHC_WTMK_LVL_WML_VAL_MAX;
+
+				/*
+				 * Since already disable DMA mode, so also need
+				 * to clear the DMASEL. Otherwise, for standard
+				 * tuning, when send tuning command, usdhc will
+				 * still prefetch the ADMA script from wrong
+				 * DMA address, then we will see IOMMU report
+				 * some error which show lack of TLB mapping.
+				 */
+				ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+				ctrl &= ~SDHCI_CTRL_DMA_MASK;
+				sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+			}
+			m &= ~(ESDHC_WTMK_LVL_RD_WML_MASK |
+			       ESDHC_WTMK_LVL_WR_WML_MASK);
+			m |= (wml << ESDHC_WTMK_LVL_RD_WML_SHIFT) |
+			     (wml << ESDHC_WTMK_LVL_WR_WML_SHIFT);
+			writel(m, host->ioaddr + ESDHC_WTMK_LVL);
+		} else {
+			/*
+			 * Postpone this write, we must do it together with a
+			 * command write that is down below.
+			 */
+			imx_data->scratchpad = val;
+		}
+		return;
+	case SDHCI_COMMAND:
+		if (host->cmd->opcode == MMC_STOP_TRANSMISSION)
+			val |= SDHCI_CMD_ABORTCMD;
+
+		if ((host->cmd->opcode == MMC_SET_BLOCK_COUNT) &&
+		    (imx_data->socdata->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
+			imx_data->multiblock_status = MULTIBLK_IN_PROCESS;
+
+		if (esdhc_is_usdhc(imx_data))
+			writel(val << 16,
+			       host->ioaddr + SDHCI_TRANSFER_MODE);
+		else
+			writel(val << 16 | imx_data->scratchpad,
+			       host->ioaddr + SDHCI_TRANSFER_MODE);
+		return;
+	case SDHCI_BLOCK_SIZE:
+		val &= ~SDHCI_MAKE_BLKSZ(0x7, 0);
+		break;
+	}
+	esdhc_clrset_le(host, 0xffff, val, reg);
+}
+
+static u8 esdhc_readb_le(struct sdhci_host *host, int reg)
+{
+	u8 ret;
+	u32 val;
+
+	switch (reg) {
+	case SDHCI_HOST_CONTROL:
+		val = readl(host->ioaddr + reg);
+
+		ret = val & SDHCI_CTRL_LED;
+		ret |= (val >> 5) & SDHCI_CTRL_DMA_MASK;
+		ret |= (val & ESDHC_CTRL_4BITBUS);
+		ret |= (val & ESDHC_CTRL_8BITBUS) << 3;
+		return ret;
+	}
+
+	return readb(host->ioaddr + reg);
+}
+
+static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 new_val = 0;
+	u32 mask;
+
+	switch (reg) {
+	case SDHCI_POWER_CONTROL:
+		/*
+		 * FSL put some DMA bits here
+		 * If your board has a regulator, code should be here
+		 */
+		return;
+	case SDHCI_HOST_CONTROL:
+		/* FSL messed up here, so we need to manually compose it. */
+		new_val = val & SDHCI_CTRL_LED;
+		/* ensure the endianness */
+		new_val |= ESDHC_HOST_CONTROL_LE;
+		/* bits 8&9 are reserved on mx25 */
+		if (!is_imx25_esdhc(imx_data)) {
+			/* DMA mode bits are shifted */
+			new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
+		}
+
+		/*
+		 * Do not touch buswidth bits here. This is done in
+		 * esdhc_pltfm_bus_width.
+		 * Do not touch the D3CD bit either which is used for the
+		 * SDIO interrupt erratum workaround.
+		 */
+		mask = 0xffff & ~(ESDHC_CTRL_BUSWIDTH_MASK | ESDHC_CTRL_D3CD);
+
+		esdhc_clrset_le(host, mask, new_val, reg);
+		return;
+	case SDHCI_TIMEOUT_CONTROL:
+		esdhc_clrset_le(host, ESDHC_SYS_CTRL_DTOCV_MASK,
+				FIELD_PREP(ESDHC_SYS_CTRL_DTOCV_MASK, val),
+				ESDHC_SYSTEM_CONTROL);
+		return;
+	case SDHCI_SOFTWARE_RESET:
+		if (val & SDHCI_RESET_DATA)
+			new_val = readl(host->ioaddr + SDHCI_HOST_CONTROL);
+		break;
+	}
+	esdhc_clrset_le(host, 0xff, val, reg);
+
+	if (reg == SDHCI_SOFTWARE_RESET) {
+		if (val & SDHCI_RESET_ALL) {
+			/*
+			 * The esdhc has a design violation to SDHC spec which
+			 * tells that software reset should not affect card
+			 * detection circuit. But esdhc clears its SYSCTL
+			 * register bits [0..2] during the software reset. This
+			 * will stop those clocks that card detection circuit
+			 * relies on. To work around it, we turn the clocks on
+			 * back to keep card detection circuit functional.
+			 */
+			esdhc_clrset_le(host, 0x7, 0x7, ESDHC_SYSTEM_CONTROL);
+			/*
+			 * The reset on usdhc fails to clear MIX_CTRL register.
+			 * Do it manually here.
+			 */
+			if (esdhc_is_usdhc(imx_data)) {
+				/*
+				 * the tuning bits should be kept during reset
+				 */
+				new_val = readl(host->ioaddr + ESDHC_MIX_CTRL);
+				writel(new_val & ESDHC_MIX_CTRL_TUNING_MASK,
+						host->ioaddr + ESDHC_MIX_CTRL);
+				imx_data->is_ddr = 0;
+			}
+		} else if (val & SDHCI_RESET_DATA) {
+			/*
+			 * The eSDHC DAT line software reset clears at least the
+			 * data transfer width on i.MX25, so make sure that the
+			 * Host Control register is unaffected.
+			 */
+			esdhc_clrset_le(host, 0xff, new_val,
+					SDHCI_HOST_CONTROL);
+		}
+	}
+}
+
+static unsigned int esdhc_pltfm_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return pltfm_host->clock;
+}
+
+static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return pltfm_host->clock / 256 / 16;
+}
+
+static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
+					 unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	unsigned int host_clock = pltfm_host->clock;
+	int ddr_pre_div = imx_data->is_ddr ? 2 : 1;
+	int pre_div = 1;
+	int div = 1;
+	int ret;
+	u32 temp, val;
+
+	if (esdhc_is_usdhc(imx_data)) {
+		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
+		writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
+			host->ioaddr + ESDHC_VENDOR_SPEC);
+		esdhc_wait_for_card_clock_gate_off(host);
+	}
+
+	if (clock == 0) {
+		host->mmc->actual_clock = 0;
+		return;
+	}
+
+	/* For i.MX53 eSDHCv3, SYSCTL.SDCLKFS may not be set to 0. */
+	if (is_imx53_esdhc(imx_data)) {
+		/*
+		 * According to the i.MX53 reference manual, if DLLCTRL[10] can
+		 * be set, then the controller is eSDHCv3, else it is eSDHCv2.
+		 */
+		val = readl(host->ioaddr + ESDHC_DLL_CTRL);
+		writel(val | BIT(10), host->ioaddr + ESDHC_DLL_CTRL);
+		temp = readl(host->ioaddr + ESDHC_DLL_CTRL);
+		writel(val, host->ioaddr + ESDHC_DLL_CTRL);
+		if (temp & BIT(10))
+			pre_div = 2;
+	}
+
+	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
+	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
+		| ESDHC_CLOCK_MASK);
+	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+
+	if ((imx_data->socdata->flags & ESDHC_FLAG_ERR010450) &&
+	    (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))) {
+		unsigned int max_clock;
+
+		max_clock = imx_data->is_ddr ? 45000000 : 150000000;
+
+		clock = min(clock, max_clock);
+	}
+
+	while (host_clock / (16 * pre_div * ddr_pre_div) > clock &&
+			pre_div < 256)
+		pre_div *= 2;
+
+	while (host_clock / (div * pre_div * ddr_pre_div) > clock && div < 16)
+		div++;
+
+	host->mmc->actual_clock = host_clock / (div * pre_div * ddr_pre_div);
+	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
+		clock, host->mmc->actual_clock);
+
+	pre_div >>= 1;
+	div--;
+
+	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
+	temp |= (ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
+		| (div << ESDHC_DIVIDER_SHIFT)
+		| (pre_div << ESDHC_PREDIV_SHIFT));
+	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+
+	/* need to wait the bit 3 of the PRSSTAT to be set, make sure card clock is stable */
+	ret = readl_poll_timeout(host->ioaddr + ESDHC_PRSSTAT, temp,
+				(temp & ESDHC_CLOCK_STABLE), 2, 100);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc), "card clock still not stable in 100us!.\n");
+
+	if (esdhc_is_usdhc(imx_data)) {
+		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
+		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
+			host->ioaddr + ESDHC_VENDOR_SPEC);
+	}
+
+}
+
+static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
+
+	switch (boarddata->wp_type) {
+	case ESDHC_WP_GPIO:
+		return mmc_gpio_get_ro(host->mmc);
+	case ESDHC_WP_CONTROLLER:
+		return !(readl(host->ioaddr + SDHCI_PRESENT_STATE) &
+			       SDHCI_WRITE_PROTECT);
+	case ESDHC_WP_NONE:
+		break;
+	}
+
+	return -ENOSYS;
+}
+
+static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
+{
+	u32 ctrl;
+
+	switch (width) {
+	case MMC_BUS_WIDTH_8:
+		ctrl = ESDHC_CTRL_8BITBUS;
+		break;
+	case MMC_BUS_WIDTH_4:
+		ctrl = ESDHC_CTRL_4BITBUS;
+		break;
+	default:
+		ctrl = 0;
+		break;
+	}
+
+	esdhc_clrset_le(host, ESDHC_CTRL_BUSWIDTH_MASK, ctrl,
+			SDHCI_HOST_CONTROL);
+}
+
+static void esdhc_reset_tuning(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 ctrl, tuning_ctrl, sys_ctrl;
+	int ret;
+
+	/* Reset the tuning circuit */
+	if (esdhc_is_usdhc(imx_data)) {
+		ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
+		ctrl &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
+		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
+			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
+			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
+			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
+			/*
+			 * enable the std tuning just in case it cleared in
+			 * sdhc_esdhc_tuning_restore.
+			 */
+			tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
+			if (!(tuning_ctrl & ESDHC_STD_TUNING_EN)) {
+				tuning_ctrl |= ESDHC_STD_TUNING_EN;
+				writel(tuning_ctrl, host->ioaddr + ESDHC_TUNING_CTRL);
+			}
+
+			/* set the reset tuning bit */
+			sys_ctrl = readl(host->ioaddr + ESDHC_SYSTEM_CONTROL);
+			sys_ctrl |= ESDHC_SYS_CTRL_RESET_TUNING;
+			writel(sys_ctrl, host->ioaddr + ESDHC_SYSTEM_CONTROL);
+
+			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
+			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
+			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
+			writel(ctrl, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
+			/* Make sure ESDHC_MIX_CTRL_EXE_TUNE cleared */
+			ret = readl_poll_timeout(host->ioaddr + SDHCI_AUTO_CMD_STATUS,
+				ctrl, !(ctrl & ESDHC_MIX_CTRL_EXE_TUNE), 1, 50);
+			if (ret == -ETIMEDOUT)
+				dev_warn(mmc_dev(host->mmc),
+				 "Warning! clear execute tuning bit failed\n");
+			/*
+			 * SDHCI_INT_DATA_AVAIL is W1C bit, set this bit will clear the
+			 * usdhc IP internal logic flag execute_tuning_with_clr_buf, which
+			 * will finally make sure the normal data transfer logic correct.
+			 */
+			ctrl = readl(host->ioaddr + SDHCI_INT_STATUS);
+			ctrl |= SDHCI_INT_DATA_AVAIL;
+			writel(ctrl, host->ioaddr + SDHCI_INT_STATUS);
+		}
+	}
+}
+
+static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+
+	imx_data->init_card_type = card->type;
+}
+
+static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int err;
+
+	/*
+	 * i.MX uSDHC internally already uses a fixed optimized timing for
+	 * DDR50, normally does not require tuning for DDR50 mode.
+	 */
+	if (host->timing == MMC_TIMING_UHS_DDR50)
+		return 0;
+
+	/*
+	 * Reset tuning circuit logic. If not, the previous tuning result
+	 * will impact current tuning, make current tuning can't set the
+	 * correct delay cell.
+	 */
+	esdhc_reset_tuning(host);
+	err = sdhci_execute_tuning(mmc, opcode);
+	/* If tuning done, enable auto tuning */
+	if (!err && !host->tuning_err)
+		usdhc_auto_tuning_mode_sel_and_en(host);
+
+	return err;
+}
+
+static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
+{
+	u32 reg, sys_ctrl;
+	u8 sw_rst;
+	int ret;
+
+	/* FIXME: delay a bit for card to be ready for next tuning due to errors */
+	mdelay(1);
+
+	/* IC suggest to reset USDHC before every tuning command */
+	esdhc_clrset_le(host, 0xff, SDHCI_RESET_ALL, SDHCI_SOFTWARE_RESET);
+	ret = readb_poll_timeout(host->ioaddr + SDHCI_SOFTWARE_RESET, sw_rst,
+				!(sw_rst & SDHCI_RESET_ALL), 10, 100);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc),
+		"warning! RESET_ALL never complete before sending tuning command\n");
+
+	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
+	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL;
+	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
+	writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK, val),
+	       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+	dev_dbg(mmc_dev(host->mmc),
+		"tuning with delay 0x%x ESDHC_TUNE_CTRL_STATUS 0x%x\n",
+			val, readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS));
+
+	/* set RST_FIFO to reset the async FIFO, and wat it to self-clear */
+	sys_ctrl = readl(host->ioaddr + ESDHC_SYSTEM_CONTROL);
+	sys_ctrl |= ESDHC_SYS_CTRL_RST_FIFO;
+	writel(sys_ctrl, host->ioaddr + ESDHC_SYSTEM_CONTROL);
+	ret = readl_poll_timeout(host->ioaddr + ESDHC_SYSTEM_CONTROL, sys_ctrl,
+				 !(sys_ctrl & ESDHC_SYS_CTRL_RST_FIFO), 10, 100);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc),
+			 "warning! RST_FIFO not clear in 100us\n");
+}
+
+static void esdhc_post_tuning(struct sdhci_host *host)
+{
+	u32 reg;
+
+	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
+	reg &= ~ESDHC_MIX_CTRL_EXE_TUNE;
+	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
+}
+
+/*
+ * find the largest pass window, and use the average delay of this
+ * largest window to get the best timing.
+ */
+static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
+{
+	int min, max, avg, ret;
+	int win_length, target_min, target_max, target_win_length;
+	u32 clk_tune_ctrl_status, temp;
+
+	min = target_min = ESDHC_TUNE_CTRL_MIN;
+	max = target_max = ESDHC_TUNE_CTRL_MIN;
+	target_win_length = 0;
+	while (max < ESDHC_TUNE_CTRL_MAX) {
+		/* find the mininum delay first which can pass tuning */
+		while (min < ESDHC_TUNE_CTRL_MAX) {
+			esdhc_prepare_tuning(host, min);
+			if (!mmc_send_tuning(host->mmc, opcode, NULL))
+				break;
+			min += ESDHC_TUNE_CTRL_STEP;
+		}
+
+		/* find the maxinum delay which can not pass tuning */
+		max = min + ESDHC_TUNE_CTRL_STEP;
+		while (max < ESDHC_TUNE_CTRL_MAX) {
+			esdhc_prepare_tuning(host, max);
+			if (mmc_send_tuning(host->mmc, opcode, NULL)) {
+				max -= ESDHC_TUNE_CTRL_STEP;
+				break;
+			}
+			max += ESDHC_TUNE_CTRL_STEP;
+		}
+
+		win_length = max - min + 1;
+		/* get the largest pass window */
+		if (win_length > target_win_length) {
+			target_win_length = win_length;
+			target_min = min;
+			target_max = max;
+		}
+
+		/* continue to find the next pass window */
+		min = max + ESDHC_TUNE_CTRL_STEP;
+	}
+
+	/* use average delay to get the best timing */
+	avg = (target_min + target_max) / 2;
+	esdhc_prepare_tuning(host, avg);
+
+	/*
+	 * adjust the delay according to tuning window, make preparation
+	 * for the auto-tuning logic. According to hardware suggest, need
+	 * to config the auto tuning window width to 3, to make the auto
+	 * tuning logic have enough space to handle the sample point shift
+	 * caused by temperature change.
+	 */
+	clk_tune_ctrl_status = FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK,
+					  avg - ESDHC_AUTO_TUNING_WINDOW) |
+			       FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_OUT_MASK,
+					  ESDHC_AUTO_TUNING_WINDOW) |
+			       FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_POST_MASK,
+					  ESDHC_AUTO_TUNING_WINDOW);
+
+	writel(clk_tune_ctrl_status, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+	ret = readl_poll_timeout(host->ioaddr + ESDHC_TUNE_CTRL_STATUS, temp,
+				 clk_tune_ctrl_status ==
+				 FIELD_GET(ESDHC_TUNE_CTRL_STATUS_TAP_SEL_MASK, temp),
+				 1, 10);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc),
+			 "clock tuning control status not set in 10us\n");
+
+	ret = mmc_send_tuning(host->mmc, opcode, NULL);
+	esdhc_post_tuning(host);
+
+	dev_dbg(mmc_dev(host->mmc), "tuning %s at 0x%x ret %d\n",
+		ret ? "failed" : "passed", avg, ret);
+
+	return ret;
+}
+
+static void esdhc_hs400_enhanced_strobe(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u32 m;
+
+	m = readl(host->ioaddr + ESDHC_MIX_CTRL);
+	if (ios->enhanced_strobe)
+		m |= ESDHC_MIX_CTRL_HS400_ES_EN;
+	else
+		m &= ~ESDHC_MIX_CTRL_HS400_ES_EN;
+	writel(m, host->ioaddr + ESDHC_MIX_CTRL);
+}
+
+static int esdhc_change_pinstate(struct sdhci_host *host,
+						unsigned int uhs)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	struct pinctrl_state *pinctrl;
+
+	dev_dbg(mmc_dev(host->mmc), "change pinctrl state for uhs %d\n", uhs);
+
+	if (IS_ERR(imx_data->pinctrl) ||
+		IS_ERR(imx_data->pins_100mhz) ||
+		IS_ERR(imx_data->pins_200mhz))
+		return -EINVAL;
+
+	switch (uhs) {
+	case MMC_TIMING_UHS_SDR50:
+	case MMC_TIMING_UHS_DDR50:
+		pinctrl = imx_data->pins_100mhz;
+		break;
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
+	case MMC_TIMING_MMC_HS400:
+		pinctrl = imx_data->pins_200mhz;
+		break;
+	default:
+		/* back to default state for other legacy timing */
+		return pinctrl_select_default_state(mmc_dev(host->mmc));
+	}
+
+	return pinctrl_select_state(imx_data->pinctrl, pinctrl);
+}
+
+/*
+ * For HS400 eMMC, there is a data_strobe line. This signal is generated
+ * by the device and used for data output and CRC status response output
+ * in HS400 mode. The frequency of this signal follows the frequency of
+ * CLK generated by host. The host receives the data which is aligned to the
+ * edge of data_strobe line. Due to the time delay between CLK line and
+ * data_strobe line, if the delay time is larger than one clock cycle,
+ * then CLK and data_strobe line will be misaligned, read error shows up.
+ */
+static void esdhc_set_strobe_dll(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 strobe_delay;
+	u32 v;
+	int ret;
+
+	/* disable clock before enabling strobe dll */
+	writel(readl(host->ioaddr + ESDHC_VENDOR_SPEC) &
+		~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
+		host->ioaddr + ESDHC_VENDOR_SPEC);
+	esdhc_wait_for_card_clock_gate_off(host);
+
+	/* force a reset on strobe dll */
+	writel(ESDHC_STROBE_DLL_CTRL_RESET,
+		host->ioaddr + ESDHC_STROBE_DLL_CTRL);
+	/* clear the reset bit on strobe dll before any setting */
+	writel(0, host->ioaddr + ESDHC_STROBE_DLL_CTRL);
+
+	/*
+	 * enable strobe dll ctrl and adjust the delay target
+	 * for the uSDHC loopback read clock
+	 */
+	if (imx_data->boarddata.strobe_dll_delay_target)
+		strobe_delay = imx_data->boarddata.strobe_dll_delay_target;
+	else
+		strobe_delay = ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT;
+	v = ESDHC_STROBE_DLL_CTRL_ENABLE |
+		ESDHC_STROBE_DLL_CTRL_SLV_UPDATE_INT_DEFAULT |
+		(strobe_delay << ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_SHIFT);
+	writel(v, host->ioaddr + ESDHC_STROBE_DLL_CTRL);
+
+	/* wait max 50us to get the REF/SLV lock */
+	ret = readl_poll_timeout(host->ioaddr + ESDHC_STROBE_DLL_STATUS, v,
+		((v & ESDHC_STROBE_DLL_STS_REF_LOCK) && (v & ESDHC_STROBE_DLL_STS_SLV_LOCK)), 1, 50);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc),
+		"warning! HS400 strobe DLL status REF/SLV not lock in 50us, STROBE DLL status is %x!\n", v);
+}
+
+static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
+{
+	u32 m;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
+
+	/* disable ddr mode and disable HS400 mode */
+	m = readl(host->ioaddr + ESDHC_MIX_CTRL);
+	m &= ~(ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN);
+	imx_data->is_ddr = 0;
+
+	switch (timing) {
+	case MMC_TIMING_UHS_SDR12:
+	case MMC_TIMING_UHS_SDR25:
+	case MMC_TIMING_UHS_SDR50:
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS:
+	case MMC_TIMING_MMC_HS200:
+		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
+		break;
+	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_DDR52:
+		m |= ESDHC_MIX_CTRL_DDREN;
+		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
+		imx_data->is_ddr = 1;
+		if (boarddata->delay_line) {
+			u32 v;
+			v = boarddata->delay_line <<
+				ESDHC_DLL_OVERRIDE_VAL_SHIFT |
+				(1 << ESDHC_DLL_OVERRIDE_EN_SHIFT);
+			if (is_imx53_esdhc(imx_data))
+				v <<= 1;
+			writel(v, host->ioaddr + ESDHC_DLL_CTRL);
+		}
+		break;
+	case MMC_TIMING_MMC_HS400:
+		m |= ESDHC_MIX_CTRL_DDREN | ESDHC_MIX_CTRL_HS400_EN;
+		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
+		imx_data->is_ddr = 1;
+		/* update clock after enable DDR for strobe DLL lock */
+		host->ops->set_clock(host, host->clock);
+		esdhc_set_strobe_dll(host);
+		break;
+	case MMC_TIMING_LEGACY:
+	default:
+		esdhc_reset_tuning(host);
+		break;
+	}
+
+	if (!(imx_data->socdata->flags & ESDHC_FLAG_DUMMY_PAD) &&
+	    (timing == MMC_TIMING_UHS_SDR104 ||
+	     timing == MMC_TIMING_MMC_HS200 ||
+	     timing == MMC_TIMING_MMC_HS400))
+		m |= ESDHC_MIX_CTRL_FBCLK_SEL;
+	else
+		m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
+
+	writel(m, host->ioaddr + ESDHC_MIX_CTRL);
+
+	esdhc_change_pinstate(host, timing);
+}
+
+static void esdhc_reset(struct sdhci_host *host, u8 mask)
+{
+	sdhci_and_cqhci_reset(host, mask);
+
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+}
+
+static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+
+	/* Doc Erratum: the uSDHC actual maximum timeout count is 1 << 29 */
+	return esdhc_is_usdhc(imx_data) ? 1 << 29 : 1 << 27;
+}
+
+static u32 esdhc_cqhci_irq(struct sdhci_host *host, u32 intmask)
+{
+	int cmd_error = 0;
+	int data_error = 0;
+
+	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
+		return intmask;
+
+	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
+
+	return 0;
+}
+
+static void esdhc_hw_reset(struct sdhci_host *host)
+{
+	esdhc_clrset_le(host, ESDHC_SYS_CTRL_IPP_RST_N, 0, ESDHC_SYSTEM_CONTROL);
+	/* eMMC spec requires minimum 1us, here delay between 1-10us */
+	usleep_range(1, 10);
+	esdhc_clrset_le(host, ESDHC_SYS_CTRL_IPP_RST_N,
+			ESDHC_SYS_CTRL_IPP_RST_N, ESDHC_SYSTEM_CONTROL);
+	/* eMMC spec requires minimum 200us, here delay between 200-300us */
+	usleep_range(200, 300);
+}
+
+static struct sdhci_ops sdhci_esdhc_ops = {
+	.read_l = esdhc_readl_le,
+	.read_w = esdhc_readw_le,
+	.read_b = esdhc_readb_le,
+	.write_l = esdhc_writel_le,
+	.write_w = esdhc_writew_le,
+	.write_b = esdhc_writeb_le,
+	.set_clock = esdhc_pltfm_set_clock,
+	.get_max_clock = esdhc_pltfm_get_max_clock,
+	.get_min_clock = esdhc_pltfm_get_min_clock,
+	.get_max_timeout_count = esdhc_get_max_timeout_count,
+	.get_ro = esdhc_pltfm_get_ro,
+	.set_bus_width = esdhc_pltfm_set_bus_width,
+	.set_uhs_signaling = esdhc_set_uhs_signaling,
+	.reset = esdhc_reset,
+	.irq = esdhc_cqhci_irq,
+	.dump_vendor_regs = esdhc_dump_debug_regs,
+	.hw_reset = esdhc_hw_reset,
+};
+
+static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
+	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_HISPD_BIT
+			| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
+			| SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
+			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
+	.ops = &sdhci_esdhc_ops,
+};
+
+static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	struct cqhci_host *cq_host = host->mmc->cqe_private;
+	u32 tmp;
+
+	if (esdhc_is_usdhc(imx_data)) {
+		/*
+		 * The imx6q ROM code will change the default watermark
+		 * level setting to something insane.  Change it back here.
+		 */
+		writel(ESDHC_WTMK_DEFAULT_VAL, host->ioaddr + ESDHC_WTMK_LVL);
+
+		/*
+		 * ROM code will change the bit burst_length_enable setting
+		 * to zero if this usdhc is chosen to boot system. Change
+		 * it back here, otherwise it will impact the performance a
+		 * lot. This bit is used to enable/disable the burst length
+		 * for the external AHB2AXI bridge. It's useful especially
+		 * for INCR transfer because without burst length indicator,
+		 * the AHB2AXI bridge does not know the burst length in
+		 * advance. And without burst length indicator, AHB INCR
+		 * transfer can only be converted to singles on the AXI side.
+		 */
+		writel(readl(host->ioaddr + SDHCI_HOST_CONTROL)
+			| ESDHC_BURST_LEN_EN_INCR,
+			host->ioaddr + SDHCI_HOST_CONTROL);
+
+		/*
+		 * erratum ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
+		 * TO1.1, it's harmless for MX6SL
+		 */
+		if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_ERR004536)) {
+			writel(readl(host->ioaddr + 0x6c) & ~BIT(7),
+				host->ioaddr + 0x6c);
+		}
+
+		/* disable DLL_CTRL delay line settings */
+		writel(0x0, host->ioaddr + ESDHC_DLL_CTRL);
+
+		/*
+		 * For the case of command with busy, if set the bit
+		 * ESDHC_VEND_SPEC2_EN_BUSY_IRQ, USDHC will generate a
+		 * transfer complete interrupt when busy is deasserted.
+		 * When CQHCI use DCMD to send a CMD need R1b respons,
+		 * CQHCI require to set ESDHC_VEND_SPEC2_EN_BUSY_IRQ,
+		 * otherwise DCMD will always meet timeout waiting for
+		 * hardware interrupt issue.
+		 */
+		if (imx_data->socdata->flags & ESDHC_FLAG_CQHCI) {
+			tmp = readl(host->ioaddr + ESDHC_VEND_SPEC2);
+			tmp |= ESDHC_VEND_SPEC2_EN_BUSY_IRQ;
+			writel(tmp, host->ioaddr + ESDHC_VEND_SPEC2);
+
+			host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
+		}
+
+		if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
+			tmp = readl(host->ioaddr + ESDHC_TUNING_CTRL);
+			tmp |= ESDHC_STD_TUNING_EN;
+
+			/*
+			 * ROM code or bootloader may config the start tap
+			 * and step, unmask them first.
+			 */
+			tmp &= ~(ESDHC_TUNING_START_TAP_MASK | ESDHC_TUNING_STEP_MASK);
+			if (imx_data->boarddata.tuning_start_tap)
+				tmp |= imx_data->boarddata.tuning_start_tap;
+			else
+				tmp |= ESDHC_TUNING_START_TAP_DEFAULT;
+
+			if (imx_data->boarddata.tuning_step) {
+				tmp |= imx_data->boarddata.tuning_step
+					<< ESDHC_TUNING_STEP_SHIFT;
+			} else {
+				tmp |= ESDHC_TUNING_STEP_DEFAULT
+					<< ESDHC_TUNING_STEP_SHIFT;
+			}
+
+			/*
+			 * Config the tuning window to the hardware suggested value 3.
+			 * This tuning window is used for auto tuning logic. The default
+			 * tuning window is 2, here change to 3 make the window a bit
+			 * wider, give auto tuning enough space to handle the sample
+			 * point shift cause by temperature change.
+			 */
+			tmp &= ~ESDHC_TUNING_WINDOW_MASK;
+			tmp |= FIELD_PREP(ESDHC_TUNING_WINDOW_MASK, ESDHC_AUTO_TUNING_WINDOW);
+
+			/* Disable the CMD CRC check for tuning, if not, need to
+			 * add some delay after every tuning command, because
+			 * hardware standard tuning logic will directly go to next
+			 * step once it detect the CMD CRC error, will not wait for
+			 * the card side to finally send out the tuning data, trigger
+			 * the buffer read ready interrupt immediately. If usdhc send
+			 * the next tuning command some eMMC card will stuck, can't
+			 * response, block the tuning procedure or the first command
+			 * after the whole tuning procedure always can't get any response.
+			 */
+			tmp |= ESDHC_TUNING_CMD_CRC_CHECK_DISABLE;
+			writel(tmp, host->ioaddr + ESDHC_TUNING_CTRL);
+		} else if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
+			/*
+			 * ESDHC_STD_TUNING_EN may be configured in bootloader
+			 * or ROM code, so clear this bit here to make sure
+			 * the manual tuning can work.
+			 */
+			tmp = readl(host->ioaddr + ESDHC_TUNING_CTRL);
+			tmp &= ~ESDHC_STD_TUNING_EN;
+			writel(tmp, host->ioaddr + ESDHC_TUNING_CTRL);
+		}
+
+		/*
+		 * On i.MX8MM, we are running Dual Linux OS, with 1st Linux using SD Card
+		 * as rootfs storage, 2nd Linux using eMMC as rootfs storage. We let
+		 * the 1st linux configure power/clock for the 2nd Linux.
+		 *
+		 * When the 2nd Linux is booting into rootfs stage, we let the 1st Linux
+		 * to destroy the 2nd linux, then restart the 2nd linux, we met SDHCI dump.
+		 * After we clear the pending interrupt and halt CQCTL, issue gone.
+		 */
+		if (cq_host) {
+			tmp = cqhci_readl(cq_host, CQHCI_IS);
+			cqhci_writel(cq_host, tmp, CQHCI_IS);
+			cqhci_writel(cq_host, CQHCI_HALT, CQHCI_CTL);
+		}
+	}
+}
+
+static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	/*
+	 * SD/eMMC do not need this tuning save because it will re-init
+	 * after system resume back.
+	 * Here save the tuning delay value for SDIO device since it may
+	 * keep power during system PM. And for usdhc, only SDR50 and
+	 * SDR104 mode for SDIO device need to do tuning, and need to
+	 * save/restore.
+	 */
+	if (host->timing == MMC_TIMING_UHS_SDR50 ||
+	    host->timing == MMC_TIMING_UHS_SDR104) {
+		reg = readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+		reg = FIELD_GET(ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK, reg);
+		imx_data->boarddata.saved_tuning_delay_cell = reg;
+	}
+}
+
+static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	if (host->timing == MMC_TIMING_UHS_SDR50 ||
+	    host->timing == MMC_TIMING_UHS_SDR104) {
+		/*
+		 * restore the tuning delay value actually is a
+		 * manual tuning method, so clear the standard
+		 * tuning enable bit here. Will set back this
+		 * ESDHC_STD_TUNING_EN in esdhc_reset_tuning()
+		 * when trigger re-tuning.
+		 */
+		reg = readl(host->ioaddr + ESDHC_TUNING_CTRL);
+		reg &= ~ESDHC_STD_TUNING_EN;
+		writel(reg, host->ioaddr + ESDHC_TUNING_CTRL);
+
+		reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
+		reg |= ESDHC_MIX_CTRL_SMPCLK_SEL;
+		if (!(imx_data->socdata->flags & ESDHC_FLAG_DUMMY_PAD))
+			reg |= ESDHC_MIX_CTRL_FBCLK_SEL;
+		writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
+
+		writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK,
+				  imx_data->boarddata.saved_tuning_delay_cell) |
+		       FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_OUT_MASK,
+				  ESDHC_AUTO_TUNING_WINDOW) |
+		       FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_POST_MASK,
+				  ESDHC_AUTO_TUNING_WINDOW),
+		       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+	}
+}
+
+static void esdhc_cqe_enable(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct cqhci_host *cq_host = mmc->cqe_private;
+	u32 reg;
+	u16 mode;
+	int count = 10;
+
+	/*
+	 * CQE gets stuck if it sees Buffer Read Enable bit set, which can be
+	 * the case after tuning, so ensure the buffer is drained.
+	 */
+	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	while (reg & SDHCI_DATA_AVAILABLE) {
+		sdhci_readl(host, SDHCI_BUFFER);
+		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
+		if (count-- == 0) {
+			dev_warn(mmc_dev(host->mmc),
+				"CQE may get stuck because the Buffer Read Enable bit is set\n");
+			break;
+		}
+		mdelay(1);
+	}
+
+	/*
+	 * Runtime resume will reset the entire host controller, which
+	 * will also clear the DMAEN/BCEN of register ESDHC_MIX_CTRL.
+	 * Here set DMAEN and BCEN when enable CMDQ.
+	 */
+	mode = sdhci_readw(host, SDHCI_TRANSFER_MODE);
+	if (host->flags & SDHCI_REQ_USE_DMA)
+		mode |= SDHCI_TRNS_DMA;
+	if (!(host->quirks2 & SDHCI_QUIRK2_SUPPORT_SINGLE))
+		mode |= SDHCI_TRNS_BLK_CNT_EN;
+	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
+
+	/*
+	 * Though Runtime resume reset the entire host controller,
+	 * but do not impact the CQHCI side, need to clear the
+	 * HALT bit, avoid CQHCI stuck in the first request when
+	 * system resume back.
+	 */
+	cqhci_writel(cq_host, 0, CQHCI_CTL);
+	if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
+		dev_err(mmc_dev(host->mmc),
+			"failed to exit halt state when enable CQE\n");
+
+
+	sdhci_cqe_enable(mmc);
+}
+
+static void esdhc_sdhci_dumpregs(struct mmc_host *mmc)
+{
+	sdhci_dumpregs(mmc_priv(mmc));
+}
+
+static const struct cqhci_host_ops esdhc_cqhci_ops = {
+	.enable		= esdhc_cqe_enable,
+	.disable	= sdhci_cqe_disable,
+	.dumpregs	= esdhc_sdhci_dumpregs,
+};
+
+static int
+sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
+			 struct sdhci_host *host,
+			 struct pltfm_imx_data *imx_data)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
+	int ret;
+
+	if (of_property_read_bool(np, "fsl,wp-controller"))
+		boarddata->wp_type = ESDHC_WP_CONTROLLER;
+
+	/*
+	 * If we have this property, then activate WP check.
+	 * Retrieving and requesting the actual WP GPIO will happen
+	 * in the call to mmc_of_parse().
+	 */
+	if (of_property_present(np, "wp-gpios"))
+		boarddata->wp_type = ESDHC_WP_GPIO;
+
+	of_property_read_u32(np, "fsl,tuning-step", &boarddata->tuning_step);
+	of_property_read_u32(np, "fsl,tuning-start-tap",
+			     &boarddata->tuning_start_tap);
+
+	of_property_read_u32(np, "fsl,strobe-dll-delay-target",
+				&boarddata->strobe_dll_delay_target);
+	if (of_property_read_bool(np, "no-1-8-v"))
+		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+
+	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
+		boarddata->delay_line = 0;
+
+	mmc_of_parse_voltage(host->mmc, &host->ocr_mask);
+
+	if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pinctrl)) {
+		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
+						ESDHC_PINCTRL_STATE_100MHZ);
+		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
+						ESDHC_PINCTRL_STATE_200MHZ);
+	}
+
+	/* call to generic mmc_of_parse to support additional capabilities */
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		return ret;
+
+	/* HS400/HS400ES require 8 bit bus */
+	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
+		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+
+	if (mmc_gpio_get_cd(host->mmc) >= 0)
+		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
+	return 0;
+}
+
+static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
+{
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_host *host;
+	struct cqhci_host *cq_host;
+	int err;
+	struct pltfm_imx_data *imx_data;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata,
+				sizeof(*imx_data));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+
+	imx_data = sdhci_pltfm_priv(pltfm_host);
+
+	imx_data->socdata = device_get_match_data(&pdev->dev);
+
+	host->quirks |= imx_data->socdata->quirks;
+	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
+		cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
+
+	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(imx_data->clk_ipg)) {
+		err = PTR_ERR(imx_data->clk_ipg);
+		goto free_sdhci;
+	}
+
+	imx_data->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(imx_data->clk_ahb)) {
+		err = PTR_ERR(imx_data->clk_ahb);
+		goto free_sdhci;
+	}
+
+	imx_data->clk_per = devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(imx_data->clk_per)) {
+		err = PTR_ERR(imx_data->clk_per);
+		goto free_sdhci;
+	}
+
+	pltfm_host->clk = imx_data->clk_per;
+	err = clk_prepare_enable(imx_data->clk_per);
+	if (err)
+		goto free_sdhci;
+	err = clk_prepare_enable(imx_data->clk_ipg);
+	if (err)
+		goto disable_per_clk;
+	err = clk_prepare_enable(imx_data->clk_ahb);
+	if (err)
+		goto disable_ipg_clk;
+
+	pltfm_host->clock = clk_get_rate(pltfm_host->clk);
+	if (!pltfm_host->clock) {
+		dev_err(mmc_dev(host->mmc), "could not get clk rate\n");
+		err = -EINVAL;
+		goto disable_ahb_clk;
+	}
+
+	imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(imx_data->pinctrl))
+		dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");
+
+	if (esdhc_is_usdhc(imx_data)) {
+		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+		host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
+
+		/* GPIO CD can be set as a wakeup source */
+		if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_CD_WAKE))
+			host->mmc->caps |= MMC_CAP_CD_WAKE;
+
+		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
+			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
+
+		/* clear tuning bits in case ROM has set it already */
+		writel(0x0, host->ioaddr + ESDHC_MIX_CTRL);
+		writel(0x0, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
+		writel(0x0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+
+		/*
+		 * Link usdhc specific mmc_host_ops execute_tuning function,
+		 * to replace the standard one in sdhci_ops.
+		 */
+		host->mmc_host_ops.execute_tuning = usdhc_execute_tuning;
+
+		/*
+		 * Link usdhc specific mmc_host_ops init card function,
+		 * to distinguish the card type.
+		 */
+		host->mmc_host_ops.init_card = usdhc_init_card;
+
+		host->max_timeout_count = 0xF;
+	}
+
+	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
+		sdhci_esdhc_ops.platform_execute_tuning =
+					esdhc_executing_tuning;
+
+	if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
+		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+
+	if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
+		host->mmc->caps2 |= MMC_CAP2_HS400;
+
+	if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
+		host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
+
+	if (imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
+		host->mmc->caps2 |= MMC_CAP2_HS400_ES;
+		host->mmc_host_ops.hs400_enhanced_strobe =
+					esdhc_hs400_enhanced_strobe;
+	}
+
+	if (imx_data->socdata->flags & ESDHC_FLAG_CQHCI) {
+		host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
+		cq_host = devm_kzalloc(&pdev->dev, sizeof(*cq_host), GFP_KERNEL);
+		if (!cq_host) {
+			err = -ENOMEM;
+			goto disable_ahb_clk;
+		}
+
+		cq_host->mmio = host->ioaddr + ESDHC_CQHCI_ADDR_OFFSET;
+		cq_host->ops = &esdhc_cqhci_ops;
+
+		err = cqhci_init(cq_host, host->mmc, false);
+		if (err)
+			goto disable_ahb_clk;
+	}
+
+	err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
+	if (err)
+		goto disable_ahb_clk;
+
+	sdhci_esdhc_imx_hwinit(host);
+
+	err = sdhci_add_host(host);
+	if (err)
+		goto disable_ahb_clk;
+
+	/*
+	 * Setup the wakeup capability here, let user to decide
+	 * whether need to enable this wakeup through sysfs interface.
+	 */
+	if ((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
+			(host->mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ))
+		device_set_wakeup_capable(&pdev->dev, true);
+
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_suspend_ignore_children(&pdev->dev, 1);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+disable_ahb_clk:
+	clk_disable_unprepare(imx_data->clk_ahb);
+disable_ipg_clk:
+	clk_disable_unprepare(imx_data->clk_ipg);
+disable_per_clk:
+	clk_disable_unprepare(imx_data->clk_per);
+free_sdhci:
+	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
+		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
+	return err;
+}
+
+static void sdhci_esdhc_imx_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	int dead;
+
+	pm_runtime_get_sync(&pdev->dev);
+	dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	sdhci_remove_host(host, dead);
+
+	clk_disable_unprepare(imx_data->clk_per);
+	clk_disable_unprepare(imx_data->clk_ipg);
+	clk_disable_unprepare(imx_data->clk_ahb);
+
+	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
+		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
+}
+
+static int sdhci_esdhc_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	/*
+	 * Switch to runtime resume for two reasons:
+	 * 1, there is register access (e.g., wakeup control register), so
+	 *    need to make sure gate on ipg clock.
+	 * 2, make sure the pm_runtime_force_resume() in sdhci_esdhc_resume() really
+	 *    invoke its ->runtime_resume callback (needs_force_resume = 1).
+	 */
+	pm_runtime_get_sync(dev);
+
+	if ((imx_data->socdata->flags & ESDHC_FLAG_STATE_LOST_IN_LPMODE) &&
+		(host->tuning_mode != SDHCI_TUNING_MODE_1)) {
+		mmc_retune_timer_stop(host->mmc);
+		mmc_retune_needed(host->mmc);
+	}
+
+	/*
+	 * For the device need to keep power during system PM, need
+	 * to save the tuning delay value just in case the usdhc
+	 * lost power during system PM.
+	 */
+	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
+	    esdhc_is_usdhc(imx_data))
+		sdhc_esdhc_tuning_save(host);
+
+	if (device_may_wakeup(dev)) {
+		/* The irqs of imx are not shared. It is safe to disable */
+		disable_irq(host->irq);
+		ret = sdhci_enable_irq_wakeups(host);
+		if (!ret)
+			dev_warn(dev, "Failed to enable irq wakeup\n");
+	} else {
+		/*
+		 * For the device which works as wakeup source, no need
+		 * to change the pinctrl to sleep state.
+		 * e.g. For SDIO device, the interrupt share with data pin,
+		 * but the pinctrl sleep state may config the data pin to
+		 * other function like GPIO function to save power in PM,
+		 * which finally block the SDIO wakeup function.
+		 */
+		ret = pinctrl_pm_select_sleep_state(dev);
+		if (ret)
+			return ret;
+	}
+
+	ret = mmc_gpio_set_cd_wake(host->mmc, true);
+
+	/*
+	 * Make sure invoke runtime_suspend to gate off clock.
+	 * uSDHC IP supports in-band SDIO wakeup even without clock.
+	 */
+	pm_runtime_force_suspend(dev);
+
+	return ret;
+}
+
+static int sdhci_esdhc_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	pm_runtime_force_resume(dev);
+
+	ret = mmc_gpio_set_cd_wake(host->mmc, false);
+	if (ret)
+		return ret;
+
+	/* re-initialize hw state in case it's lost in low power mode */
+	sdhci_esdhc_imx_hwinit(host);
+
+	if (host->irq_wake_enabled) {
+		sdhci_disable_irq_wakeups(host);
+		enable_irq(host->irq);
+	}
+
+	/*
+	 * restore the saved tuning delay value for the device which keep
+	 * power during system PM.
+	 */
+	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
+	    esdhc_is_usdhc(imx_data))
+		sdhc_esdhc_tuning_restore(host);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static int sdhci_esdhc_runtime_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
+	sdhci_runtime_suspend_host(host);
+
+	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
+	imx_data->actual_clock = host->mmc->actual_clock;
+	esdhc_pltfm_set_clock(host, 0);
+	clk_disable_unprepare(imx_data->clk_per);
+	clk_disable_unprepare(imx_data->clk_ipg);
+	clk_disable_unprepare(imx_data->clk_ahb);
+
+	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
+		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
+
+	return 0;
+}
+
+static int sdhci_esdhc_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
+	int err;
+
+	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
+		cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
+
+	if (imx_data->socdata->flags & ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME)
+		clk_set_rate(imx_data->clk_per, pltfm_host->clock);
+
+	err = clk_prepare_enable(imx_data->clk_ahb);
+	if (err)
+		goto remove_pm_qos_request;
+
+	err = clk_prepare_enable(imx_data->clk_per);
+	if (err)
+		goto disable_ahb_clk;
+
+	err = clk_prepare_enable(imx_data->clk_ipg);
+	if (err)
+		goto disable_per_clk;
+
+	esdhc_pltfm_set_clock(host, imx_data->actual_clock);
+
+	sdhci_runtime_resume_host(host, 0);
+
+	if (host->mmc->caps2 & MMC_CAP2_CQE)
+		err = cqhci_resume(host->mmc);
+
+	return err;
+
+disable_per_clk:
+	clk_disable_unprepare(imx_data->clk_per);
+disable_ahb_clk:
+	clk_disable_unprepare(imx_data->clk_ahb);
+remove_pm_qos_request:
+	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
+		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
+	return err;
+}
+
+static const struct dev_pm_ops sdhci_esdhc_pmops = {
+	SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
+	RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend, sdhci_esdhc_runtime_resume, NULL)
+};
+
+static struct platform_driver sdhci_esdhc_imx_driver = {
+	.driver		= {
+		.name	= "sdhci-esdhc-imx",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = imx_esdhc_dt_ids,
+		.pm	= pm_ptr(&sdhci_esdhc_pmops),
+	},
+	.probe		= sdhci_esdhc_imx_probe,
+	.remove		= sdhci_esdhc_imx_remove,
+};
+
+module_platform_driver(sdhci_esdhc_imx_driver);
+
+MODULE_DESCRIPTION("SDHCI driver for Freescale i.MX eSDHC");
+MODULE_AUTHOR("Wolfram Sang <kernel@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
new file mode 100644
index 0000000..005f26c
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -0,0 +1,4377 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2007-2015, 2018-2024 Intel Corporation
+ * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
+ * Copyright (C) 2016-2017 Intel Deutschland GmbH
+ */
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/debugfs.h>
+#include <linux/sched.h>
+#include <linux/bitops.h>
+#include <linux/gfp.h>
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+#include <linux/wait.h>
+#include <linux/seq_file.h>
+
+#include "iwl-drv.h"
+#include "iwl-trans.h"
+#include "iwl-csr.h"
+#include "iwl-prph.h"
+#include "iwl-scd.h"
+#include "iwl-agn-hw.h"
+#include "fw/error-dump.h"
+#include "fw/dbg.h"
+#include "fw/api/tx.h"
+#include "fw/acpi.h"
+#include "mei/iwl-mei.h"
+#include "internal.h"
+#include "iwl-fh.h"
+#include "pcie/iwl-context-info-v2.h"
+#include "pcie/utils.h"
+
+#define IWL_HOST_MON_BLOCK_PEMON	0x00
+#define IWL_HOST_MON_BLOCK_HIPM		0x22
+
+#define IWL_HOST_MON_BLOCK_PEMON_VEC0	0x00
+#define IWL_HOST_MON_BLOCK_PEMON_VEC1	0x01
+#define IWL_HOST_MON_BLOCK_PEMON_WFPM	0x06
+
+static void iwl_dump_host_monitor_block(struct iwl_trans *trans,
+					u32 block, u32 vec, u32 iter)
+{
+	int i;
+
+	IWL_ERR(trans, "Host monitor block 0x%x vector 0x%x\n", block, vec);
+	iwl_write32(trans, CSR_MONITOR_CFG_REG, (block << 8) | vec);
+	for (i = 0; i < iter; i++)
+		IWL_ERR(trans, "    value [iter %d]: 0x%08x\n",
+			i, iwl_read32(trans, CSR_MONITOR_STATUS_REG));
+}
+
+static void iwl_pcie_dump_host_monitor(struct iwl_trans *trans)
+{
+	switch (trans->mac_cfg->device_family) {
+	case IWL_DEVICE_FAMILY_22000:
+	case IWL_DEVICE_FAMILY_AX210:
+		IWL_ERR(trans, "CSR_RESET = 0x%x\n",
+			iwl_read32(trans, CSR_RESET));
+		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_PEMON,
+					    IWL_HOST_MON_BLOCK_PEMON_VEC0, 15);
+		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_PEMON,
+					    IWL_HOST_MON_BLOCK_PEMON_VEC1, 15);
+		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_PEMON,
+					    IWL_HOST_MON_BLOCK_PEMON_WFPM, 15);
+		iwl_dump_host_monitor_block(trans, IWL_HOST_MON_BLOCK_HIPM,
+					    IWL_HOST_MON_BLOCK_PEMON_VEC0, 1);
+		break;
+	default:
+		return;
+	}
+}
+
+/* extended range in FW SRAM */
+#define IWL_FW_MEM_EXTENDED_START	0x40000
+#define IWL_FW_MEM_EXTENDED_END		0x57FFF
+
+int iwl_trans_pcie_sw_reset(struct iwl_trans *trans, bool retake_ownership)
+{
+	/* Reset entire device - do controller reset (results in SHRD_HW_RST) */
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_SW_RESET);
+		usleep_range(10000, 20000);
+	} else {
+		iwl_set_bit(trans, CSR_RESET,
+			    CSR_RESET_REG_FLAG_SW_RESET);
+		usleep_range(5000, 6000);
+	}
+
+	if (retake_ownership)
+		return iwl_pcie_prepare_card_hw(trans);
+
+	return 0;
+}
+
+static void iwl_pcie_free_fw_monitor(struct iwl_trans *trans)
+{
+	struct iwl_dram_data *fw_mon = &trans->dbg.fw_mon;
+
+	if (!fw_mon->size)
+		return;
+
+	dma_free_coherent(trans->dev, fw_mon->size, fw_mon->block,
+			  fw_mon->physical);
+
+	fw_mon->block = NULL;
+	fw_mon->physical = 0;
+	fw_mon->size = 0;
+}
+
+static void iwl_pcie_alloc_fw_monitor_block(struct iwl_trans *trans,
+					    u8 max_power)
+{
+	struct iwl_dram_data *fw_mon = &trans->dbg.fw_mon;
+	void *block = NULL;
+	dma_addr_t physical = 0;
+	u32 size = 0;
+	u8 power;
+
+	if (fw_mon->size) {
+		memset(fw_mon->block, 0, fw_mon->size);
+		return;
+	}
+
+	/* need at least 2 KiB, so stop at 11 */
+	for (power = max_power; power >= 11; power--) {
+		size = BIT(power);
+		block = dma_alloc_coherent(trans->dev, size, &physical,
+					   GFP_KERNEL | __GFP_NOWARN);
+		if (!block)
+			continue;
+
+		IWL_INFO(trans,
+			 "Allocated 0x%08x bytes for firmware monitor.\n",
+			 size);
+		break;
+	}
+
+	if (WARN_ON_ONCE(!block))
+		return;
+
+	if (power != max_power)
+		IWL_ERR(trans,
+			"Sorry - debug buffer is only %luK while you requested %luK\n",
+			(unsigned long)BIT(power - 10),
+			(unsigned long)BIT(max_power - 10));
+
+	fw_mon->block = block;
+	fw_mon->physical = physical;
+	fw_mon->size = size;
+}
+
+void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power)
+{
+	if (!max_power) {
+		/* default max_power is maximum */
+		max_power = 26;
+	} else {
+		max_power += 11;
+	}
+
+	if (WARN(max_power > 26,
+		 "External buffer size for monitor is too big %d, check the FW TLV\n",
+		 max_power))
+		return;
+
+	iwl_pcie_alloc_fw_monitor_block(trans, max_power);
+}
+
+static u32 iwl_trans_pcie_read_shr(struct iwl_trans *trans, u32 reg)
+{
+	iwl_write32(trans, HEEP_CTRL_WRD_PCIEX_CTRL_REG,
+		    ((reg & 0x0000ffff) | (2 << 28)));
+	return iwl_read32(trans, HEEP_CTRL_WRD_PCIEX_DATA_REG);
+}
+
+static void iwl_trans_pcie_write_shr(struct iwl_trans *trans, u32 reg, u32 val)
+{
+	iwl_write32(trans, HEEP_CTRL_WRD_PCIEX_DATA_REG, val);
+	iwl_write32(trans, HEEP_CTRL_WRD_PCIEX_CTRL_REG,
+		    ((reg & 0x0000ffff) | (3 << 28)));
+}
+
+static void iwl_pcie_set_pwr(struct iwl_trans *trans, bool vaux)
+{
+	if (trans->mac_cfg->base->apmg_not_supported)
+		return;
+
+	if (vaux && pci_pme_capable(to_pci_dev(trans->dev), PCI_D3cold))
+		iwl_set_bits_mask_prph(trans, APMG_PS_CTRL_REG,
+				       APMG_PS_CTRL_VAL_PWR_SRC_VAUX,
+				       ~APMG_PS_CTRL_MSK_PWR_SRC);
+	else
+		iwl_set_bits_mask_prph(trans, APMG_PS_CTRL_REG,
+				       APMG_PS_CTRL_VAL_PWR_SRC_VMAIN,
+				       ~APMG_PS_CTRL_MSK_PWR_SRC);
+}
+
+/* PCI registers */
+#define PCI_CFG_RETRY_TIMEOUT	0x041
+
+void iwl_pcie_apm_config(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	u16 lctl;
+	u16 cap;
+
+	/*
+	 * L0S states have been found to be unstable with our devices
+	 * and in newer hardware they are not officially supported at
+	 * all, so we must always set the L0S_DISABLED bit.
+	 */
+	iwl_set_bit(trans, CSR_GIO_REG, CSR_GIO_REG_VAL_L0S_DISABLED);
+
+	pcie_capability_read_word(trans_pcie->pci_dev, PCI_EXP_LNKCTL, &lctl);
+	trans_pcie->pm_support = !(lctl & PCI_EXP_LNKCTL_ASPM_L0S);
+
+	pcie_capability_read_word(trans_pcie->pci_dev, PCI_EXP_DEVCTL2, &cap);
+	trans_pcie->ltr_enabled = cap & PCI_EXP_DEVCTL2_LTR_EN;
+	IWL_DEBUG_POWER(trans, "L1 %sabled - LTR %sabled\n",
+			(lctl & PCI_EXP_LNKCTL_ASPM_L1) ? "En" : "Dis",
+			trans_pcie->ltr_enabled ? "En" : "Dis");
+}
+
+/*
+ * Start up NIC's basic functionality after it has been reset
+ * (e.g. after platform boot, or shutdown via iwl_pcie_apm_stop())
+ * NOTE:  This does not load uCode nor start the embedded processor
+ */
+static int iwl_pcie_apm_init(struct iwl_trans *trans)
+{
+	int ret;
+
+	IWL_DEBUG_INFO(trans, "Init card's basic functions\n");
+
+	/*
+	 * Use "set_bit" below rather than "write", to preserve any hardware
+	 * bits already set by default after reset.
+	 */
+
+	/* Disable L0S exit timer (platform NMI Work/Around) */
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_8000)
+		iwl_set_bit(trans, CSR_GIO_CHICKEN_BITS,
+			    CSR_GIO_CHICKEN_BITS_REG_BIT_DIS_L0S_EXIT_TIMER);
+
+	/*
+	 * Disable L0s without affecting L1;
+	 *  don't wait for ICH L0s (ICH bug W/A)
+	 */
+	iwl_set_bit(trans, CSR_GIO_CHICKEN_BITS,
+		    CSR_GIO_CHICKEN_BITS_REG_BIT_L1A_NO_L0S_RX);
+
+	/* Set FH wait threshold to maximum (HW error during stress W/A) */
+	iwl_set_bit(trans, CSR_DBG_HPET_MEM_REG, CSR_DBG_HPET_MEM_REG_VAL);
+
+	/*
+	 * Enable HAP INTA (interrupt from management bus) to
+	 * wake device's PCI Express link L1a -> L0s
+	 */
+	iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
+		    CSR_HW_IF_CONFIG_REG_HAP_WAKE);
+
+	iwl_pcie_apm_config(trans);
+
+	/* Configure analog phase-lock-loop before activating to D0A */
+	if (trans->mac_cfg->base->pll_cfg)
+		iwl_set_bit(trans, CSR_ANA_PLL_CFG, CSR50_ANA_PLL_CFG_VAL);
+
+	ret = iwl_trans_activate_nic(trans);
+	if (ret)
+		return ret;
+
+	if (trans->cfg->host_interrupt_operation_mode) {
+		/*
+		 * This is a bit of an abuse - This is needed for 7260 / 3160
+		 * only check host_interrupt_operation_mode even if this is
+		 * not related to host_interrupt_operation_mode.
+		 *
+		 * Enable the oscillator to count wake up time for L1 exit. This
+		 * consumes slightly more power (100uA) - but allows to be sure
+		 * that we wake up from L1 on time.
+		 *
+		 * This looks weird: read twice the same register, discard the
+		 * value, set a bit, and yet again, read that same register
+		 * just to discard the value. But that's the way the hardware
+		 * seems to like it.
+		 */
+		iwl_read_prph(trans, OSC_CLK);
+		iwl_read_prph(trans, OSC_CLK);
+		iwl_set_bits_prph(trans, OSC_CLK, OSC_CLK_FORCE_CONTROL);
+		iwl_read_prph(trans, OSC_CLK);
+		iwl_read_prph(trans, OSC_CLK);
+	}
+
+	/*
+	 * Enable DMA clock and wait for it to stabilize.
+	 *
+	 * Write to "CLK_EN_REG"; "1" bits enable clocks, while "0"
+	 * bits do not disable clocks.  This preserves any hardware
+	 * bits already set by default in "CLK_CTRL_REG" after reset.
+	 */
+	if (!trans->mac_cfg->base->apmg_not_supported) {
+		iwl_write_prph(trans, APMG_CLK_EN_REG,
+			       APMG_CLK_VAL_DMA_CLK_RQT);
+		udelay(20);
+
+		/* Disable L1-Active */
+		iwl_set_bits_prph(trans, APMG_PCIDEV_STT_REG,
+				  APMG_PCIDEV_STT_VAL_L1_ACT_DIS);
+
+		/* Clear the interrupt in APMG if the NIC is in RFKILL */
+		iwl_write_prph(trans, APMG_RTC_INT_STT_REG,
+			       APMG_RTC_INT_STT_RFKILL);
+	}
+
+	set_bit(STATUS_DEVICE_ENABLED, &trans->status);
+
+	return 0;
+}
+
+/*
+ * Enable LP XTAL to avoid HW bug where device may consume much power if
+ * FW is not loaded after device reset. LP XTAL is disabled by default
+ * after device HW reset. Do it only if XTAL is fed by internal source.
+ * Configure device's "persistence" mode to avoid resetting XTAL again when
+ * SHRD_HW_RST occurs in S3.
+ */
+static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
+{
+	int ret;
+	u32 apmg_gp1_reg;
+	u32 apmg_xtal_cfg_reg;
+	u32 dl_cfg_reg;
+
+	/* Force XTAL ON */
+	iwl_trans_set_bit(trans, CSR_GP_CNTRL,
+			  CSR_GP_CNTRL_REG_FLAG_XTAL_ON);
+
+	ret = iwl_trans_pcie_sw_reset(trans, true);
+
+	if (!ret)
+		ret = iwl_trans_activate_nic(trans);
+
+	if (WARN_ON(ret)) {
+		/* Release XTAL ON request */
+		iwl_trans_clear_bit(trans, CSR_GP_CNTRL,
+				    CSR_GP_CNTRL_REG_FLAG_XTAL_ON);
+		return;
+	}
+
+	/*
+	 * Clear "disable persistence" to avoid LP XTAL resetting when
+	 * SHRD_HW_RST is applied in S3.
+	 */
+	iwl_clear_bits_prph(trans, APMG_PCIDEV_STT_REG,
+				    APMG_PCIDEV_STT_VAL_PERSIST_DIS);
+
+	/*
+	 * Force APMG XTAL to be active to prevent its disabling by HW
+	 * caused by APMG idle state.
+	 */
+	apmg_xtal_cfg_reg = iwl_trans_pcie_read_shr(trans,
+						    SHR_APMG_XTAL_CFG_REG);
+	iwl_trans_pcie_write_shr(trans, SHR_APMG_XTAL_CFG_REG,
+				 apmg_xtal_cfg_reg |
+				 SHR_APMG_XTAL_CFG_XTAL_ON_REQ);
+
+	ret = iwl_trans_pcie_sw_reset(trans, true);
+	if (ret)
+		IWL_ERR(trans,
+			"iwl_pcie_apm_lp_xtal_enable: failed to retake NIC ownership\n");
+
+	/* Enable LP XTAL by indirect access through CSR */
+	apmg_gp1_reg = iwl_trans_pcie_read_shr(trans, SHR_APMG_GP1_REG);
+	iwl_trans_pcie_write_shr(trans, SHR_APMG_GP1_REG, apmg_gp1_reg |
+				 SHR_APMG_GP1_WF_XTAL_LP_EN |
+				 SHR_APMG_GP1_CHICKEN_BIT_SELECT);
+
+	/* Clear delay line clock power up */
+	dl_cfg_reg = iwl_trans_pcie_read_shr(trans, SHR_APMG_DL_CFG_REG);
+	iwl_trans_pcie_write_shr(trans, SHR_APMG_DL_CFG_REG, dl_cfg_reg &
+				 ~SHR_APMG_DL_CFG_DL_CLOCK_POWER_UP);
+
+	/*
+	 * Enable persistence mode to avoid LP XTAL resetting when
+	 * SHRD_HW_RST is applied in S3.
+	 */
+	iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
+		    CSR_HW_IF_CONFIG_REG_PERSISTENCE);
+
+	/*
+	 * Clear "initialization complete" bit to move adapter from
+	 * D0A* (powered-up Active) --> D0U* (Uninitialized) state.
+	 */
+	iwl_clear_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
+
+	/* Activates XTAL resources monitor */
+	iwl_trans_set_bit(trans, CSR_MONITOR_CFG_REG,
+			  CSR_MONITOR_XTAL_RESOURCES);
+
+	/* Release XTAL ON request */
+	iwl_trans_clear_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_XTAL_ON);
+	udelay(10);
+
+	/* Release APMG XTAL */
+	iwl_trans_pcie_write_shr(trans, SHR_APMG_XTAL_CFG_REG,
+				 apmg_xtal_cfg_reg &
+				 ~SHR_APMG_XTAL_CFG_XTAL_ON_REQ);
+}
+
+void iwl_pcie_apm_stop_master(struct iwl_trans *trans)
+{
+	int ret;
+
+	/* stop device's busmaster DMA activity */
+
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_REQ);
+
+		ret = iwl_poll_bits(trans, CSR_GP_CNTRL,
+				    CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
+				    100);
+		usleep_range(10000, 20000);
+	} else {
+		iwl_set_bit(trans, CSR_RESET, CSR_RESET_REG_FLAG_STOP_MASTER);
+
+		ret = iwl_poll_bits(trans, CSR_RESET,
+				    CSR_RESET_REG_FLAG_MASTER_DISABLED, 100);
+	}
+
+	if (ret)
+		IWL_WARN(trans, "Master Disable Timed Out, 100 usec\n");
+
+	IWL_DEBUG_INFO(trans, "stop master\n");
+}
+
+static void iwl_pcie_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
+{
+	IWL_DEBUG_INFO(trans, "Stop card, put in low power state\n");
+
+	if (op_mode_leave) {
+		if (!test_bit(STATUS_DEVICE_ENABLED, &trans->status))
+			iwl_pcie_apm_init(trans);
+
+		/* inform ME that we are leaving */
+		if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_7000)
+			iwl_set_bits_prph(trans, APMG_PCIDEV_STT_REG,
+					  APMG_PCIDEV_STT_VAL_WAKE_ME);
+		else if (trans->mac_cfg->device_family >=
+			 IWL_DEVICE_FAMILY_8000) {
+			iwl_set_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
+				    CSR_RESET_LINK_PWR_MGMT_DISABLED);
+			iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
+				    CSR_HW_IF_CONFIG_REG_WAKE_ME |
+				    CSR_HW_IF_CONFIG_REG_WAKE_ME_PCIE_OWNER_EN);
+			mdelay(1);
+			iwl_clear_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
+				      CSR_RESET_LINK_PWR_MGMT_DISABLED);
+		}
+		mdelay(5);
+	}
+
+	clear_bit(STATUS_DEVICE_ENABLED, &trans->status);
+
+	/* Stop device's DMA activity */
+	iwl_pcie_apm_stop_master(trans);
+
+	if (trans->cfg->lp_xtal_workaround) {
+		iwl_pcie_apm_lp_xtal_enable(trans);
+		return;
+	}
+
+	iwl_trans_pcie_sw_reset(trans, false);
+
+	/*
+	 * Clear "initialization complete" bit to move adapter from
+	 * D0A* (powered-up Active) --> D0U* (Uninitialized) state.
+	 */
+	iwl_clear_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
+}
+
+static int iwl_pcie_nic_init(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int ret;
+
+	/* nic_init */
+	spin_lock_bh(&trans_pcie->irq_lock);
+	ret = iwl_pcie_apm_init(trans);
+	spin_unlock_bh(&trans_pcie->irq_lock);
+
+	if (ret)
+		return ret;
+
+	iwl_pcie_set_pwr(trans, false);
+
+	iwl_op_mode_nic_config(trans->op_mode);
+
+	/* Allocate the RX queue, or reset if it is already allocated */
+	ret = iwl_pcie_rx_init(trans);
+	if (ret)
+		return ret;
+
+	/* Allocate or reset and init all Tx and Command queues */
+	if (iwl_pcie_tx_init(trans)) {
+		iwl_pcie_rx_free(trans);
+		return -ENOMEM;
+	}
+
+	if (trans->mac_cfg->base->shadow_reg_enable) {
+		/* enable shadow regs in HW */
+		iwl_set_bit(trans, CSR_MAC_SHADOW_REG_CTRL, 0x800FFFFF);
+		IWL_DEBUG_INFO(trans, "Enabling shadow registers in device\n");
+	}
+
+	return 0;
+}
+
+#define HW_READY_TIMEOUT (50)
+
+/* Note: returns poll_bit return value, which is >= 0 if success */
+static int iwl_pcie_set_hw_ready(struct iwl_trans *trans)
+{
+	int ret;
+
+	iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
+		    CSR_HW_IF_CONFIG_REG_PCI_OWN_SET);
+
+	/* See if we got it */
+	ret = iwl_poll_bits(trans, CSR_HW_IF_CONFIG_REG,
+			    CSR_HW_IF_CONFIG_REG_PCI_OWN_SET,
+			    HW_READY_TIMEOUT);
+
+	if (!ret)
+		iwl_set_bit(trans, CSR_MBOX_SET_REG, CSR_MBOX_SET_REG_OS_ALIVE);
+
+	IWL_DEBUG_INFO(trans, "hardware%s ready\n", ret ? " not" : "");
+	return ret;
+}
+
+/* Note: returns standard 0/-ERROR code */
+int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
+{
+	int ret;
+	int iter;
+
+	IWL_DEBUG_INFO(trans, "iwl_trans_prepare_card_hw enter\n");
+
+	ret = iwl_pcie_set_hw_ready(trans);
+	/* If the card is ready, exit 0 */
+	if (!ret) {
+		trans->csme_own = false;
+		return 0;
+	}
+
+	iwl_set_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
+		    CSR_RESET_LINK_PWR_MGMT_DISABLED);
+	usleep_range(1000, 2000);
+
+	for (iter = 0; iter < 10; iter++) {
+		int t = 0;
+
+		/* If HW is not ready, prepare the conditions to check again */
+		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
+			    CSR_HW_IF_CONFIG_REG_WAKE_ME);
+
+		do {
+			ret = iwl_pcie_set_hw_ready(trans);
+			if (!ret) {
+				trans->csme_own = false;
+				return 0;
+			}
+
+			if (iwl_mei_is_connected()) {
+				IWL_DEBUG_INFO(trans,
+					       "Couldn't prepare the card but SAP is connected\n");
+				trans->csme_own = true;
+				if (trans->mac_cfg->device_family !=
+				    IWL_DEVICE_FAMILY_9000)
+					IWL_ERR(trans,
+						"SAP not supported for this NIC family\n");
+
+				return -EBUSY;
+			}
+
+			usleep_range(200, 1000);
+			t += 200;
+		} while (t < 150000);
+		msleep(25);
+	}
+
+	IWL_ERR(trans, "Couldn't prepare the card\n");
+
+	return ret;
+}
+
+/*
+ * ucode
+ */
+static void iwl_pcie_load_firmware_chunk_fh(struct iwl_trans *trans,
+					    u32 dst_addr, dma_addr_t phy_addr,
+					    u32 byte_cnt)
+{
+	iwl_write32(trans, FH_TCSR_CHNL_TX_CONFIG_REG(FH_SRVC_CHNL),
+		    FH_TCSR_TX_CONFIG_REG_VAL_DMA_CHNL_PAUSE);
+
+	iwl_write32(trans, FH_SRVC_CHNL_SRAM_ADDR_REG(FH_SRVC_CHNL),
+		    dst_addr);
+
+	iwl_write32(trans, FH_TFDIB_CTRL0_REG(FH_SRVC_CHNL),
+		    phy_addr & FH_MEM_TFDIB_DRAM_ADDR_LSB_MSK);
+
+	iwl_write32(trans, FH_TFDIB_CTRL1_REG(FH_SRVC_CHNL),
+		    (iwl_get_dma_hi_addr(phy_addr)
+			<< FH_MEM_TFDIB_REG1_ADDR_BITSHIFT) | byte_cnt);
+
+	iwl_write32(trans, FH_TCSR_CHNL_TX_BUF_STS_REG(FH_SRVC_CHNL),
+		    BIT(FH_TCSR_CHNL_TX_BUF_STS_REG_POS_TB_NUM) |
+		    BIT(FH_TCSR_CHNL_TX_BUF_STS_REG_POS_TB_IDX) |
+		    FH_TCSR_CHNL_TX_BUF_STS_REG_VAL_TFDB_VALID);
+
+	iwl_write32(trans, FH_TCSR_CHNL_TX_CONFIG_REG(FH_SRVC_CHNL),
+		    FH_TCSR_TX_CONFIG_REG_VAL_DMA_CHNL_ENABLE |
+		    FH_TCSR_TX_CONFIG_REG_VAL_DMA_CREDIT_DISABLE |
+		    FH_TCSR_TX_CONFIG_REG_VAL_CIRQ_HOST_ENDTFD);
+}
+
+static int iwl_pcie_load_firmware_chunk(struct iwl_trans *trans,
+					u32 dst_addr, dma_addr_t phy_addr,
+					u32 byte_cnt)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int ret;
+
+	trans_pcie->ucode_write_complete = false;
+
+	if (!iwl_trans_grab_nic_access(trans))
+		return -EIO;
+
+	iwl_pcie_load_firmware_chunk_fh(trans, dst_addr, phy_addr,
+					byte_cnt);
+	iwl_trans_release_nic_access(trans);
+
+	ret = wait_event_timeout(trans_pcie->ucode_write_waitq,
+				 trans_pcie->ucode_write_complete, 5 * HZ);
+	if (!ret) {
+		IWL_ERR(trans, "Failed to load firmware chunk!\n");
+		iwl_trans_pcie_dump_regs(trans, trans_pcie->pci_dev);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int iwl_pcie_load_section(struct iwl_trans *trans, u8 section_num,
+			    const struct fw_desc *section)
+{
+	u8 *v_addr;
+	dma_addr_t p_addr;
+	u32 offset, chunk_sz = min_t(u32, FH_MEM_TB_MAX_LENGTH, section->len);
+	int ret = 0;
+
+	IWL_DEBUG_FW(trans, "[%d] uCode section being loaded...\n",
+		     section_num);
+
+	v_addr = dma_alloc_coherent(trans->dev, chunk_sz, &p_addr,
+				    GFP_KERNEL | __GFP_NOWARN);
+	if (!v_addr) {
+		IWL_DEBUG_INFO(trans, "Falling back to small chunks of DMA\n");
+		chunk_sz = PAGE_SIZE;
+		v_addr = dma_alloc_coherent(trans->dev, chunk_sz,
+					    &p_addr, GFP_KERNEL);
+		if (!v_addr)
+			return -ENOMEM;
+	}
+
+	for (offset = 0; offset < section->len; offset += chunk_sz) {
+		u32 copy_size, dst_addr;
+		bool extended_addr = false;
+
+		copy_size = min_t(u32, chunk_sz, section->len - offset);
+		dst_addr = section->offset + offset;
+
+		if (dst_addr >= IWL_FW_MEM_EXTENDED_START &&
+		    dst_addr <= IWL_FW_MEM_EXTENDED_END)
+			extended_addr = true;
+
+		if (extended_addr)
+			iwl_set_bits_prph(trans, LMPM_CHICK,
+					  LMPM_CHICK_EXTENDED_ADDR_SPACE);
+
+		memcpy(v_addr, (const u8 *)section->data + offset, copy_size);
+		ret = iwl_pcie_load_firmware_chunk(trans, dst_addr, p_addr,
+						   copy_size);
+
+		if (extended_addr)
+			iwl_clear_bits_prph(trans, LMPM_CHICK,
+					    LMPM_CHICK_EXTENDED_ADDR_SPACE);
+
+		if (ret) {
+			IWL_ERR(trans,
+				"Could not load the [%d] uCode section\n",
+				section_num);
+			break;
+		}
+	}
+
+	dma_free_coherent(trans->dev, chunk_sz, v_addr, p_addr);
+	return ret;
+}
+
+static int iwl_pcie_load_cpu_sections_8000(struct iwl_trans *trans,
+					   const struct fw_img *image,
+					   int cpu,
+					   int *first_ucode_section)
+{
+	int shift_param;
+	int i, ret = 0, sec_num = 0x1;
+	u32 val, last_read_idx = 0;
+
+	if (cpu == 1) {
+		shift_param = 0;
+		*first_ucode_section = 0;
+	} else {
+		shift_param = 16;
+		(*first_ucode_section)++;
+	}
+
+	for (i = *first_ucode_section; i < image->num_sec; i++) {
+		last_read_idx = i;
+
+		/*
+		 * CPU1_CPU2_SEPARATOR_SECTION delimiter - separate between
+		 * CPU1 to CPU2.
+		 * PAGING_SEPARATOR_SECTION delimiter - separate between
+		 * CPU2 non paged to CPU2 paging sec.
+		 */
+		if (!image->sec[i].data ||
+		    image->sec[i].offset == CPU1_CPU2_SEPARATOR_SECTION ||
+		    image->sec[i].offset == PAGING_SEPARATOR_SECTION) {
+			IWL_DEBUG_FW(trans,
+				     "Break since Data not valid or Empty section, sec = %d\n",
+				     i);
+			break;
+		}
+
+		ret = iwl_pcie_load_section(trans, i, &image->sec[i]);
+		if (ret)
+			return ret;
+
+		/* Notify ucode of loaded section number and status */
+		val = iwl_read_direct32(trans, FH_UCODE_LOAD_STATUS);
+		val = val | (sec_num << shift_param);
+		iwl_write_direct32(trans, FH_UCODE_LOAD_STATUS, val);
+
+		sec_num = (sec_num << 1) | 0x1;
+	}
+
+	*first_ucode_section = last_read_idx;
+
+	iwl_enable_interrupts(trans);
+
+	if (trans->mac_cfg->gen2) {
+		if (cpu == 1)
+			iwl_write_prph(trans, UREG_UCODE_LOAD_STATUS,
+				       0xFFFF);
+		else
+			iwl_write_prph(trans, UREG_UCODE_LOAD_STATUS,
+				       0xFFFFFFFF);
+	} else {
+		if (cpu == 1)
+			iwl_write_direct32(trans, FH_UCODE_LOAD_STATUS,
+					   0xFFFF);
+		else
+			iwl_write_direct32(trans, FH_UCODE_LOAD_STATUS,
+					   0xFFFFFFFF);
+	}
+
+	return 0;
+}
+
+static int iwl_pcie_load_cpu_sections(struct iwl_trans *trans,
+				      const struct fw_img *image,
+				      int cpu,
+				      int *first_ucode_section)
+{
+	int i, ret = 0;
+	u32 last_read_idx = 0;
+
+	if (cpu == 1)
+		*first_ucode_section = 0;
+	else
+		(*first_ucode_section)++;
+
+	for (i = *first_ucode_section; i < image->num_sec; i++) {
+		last_read_idx = i;
+
+		/*
+		 * CPU1_CPU2_SEPARATOR_SECTION delimiter - separate between
+		 * CPU1 to CPU2.
+		 * PAGING_SEPARATOR_SECTION delimiter - separate between
+		 * CPU2 non paged to CPU2 paging sec.
+		 */
+		if (!image->sec[i].data ||
+		    image->sec[i].offset == CPU1_CPU2_SEPARATOR_SECTION ||
+		    image->sec[i].offset == PAGING_SEPARATOR_SECTION) {
+			IWL_DEBUG_FW(trans,
+				     "Break since Data not valid or Empty section, sec = %d\n",
+				     i);
+			break;
+		}
+
+		ret = iwl_pcie_load_section(trans, i, &image->sec[i]);
+		if (ret)
+			return ret;
+	}
+
+	*first_ucode_section = last_read_idx;
+
+	return 0;
+}
+
+static void iwl_pcie_apply_destination_ini(struct iwl_trans *trans)
+{
+	enum iwl_fw_ini_allocation_id alloc_id = IWL_FW_INI_ALLOCATION_ID_DBGC1;
+	struct iwl_fw_ini_allocation_tlv *fw_mon_cfg =
+		&trans->dbg.fw_mon_cfg[alloc_id];
+	struct iwl_dram_data *frag;
+
+	if (!iwl_trans_dbg_ini_valid(trans))
+		return;
+
+	if (le32_to_cpu(fw_mon_cfg->buf_location) ==
+	    IWL_FW_INI_LOCATION_SRAM_PATH) {
+		IWL_DEBUG_FW(trans, "WRT: Applying SMEM buffer destination\n");
+		/* set sram monitor by enabling bit 7 */
+		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
+			    CSR_HW_IF_CONFIG_REG_BIT_MONITOR_SRAM);
+
+		return;
+	}
+
+	if (le32_to_cpu(fw_mon_cfg->buf_location) !=
+	    IWL_FW_INI_LOCATION_DRAM_PATH ||
+	    !trans->dbg.fw_mon_ini[alloc_id].num_frags)
+		return;
+
+	frag = &trans->dbg.fw_mon_ini[alloc_id].frags[0];
+
+	IWL_DEBUG_FW(trans, "WRT: Applying DRAM destination (alloc_id=%u)\n",
+		     alloc_id);
+
+	iwl_write_umac_prph(trans, MON_BUFF_BASE_ADDR_VER2,
+			    frag->physical >> MON_BUFF_SHIFT_VER2);
+	iwl_write_umac_prph(trans, MON_BUFF_END_ADDR_VER2,
+			    (frag->physical + frag->size - 256) >>
+			    MON_BUFF_SHIFT_VER2);
+}
+
+void iwl_pcie_apply_destination(struct iwl_trans *trans)
+{
+	const struct iwl_fw_dbg_dest_tlv_v1 *dest = trans->dbg.dest_tlv;
+	const struct iwl_dram_data *fw_mon = &trans->dbg.fw_mon;
+	int i;
+
+	if (iwl_trans_dbg_ini_valid(trans)) {
+		iwl_pcie_apply_destination_ini(trans);
+		return;
+	}
+
+	IWL_INFO(trans, "Applying debug destination %s\n",
+		 get_fw_dbg_mode_string(dest->monitor_mode));
+
+	if (dest->monitor_mode == EXTERNAL_MODE)
+		iwl_pcie_alloc_fw_monitor(trans, dest->size_power);
+	else
+		IWL_WARN(trans, "PCI should have external buffer debug\n");
+
+	for (i = 0; i < trans->dbg.n_dest_reg; i++) {
+		u32 addr = le32_to_cpu(dest->reg_ops[i].addr);
+		u32 val = le32_to_cpu(dest->reg_ops[i].val);
+
+		switch (dest->reg_ops[i].op) {
+		case CSR_ASSIGN:
+			iwl_write32(trans, addr, val);
+			break;
+		case CSR_SETBIT:
+			iwl_set_bit(trans, addr, BIT(val));
+			break;
+		case CSR_CLEARBIT:
+			iwl_clear_bit(trans, addr, BIT(val));
+			break;
+		case PRPH_ASSIGN:
+			iwl_write_prph(trans, addr, val);
+			break;
+		case PRPH_SETBIT:
+			iwl_set_bits_prph(trans, addr, BIT(val));
+			break;
+		case PRPH_CLEARBIT:
+			iwl_clear_bits_prph(trans, addr, BIT(val));
+			break;
+		case PRPH_BLOCKBIT:
+			if (iwl_read_prph(trans, addr) & BIT(val)) {
+				IWL_ERR(trans,
+					"BIT(%u) in address 0x%x is 1, stopping FW configuration\n",
+					val, addr);
+				goto monitor;
+			}
+			break;
+		default:
+			IWL_ERR(trans, "FW debug - unknown OP %d\n",
+				dest->reg_ops[i].op);
+			break;
+		}
+	}
+
+monitor:
+	if (dest->monitor_mode == EXTERNAL_MODE && fw_mon->size) {
+		iwl_write_prph(trans, le32_to_cpu(dest->base_reg),
+			       fw_mon->physical >> dest->base_shift);
+		if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
+			iwl_write_prph(trans, le32_to_cpu(dest->end_reg),
+				       (fw_mon->physical + fw_mon->size -
+					256) >> dest->end_shift);
+		else
+			iwl_write_prph(trans, le32_to_cpu(dest->end_reg),
+				       (fw_mon->physical + fw_mon->size) >>
+				       dest->end_shift);
+	}
+}
+
+static int iwl_pcie_load_given_ucode(struct iwl_trans *trans,
+				const struct fw_img *image)
+{
+	int ret = 0;
+	int first_ucode_section;
+
+	IWL_DEBUG_FW(trans, "working with %s CPU\n",
+		     image->is_dual_cpus ? "Dual" : "Single");
+
+	/* load to FW the binary non secured sections of CPU1 */
+	ret = iwl_pcie_load_cpu_sections(trans, image, 1, &first_ucode_section);
+	if (ret)
+		return ret;
+
+	if (image->is_dual_cpus) {
+		/* set CPU2 header address */
+		iwl_write_prph(trans,
+			       LMPM_SECURE_UCODE_LOAD_CPU2_HDR_ADDR,
+			       LMPM_SECURE_CPU2_HDR_MEM_SPACE);
+
+		/* load to FW the binary sections of CPU2 */
+		ret = iwl_pcie_load_cpu_sections(trans, image, 2,
+						 &first_ucode_section);
+		if (ret)
+			return ret;
+	}
+
+	if (iwl_pcie_dbg_on(trans))
+		iwl_pcie_apply_destination(trans);
+
+	iwl_enable_interrupts(trans);
+
+	/* release CPU reset */
+	iwl_write32(trans, CSR_RESET, 0);
+
+	return 0;
+}
+
+static int iwl_pcie_load_given_ucode_8000(struct iwl_trans *trans,
+					  const struct fw_img *image)
+{
+	int ret = 0;
+	int first_ucode_section;
+
+	IWL_DEBUG_FW(trans, "working with %s CPU\n",
+		     image->is_dual_cpus ? "Dual" : "Single");
+
+	if (iwl_pcie_dbg_on(trans))
+		iwl_pcie_apply_destination(trans);
+
+	IWL_DEBUG_POWER(trans, "Original WFPM value = 0x%08X\n",
+			iwl_read_prph(trans, WFPM_GP2));
+
+	/*
+	 * Set default value. On resume reading the values that were
+	 * zeored can provide debug data on the resume flow.
+	 * This is for debugging only and has no functional impact.
+	 */
+	iwl_write_prph(trans, WFPM_GP2, 0x01010101);
+
+	/* configure the ucode to be ready to get the secured image */
+	/* release CPU reset */
+	iwl_write_prph(trans, RELEASE_CPU_RESET, RELEASE_CPU_RESET_BIT);
+
+	/* load to FW the binary Secured sections of CPU1 */
+	ret = iwl_pcie_load_cpu_sections_8000(trans, image, 1,
+					      &first_ucode_section);
+	if (ret)
+		return ret;
+
+	/* load to FW the binary sections of CPU2 */
+	return iwl_pcie_load_cpu_sections_8000(trans, image, 2,
+					       &first_ucode_section);
+}
+
+bool iwl_pcie_check_hw_rf_kill(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie =  IWL_TRANS_GET_PCIE_TRANS(trans);
+	bool hw_rfkill = iwl_is_rfkill_set(trans);
+	bool prev = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
+	bool report;
+
+	if (hw_rfkill) {
+		set_bit(STATUS_RFKILL_HW, &trans->status);
+		set_bit(STATUS_RFKILL_OPMODE, &trans->status);
+	} else {
+		clear_bit(STATUS_RFKILL_HW, &trans->status);
+		if (trans_pcie->opmode_down)
+			clear_bit(STATUS_RFKILL_OPMODE, &trans->status);
+	}
+
+	report = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
+
+	if (prev != report)
+		iwl_trans_pcie_rf_kill(trans, report, false);
+
+	return hw_rfkill;
+}
+
+struct iwl_causes_list {
+	u16 mask_reg;
+	u8 bit;
+	u8 addr;
+};
+
+#define IWL_CAUSE(reg, mask)						\
+	{								\
+		.mask_reg = reg,					\
+		.bit = ilog2(mask),					\
+		.addr = ilog2(mask) +					\
+			((reg) == CSR_MSIX_FH_INT_MASK_AD ? -16 :	\
+			 (reg) == CSR_MSIX_HW_INT_MASK_AD ? 16 :	\
+			 0xffff),	/* causes overflow warning */	\
+	}
+
+static const struct iwl_causes_list causes_list_common[] = {
+	IWL_CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_D2S_CH0_NUM),
+	IWL_CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_D2S_CH1_NUM),
+	IWL_CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_S2D),
+	IWL_CAUSE(CSR_MSIX_FH_INT_MASK_AD, MSIX_FH_INT_CAUSES_FH_ERR),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_ALIVE),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_WAKEUP),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_RESET_DONE),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_TOP_FATAL_ERR),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_CT_KILL),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_RF_KILL),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_PERIODIC),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_SCD),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_FH_TX),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_HW_ERR),
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_HAP),
+};
+
+static const struct iwl_causes_list causes_list_pre_bz[] = {
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_SW_ERR),
+};
+
+static const struct iwl_causes_list causes_list_bz[] = {
+	IWL_CAUSE(CSR_MSIX_HW_INT_MASK_AD, MSIX_HW_INT_CAUSES_REG_SW_ERR_BZ),
+};
+
+static void iwl_pcie_map_list(struct iwl_trans *trans,
+			      const struct iwl_causes_list *causes,
+			      int arr_size, int val)
+{
+	int i;
+
+	for (i = 0; i < arr_size; i++) {
+		iwl_write8(trans, CSR_MSIX_IVAR(causes[i].addr), val);
+		iwl_clear_bit(trans, causes[i].mask_reg,
+			      BIT(causes[i].bit));
+	}
+}
+
+static void iwl_pcie_map_non_rx_causes(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie =  IWL_TRANS_GET_PCIE_TRANS(trans);
+	int val = trans_pcie->def_irq | MSIX_NON_AUTO_CLEAR_CAUSE;
+	/*
+	 * Access all non RX causes and map them to the default irq.
+	 * In case we are missing at least one interrupt vector,
+	 * the first interrupt vector will serve non-RX and FBQ causes.
+	 */
+	iwl_pcie_map_list(trans, causes_list_common,
+			  ARRAY_SIZE(causes_list_common), val);
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		iwl_pcie_map_list(trans, causes_list_bz,
+				  ARRAY_SIZE(causes_list_bz), val);
+	else
+		iwl_pcie_map_list(trans, causes_list_pre_bz,
+				  ARRAY_SIZE(causes_list_pre_bz), val);
+}
+
+static void iwl_pcie_map_rx_causes(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	u32 offset =
+		trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_FIRST_RSS ? 1 : 0;
+	u32 val, idx;
+
+	/*
+	 * The first RX queue - fallback queue, which is designated for
+	 * management frame, command responses etc, is always mapped to the
+	 * first interrupt vector. The other RX queues are mapped to
+	 * the other (N - 2) interrupt vectors.
+	 */
+	val = BIT(MSIX_FH_INT_CAUSES_Q(0));
+	for (idx = 1; idx < trans->info.num_rxqs; idx++) {
+		iwl_write8(trans, CSR_MSIX_RX_IVAR(idx),
+			   MSIX_FH_INT_CAUSES_Q(idx - offset));
+		val |= BIT(MSIX_FH_INT_CAUSES_Q(idx));
+	}
+	iwl_write32(trans, CSR_MSIX_FH_INT_MASK_AD, ~val);
+
+	val = MSIX_FH_INT_CAUSES_Q(0);
+	if (trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_NON_RX)
+		val |= MSIX_NON_AUTO_CLEAR_CAUSE;
+	iwl_write8(trans, CSR_MSIX_RX_IVAR(0), val);
+
+	if (trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_FIRST_RSS)
+		iwl_write8(trans, CSR_MSIX_RX_IVAR(1), val);
+}
+
+void iwl_pcie_conf_msix_hw(struct iwl_trans_pcie *trans_pcie)
+{
+	struct iwl_trans *trans = trans_pcie->trans;
+
+	if (!trans_pcie->msix_enabled) {
+		if (trans->mac_cfg->mq_rx_supported &&
+		    test_bit(STATUS_DEVICE_ENABLED, &trans->status))
+			iwl_write_umac_prph(trans, UREG_CHICK,
+					    UREG_CHICK_MSI_ENABLE);
+		return;
+	}
+	/*
+	 * The IVAR table needs to be configured again after reset,
+	 * but if the device is disabled, we can't write to
+	 * prph.
+	 */
+	if (test_bit(STATUS_DEVICE_ENABLED, &trans->status))
+		iwl_write_umac_prph(trans, UREG_CHICK, UREG_CHICK_MSIX_ENABLE);
+
+	/*
+	 * Each cause from the causes list above and the RX causes is
+	 * represented as a byte in the IVAR table. The first nibble
+	 * represents the bound interrupt vector of the cause, the second
+	 * represents no auto clear for this cause. This will be set if its
+	 * interrupt vector is bound to serve other causes.
+	 */
+	iwl_pcie_map_rx_causes(trans);
+
+	iwl_pcie_map_non_rx_causes(trans);
+}
+
+static void iwl_pcie_init_msix(struct iwl_trans_pcie *trans_pcie)
+{
+	struct iwl_trans *trans = trans_pcie->trans;
+
+	iwl_pcie_conf_msix_hw(trans_pcie);
+
+	if (!trans_pcie->msix_enabled)
+		return;
+
+	trans_pcie->fh_init_mask = ~iwl_read32(trans, CSR_MSIX_FH_INT_MASK_AD);
+	trans_pcie->fh_mask = trans_pcie->fh_init_mask;
+	trans_pcie->hw_init_mask = ~iwl_read32(trans, CSR_MSIX_HW_INT_MASK_AD);
+	trans_pcie->hw_mask = trans_pcie->hw_init_mask;
+}
+
+static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans, bool from_irq)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	lockdep_assert_held(&trans_pcie->mutex);
+
+	if (trans_pcie->is_down)
+		return;
+
+	trans_pcie->is_down = true;
+
+	/* tell the device to stop sending interrupts */
+	iwl_disable_interrupts(trans);
+
+	/* device going down, Stop using ICT table */
+	iwl_pcie_disable_ict(trans);
+
+	/*
+	 * If a HW restart happens during firmware loading,
+	 * then the firmware loading might call this function
+	 * and later it might be called again due to the
+	 * restart. So don't process again if the device is
+	 * already dead.
+	 */
+	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
+		IWL_DEBUG_INFO(trans,
+			       "DEVICE_ENABLED bit was set and is now cleared\n");
+		if (!from_irq)
+			iwl_pcie_synchronize_irqs(trans);
+		iwl_pcie_rx_napi_sync(trans);
+		iwl_pcie_tx_stop(trans);
+		iwl_pcie_rx_stop(trans);
+
+		/* Power-down device's busmaster DMA clocks */
+		if (!trans->mac_cfg->base->apmg_not_supported) {
+			iwl_write_prph(trans, APMG_CLK_DIS_REG,
+				       APMG_CLK_VAL_DMA_CLK_RQT);
+			udelay(5);
+		}
+	}
+
+	/* Make sure (redundant) we've released our request to stay awake */
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
+	else
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+
+	/* Stop the device, and put it in low power state */
+	iwl_pcie_apm_stop(trans, false);
+
+	/* re-take ownership to prevent other users from stealing the device */
+	iwl_trans_pcie_sw_reset(trans, true);
+
+	/*
+	 * Upon stop, the IVAR table gets erased, so msi-x won't
+	 * work. This causes a bug in RF-KILL flows, since the interrupt
+	 * that enables radio won't fire on the correct irq, and the
+	 * driver won't be able to handle the interrupt.
+	 * Configure the IVAR table again after reset.
+	 */
+	iwl_pcie_conf_msix_hw(trans_pcie);
+
+	/*
+	 * Upon stop, the APM issues an interrupt if HW RF kill is set.
+	 * This is a bug in certain verions of the hardware.
+	 * Certain devices also keep sending HW RF kill interrupt all
+	 * the time, unless the interrupt is ACKed even if the interrupt
+	 * should be masked. Re-ACK all the interrupts here.
+	 */
+	iwl_disable_interrupts(trans);
+
+	/* clear all status bits */
+	clear_bit(STATUS_SYNC_HCMD_ACTIVE, &trans->status);
+	clear_bit(STATUS_INT_ENABLED, &trans->status);
+	clear_bit(STATUS_TPOWER_PMI, &trans->status);
+
+	/*
+	 * Even if we stop the HW, we still want the RF kill
+	 * interrupt
+	 */
+	iwl_enable_rfkill_int(trans);
+}
+
+void iwl_pcie_synchronize_irqs(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	if (trans_pcie->msix_enabled) {
+		int i;
+
+		for (i = 0; i < trans_pcie->alloc_vecs; i++)
+			synchronize_irq(trans_pcie->msix_entries[i].vector);
+	} else {
+		synchronize_irq(trans_pcie->pci_dev->irq);
+	}
+}
+
+int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
+			    const struct iwl_fw *fw,
+			    const struct fw_img *img,
+			    bool run_in_rfkill)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	bool hw_rfkill;
+	int ret;
+
+	/* This may fail if AMT took ownership of the device */
+	if (iwl_pcie_prepare_card_hw(trans)) {
+		IWL_WARN(trans, "Exit HW not ready\n");
+		return -EIO;
+	}
+
+	iwl_enable_rfkill_int(trans);
+
+	iwl_write32(trans, CSR_INT, 0xFFFFFFFF);
+
+	/*
+	 * We enabled the RF-Kill interrupt and the handler may very
+	 * well be running. Disable the interrupts to make sure no other
+	 * interrupt can be fired.
+	 */
+	iwl_disable_interrupts(trans);
+
+	/* Make sure it finished running */
+	iwl_pcie_synchronize_irqs(trans);
+
+	mutex_lock(&trans_pcie->mutex);
+
+	/* If platform's RF_KILL switch is NOT set to KILL */
+	hw_rfkill = iwl_pcie_check_hw_rf_kill(trans);
+	if (hw_rfkill && !run_in_rfkill) {
+		ret = -ERFKILL;
+		goto out;
+	}
+
+	/* Someone called stop_device, don't try to start_fw */
+	if (trans_pcie->is_down) {
+		IWL_WARN(trans,
+			 "Can't start_fw since the HW hasn't been started\n");
+		ret = -EIO;
+		goto out;
+	}
+
+	/* make sure rfkill handshake bits are cleared */
+	iwl_write32(trans, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_SW_BIT_RFKILL);
+	iwl_write32(trans, CSR_UCODE_DRV_GP1_CLR,
+		    CSR_UCODE_DRV_GP1_BIT_CMD_BLOCKED);
+
+	/* clear (again), then enable host interrupts */
+	iwl_write32(trans, CSR_INT, 0xFFFFFFFF);
+
+	ret = iwl_pcie_nic_init(trans);
+	if (ret) {
+		IWL_ERR(trans, "Unable to init nic\n");
+		goto out;
+	}
+
+	/*
+	 * Now, we load the firmware and don't want to be interrupted, even
+	 * by the RF-Kill interrupt (hence mask all the interrupt besides the
+	 * FH_TX interrupt which is needed to load the firmware). If the
+	 * RF-Kill switch is toggled, we will find out after having loaded
+	 * the firmware and return the proper value to the caller.
+	 */
+	iwl_enable_fw_load_int(trans);
+
+	/* really make sure rfkill handshake bits are cleared */
+	iwl_write32(trans, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_SW_BIT_RFKILL);
+	iwl_write32(trans, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_SW_BIT_RFKILL);
+
+	/* Load the given image to the HW */
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
+		ret = iwl_pcie_load_given_ucode_8000(trans, img);
+	else
+		ret = iwl_pcie_load_given_ucode(trans, img);
+
+	/* re-check RF-Kill state since we may have missed the interrupt */
+	hw_rfkill = iwl_pcie_check_hw_rf_kill(trans);
+	if (hw_rfkill && !run_in_rfkill)
+		ret = -ERFKILL;
+
+out:
+	mutex_unlock(&trans_pcie->mutex);
+	return ret;
+}
+
+void iwl_trans_pcie_fw_alive(struct iwl_trans *trans)
+{
+	iwl_pcie_reset_ict(trans);
+	iwl_pcie_tx_start(trans);
+}
+
+void iwl_trans_pcie_handle_stop_rfkill(struct iwl_trans *trans,
+				       bool was_in_rfkill)
+{
+	bool hw_rfkill;
+
+	/*
+	 * Check again since the RF kill state may have changed while
+	 * all the interrupts were disabled, in this case we couldn't
+	 * receive the RF kill interrupt and update the state in the
+	 * op_mode.
+	 * Don't call the op_mode if the rkfill state hasn't changed.
+	 * This allows the op_mode to call stop_device from the rfkill
+	 * notification without endless recursion. Under very rare
+	 * circumstances, we might have a small recursion if the rfkill
+	 * state changed exactly now while we were called from stop_device.
+	 * This is very unlikely but can happen and is supported.
+	 */
+	hw_rfkill = iwl_is_rfkill_set(trans);
+	if (hw_rfkill) {
+		set_bit(STATUS_RFKILL_HW, &trans->status);
+		set_bit(STATUS_RFKILL_OPMODE, &trans->status);
+	} else {
+		clear_bit(STATUS_RFKILL_HW, &trans->status);
+		clear_bit(STATUS_RFKILL_OPMODE, &trans->status);
+	}
+	if (hw_rfkill != was_in_rfkill)
+		iwl_trans_pcie_rf_kill(trans, hw_rfkill, false);
+}
+
+void iwl_trans_pcie_stop_device(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	bool was_in_rfkill;
+
+	iwl_op_mode_time_point(trans->op_mode,
+			       IWL_FW_INI_TIME_POINT_HOST_DEVICE_DISABLE,
+			       NULL);
+
+	mutex_lock(&trans_pcie->mutex);
+	trans_pcie->opmode_down = true;
+	was_in_rfkill = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
+	_iwl_trans_pcie_stop_device(trans, false);
+	iwl_trans_pcie_handle_stop_rfkill(trans, was_in_rfkill);
+	mutex_unlock(&trans_pcie->mutex);
+}
+
+void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq)
+{
+	struct iwl_trans_pcie __maybe_unused *trans_pcie =
+		IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	lockdep_assert_held(&trans_pcie->mutex);
+
+	IWL_WARN(trans, "reporting RF_KILL (radio %s)\n",
+		 state ? "disabled" : "enabled");
+	if (iwl_op_mode_hw_rf_kill(trans->op_mode, state) &&
+	    !WARN_ON(trans->mac_cfg->gen2))
+		_iwl_trans_pcie_stop_device(trans, from_irq);
+}
+
+static void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
+					 bool reset)
+{
+	iwl_disable_interrupts(trans);
+
+	iwl_pcie_disable_ict(trans);
+
+	iwl_pcie_synchronize_irqs(trans);
+
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_MAC_INIT);
+	} else {
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
+	}
+
+	if (reset) {
+		/*
+		 * reset TX queues -- some of their registers reset during S3
+		 * so if we don't reset everything here the D3 image would try
+		 * to execute some invalid memory upon resume
+		 */
+		iwl_trans_pcie_tx_reset(trans);
+	}
+
+	iwl_pcie_set_pwr(trans, true);
+}
+
+static int iwl_pcie_d3_handshake(struct iwl_trans *trans, bool suspend)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int ret;
+
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+		return 0;
+
+	trans_pcie->sx_state = IWL_SX_WAITING;
+
+	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_AX210)
+		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
+				    suspend ? UREG_DOORBELL_TO_ISR6_SUSPEND :
+					      UREG_DOORBELL_TO_ISR6_RESUME);
+	else
+		iwl_write32(trans, CSR_IPC_SLEEP_CONTROL,
+			    suspend ? CSR_IPC_SLEEP_CONTROL_SUSPEND :
+				      CSR_IPC_SLEEP_CONTROL_RESUME);
+
+	ret = wait_event_timeout(trans_pcie->sx_waitq,
+				 trans_pcie->sx_state != IWL_SX_WAITING,
+				 2 * HZ);
+	if (!ret) {
+		IWL_ERR(trans, "Timeout %s D3\n",
+			suspend ? "entering" : "exiting");
+		ret = -ETIMEDOUT;
+	} else {
+		ret = 0;
+	}
+
+	if (trans_pcie->sx_state == IWL_SX_ERROR) {
+		IWL_ERR(trans, "FW error while %s D3\n",
+			suspend ? "entering" : "exiting");
+		ret = -EIO;
+	}
+
+	/* Invalidate it toward next suspend or resume */
+	trans_pcie->sx_state = IWL_SX_INVALID;
+
+	return ret;
+}
+
+int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool reset)
+{
+	int ret;
+
+	if (!reset)
+		/* Enable persistence mode to avoid reset */
+		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
+			    CSR_HW_IF_CONFIG_REG_PERSISTENCE);
+
+	ret = iwl_pcie_d3_handshake(trans, true);
+	if (ret)
+		return ret;
+
+	iwl_pcie_d3_complete_suspend(trans, reset);
+
+	return 0;
+}
+
+int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
+			     bool reset)
+{
+	struct iwl_trans_pcie *trans_pcie =  IWL_TRANS_GET_PCIE_TRANS(trans);
+	u32 val;
+	int ret;
+
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
+	else
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+
+	ret = iwl_trans_activate_nic(trans);
+	if (ret) {
+		IWL_ERR(trans, "Failed to init nic upon resume. err = %d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * Reconfigure IVAR table in case of MSIX or reset ict table in
+	 * MSI mode since HW reset erased it.
+	 * Also enables interrupts - none will happen as
+	 * the device doesn't know we're waking it up, only when
+	 * the opmode actually tells it after this call.
+	 */
+	iwl_pcie_conf_msix_hw(trans_pcie);
+	if (!trans_pcie->msix_enabled)
+		iwl_pcie_reset_ict(trans);
+	iwl_enable_interrupts(trans);
+
+	iwl_pcie_set_pwr(trans, false);
+
+	if (!reset) {
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+	} else {
+		iwl_trans_pcie_tx_reset(trans);
+
+		ret = iwl_pcie_rx_init(trans);
+		if (ret) {
+			IWL_ERR(trans,
+				"Failed to resume the device (RX reset)\n");
+			return ret;
+		}
+	}
+
+	IWL_DEBUG_POWER(trans, "WFPM value upon resume = 0x%08X\n",
+			iwl_read_umac_prph(trans, WFPM_GP2));
+
+	val = iwl_read32(trans, CSR_RESET);
+	if (val & CSR_RESET_REG_FLAG_NEVO_RESET) {
+		IWL_INFO(trans, "Device was reset during suspend\n");
+		trans->state = IWL_TRANS_NO_FW;
+		return -ENOENT;
+	}
+
+	return iwl_pcie_d3_handshake(trans, false);
+}
+
+static void
+iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
+			    struct iwl_trans *trans,
+			    const struct iwl_mac_cfg *mac_cfg,
+			    struct iwl_trans_info *info)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int max_irqs, num_irqs, i, ret;
+	u16 pci_cmd;
+	u32 max_rx_queues = IWL_MAX_RX_HW_QUEUES;
+
+	if (!mac_cfg->mq_rx_supported)
+		goto enable_msi;
+
+	if (mac_cfg->device_family <= IWL_DEVICE_FAMILY_9000)
+		max_rx_queues = IWL_9000_MAX_RX_HW_QUEUES;
+
+	max_irqs = min_t(u32, num_online_cpus() + 2, max_rx_queues);
+	for (i = 0; i < max_irqs; i++)
+		trans_pcie->msix_entries[i].entry = i;
+
+	num_irqs = pci_enable_msix_range(pdev, trans_pcie->msix_entries,
+					 MSIX_MIN_INTERRUPT_VECTORS,
+					 max_irqs);
+	if (num_irqs < 0) {
+		IWL_DEBUG_INFO(trans,
+			       "Failed to enable msi-x mode (ret %d). Moving to msi mode.\n",
+			       num_irqs);
+		goto enable_msi;
+	}
+	trans_pcie->def_irq = (num_irqs == max_irqs) ? num_irqs - 1 : 0;
+
+	IWL_DEBUG_INFO(trans,
+		       "MSI-X enabled. %d interrupt vectors were allocated\n",
+		       num_irqs);
+
+	/*
+	 * In case the OS provides fewer interrupts than requested, different
+	 * causes will share the same interrupt vector as follows:
+	 * One interrupt less: non rx causes shared with FBQ.
+	 * Two interrupts less: non rx causes shared with FBQ and RSS.
+	 * More than two interrupts: we will use fewer RSS queues.
+	 */
+	if (num_irqs <= max_irqs - 2) {
+		info->num_rxqs = num_irqs + 1;
+		trans_pcie->shared_vec_mask = IWL_SHARED_IRQ_NON_RX |
+			IWL_SHARED_IRQ_FIRST_RSS;
+	} else if (num_irqs == max_irqs - 1) {
+		info->num_rxqs = num_irqs;
+		trans_pcie->shared_vec_mask = IWL_SHARED_IRQ_NON_RX;
+	} else {
+		info->num_rxqs = num_irqs - 1;
+	}
+
+	IWL_DEBUG_INFO(trans,
+		       "MSI-X enabled with rx queues %d, vec mask 0x%x\n",
+		       info->num_rxqs, trans_pcie->shared_vec_mask);
+
+	WARN_ON(info->num_rxqs > IWL_MAX_RX_HW_QUEUES);
+
+	trans_pcie->alloc_vecs = num_irqs;
+	trans_pcie->msix_enabled = true;
+	return;
+
+enable_msi:
+	info->num_rxqs = 1;
+	ret = pci_enable_msi(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "pci_enable_msi failed - %d\n", ret);
+		/* enable rfkill interrupt: hw bug w/a */
+		pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
+		if (pci_cmd & PCI_COMMAND_INTX_DISABLE) {
+			pci_cmd &= ~PCI_COMMAND_INTX_DISABLE;
+			pci_write_config_word(pdev, PCI_COMMAND, pci_cmd);
+		}
+	}
+}
+
+static void iwl_pcie_irq_set_affinity(struct iwl_trans *trans,
+				      struct iwl_trans_info *info)
+{
+#if defined(CONFIG_SMP)
+	int iter_rx_q, i, ret, cpu, offset;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	i = trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_FIRST_RSS ? 0 : 1;
+	iter_rx_q = info->num_rxqs - 1 + i;
+	offset = 1 + i;
+	for (; i < iter_rx_q ; i++) {
+		/*
+		 * Get the cpu prior to the place to search
+		 * (i.e. return will be > i - 1).
+		 */
+		/*
+		 * Balanced distribution: skip CPU0 for high-rate RSS queues
+		 * to avoid contention with system housekeeping.
+		 */
+		cpu = cpumask_next(i - offset, cpu_online_mask);
+		if (cpu >= nr_cpu_ids)
+			cpu = cpumask_first(cpu_online_mask);
+		
+		if (cpu == 0 && num_online_cpus() > 1)
+			cpu = cpumask_next(0, cpu_online_mask);
+
+		cpumask_set_cpu(cpu, &trans_pcie->affinity_mask[i]);
+		ret = irq_set_affinity_hint(trans_pcie->msix_entries[i].vector,
+					    &trans_pcie->affinity_mask[i]);
+		if (ret)
+			IWL_ERR(trans_pcie->trans,
+				"Failed to set affinity mask for IRQ %d\n",
+				trans_pcie->msix_entries[i].vector);
+	}
+#endif
+}
+
+static int iwl_pcie_init_msix_handler(struct pci_dev *pdev,
+				      struct iwl_trans_pcie *trans_pcie,
+				      struct iwl_trans_info *info)
+{
+	int i;
+
+	for (i = 0; i < trans_pcie->alloc_vecs; i++) {
+		int ret;
+		struct msix_entry *msix_entry;
+		const char *qname = queue_name(&pdev->dev, trans_pcie, i);
+
+		if (!qname)
+			return -ENOMEM;
+
+		msix_entry = &trans_pcie->msix_entries[i];
+		ret = devm_request_threaded_irq(&pdev->dev,
+						msix_entry->vector,
+						iwl_pcie_msix_isr,
+						(i == trans_pcie->def_irq) ?
+						iwl_pcie_irq_msix_handler :
+						iwl_pcie_irq_rx_msix_handler,
+						IRQF_SHARED,
+						qname,
+						msix_entry);
+		if (ret) {
+			IWL_ERR(trans_pcie->trans,
+				"Error allocating IRQ %d\n", i);
+
+			return ret;
+		}
+	}
+	iwl_pcie_irq_set_affinity(trans_pcie->trans, info);
+
+	return 0;
+}
+
+static int iwl_trans_pcie_clear_persistence_bit(struct iwl_trans *trans)
+{
+	u32 hpm, wprot;
+
+	switch (trans->mac_cfg->device_family) {
+	case IWL_DEVICE_FAMILY_9000:
+		wprot = PREG_PRPH_WPROT_9000;
+		break;
+	case IWL_DEVICE_FAMILY_22000:
+		wprot = PREG_PRPH_WPROT_22000;
+		break;
+	default:
+		return 0;
+	}
+
+	hpm = iwl_read_umac_prph_no_grab(trans, HPM_DEBUG);
+	if (!iwl_trans_is_hw_error_value(hpm) && (hpm & PERSISTENCE_BIT)) {
+		u32 wprot_val = iwl_read_umac_prph_no_grab(trans, wprot);
+
+		if (wprot_val & PREG_WFPM_ACCESS) {
+			IWL_ERR(trans,
+				"Error, can not clear persistence bit\n");
+			return -EPERM;
+		}
+		iwl_write_umac_prph_no_grab(trans, HPM_DEBUG,
+					    hpm & ~PERSISTENCE_BIT);
+	}
+
+	return 0;
+}
+
+static int iwl_pcie_gen2_force_power_gating(struct iwl_trans *trans)
+{
+	int ret;
+
+	ret = iwl_trans_activate_nic(trans);
+	if (ret < 0)
+		return ret;
+
+	iwl_set_bits_prph(trans, HPM_HIPM_GEN_CFG,
+			  HPM_HIPM_GEN_CFG_CR_FORCE_ACTIVE);
+	udelay(20);
+	iwl_set_bits_prph(trans, HPM_HIPM_GEN_CFG,
+			  HPM_HIPM_GEN_CFG_CR_PG_EN |
+			  HPM_HIPM_GEN_CFG_CR_SLP_EN);
+	udelay(20);
+	iwl_clear_bits_prph(trans, HPM_HIPM_GEN_CFG,
+			    HPM_HIPM_GEN_CFG_CR_FORCE_ACTIVE);
+
+	return iwl_trans_pcie_sw_reset(trans, true);
+}
+
+int _iwl_trans_pcie_start_hw(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int err;
+
+	lockdep_assert_held(&trans_pcie->mutex);
+
+	err = iwl_pcie_prepare_card_hw(trans);
+	if (err) {
+		IWL_ERR(trans, "Error while preparing HW: %d\n", err);
+		return err;
+	}
+
+	err = iwl_trans_pcie_clear_persistence_bit(trans);
+	if (err)
+		return err;
+
+	err = iwl_trans_pcie_sw_reset(trans, true);
+	if (err)
+		return err;
+
+	if (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_22000 &&
+	    trans->mac_cfg->integrated) {
+		err = iwl_pcie_gen2_force_power_gating(trans);
+		if (err)
+			return err;
+	}
+
+	err = iwl_pcie_apm_init(trans);
+	if (err)
+		return err;
+
+	iwl_pcie_init_msix(trans_pcie);
+
+	/* From now on, the op_mode will be kept updated about RF kill state */
+	iwl_enable_rfkill_int(trans);
+
+	trans_pcie->opmode_down = false;
+
+	/* Set is_down to false here so that...*/
+	trans_pcie->is_down = false;
+
+	/* ...rfkill can call stop_device and set it false if needed */
+	iwl_pcie_check_hw_rf_kill(trans);
+
+	return 0;
+}
+
+int iwl_trans_pcie_start_hw(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int ret;
+
+	mutex_lock(&trans_pcie->mutex);
+	ret = _iwl_trans_pcie_start_hw(trans);
+	mutex_unlock(&trans_pcie->mutex);
+
+	return ret;
+}
+
+void iwl_trans_pcie_op_mode_leave(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	mutex_lock(&trans_pcie->mutex);
+
+	/* disable interrupts - don't enable HW RF kill interrupt */
+	iwl_disable_interrupts(trans);
+
+	iwl_pcie_apm_stop(trans, true);
+
+	iwl_disable_interrupts(trans);
+
+	iwl_pcie_disable_ict(trans);
+
+	mutex_unlock(&trans_pcie->mutex);
+
+	iwl_pcie_synchronize_irqs(trans);
+}
+
+void iwl_trans_pcie_write8(struct iwl_trans *trans, u32 ofs, u8 val)
+{
+	writeb(val, IWL_TRANS_GET_PCIE_TRANS(trans)->hw_base + ofs);
+}
+
+void iwl_trans_pcie_write32(struct iwl_trans *trans, u32 ofs, u32 val)
+{
+	writel(val, IWL_TRANS_GET_PCIE_TRANS(trans)->hw_base + ofs);
+}
+
+u32 iwl_trans_pcie_read32(struct iwl_trans *trans, u32 ofs)
+{
+	return readl(IWL_TRANS_GET_PCIE_TRANS(trans)->hw_base + ofs);
+}
+
+static u32 iwl_trans_pcie_prph_msk(struct iwl_trans *trans)
+{
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		return 0x00FFFFFF;
+	else
+		return 0x000FFFFF;
+}
+
+u32 iwl_trans_pcie_read_prph(struct iwl_trans *trans, u32 reg)
+{
+	u32 mask = iwl_trans_pcie_prph_msk(trans);
+
+	iwl_trans_pcie_write32(trans, HBUS_TARG_PRPH_RADDR,
+			       ((reg & mask) | (3 << 24)));
+	return iwl_trans_pcie_read32(trans, HBUS_TARG_PRPH_RDAT);
+}
+
+void iwl_trans_pcie_write_prph(struct iwl_trans *trans, u32 addr, u32 val)
+{
+	u32 mask = iwl_trans_pcie_prph_msk(trans);
+
+	iwl_trans_pcie_write32(trans, HBUS_TARG_PRPH_WADDR,
+			       ((addr & mask) | (3 << 24)));
+	iwl_trans_pcie_write32(trans, HBUS_TARG_PRPH_WDAT, val);
+}
+
+void iwl_pcie_gen1_2_op_mode_enter(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	/* free all first - we might be reconfigured for a different size */
+	iwl_pcie_free_rbs_pool(trans);
+
+	trans_pcie->rx_page_order =
+		iwl_trans_get_rb_size_order(trans->conf.rx_buf_size);
+	trans_pcie->rx_buf_bytes =
+		iwl_trans_get_rb_size(trans->conf.rx_buf_size);
+}
+
+void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_regions,
+					   struct device *dev)
+{
+	u8 i;
+	struct iwl_dram_data *desc_dram = &dram_regions->prph_scratch_mem_desc;
+
+	/* free DRAM payloads */
+	for (i = 0; i < dram_regions->n_regions; i++) {
+		dma_free_coherent(dev, dram_regions->drams[i].size,
+				  dram_regions->drams[i].block,
+				  dram_regions->drams[i].physical);
+	}
+	dram_regions->n_regions = 0;
+
+	/* free DRAM addresses array */
+	if (desc_dram->block) {
+		dma_free_coherent(dev, desc_dram->size,
+				  desc_dram->block,
+				  desc_dram->physical);
+	}
+	memset(desc_dram, 0, sizeof(*desc_dram));
+}
+
+static void iwl_pcie_free_invalid_tx_cmd(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	iwl_pcie_free_dma_ptr(trans, &trans_pcie->invalid_tx_cmd);
+}
+
+static int iwl_pcie_alloc_invalid_tx_cmd(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_cmd_header_wide bad_cmd = {
+		.cmd = INVALID_WR_PTR_CMD,
+		.group_id = DEBUG_GROUP,
+		.sequence = cpu_to_le16(0xffff),
+		.length = cpu_to_le16(0),
+		.version = 0,
+	};
+	int ret;
+
+	ret = iwl_pcie_alloc_dma_ptr(trans, &trans_pcie->invalid_tx_cmd,
+				     sizeof(bad_cmd));
+	if (ret)
+		return ret;
+	memcpy(trans_pcie->invalid_tx_cmd.addr, &bad_cmd, sizeof(bad_cmd));
+	return 0;
+}
+
+void iwl_trans_pcie_free(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int i;
+
+	iwl_pcie_synchronize_irqs(trans);
+
+	if (trans->mac_cfg->gen2)
+		iwl_txq_gen2_tx_free(trans);
+	else
+		iwl_pcie_tx_free(trans);
+	iwl_pcie_rx_free(trans);
+
+	if (trans_pcie->rba.alloc_wq) {
+		destroy_workqueue(trans_pcie->rba.alloc_wq);
+		trans_pcie->rba.alloc_wq = NULL;
+	}
+
+	if (trans_pcie->msix_enabled) {
+		for (i = 0; i < trans_pcie->alloc_vecs; i++) {
+			irq_set_affinity_hint(
+				trans_pcie->msix_entries[i].vector,
+				NULL);
+		}
+
+		trans_pcie->msix_enabled = false;
+	} else {
+		iwl_pcie_free_ict(trans);
+	}
+
+	free_netdev(trans_pcie->napi_dev);
+
+	iwl_pcie_free_invalid_tx_cmd(trans);
+
+	iwl_pcie_free_fw_monitor(trans);
+
+	iwl_trans_pcie_free_pnvm_dram_regions(&trans_pcie->pnvm_data,
+					      trans->dev);
+	iwl_trans_pcie_free_pnvm_dram_regions(&trans_pcie->reduced_tables_data,
+					      trans->dev);
+
+	mutex_destroy(&trans_pcie->mutex);
+
+	if (trans_pcie->txqs.tso_hdr_page) {
+		for_each_possible_cpu(i) {
+			struct iwl_tso_hdr_page *p =
+				per_cpu_ptr(trans_pcie->txqs.tso_hdr_page, i);
+
+			if (p && p->page)
+				__free_page(p->page);
+		}
+
+		free_percpu(trans_pcie->txqs.tso_hdr_page);
+	}
+
+	kmem_cache_destroy(trans_pcie->dev_cmd_pool);
+	iwl_trans_free(trans);
+}
+
+static union acpi_object *
+iwl_trans_pcie_call_prod_reset_dsm(struct pci_dev *pdev, u16 cmd, u16 value)
+{
+#ifdef CONFIG_ACPI
+	struct iwl_dsm_internal_product_reset_cmd pldr_arg = {
+		.cmd = cmd,
+		.value = value,
+	};
+	union acpi_object arg = {
+		.buffer.type = ACPI_TYPE_BUFFER,
+		.buffer.length = sizeof(pldr_arg),
+		.buffer.pointer = (void *)&pldr_arg,
+	};
+	static const guid_t dsm_guid = GUID_INIT(0x7266172C, 0x220B, 0x4B29,
+						 0x81, 0x4F, 0x75, 0xE4,
+						 0xDD, 0x26, 0xB5, 0xFD);
+
+	if (!acpi_check_dsm(ACPI_HANDLE(&pdev->dev), &dsm_guid, ACPI_DSM_REV,
+			    DSM_INTERNAL_FUNC_PRODUCT_RESET))
+		return ERR_PTR(-ENODEV);
+
+	return iwl_acpi_get_dsm_object(&pdev->dev, ACPI_DSM_REV,
+				       DSM_INTERNAL_FUNC_PRODUCT_RESET,
+				       &arg, &dsm_guid);
+#else
+	return ERR_PTR(-EOPNOTSUPP);
+#endif
+}
+
+void iwl_trans_pcie_check_product_reset_mode(struct pci_dev *pdev)
+{
+	union acpi_object *res;
+
+	res = iwl_trans_pcie_call_prod_reset_dsm(pdev,
+						 DSM_INTERNAL_PLDR_CMD_GET_MODE,
+						 0);
+	if (IS_ERR(res))
+		return;
+
+	if (res->type != ACPI_TYPE_INTEGER)
+		IWL_ERR_DEV(&pdev->dev,
+			    "unexpected return type from product reset DSM\n");
+	else
+		IWL_DEBUG_DEV_POWER(&pdev->dev,
+				    "product reset mode is 0x%llx\n",
+				    res->integer.value);
+
+	ACPI_FREE(res);
+}
+
+static void iwl_trans_pcie_set_product_reset(struct pci_dev *pdev, bool enable,
+					     bool integrated)
+{
+	union acpi_object *res;
+	u16 mode = enable ? DSM_INTERNAL_PLDR_MODE_EN_PROD_RESET : 0;
+
+	if (!integrated)
+		mode |= DSM_INTERNAL_PLDR_MODE_EN_WIFI_FLR |
+			DSM_INTERNAL_PLDR_MODE_EN_BT_OFF_ON;
+
+	res = iwl_trans_pcie_call_prod_reset_dsm(pdev,
+						 DSM_INTERNAL_PLDR_CMD_SET_MODE,
+						 mode);
+	if (IS_ERR(res)) {
+		if (enable)
+			IWL_ERR_DEV(&pdev->dev,
+				    "ACPI _DSM not available (%d), cannot do product reset\n",
+				    (int)PTR_ERR(res));
+		return;
+	}
+
+	ACPI_FREE(res);
+	IWL_DEBUG_DEV_POWER(&pdev->dev, "%sabled product reset via DSM\n",
+			    enable ? "En" : "Dis");
+	iwl_trans_pcie_check_product_reset_mode(pdev);
+}
+
+void iwl_trans_pcie_check_product_reset_status(struct pci_dev *pdev)
+{
+	union acpi_object *res;
+
+	res = iwl_trans_pcie_call_prod_reset_dsm(pdev,
+						 DSM_INTERNAL_PLDR_CMD_GET_STATUS,
+						 0);
+	if (IS_ERR(res))
+		return;
+
+	if (res->type != ACPI_TYPE_INTEGER)
+		IWL_ERR_DEV(&pdev->dev,
+			    "unexpected return type from product reset DSM\n");
+	else
+		IWL_DEBUG_DEV_POWER(&pdev->dev,
+				    "product reset status is 0x%llx\n",
+				    res->integer.value);
+
+	ACPI_FREE(res);
+}
+
+static void iwl_trans_pcie_call_reset(struct pci_dev *pdev)
+{
+#ifdef CONFIG_ACPI
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *p, *ref;
+	acpi_status status;
+	int ret = -EINVAL;
+
+	status = acpi_evaluate_object(ACPI_HANDLE(&pdev->dev),
+				      "_PRR", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		IWL_DEBUG_DEV_POWER(&pdev->dev, "No _PRR method found\n");
+		goto out;
+	}
+	p = buffer.pointer;
+
+	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 1) {
+		pci_err(pdev, "Bad _PRR return type\n");
+		goto out;
+	}
+
+	ref = &p->package.elements[0];
+	if (ref->type != ACPI_TYPE_LOCAL_REFERENCE) {
+		pci_err(pdev, "_PRR wasn't a reference\n");
+		goto out;
+	}
+
+	status = acpi_evaluate_object(ref->reference.handle,
+				      "_RST", NULL, NULL);
+	if (ACPI_FAILURE(status)) {
+		pci_err(pdev,
+			"Failed to call _RST on object returned by _PRR (%d)\n",
+			status);
+		goto out;
+	}
+	ret = 0;
+out:
+	kfree(buffer.pointer);
+	if (!ret) {
+		IWL_DEBUG_DEV_POWER(&pdev->dev, "called _RST on _PRR object\n");
+		return;
+	}
+	IWL_DEBUG_DEV_POWER(&pdev->dev,
+			    "No BIOS support, using pci_reset_function()\n");
+#endif
+	pci_reset_function(pdev);
+}
+
+struct iwl_trans_pcie_removal {
+	struct pci_dev *pdev;
+	struct work_struct work;
+	enum iwl_reset_mode mode;
+	bool integrated;
+};
+
+static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
+{
+	struct iwl_trans_pcie_removal *removal =
+		container_of(wk, struct iwl_trans_pcie_removal, work);
+	struct pci_dev *pdev = removal->pdev;
+	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
+	struct pci_bus *bus;
+
+	pci_lock_rescan_remove();
+
+	bus = pdev->bus;
+	/* in this case, something else already removed the device */
+	if (!bus)
+		goto out;
+
+	kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, prop);
+
+	if (removal->mode == IWL_RESET_MODE_PROD_RESET) {
+		struct pci_dev *bt = NULL;
+
+		if (!removal->integrated) {
+			/* discrete devices have WiFi/BT at function 0/1 */
+			int slot = PCI_SLOT(pdev->devfn);
+			int func = PCI_FUNC(pdev->devfn);
+
+			if (func == 0)
+				bt = pci_get_slot(bus, PCI_DEVFN(slot, 1));
+			else
+				pci_info(pdev, "Unexpected function %d\n",
+					 func);
+		} else {
+			/* on integrated we have to look up by ID (same bus) */
+			static const struct pci_device_id bt_device_ids[] = {
+#define BT_DEV(_id) { PCI_DEVICE(PCI_VENDOR_ID_INTEL, _id) }
+				BT_DEV(0xA876), /* LNL */
+				BT_DEV(0xE476), /* PTL-P */
+				BT_DEV(0xE376), /* PTL-H */
+				BT_DEV(0xD346), /* NVL-H */
+				BT_DEV(0x6E74), /* NVL-S */
+				BT_DEV(0x4D76), /* WCL */
+				BT_DEV(0xD246), /* RZL-H */
+				BT_DEV(0x6C46), /* RZL-M */
+				{}
+			};
+			struct pci_dev *tmp = NULL;
+
+			for_each_pci_dev(tmp) {
+				if (tmp->bus != bus)
+					continue;
+
+				if (pci_match_id(bt_device_ids, tmp)) {
+					bt = tmp;
+					break;
+				}
+			}
+		}
+
+		if (bt) {
+			pci_info(bt, "Removal by WiFi due to product reset\n");
+			pci_stop_and_remove_bus_device(bt);
+			pci_dev_put(bt);
+		}
+	}
+
+	iwl_trans_pcie_set_product_reset(pdev,
+					 removal->mode ==
+						IWL_RESET_MODE_PROD_RESET,
+					 removal->integrated);
+	if (removal->mode >= IWL_RESET_MODE_FUNC_RESET)
+		iwl_trans_pcie_call_reset(pdev);
+
+	pci_stop_and_remove_bus_device(pdev);
+	pci_dev_put(pdev);
+
+	if (removal->mode >= IWL_RESET_MODE_RESCAN) {
+		if (bus->parent)
+			bus = bus->parent;
+		pci_rescan_bus(bus);
+	}
+
+out:
+	pci_unlock_rescan_remove();
+
+	kfree(removal);
+	module_put(THIS_MODULE);
+}
+
+void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_trans_pcie_removal *removal;
+	char _msg = 0, *msg = &_msg;
+
+	if (WARN_ON(mode < IWL_RESET_MODE_REMOVE_ONLY ||
+		    mode == IWL_RESET_MODE_BACKOFF))
+		return;
+
+	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
+		return;
+
+	if (trans_pcie->me_present && mode == IWL_RESET_MODE_PROD_RESET) {
+		mode = IWL_RESET_MODE_FUNC_RESET;
+		if (trans_pcie->me_present < 0)
+			msg = " instead of product reset as ME may be present";
+		else
+			msg = " instead of product reset as ME is present";
+	}
+
+	IWL_INFO(trans, "scheduling reset (mode=%d%s)\n", mode, msg);
+
+	iwl_pcie_dump_csr(trans);
+
+	/*
+	 * get a module reference to avoid doing this
+	 * while unloading anyway and to avoid
+	 * scheduling a work with code that's being
+	 * removed.
+	 */
+	if (!try_module_get(THIS_MODULE)) {
+		IWL_ERR(trans,
+			"Module is being unloaded - abort\n");
+		return;
+	}
+
+	removal = kzalloc_obj(*removal, GFP_ATOMIC);
+	if (!removal) {
+		module_put(THIS_MODULE);
+		return;
+	}
+	/*
+	 * we don't need to clear this flag, because
+	 * the trans will be freed and reallocated.
+	 */
+	set_bit(STATUS_TRANS_DEAD, &trans->status);
+
+	removal->pdev = to_pci_dev(trans->dev);
+	removal->mode = mode;
+	removal->integrated = trans->mac_cfg->integrated;
+	INIT_WORK(&removal->work, iwl_trans_pcie_removal_wk);
+	pci_dev_get(removal->pdev);
+	schedule_work(&removal->work);
+}
+EXPORT_SYMBOL(iwl_trans_pcie_reset);
+
+/*
+ * This version doesn't disable BHs but rather assumes they're
+ * already disabled.
+ */
+bool _iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent)
+{
+	int ret;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	u32 write = CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ;
+	u32 mask = CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY |
+		   CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP;
+	u32 poll = CSR_GP_CNTRL_REG_VAL_MAC_ACCESS_EN;
+
+	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
+		return false;
+
+	spin_lock(&trans_pcie->reg_lock);
+
+	if (trans_pcie->cmd_hold_nic_awake)
+		goto out;
+
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		write = CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ;
+		mask = CSR_GP_CNTRL_REG_FLAG_MAC_STATUS;
+		poll = CSR_GP_CNTRL_REG_FLAG_MAC_STATUS;
+	}
+
+	/* this bit wakes up the NIC */
+	iwl_trans_set_bit(trans, CSR_GP_CNTRL, write);
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
+		udelay(2);
+
+	/*
+	 * These bits say the device is running, and should keep running for
+	 * at least a short while (at least as long as MAC_ACCESS_REQ stays 1),
+	 * but they do not indicate that embedded SRAM is restored yet;
+	 * HW with volatile SRAM must save/restore contents to/from
+	 * host DRAM when sleeping/waking for power-saving.
+	 * Each direction takes approximately 1/4 millisecond; with this
+	 * overhead, it's a good idea to grab and hold MAC_ACCESS_REQUEST if a
+	 * series of register accesses are expected (e.g. reading Event Log),
+	 * to keep device from sleeping.
+	 *
+	 * CSR_UCODE_DRV_GP1 register bit MAC_SLEEP == 0 indicates that
+	 * SRAM is okay/restored.  We don't check that here because this call
+	 * is just for hardware register access; but GP1 MAC_SLEEP
+	 * check is a good idea before accessing the SRAM of HW with
+	 * volatile SRAM (e.g. reading Event Log).
+	 *
+	 * 5000 series and later (including 1000 series) have non-volatile SRAM,
+	 * and do not save/restore SRAM when power cycling.
+	 */
+	ret = iwl_poll_bits_mask(trans, CSR_GP_CNTRL, poll, mask, 15000);
+	if (unlikely(ret)) {
+		u32 cntrl = iwl_read32(trans, CSR_GP_CNTRL);
+
+		if (silent) {
+			spin_unlock(&trans_pcie->reg_lock);
+			return false;
+		}
+
+		WARN_ONCE(1,
+			  "Timeout waiting for hardware access (CSR_GP_CNTRL 0x%08x)\n",
+			  cntrl);
+
+		iwl_trans_pcie_dump_regs(trans, trans_pcie->pci_dev);
+
+		if (iwlwifi_mod_params.remove_when_gone && cntrl == ~0U)
+			iwl_trans_pcie_reset(trans,
+					     IWL_RESET_MODE_REMOVE_ONLY);
+		else
+			iwl_write32(trans, CSR_RESET,
+				    CSR_RESET_REG_FLAG_FORCE_NMI);
+
+		spin_unlock(&trans_pcie->reg_lock);
+		return false;
+	}
+
+out:
+	/*
+	 * Fool sparse by faking we release the lock - sparse will
+	 * track nic_access anyway.
+	 */
+	__release(&trans_pcie->reg_lock);
+	return true;
+}
+
+bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
+{
+	bool ret;
+
+	local_bh_disable();
+	ret = _iwl_trans_pcie_grab_nic_access(trans, false);
+	if (ret) {
+		/* keep BHs disabled until iwl_trans_pcie_release_nic_access */
+		return ret;
+	}
+	local_bh_enable();
+	return false;
+}
+
+void __releases(nic_access_nobh)
+iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	lockdep_assert_held(&trans_pcie->reg_lock);
+
+	/*
+	 * Fool sparse by faking we acquiring the lock - sparse will
+	 * track nic_access anyway.
+	 */
+	__acquire(&trans_pcie->reg_lock);
+
+	if (trans_pcie->cmd_hold_nic_awake)
+		goto out;
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		iwl_trans_clear_bit(trans, CSR_GP_CNTRL,
+				    CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
+	else
+		iwl_trans_clear_bit(trans, CSR_GP_CNTRL,
+				    CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+	/*
+	 * Above we read the CSR_GP_CNTRL register, which will flush
+	 * any previous writes, but we need the write that clears the
+	 * MAC_ACCESS_REQ bit to be performed before any other writes
+	 * scheduled on different CPUs (after we drop reg_lock).
+	 */
+out:
+	__release(nic_access_nobh);
+	spin_unlock_bh(&trans_pcie->reg_lock);
+}
+
+int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
+			    void *buf, int dwords)
+{
+#define IWL_MAX_HW_ERRS 5
+	unsigned int num_consec_hw_errors = 0;
+	int offs = 0;
+	u32 *vals = buf;
+
+	while (offs < dwords) {
+		/* limit the time we spin here under lock to 1/2s */
+		unsigned long end = jiffies + HZ / 2;
+		bool resched = false;
+
+		if (iwl_trans_grab_nic_access(trans)) {
+			iwl_write32(trans, HBUS_TARG_MEM_RADDR,
+				    addr + 4 * offs);
+
+			while (offs < dwords) {
+				vals[offs] = iwl_read32(trans,
+							HBUS_TARG_MEM_RDAT);
+
+				if (iwl_trans_is_hw_error_value(vals[offs]))
+					num_consec_hw_errors++;
+				else
+					num_consec_hw_errors = 0;
+
+				if (num_consec_hw_errors >= IWL_MAX_HW_ERRS) {
+					iwl_trans_release_nic_access(trans);
+					return -EIO;
+				}
+
+				offs++;
+
+				if (time_after(jiffies, end)) {
+					resched = true;
+					break;
+				}
+			}
+			iwl_trans_release_nic_access(trans);
+
+			if (resched)
+				cond_resched();
+		} else {
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
+int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
+				 u32 *val)
+{
+	return pci_read_config_dword(IWL_TRANS_GET_PCIE_TRANS(trans)->pci_dev,
+				     ofs, val);
+}
+
+#define IWL_FLUSH_WAIT_MS	2000
+
+int iwl_trans_pcie_rxq_dma_data(struct iwl_trans *trans, int queue,
+				struct iwl_trans_rxq_dma_data *data)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	if (queue >= trans->info.num_rxqs || !trans_pcie->rxq)
+		return -EINVAL;
+
+	data->fr_bd_cb = trans_pcie->rxq[queue].bd_dma;
+	data->urbd_stts_wrptr = trans_pcie->rxq[queue].rb_stts_dma;
+	data->ur_bd_cb = trans_pcie->rxq[queue].used_bd_dma;
+	data->fr_bd_wid = 0;
+
+	return 0;
+}
+
+int iwl_trans_pcie_wait_txq_empty(struct iwl_trans *trans, int txq_idx)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq;
+	unsigned long now = jiffies;
+	bool overflow_tx;
+	u8 wr_ptr;
+
+	/* Make sure the NIC is still alive in the bus */
+	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
+		return -ENODEV;
+
+	if (!test_bit(txq_idx, trans_pcie->txqs.queue_used))
+		return -EINVAL;
+
+	IWL_DEBUG_TX_QUEUES(trans, "Emptying queue %d...\n", txq_idx);
+	txq = trans_pcie->txqs.txq[txq_idx];
+
+	spin_lock_bh(&txq->lock);
+	overflow_tx = txq->overflow_tx ||
+		      !skb_queue_empty(&txq->overflow_q);
+	spin_unlock_bh(&txq->lock);
+
+	wr_ptr = READ_ONCE(txq->write_ptr);
+
+	while ((txq->read_ptr != READ_ONCE(txq->write_ptr) ||
+		overflow_tx) &&
+	       !time_after(jiffies,
+			   now + msecs_to_jiffies(IWL_FLUSH_WAIT_MS))) {
+		u8 write_ptr = READ_ONCE(txq->write_ptr);
+
+		/*
+		 * If write pointer moved during the wait, warn only
+		 * if the TX came from op mode. In case TX came from
+		 * trans layer (overflow TX) don't warn.
+		 */
+		if (WARN_ONCE(wr_ptr != write_ptr && !overflow_tx,
+			      "WR pointer moved while flushing %d -> %d\n",
+			      wr_ptr, write_ptr))
+			return -ETIMEDOUT;
+		wr_ptr = write_ptr;
+
+		usleep_range(1000, 2000);
+
+		spin_lock_bh(&txq->lock);
+		overflow_tx = txq->overflow_tx ||
+			      !skb_queue_empty(&txq->overflow_q);
+		spin_unlock_bh(&txq->lock);
+	}
+
+	if (txq->read_ptr != txq->write_ptr) {
+		IWL_ERR(trans,
+			"fail to flush all tx fifo queues Q %d\n", txq_idx);
+		iwl_txq_log_scd_error(trans, txq);
+		return -ETIMEDOUT;
+	}
+
+	IWL_DEBUG_TX_QUEUES(trans, "Queue %d is now empty.\n", txq_idx);
+
+	return 0;
+}
+
+int iwl_trans_pcie_wait_txqs_empty(struct iwl_trans *trans, u32 txq_bm)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int cnt;
+	int ret = 0;
+
+	/* waiting for all the tx frames complete might take a while */
+	for (cnt = 0;
+	     cnt < trans->mac_cfg->base->num_of_queues;
+	     cnt++) {
+
+		if (cnt == trans->conf.cmd_queue)
+			continue;
+		if (!test_bit(cnt, trans_pcie->txqs.queue_used))
+			continue;
+		if (!(BIT(cnt) & txq_bm))
+			continue;
+
+		ret = iwl_trans_pcie_wait_txq_empty(trans, cnt);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+void iwl_trans_pcie_set_bits_mask(struct iwl_trans *trans, u32 reg,
+				  u32 mask, u32 value)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	spin_lock_bh(&trans_pcie->reg_lock);
+	_iwl_trans_set_bits_mask(trans, reg, mask, value);
+	spin_unlock_bh(&trans_pcie->reg_lock);
+}
+
+static const char *get_csr_string(int cmd)
+{
+#define IWL_CMD(x) case x: return #x
+	switch (cmd) {
+	IWL_CMD(CSR_HW_IF_CONFIG_REG);
+	IWL_CMD(CSR_INT_COALESCING);
+	IWL_CMD(CSR_INT);
+	IWL_CMD(CSR_INT_MASK);
+	IWL_CMD(CSR_FH_INT_STATUS);
+	IWL_CMD(CSR_GPIO_IN);
+	IWL_CMD(CSR_RESET);
+	IWL_CMD(CSR_GP_CNTRL);
+	IWL_CMD(CSR_HW_REV);
+	IWL_CMD(CSR_EEPROM_REG);
+	IWL_CMD(CSR_EEPROM_GP);
+	IWL_CMD(CSR_OTP_GP_REG);
+	IWL_CMD(CSR_GIO_REG);
+	IWL_CMD(CSR_GP_UCODE_REG);
+	IWL_CMD(CSR_GP_DRIVER_REG);
+	IWL_CMD(CSR_UCODE_DRV_GP1);
+	IWL_CMD(CSR_UCODE_DRV_GP2);
+	IWL_CMD(CSR_LED_REG);
+	IWL_CMD(CSR_DRAM_INT_TBL_REG);
+	IWL_CMD(CSR_GIO_CHICKEN_BITS);
+	IWL_CMD(CSR_ANA_PLL_CFG);
+	IWL_CMD(CSR_HW_REV_WA_REG);
+	IWL_CMD(CSR_MONITOR_STATUS_REG);
+	IWL_CMD(CSR_DBG_HPET_MEM_REG);
+	default:
+		return "UNKNOWN";
+	}
+#undef IWL_CMD
+}
+
+void iwl_pcie_dump_csr(struct iwl_trans *trans)
+{
+	int i;
+	static const u32 csr_tbl[] = {
+		CSR_HW_IF_CONFIG_REG,
+		CSR_INT_COALESCING,
+		CSR_INT,
+		CSR_INT_MASK,
+		CSR_FH_INT_STATUS,
+		CSR_GPIO_IN,
+		CSR_RESET,
+		CSR_GP_CNTRL,
+		CSR_HW_REV,
+		CSR_EEPROM_REG,
+		CSR_EEPROM_GP,
+		CSR_OTP_GP_REG,
+		CSR_GIO_REG,
+		CSR_GP_UCODE_REG,
+		CSR_GP_DRIVER_REG,
+		CSR_UCODE_DRV_GP1,
+		CSR_UCODE_DRV_GP2,
+		CSR_LED_REG,
+		CSR_DRAM_INT_TBL_REG,
+		CSR_GIO_CHICKEN_BITS,
+		CSR_ANA_PLL_CFG,
+		CSR_MONITOR_STATUS_REG,
+		CSR_HW_REV_WA_REG,
+		CSR_DBG_HPET_MEM_REG
+	};
+	IWL_ERR(trans, "CSR values:\n");
+	IWL_ERR(trans, "(2nd byte of CSR_INT_COALESCING is "
+		"CSR_INT_PERIODIC_REG)\n");
+	for (i = 0; i <  ARRAY_SIZE(csr_tbl); i++) {
+		IWL_ERR(trans, "  %25s: 0X%08x\n",
+			get_csr_string(csr_tbl[i]),
+			iwl_read32(trans, csr_tbl[i]));
+	}
+}
+
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+/* create and remove of files */
+#define DEBUGFS_ADD_FILE(name, parent, mode) do {			\
+	debugfs_create_file(#name, mode, parent, trans,			\
+			    &iwl_dbgfs_##name##_ops);			\
+} while (0)
+
+/* file operation */
+#define DEBUGFS_READ_FILE_OPS(name)					\
+static const struct file_operations iwl_dbgfs_##name##_ops = {		\
+	.read = iwl_dbgfs_##name##_read,				\
+	.open = simple_open,						\
+	.llseek = generic_file_llseek,					\
+};
+
+#define DEBUGFS_WRITE_FILE_OPS(name)                                    \
+static const struct file_operations iwl_dbgfs_##name##_ops = {          \
+	.write = iwl_dbgfs_##name##_write,                              \
+	.open = simple_open,						\
+	.llseek = generic_file_llseek,					\
+};
+
+#define DEBUGFS_READ_WRITE_FILE_OPS(name)				\
+static const struct file_operations iwl_dbgfs_##name##_ops = {		\
+	.write = iwl_dbgfs_##name##_write,				\
+	.read = iwl_dbgfs_##name##_read,				\
+	.open = simple_open,						\
+	.llseek = generic_file_llseek,					\
+};
+
+struct iwl_dbgfs_tx_queue_priv {
+	struct iwl_trans *trans;
+};
+
+struct iwl_dbgfs_tx_queue_state {
+	loff_t pos;
+};
+
+static void *iwl_dbgfs_tx_queue_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct iwl_dbgfs_tx_queue_priv *priv = seq->private;
+	struct iwl_dbgfs_tx_queue_state *state;
+
+	if (*pos >= priv->trans->mac_cfg->base->num_of_queues)
+		return NULL;
+
+	state = kmalloc_obj(*state);
+	if (!state)
+		return NULL;
+	state->pos = *pos;
+	return state;
+}
+
+static void *iwl_dbgfs_tx_queue_seq_next(struct seq_file *seq,
+					 void *v, loff_t *pos)
+{
+	struct iwl_dbgfs_tx_queue_priv *priv = seq->private;
+	struct iwl_dbgfs_tx_queue_state *state = v;
+
+	*pos = ++state->pos;
+
+	if (*pos >= priv->trans->mac_cfg->base->num_of_queues)
+		return NULL;
+
+	return state;
+}
+
+static void iwl_dbgfs_tx_queue_seq_stop(struct seq_file *seq, void *v)
+{
+	kfree(v);
+}
+
+static int iwl_dbgfs_tx_queue_seq_show(struct seq_file *seq, void *v)
+{
+	struct iwl_dbgfs_tx_queue_priv *priv = seq->private;
+	struct iwl_dbgfs_tx_queue_state *state = v;
+	struct iwl_trans *trans = priv->trans;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq = trans_pcie->txqs.txq[state->pos];
+
+	seq_printf(seq, "hwq %.3u: used=%d stopped=%d ",
+		   (unsigned int)state->pos,
+		   !!test_bit(state->pos, trans_pcie->txqs.queue_used),
+		   !!test_bit(state->pos, trans_pcie->txqs.queue_stopped));
+	if (txq)
+		seq_printf(seq,
+			   "read=%u write=%u need_update=%d frozen=%d n_window=%d ampdu=%d",
+			   txq->read_ptr, txq->write_ptr,
+			   txq->need_update, txq->frozen,
+			   txq->n_window, txq->ampdu);
+	else
+		seq_puts(seq, "(unallocated)");
+
+	if (state->pos == trans->conf.cmd_queue)
+		seq_puts(seq, " (HCMD)");
+	seq_puts(seq, "\n");
+
+	return 0;
+}
+
+static const struct seq_operations iwl_dbgfs_tx_queue_seq_ops = {
+	.start = iwl_dbgfs_tx_queue_seq_start,
+	.next = iwl_dbgfs_tx_queue_seq_next,
+	.stop = iwl_dbgfs_tx_queue_seq_stop,
+	.show = iwl_dbgfs_tx_queue_seq_show,
+};
+
+static int iwl_dbgfs_tx_queue_open(struct inode *inode, struct file *filp)
+{
+	struct iwl_dbgfs_tx_queue_priv *priv;
+
+	priv = __seq_open_private(filp, &iwl_dbgfs_tx_queue_seq_ops,
+				  sizeof(*priv));
+
+	if (!priv)
+		return -ENOMEM;
+
+	priv->trans = inode->i_private;
+	return 0;
+}
+
+static ssize_t iwl_dbgfs_rx_queue_read(struct file *file,
+				       char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	char *buf;
+	int pos = 0, i, ret;
+	size_t bufsz;
+
+	bufsz = sizeof(char) * 121 * trans->info.num_rxqs;
+
+	if (!trans_pcie->rxq)
+		return -EAGAIN;
+
+	buf = kzalloc(bufsz, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	for (i = 0; i < trans->info.num_rxqs && pos < bufsz; i++) {
+		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
+
+		spin_lock_bh(&rxq->lock);
+
+		pos += scnprintf(buf + pos, bufsz - pos, "queue#: %2d\n",
+				 i);
+		pos += scnprintf(buf + pos, bufsz - pos, "\tread: %u\n",
+				 rxq->read);
+		pos += scnprintf(buf + pos, bufsz - pos, "\twrite: %u\n",
+				 rxq->write);
+		pos += scnprintf(buf + pos, bufsz - pos, "\twrite_actual: %u\n",
+				 rxq->write_actual);
+		pos += scnprintf(buf + pos, bufsz - pos, "\tneed_update: %2d\n",
+				 rxq->need_update);
+		pos += scnprintf(buf + pos, bufsz - pos, "\tfree_count: %u\n",
+				 rxq->free_count);
+		if (rxq->rb_stts) {
+			u32 r =	iwl_get_closed_rb_stts(trans, rxq);
+			pos += scnprintf(buf + pos, bufsz - pos,
+					 "\tclosed_rb_num: %u\n", r);
+		} else {
+			pos += scnprintf(buf + pos, bufsz - pos,
+					 "\tclosed_rb_num: Not Allocated\n");
+		}
+		spin_unlock_bh(&rxq->lock);
+	}
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	kfree(buf);
+
+	return ret;
+}
+
+static ssize_t iwl_dbgfs_interrupt_read(struct file *file,
+					char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct isr_statistics *isr_stats = &trans_pcie->isr_stats;
+
+	int pos = 0;
+	char *buf;
+	int bufsz = 24 * 64; /* 24 items * 64 char per item */
+	ssize_t ret;
+
+	buf = kzalloc(bufsz, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pos += scnprintf(buf + pos, bufsz - pos,
+			"Interrupt Statistics Report:\n");
+
+	pos += scnprintf(buf + pos, bufsz - pos, "HW Error:\t\t\t %u\n",
+		isr_stats->hw);
+	pos += scnprintf(buf + pos, bufsz - pos, "SW Error:\t\t\t %u\n",
+		isr_stats->sw);
+	if (isr_stats->sw || isr_stats->hw) {
+		pos += scnprintf(buf + pos, bufsz - pos,
+			"\tLast Restarting Code:  0x%X\n",
+			isr_stats->err_code);
+	}
+#ifdef CONFIG_IWLWIFI_DEBUG
+	pos += scnprintf(buf + pos, bufsz - pos, "Frame transmitted:\t\t %u\n",
+		isr_stats->sch);
+	pos += scnprintf(buf + pos, bufsz - pos, "Alive interrupt:\t\t %u\n",
+		isr_stats->alive);
+#endif
+	pos += scnprintf(buf + pos, bufsz - pos,
+		"HW RF KILL switch toggled:\t %u\n", isr_stats->rfkill);
+
+	pos += scnprintf(buf + pos, bufsz - pos, "CT KILL:\t\t\t %u\n",
+		isr_stats->ctkill);
+
+	pos += scnprintf(buf + pos, bufsz - pos, "Wakeup Interrupt:\t\t %u\n",
+		isr_stats->wakeup);
+
+	pos += scnprintf(buf + pos, bufsz - pos,
+		"Rx command responses:\t\t %u\n", isr_stats->rx);
+
+	pos += scnprintf(buf + pos, bufsz - pos, "Tx/FH interrupt:\t\t %u\n",
+		isr_stats->tx);
+
+	pos += scnprintf(buf + pos, bufsz - pos, "Unexpected INTA:\t\t %u\n",
+		isr_stats->unhandled);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t iwl_dbgfs_interrupt_write(struct file *file,
+					 const char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct isr_statistics *isr_stats = &trans_pcie->isr_stats;
+	u32 reset_flag;
+	int ret;
+
+	ret = kstrtou32_from_user(user_buf, count, 16, &reset_flag);
+	if (ret)
+		return ret;
+	if (reset_flag == 0)
+		memset(isr_stats, 0, sizeof(*isr_stats));
+
+	return count;
+}
+
+static ssize_t iwl_dbgfs_csr_write(struct file *file,
+				   const char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct iwl_trans *trans = file->private_data;
+
+	iwl_pcie_dump_csr(trans);
+
+	return count;
+}
+
+static ssize_t iwl_dbgfs_fh_reg_read(struct file *file,
+				     char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct iwl_trans *trans = file->private_data;
+	char *buf = NULL;
+	ssize_t ret;
+
+	ret = iwl_dump_fh(trans, &buf);
+	if (ret < 0)
+		return ret;
+	if (!buf)
+		return -EINVAL;
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t iwl_dbgfs_rfkill_read(struct file *file,
+				     char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	char buf[100];
+	int pos;
+
+	pos = scnprintf(buf, sizeof(buf), "debug: %d\nhw: %d\n",
+			trans_pcie->debug_rfkill,
+			!(iwl_read32(trans, CSR_GP_CNTRL) &
+				CSR_GP_CNTRL_REG_FLAG_HW_RF_KILL_SW));
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
+}
+
+static ssize_t iwl_dbgfs_rfkill_write(struct file *file,
+				      const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	bool new_value;
+	int ret;
+
+	ret = kstrtobool_from_user(user_buf, count, &new_value);
+	if (ret)
+		return ret;
+	if (new_value == trans_pcie->debug_rfkill)
+		return count;
+	IWL_WARN(trans, "changing debug rfkill %d->%d\n",
+		 trans_pcie->debug_rfkill, new_value);
+	trans_pcie->debug_rfkill = new_value;
+	iwl_pcie_handle_rfkill_irq(trans, false);
+
+	return count;
+}
+
+static int iwl_dbgfs_monitor_data_open(struct inode *inode,
+				       struct file *file)
+{
+	struct iwl_trans *trans = inode->i_private;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	if (!trans->dbg.dest_tlv ||
+	    trans->dbg.dest_tlv->monitor_mode != EXTERNAL_MODE) {
+		IWL_ERR(trans, "Debug destination is not set to DRAM\n");
+		return -ENOENT;
+	}
+
+	if (trans_pcie->fw_mon_data.state != IWL_FW_MON_DBGFS_STATE_CLOSED)
+		return -EBUSY;
+
+	trans_pcie->fw_mon_data.state = IWL_FW_MON_DBGFS_STATE_OPEN;
+	return simple_open(inode, file);
+}
+
+static int iwl_dbgfs_monitor_data_release(struct inode *inode,
+					  struct file *file)
+{
+	struct iwl_trans_pcie *trans_pcie =
+		IWL_TRANS_GET_PCIE_TRANS(inode->i_private);
+
+	if (trans_pcie->fw_mon_data.state == IWL_FW_MON_DBGFS_STATE_OPEN)
+		trans_pcie->fw_mon_data.state = IWL_FW_MON_DBGFS_STATE_CLOSED;
+	return 0;
+}
+
+static bool iwl_write_to_user_buf(char __user *user_buf, ssize_t count,
+				  void *buf, ssize_t *size,
+				  ssize_t *bytes_copied)
+{
+	ssize_t buf_size_left = count - *bytes_copied;
+
+	buf_size_left = buf_size_left - (buf_size_left % sizeof(u32));
+	if (*size > buf_size_left)
+		*size = buf_size_left;
+
+	*size -= copy_to_user(user_buf, buf, *size);
+	*bytes_copied += *size;
+
+	if (buf_size_left == *size)
+		return true;
+	return false;
+}
+
+static ssize_t iwl_dbgfs_monitor_data_read(struct file *file,
+					   char __user *user_buf,
+					   size_t count, loff_t *ppos)
+{
+	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	u8 *cpu_addr = (void *)trans->dbg.fw_mon.block, *curr_buf;
+	struct cont_rec *data = &trans_pcie->fw_mon_data;
+	u32 write_ptr_addr, wrap_cnt_addr, write_ptr, wrap_cnt;
+	ssize_t size, bytes_copied = 0;
+	bool b_full;
+
+	if (trans->dbg.dest_tlv) {
+		write_ptr_addr =
+			le32_to_cpu(trans->dbg.dest_tlv->write_ptr_reg);
+		wrap_cnt_addr = le32_to_cpu(trans->dbg.dest_tlv->wrap_count);
+	} else {
+		write_ptr_addr = MON_BUFF_WRPTR;
+		wrap_cnt_addr = MON_BUFF_CYCLE_CNT;
+	}
+
+	if (unlikely(!trans->dbg.rec_on))
+		return 0;
+
+	mutex_lock(&data->mutex);
+	if (data->state ==
+	    IWL_FW_MON_DBGFS_STATE_DISABLED) {
+		mutex_unlock(&data->mutex);
+		return 0;
+	}
+
+	/* write_ptr position in bytes rather then DW */
+	write_ptr = iwl_read_prph(trans, write_ptr_addr) * sizeof(u32);
+	wrap_cnt = iwl_read_prph(trans, wrap_cnt_addr);
+
+	if (data->prev_wrap_cnt == wrap_cnt) {
+		size = write_ptr - data->prev_wr_ptr;
+		curr_buf = cpu_addr + data->prev_wr_ptr;
+		b_full = iwl_write_to_user_buf(user_buf, count,
+					       curr_buf, &size,
+					       &bytes_copied);
+		data->prev_wr_ptr += size;
+
+	} else if (data->prev_wrap_cnt == wrap_cnt - 1 &&
+		   write_ptr < data->prev_wr_ptr) {
+		size = trans->dbg.fw_mon.size - data->prev_wr_ptr;
+		curr_buf = cpu_addr + data->prev_wr_ptr;
+		b_full = iwl_write_to_user_buf(user_buf, count,
+					       curr_buf, &size,
+					       &bytes_copied);
+		data->prev_wr_ptr += size;
+
+		if (!b_full) {
+			size = write_ptr;
+			b_full = iwl_write_to_user_buf(user_buf, count,
+						       cpu_addr, &size,
+						       &bytes_copied);
+			data->prev_wr_ptr = size;
+			data->prev_wrap_cnt++;
+		}
+	} else {
+		if (data->prev_wrap_cnt == wrap_cnt - 1 &&
+		    write_ptr > data->prev_wr_ptr)
+			IWL_WARN(trans,
+				 "write pointer passed previous write pointer, start copying from the beginning\n");
+		else if (!unlikely(data->prev_wrap_cnt == 0 &&
+				   data->prev_wr_ptr == 0))
+			IWL_WARN(trans,
+				 "monitor data is out of sync, start copying from the beginning\n");
+
+		size = write_ptr;
+		b_full = iwl_write_to_user_buf(user_buf, count,
+					       cpu_addr, &size,
+					       &bytes_copied);
+		data->prev_wr_ptr = size;
+		data->prev_wrap_cnt = wrap_cnt;
+	}
+
+	mutex_unlock(&data->mutex);
+
+	return bytes_copied;
+}
+
+static ssize_t iwl_dbgfs_rf_read(struct file *file,
+				 char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	struct iwl_trans *trans = file->private_data;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	if (!trans_pcie->rf_name[0])
+		return -ENODEV;
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       trans_pcie->rf_name,
+				       strlen(trans_pcie->rf_name));
+}
+
+static ssize_t iwl_dbgfs_reset_write(struct file *file,
+				     const char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct iwl_trans *trans = file->private_data;
+	static const char * const modes[] = {
+		[IWL_RESET_MODE_SW_RESET] = "sw",
+		[IWL_RESET_MODE_REPROBE] = "reprobe",
+		[IWL_RESET_MODE_TOP_RESET] = "top",
+		[IWL_RESET_MODE_REMOVE_ONLY] = "remove",
+		[IWL_RESET_MODE_RESCAN] = "rescan",
+		[IWL_RESET_MODE_FUNC_RESET] = "function",
+		[IWL_RESET_MODE_PROD_RESET] = "product",
+	};
+	char buf[10] = {};
+	int mode;
+
+	if (count > sizeof(buf) - 1)
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	mode = sysfs_match_string(modes, buf);
+	if (mode < 0)
+		return mode;
+
+	if (mode < IWL_RESET_MODE_REMOVE_ONLY) {
+		if (!test_bit(STATUS_DEVICE_ENABLED, &trans->status))
+			return -EINVAL;
+		if (mode == IWL_RESET_MODE_TOP_RESET) {
+			if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_SC)
+				return -EINVAL;
+			trans->request_top_reset = 1;
+		}
+		iwl_op_mode_nic_error(trans->op_mode, IWL_ERR_TYPE_DEBUGFS);
+		iwl_trans_schedule_reset(trans, IWL_ERR_TYPE_DEBUGFS);
+		return count;
+	}
+
+	iwl_trans_pcie_reset(trans, mode);
+
+	return count;
+}
+
+DEBUGFS_READ_WRITE_FILE_OPS(interrupt);
+DEBUGFS_READ_FILE_OPS(fh_reg);
+DEBUGFS_READ_FILE_OPS(rx_queue);
+DEBUGFS_WRITE_FILE_OPS(csr);
+DEBUGFS_READ_WRITE_FILE_OPS(rfkill);
+DEBUGFS_READ_FILE_OPS(rf);
+DEBUGFS_WRITE_FILE_OPS(reset);
+
+static const struct file_operations iwl_dbgfs_tx_queue_ops = {
+	.owner = THIS_MODULE,
+	.open = iwl_dbgfs_tx_queue_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release_private,
+};
+
+static const struct file_operations iwl_dbgfs_monitor_data_ops = {
+	.read = iwl_dbgfs_monitor_data_read,
+	.open = iwl_dbgfs_monitor_data_open,
+	.release = iwl_dbgfs_monitor_data_release,
+};
+
+/* Create the debugfs files and directories */
+void iwl_trans_pcie_dbgfs_register(struct iwl_trans *trans)
+{
+	struct dentry *dir = trans->dbgfs_dir;
+
+	DEBUGFS_ADD_FILE(rx_queue, dir, 0400);
+	DEBUGFS_ADD_FILE(tx_queue, dir, 0400);
+	DEBUGFS_ADD_FILE(interrupt, dir, 0600);
+	DEBUGFS_ADD_FILE(csr, dir, 0200);
+	DEBUGFS_ADD_FILE(fh_reg, dir, 0400);
+	DEBUGFS_ADD_FILE(rfkill, dir, 0600);
+	DEBUGFS_ADD_FILE(monitor_data, dir, 0400);
+	DEBUGFS_ADD_FILE(rf, dir, 0400);
+	DEBUGFS_ADD_FILE(reset, dir, 0200);
+}
+
+void iwl_trans_pcie_debugfs_cleanup(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct cont_rec *data = &trans_pcie->fw_mon_data;
+
+	mutex_lock(&data->mutex);
+	data->state = IWL_FW_MON_DBGFS_STATE_DISABLED;
+	mutex_unlock(&data->mutex);
+}
+#endif /*CONFIG_IWLWIFI_DEBUGFS */
+
+static u32 iwl_trans_pcie_get_cmdlen(struct iwl_trans *trans, void *tfd)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	u32 cmdlen = 0;
+	int i;
+
+	for (i = 0; i < trans_pcie->txqs.tfd.max_tbs; i++)
+		cmdlen += iwl_txq_gen1_tfd_tb_get_len(trans, tfd, i);
+
+	return cmdlen;
+}
+
+static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
+				   struct iwl_fw_error_dump_data **data,
+				   int allocated_rb_nums)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int max_len = trans_pcie->rx_buf_bytes;
+	/* Dump RBs is supported only for pre-9000 devices (1 queue) */
+	struct iwl_rxq *rxq = &trans_pcie->rxq[0];
+	u32 i, r, j, rb_len = 0;
+
+	spin_lock_bh(&rxq->lock);
+
+	r = iwl_get_closed_rb_stts(trans, rxq);
+
+	for (i = rxq->read, j = 0;
+	     i != r && j < allocated_rb_nums;
+	     i = (i + 1) & RX_QUEUE_MASK, j++) {
+		struct iwl_rx_mem_buffer *rxb = rxq->queue[i];
+		struct iwl_fw_error_dump_rb *rb;
+
+		dma_sync_single_for_cpu(trans->dev, rxb->page_dma,
+					max_len, DMA_FROM_DEVICE);
+
+		rb_len += sizeof(**data) + sizeof(*rb) + max_len;
+
+		(*data)->type = cpu_to_le32(IWL_FW_ERROR_DUMP_RB);
+		(*data)->len = cpu_to_le32(sizeof(*rb) + max_len);
+		rb = (void *)(*data)->data;
+		rb->index = cpu_to_le32(i);
+		memcpy(rb->data, page_address(rxb->page), max_len);
+
+		*data = iwl_fw_error_next_data(*data);
+	}
+
+	spin_unlock_bh(&rxq->lock);
+
+	return rb_len;
+}
+#define IWL_CSR_TO_DUMP (0x250)
+
+static u32 iwl_trans_pcie_dump_csr(struct iwl_trans *trans,
+				   struct iwl_fw_error_dump_data **data)
+{
+	u32 csr_len = sizeof(**data) + IWL_CSR_TO_DUMP;
+	__le32 *val;
+	int i;
+
+	(*data)->type = cpu_to_le32(IWL_FW_ERROR_DUMP_CSR);
+	(*data)->len = cpu_to_le32(IWL_CSR_TO_DUMP);
+	val = (void *)(*data)->data;
+
+	for (i = 0; i < IWL_CSR_TO_DUMP; i += 4)
+		*val++ = cpu_to_le32(iwl_trans_pcie_read32(trans, i));
+
+	*data = iwl_fw_error_next_data(*data);
+
+	return csr_len;
+}
+
+static u32 iwl_trans_pcie_fh_regs_dump(struct iwl_trans *trans,
+				       struct iwl_fw_error_dump_data **data)
+{
+	u32 fh_regs_len = FH_MEM_UPPER_BOUND - FH_MEM_LOWER_BOUND;
+	__le32 *val;
+	int i;
+
+	if (!iwl_trans_grab_nic_access(trans))
+		return 0;
+
+	(*data)->type = cpu_to_le32(IWL_FW_ERROR_DUMP_FH_REGS);
+	(*data)->len = cpu_to_le32(fh_regs_len);
+	val = (void *)(*data)->data;
+
+	if (!trans->mac_cfg->gen2)
+		for (i = FH_MEM_LOWER_BOUND; i < FH_MEM_UPPER_BOUND;
+		     i += sizeof(u32))
+			*val++ = cpu_to_le32(iwl_trans_pcie_read32(trans, i));
+	else
+		for (i = iwl_umac_prph(trans, FH_MEM_LOWER_BOUND_GEN2);
+		     i < iwl_umac_prph(trans, FH_MEM_UPPER_BOUND_GEN2);
+		     i += sizeof(u32))
+			*val++ = cpu_to_le32(iwl_trans_pcie_read_prph(trans,
+								      i));
+
+	iwl_trans_release_nic_access(trans);
+
+	*data = iwl_fw_error_next_data(*data);
+
+	return sizeof(**data) + fh_regs_len;
+}
+
+static u32
+iwl_trans_pci_dump_marbh_monitor(struct iwl_trans *trans,
+				 struct iwl_fw_error_dump_fw_mon *fw_mon_data,
+				 u32 monitor_len)
+{
+	u32 buf_size_in_dwords = (monitor_len >> 2);
+	u32 *buffer = (u32 *)fw_mon_data->data;
+	u32 i;
+
+	if (!iwl_trans_grab_nic_access(trans))
+		return 0;
+
+	iwl_write_umac_prph_no_grab(trans, MON_DMARB_RD_CTL_ADDR, 0x1);
+	for (i = 0; i < buf_size_in_dwords; i++)
+		buffer[i] = iwl_read_umac_prph_no_grab(trans,
+						       MON_DMARB_RD_DATA_ADDR);
+	iwl_write_umac_prph_no_grab(trans, MON_DMARB_RD_CTL_ADDR, 0x0);
+
+	iwl_trans_release_nic_access(trans);
+
+	return monitor_len;
+}
+
+static void
+iwl_trans_pcie_dump_pointers(struct iwl_trans *trans,
+			     struct iwl_fw_error_dump_fw_mon *fw_mon_data)
+{
+	u32 base, base_high, write_ptr, write_ptr_val, wrap_cnt;
+
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		base = DBGC_CUR_DBGBUF_BASE_ADDR_LSB;
+		base_high = DBGC_CUR_DBGBUF_BASE_ADDR_MSB;
+		write_ptr = DBGC_CUR_DBGBUF_STATUS;
+		wrap_cnt = DBGC_DBGBUF_WRAP_AROUND;
+	} else if (trans->dbg.dest_tlv) {
+		write_ptr = le32_to_cpu(trans->dbg.dest_tlv->write_ptr_reg);
+		wrap_cnt = le32_to_cpu(trans->dbg.dest_tlv->wrap_count);
+		base = le32_to_cpu(trans->dbg.dest_tlv->base_reg);
+	} else {
+		base = MON_BUFF_BASE_ADDR;
+		write_ptr = MON_BUFF_WRPTR;
+		wrap_cnt = MON_BUFF_CYCLE_CNT;
+	}
+
+	write_ptr_val = iwl_read_prph(trans, write_ptr);
+	fw_mon_data->fw_mon_cycle_cnt =
+		cpu_to_le32(iwl_read_prph(trans, wrap_cnt));
+	fw_mon_data->fw_mon_base_ptr =
+		cpu_to_le32(iwl_read_prph(trans, base));
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		fw_mon_data->fw_mon_base_high_ptr =
+			cpu_to_le32(iwl_read_prph(trans, base_high));
+		write_ptr_val &= DBGC_CUR_DBGBUF_STATUS_OFFSET_MSK;
+		/* convert wrtPtr to DWs, to align with all HWs */
+		write_ptr_val >>= 2;
+	}
+	fw_mon_data->fw_mon_wr_ptr = cpu_to_le32(write_ptr_val);
+}
+
+static u32
+iwl_trans_pcie_dump_monitor(struct iwl_trans *trans,
+			    struct iwl_fw_error_dump_data **data,
+			    u32 monitor_len)
+{
+	struct iwl_dram_data *fw_mon = &trans->dbg.fw_mon;
+	u32 len = 0;
+
+	if (trans->dbg.dest_tlv ||
+	    (fw_mon->size &&
+	     (trans->mac_cfg->device_family == IWL_DEVICE_FAMILY_7000 ||
+	      trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210))) {
+		struct iwl_fw_error_dump_fw_mon *fw_mon_data;
+
+		(*data)->type = cpu_to_le32(IWL_FW_ERROR_DUMP_FW_MONITOR);
+		fw_mon_data = (void *)(*data)->data;
+
+		iwl_trans_pcie_dump_pointers(trans, fw_mon_data);
+
+		len += sizeof(**data) + sizeof(*fw_mon_data);
+		if (fw_mon->size) {
+			memcpy(fw_mon_data->data, fw_mon->block, fw_mon->size);
+			monitor_len = fw_mon->size;
+		} else if (trans->dbg.dest_tlv->monitor_mode == SMEM_MODE) {
+			u32 base = le32_to_cpu(fw_mon_data->fw_mon_base_ptr);
+			/*
+			 * Update pointers to reflect actual values after
+			 * shifting
+			 */
+			if (trans->dbg.dest_tlv->version) {
+				base = (iwl_read_prph(trans, base) &
+					IWL_LDBG_M2S_BUF_BA_MSK) <<
+				       trans->dbg.dest_tlv->base_shift;
+				base *= IWL_M2S_UNIT_SIZE;
+				base += trans->mac_cfg->base->smem_offset;
+			} else {
+				base = iwl_read_prph(trans, base) <<
+				       trans->dbg.dest_tlv->base_shift;
+			}
+
+			iwl_trans_pcie_read_mem(trans, base, fw_mon_data->data,
+						monitor_len / sizeof(u32));
+		} else if (trans->dbg.dest_tlv->monitor_mode == MARBH_MODE) {
+			monitor_len =
+				iwl_trans_pci_dump_marbh_monitor(trans,
+								 fw_mon_data,
+								 monitor_len);
+		} else {
+			/* Didn't match anything - output no monitor data */
+			monitor_len = 0;
+		}
+
+		len += monitor_len;
+		(*data)->len = cpu_to_le32(monitor_len + sizeof(*fw_mon_data));
+	}
+
+	return len;
+}
+
+static int iwl_trans_get_fw_monitor_len(struct iwl_trans *trans, u32 *len)
+{
+	if (trans->dbg.fw_mon.size) {
+		*len += sizeof(struct iwl_fw_error_dump_data) +
+			sizeof(struct iwl_fw_error_dump_fw_mon) +
+			trans->dbg.fw_mon.size;
+		return trans->dbg.fw_mon.size;
+	} else if (trans->dbg.dest_tlv) {
+		u32 base, end, cfg_reg, monitor_len;
+
+		if (trans->dbg.dest_tlv->version == 1) {
+			cfg_reg = le32_to_cpu(trans->dbg.dest_tlv->base_reg);
+			cfg_reg = iwl_read_prph(trans, cfg_reg);
+			base = (cfg_reg & IWL_LDBG_M2S_BUF_BA_MSK) <<
+				trans->dbg.dest_tlv->base_shift;
+			base *= IWL_M2S_UNIT_SIZE;
+			base += trans->mac_cfg->base->smem_offset;
+
+			monitor_len =
+				(cfg_reg & IWL_LDBG_M2S_BUF_SIZE_MSK) >>
+				trans->dbg.dest_tlv->end_shift;
+			monitor_len *= IWL_M2S_UNIT_SIZE;
+		} else {
+			base = le32_to_cpu(trans->dbg.dest_tlv->base_reg);
+			end = le32_to_cpu(trans->dbg.dest_tlv->end_reg);
+
+			base = iwl_read_prph(trans, base) <<
+			       trans->dbg.dest_tlv->base_shift;
+			end = iwl_read_prph(trans, end) <<
+			      trans->dbg.dest_tlv->end_shift;
+
+			/* Make "end" point to the actual end */
+			if (trans->mac_cfg->device_family >=
+			    IWL_DEVICE_FAMILY_8000 ||
+			    trans->dbg.dest_tlv->monitor_mode == MARBH_MODE)
+				end += (1 << trans->dbg.dest_tlv->end_shift);
+			monitor_len = end - base;
+		}
+		*len += sizeof(struct iwl_fw_error_dump_data) +
+			sizeof(struct iwl_fw_error_dump_fw_mon) +
+			monitor_len;
+		return monitor_len;
+	}
+	return 0;
+}
+
+struct iwl_trans_dump_data *
+iwl_trans_pcie_dump_data(struct iwl_trans *trans, u32 dump_mask,
+			 const struct iwl_dump_sanitize_ops *sanitize_ops,
+			 void *sanitize_ctx)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_fw_error_dump_data *data;
+	struct iwl_txq *cmdq = trans_pcie->txqs.txq[trans->conf.cmd_queue];
+	struct iwl_fw_error_dump_txcmd *txcmd;
+	struct iwl_trans_dump_data *dump_data;
+	u32 len, num_rbs = 0, monitor_len = 0;
+	int i, ptr;
+	bool dump_rbs = iwl_trans_is_fw_error(trans) &&
+			!trans->mac_cfg->mq_rx_supported &&
+			dump_mask & BIT(IWL_FW_ERROR_DUMP_RB);
+
+	if (!dump_mask)
+		return NULL;
+
+	/* transport dump header */
+	len = sizeof(*dump_data);
+
+	/* host commands */
+	if (dump_mask & BIT(IWL_FW_ERROR_DUMP_TXCMD) && cmdq)
+		len += sizeof(*data) +
+			cmdq->n_window * (sizeof(*txcmd) +
+					  TFD_MAX_PAYLOAD_SIZE);
+
+	/* FW monitor */
+	if (dump_mask & BIT(IWL_FW_ERROR_DUMP_FW_MONITOR))
+		monitor_len = iwl_trans_get_fw_monitor_len(trans, &len);
+
+	/* CSR registers */
+	if (dump_mask & BIT(IWL_FW_ERROR_DUMP_CSR))
+		len += sizeof(*data) + IWL_CSR_TO_DUMP;
+
+	/* FH registers */
+	if (dump_mask & BIT(IWL_FW_ERROR_DUMP_FH_REGS)) {
+		if (trans->mac_cfg->gen2)
+			len += sizeof(*data) +
+			       (iwl_umac_prph(trans, FH_MEM_UPPER_BOUND_GEN2) -
+				iwl_umac_prph(trans, FH_MEM_LOWER_BOUND_GEN2));
+		else
+			len += sizeof(*data) +
+			       (FH_MEM_UPPER_BOUND -
+				FH_MEM_LOWER_BOUND);
+	}
+
+	if (dump_rbs) {
+		/* Dump RBs is supported only for pre-9000 devices (1 queue) */
+		struct iwl_rxq *rxq = &trans_pcie->rxq[0];
+		/* RBs */
+		spin_lock_bh(&rxq->lock);
+		num_rbs = iwl_get_closed_rb_stts(trans, rxq);
+		num_rbs = (num_rbs - rxq->read) & RX_QUEUE_MASK;
+		spin_unlock_bh(&rxq->lock);
+
+		len += num_rbs * (sizeof(*data) +
+				  sizeof(struct iwl_fw_error_dump_rb) +
+				  (PAGE_SIZE << trans_pcie->rx_page_order));
+	}
+
+	/* Paged memory for gen2 HW */
+	if (trans->mac_cfg->gen2 && dump_mask & BIT(IWL_FW_ERROR_DUMP_PAGING))
+		for (i = 0; i < trans->init_dram.paging_cnt; i++)
+			len += sizeof(*data) +
+			       sizeof(struct iwl_fw_error_dump_paging) +
+			       trans->init_dram.paging[i].size;
+
+	dump_data = vzalloc(len);
+	if (!dump_data)
+		return NULL;
+
+	len = 0;
+	data = (void *)dump_data->data;
+
+	if (dump_mask & BIT(IWL_FW_ERROR_DUMP_TXCMD) && cmdq) {
+		u16 tfd_size = trans_pcie->txqs.tfd.size;
+
+		data->type = cpu_to_le32(IWL_FW_ERROR_DUMP_TXCMD);
+		txcmd = (void *)data->data;
+		spin_lock_bh(&cmdq->lock);
+		ptr = cmdq->write_ptr;
+		for (i = 0; i < cmdq->n_window; i++) {
+			u8 idx = iwl_txq_get_cmd_index(cmdq, ptr);
+			u8 tfdidx;
+			u32 caplen, cmdlen;
+
+			if (trans->mac_cfg->gen2)
+				tfdidx = idx;
+			else
+				tfdidx = ptr;
+
+			cmdlen = iwl_trans_pcie_get_cmdlen(trans,
+							   (u8 *)cmdq->tfds +
+							   tfd_size * tfdidx);
+			caplen = min_t(u32, TFD_MAX_PAYLOAD_SIZE, cmdlen);
+
+			if (cmdlen) {
+				len += sizeof(*txcmd) + caplen;
+				txcmd->cmdlen = cpu_to_le32(cmdlen);
+				txcmd->caplen = cpu_to_le32(caplen);
+				memcpy(txcmd->data, cmdq->entries[idx].cmd,
+				       caplen);
+				if (sanitize_ops && sanitize_ops->frob_hcmd)
+					sanitize_ops->frob_hcmd(sanitize_ctx,
+								txcmd->data,
+								caplen);
+				txcmd = (void *)((u8 *)txcmd->data + caplen);
+			}
+
+			ptr = iwl_txq_dec_wrap(trans, ptr);
+		}
+		spin_unlock_bh(&cmdq->lock);
+
+		data->len = cpu_to_le32(len);
+		len += sizeof(*data);
+		data = iwl_fw_error_next_data(data);
+	}
+
+	if (dump_mask & BIT(IWL_FW_ERROR_DUMP_CSR))
+		len += iwl_trans_pcie_dump_csr(trans, &data);
+	if (dump_mask & BIT(IWL_FW_ERROR_DUMP_FH_REGS))
+		len += iwl_trans_pcie_fh_regs_dump(trans, &data);
+	if (dump_rbs)
+		len += iwl_trans_pcie_dump_rbs(trans, &data, num_rbs);
+
+	/* Paged memory for gen2 HW */
+	if (trans->mac_cfg->gen2 &&
+	    dump_mask & BIT(IWL_FW_ERROR_DUMP_PAGING)) {
+		for (i = 0; i < trans->init_dram.paging_cnt; i++) {
+			struct iwl_fw_error_dump_paging *paging;
+			u32 page_len = trans->init_dram.paging[i].size;
+
+			data->type = cpu_to_le32(IWL_FW_ERROR_DUMP_PAGING);
+			data->len = cpu_to_le32(sizeof(*paging) + page_len);
+			paging = (void *)data->data;
+			paging->index = cpu_to_le32(i);
+			memcpy(paging->data,
+			       trans->init_dram.paging[i].block, page_len);
+			data = iwl_fw_error_next_data(data);
+
+			len += sizeof(*data) + sizeof(*paging) + page_len;
+		}
+	}
+	if (dump_mask & BIT(IWL_FW_ERROR_DUMP_FW_MONITOR))
+		len += iwl_trans_pcie_dump_monitor(trans, &data, monitor_len);
+
+	dump_data->len = len;
+
+	return dump_data;
+}
+
+void iwl_trans_pci_interrupts(struct iwl_trans *trans, bool enable)
+{
+	if (enable)
+		iwl_enable_interrupts(trans);
+	else
+		iwl_disable_interrupts(trans);
+}
+
+void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
+{
+	u32 inta_addr, sw_err_bit;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	if (trans_pcie->msix_enabled) {
+		inta_addr = CSR_MSIX_HW_INT_CAUSES_AD;
+		if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+			sw_err_bit = MSIX_HW_INT_CAUSES_REG_SW_ERR_BZ;
+		else
+			sw_err_bit = MSIX_HW_INT_CAUSES_REG_SW_ERR;
+	} else {
+		inta_addr = CSR_INT;
+		sw_err_bit = CSR_INT_BIT_SW_ERR;
+	}
+
+	iwl_trans_sync_nmi_with_addr(trans, inta_addr, sw_err_bit);
+}
+
+static int iwl_trans_pcie_alloc_txcmd_pool(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	unsigned int txcmd_size, txcmd_align;
+
+	if (!trans->mac_cfg->gen2) {
+		txcmd_size = sizeof(struct iwl_tx_cmd_v6);
+		txcmd_align = sizeof(void *);
+	} else if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
+		txcmd_size = sizeof(struct iwl_tx_cmd_v9);
+		txcmd_align = 64;
+	} else {
+		txcmd_size = sizeof(struct iwl_tx_cmd);
+		txcmd_align = 128;
+	}
+
+	txcmd_size += sizeof(struct iwl_cmd_header);
+	txcmd_size += 36; /* biggest possible 802.11 header */
+
+	/* Ensure device TX cmd cannot reach/cross a page boundary in gen2 */
+	if (WARN_ON((trans->mac_cfg->gen2 && txcmd_size >= txcmd_align)))
+		return -EINVAL;
+
+	snprintf(trans_pcie->dev_cmd_pool_name,
+		 sizeof(trans_pcie->dev_cmd_pool_name),
+		 "iwl_cmd_pool:%s", dev_name(trans->dev));
+
+	trans_pcie->dev_cmd_pool =
+		kmem_cache_create(trans_pcie->dev_cmd_pool_name,
+				  txcmd_size, txcmd_align,
+				  SLAB_HWCACHE_ALIGN, NULL);
+	if (!trans_pcie->dev_cmd_pool)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static struct iwl_trans *
+iwl_trans_pcie_alloc(struct pci_dev *pdev,
+		     const struct iwl_mac_cfg *mac_cfg,
+		     struct iwl_trans_info *info, u8 __iomem *hw_base)
+{
+	struct iwl_trans_pcie *trans_pcie, **priv;
+	struct iwl_trans *trans;
+	unsigned int bc_tbl_n_entries;
+	int ret, addr_size;
+
+	trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie), &pdev->dev,
+				mac_cfg);
+	if (!trans)
+		return ERR_PTR(-ENOMEM);
+
+	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	trans_pcie->hw_base = hw_base;
+
+	/* Initialize the wait queue for commands */
+	init_waitqueue_head(&trans_pcie->wait_command_queue);
+
+	ret = iwl_trans_pcie_alloc_txcmd_pool(trans);
+	if (ret)
+		goto out_free_trans;
+
+	if (trans->mac_cfg->gen2) {
+		trans_pcie->txqs.tfd.addr_size = 64;
+		trans_pcie->txqs.tfd.max_tbs = IWL_TFH_NUM_TBS;
+		trans_pcie->txqs.tfd.size = sizeof(struct iwl_tfh_tfd);
+	} else {
+		trans_pcie->txqs.tfd.addr_size = 36;
+		trans_pcie->txqs.tfd.max_tbs = IWL_NUM_OF_TBS;
+		trans_pcie->txqs.tfd.size = sizeof(struct iwl_tfd);
+	}
+
+	trans_pcie->supported_dma_mask = (u32)DMA_BIT_MASK(12);
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		trans_pcie->supported_dma_mask = (u32)DMA_BIT_MASK(11);
+
+	info->max_skb_frags = IWL_TRANS_PCIE_MAX_FRAGS(trans_pcie);
+
+	trans_pcie->txqs.tso_hdr_page = alloc_percpu(struct iwl_tso_hdr_page);
+	if (!trans_pcie->txqs.tso_hdr_page) {
+		ret = -ENOMEM;
+		goto out_free_txcmd_pool;
+	}
+
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		bc_tbl_n_entries = TFD_QUEUE_BC_SIZE_BZ;
+	else if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		bc_tbl_n_entries = TFD_QUEUE_BC_SIZE_AX210;
+	else
+		bc_tbl_n_entries = TFD_QUEUE_BC_SIZE;
+
+	trans_pcie->txqs.bc_tbl_size =
+		sizeof(struct iwl_bc_tbl_entry) * bc_tbl_n_entries;
+	/*
+	 * For gen2 devices, we use a single allocation for each byte-count
+	 * table, but they're pretty small (1k) so use a DMA pool that we
+	 * allocate here.
+	 */
+	if (trans->mac_cfg->gen2) {
+		trans_pcie->txqs.bc_pool =
+			dmam_pool_create("iwlwifi:bc", trans->dev,
+					 trans_pcie->txqs.bc_tbl_size,
+					 256, 0);
+		if (!trans_pcie->txqs.bc_pool) {
+			ret = -ENOMEM;
+			goto out_free_tso;
+		}
+	}
+
+	/* Some things must not change even if the config does */
+	WARN_ON(trans_pcie->txqs.tfd.addr_size !=
+		(trans->mac_cfg->gen2 ? 64 : 36));
+
+	/* Initialize NAPI here - it should be before registering to mac80211
+	 * in the opmode but after the HW struct is allocated.
+	 */
+	trans_pcie->napi_dev = alloc_netdev_dummy(sizeof(struct iwl_trans_pcie *));
+	if (!trans_pcie->napi_dev) {
+		ret = -ENOMEM;
+		goto out_free_tso;
+	}
+	/* The private struct in netdev is a pointer to struct iwl_trans_pcie */
+	priv = netdev_priv(trans_pcie->napi_dev);
+	*priv = trans_pcie;
+
+	trans_pcie->trans = trans;
+	trans_pcie->opmode_down = true;
+	spin_lock_init(&trans_pcie->irq_lock);
+	spin_lock_init(&trans_pcie->reg_lock);
+	spin_lock_init(&trans_pcie->alloc_page_lock);
+	mutex_init(&trans_pcie->mutex);
+	init_waitqueue_head(&trans_pcie->ucode_write_waitq);
+	init_waitqueue_head(&trans_pcie->fw_reset_waitq);
+	init_waitqueue_head(&trans_pcie->imr_waitq);
+
+	trans_pcie->rba.alloc_wq = alloc_workqueue("rb_allocator",
+						   WQ_HIGHPRI | WQ_UNBOUND, 0);
+	if (!trans_pcie->rba.alloc_wq) {
+		ret = -ENOMEM;
+		goto out_free_ndev;
+	}
+	INIT_WORK(&trans_pcie->rba.rx_alloc, iwl_pcie_rx_allocator_work);
+
+	trans_pcie->debug_rfkill = -1;
+
+	if (!mac_cfg->base->pcie_l1_allowed) {
+		/*
+		 * W/A - seems to solve weird behavior. We need to remove this
+		 * if we don't want to stay in L1 all the time. This wastes a
+		 * lot of power.
+		 */
+		pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S |
+				       PCIE_LINK_STATE_L1 |
+				       PCIE_LINK_STATE_CLKPM);
+	}
+
+	addr_size = trans_pcie->txqs.tfd.addr_size;
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(addr_size));
+	if (ret) {
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		/* both attempts failed: */
+		if (ret) {
+			dev_err(&pdev->dev, "No suitable DMA available\n");
+			goto out_no_pci;
+		}
+	}
+
+	/* We disable the RETRY_TIMEOUT register (0x41) to keep
+	 * PCI Tx retries from interfering with C3 CPU state */
+	pci_write_config_byte(pdev, PCI_CFG_RETRY_TIMEOUT, 0x00);
+
+	trans_pcie->pci_dev = pdev;
+	iwl_disable_interrupts(trans);
+
+	/*
+	 * In the 8000 HW family the format of the 4 bytes of CSR_HW_REV have
+	 * changed, and now the revision step also includes bit 0-1 (no more
+	 * "dash" value). To keep hw_rev backwards compatible - we'll store it
+	 * in the old format.
+	 */
+	if (mac_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
+		info->hw_rev_step = info->hw_rev & 0xF;
+	else
+		info->hw_rev_step = (info->hw_rev & 0xC) >> 2;
+
+	IWL_DEBUG_INFO(trans, "HW REV: 0x%0x\n", info->hw_rev);
+
+	iwl_pcie_set_interrupt_capa(pdev, trans, mac_cfg, info);
+
+	init_waitqueue_head(&trans_pcie->sx_waitq);
+
+	ret = iwl_pcie_alloc_invalid_tx_cmd(trans);
+	if (ret)
+		goto out_no_pci;
+
+	if (trans_pcie->msix_enabled) {
+		ret = iwl_pcie_init_msix_handler(pdev, trans_pcie, info);
+		if (ret)
+			goto out_no_pci;
+	 } else {
+		ret = iwl_pcie_alloc_ict(trans);
+		if (ret)
+			goto out_no_pci;
+
+		ret = devm_request_threaded_irq(&pdev->dev, pdev->irq,
+						iwl_pcie_isr,
+						iwl_pcie_irq_handler,
+						IRQF_SHARED, DRV_NAME, trans);
+		if (ret) {
+			IWL_ERR(trans, "Error allocating IRQ %d\n", pdev->irq);
+			goto out_free_ict;
+		}
+	 }
+
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	trans_pcie->fw_mon_data.state = IWL_FW_MON_DBGFS_STATE_CLOSED;
+	mutex_init(&trans_pcie->fw_mon_data.mutex);
+#endif
+
+	iwl_dbg_tlv_init(trans);
+
+	return trans;
+
+out_free_ict:
+	iwl_pcie_free_ict(trans);
+out_no_pci:
+	destroy_workqueue(trans_pcie->rba.alloc_wq);
+out_free_ndev:
+	free_netdev(trans_pcie->napi_dev);
+out_free_tso:
+	free_percpu(trans_pcie->txqs.tso_hdr_page);
+out_free_txcmd_pool:
+	kmem_cache_destroy(trans_pcie->dev_cmd_pool);
+out_free_trans:
+	iwl_trans_free(trans);
+	return ERR_PTR(ret);
+}
+
+void iwl_trans_pcie_copy_imr_fh(struct iwl_trans *trans,
+				u32 dst_addr, u64 src_addr, u32 byte_cnt)
+{
+	iwl_write_prph(trans, IMR_UREG_CHICK,
+		       iwl_read_prph(trans, IMR_UREG_CHICK) |
+		       IMR_UREG_CHICK_HALT_UMAC_PERMANENTLY_MSK);
+	iwl_write_prph(trans, IMR_TFH_SRV_DMA_CHNL0_SRAM_ADDR, dst_addr);
+	iwl_write_prph(trans, IMR_TFH_SRV_DMA_CHNL0_DRAM_ADDR_LSB,
+		       (u32)(src_addr & 0xFFFFFFFF));
+	iwl_write_prph(trans, IMR_TFH_SRV_DMA_CHNL0_DRAM_ADDR_MSB,
+		       iwl_get_dma_hi_addr(src_addr));
+	iwl_write_prph(trans, IMR_TFH_SRV_DMA_CHNL0_BC, byte_cnt);
+	iwl_write_prph(trans, IMR_TFH_SRV_DMA_CHNL0_CTRL,
+		       IMR_TFH_SRV_DMA_CHNL0_CTRL_D2S_IRQ_TARGET_POS |
+		       IMR_TFH_SRV_DMA_CHNL0_CTRL_D2S_DMA_EN_POS |
+		       IMR_TFH_SRV_DMA_CHNL0_CTRL_D2S_RS_MSK);
+}
+
+int iwl_trans_pcie_copy_imr(struct iwl_trans *trans,
+			    u32 dst_addr, u64 src_addr, u32 byte_cnt)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int ret = -1;
+
+	trans_pcie->imr_status = IMR_D2S_REQUESTED;
+	iwl_trans_pcie_copy_imr_fh(trans, dst_addr, src_addr, byte_cnt);
+	ret = wait_event_timeout(trans_pcie->imr_waitq,
+				 trans_pcie->imr_status !=
+				 IMR_D2S_REQUESTED, 5 * HZ);
+	if (!ret || trans_pcie->imr_status == IMR_D2S_ERROR) {
+		IWL_ERR(trans, "Failed to copy IMR Memory chunk!\n");
+		iwl_trans_pcie_dump_regs(trans, trans_pcie->pci_dev);
+		return -ETIMEDOUT;
+	}
+	trans_pcie->imr_status = IMR_D2S_IDLE;
+	return 0;
+}
+
+/*
+ * Read rf id and cdb info from prph register and store it
+ */
+static void get_crf_id(struct iwl_trans *iwl_trans,
+		       struct iwl_trans_info *info)
+{
+	u32 sd_reg_ver_addr;
+	u32 hw_wfpm_id;
+	u32 val = 0;
+	u8 step;
+
+	if (iwl_trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		sd_reg_ver_addr = SD_REG_VER_GEN2;
+	else
+		sd_reg_ver_addr = SD_REG_VER;
+
+	/* Enable access to peripheral registers */
+	val = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG);
+	val |= WFPM_AUX_CTL_AUX_IF_MAC_OWNER_MSK;
+	iwl_write_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG, val);
+
+	/* Read crf info */
+	info->hw_crf_id = iwl_read_prph_no_grab(iwl_trans, sd_reg_ver_addr);
+
+	/* Read cnv info */
+	info->hw_cnv_id = iwl_read_prph_no_grab(iwl_trans, CNVI_AUX_MISC_CHIP);
+
+	/* For BZ-W, take B step also when A step is indicated */
+	if (CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ_W)
+		step = SILICON_B_STEP;
+
+	/* In BZ, the MAC step must be read from the CNVI aux register */
+	if (CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ) {
+		step = CNVI_AUX_MISC_CHIP_MAC_STEP(info->hw_cnv_id);
+
+		/* For BZ-U, take B step also when A step is indicated */
+		if ((CNVI_AUX_MISC_CHIP_PROD_TYPE(info->hw_cnv_id) ==
+		    CNVI_AUX_MISC_CHIP_PROD_TYPE_BZ_U) &&
+		    step == SILICON_A_STEP)
+			step = SILICON_B_STEP;
+	}
+
+	if (CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ ||
+	    CSR_HW_REV_TYPE(info->hw_rev) == IWL_CFG_MAC_TYPE_BZ_W) {
+		info->hw_rev_step = step;
+		info->hw_rev |= step;
+	}
+
+	/* Read cdb info (also contains the jacket info if needed in the future */
+	hw_wfpm_id = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_OTP_CFG1_ADDR);
+
+	IWL_INFO(iwl_trans, "Detected crf-id 0x%x, cnv-id 0x%x wfpm id 0x%x\n",
+		 info->hw_crf_id, info->hw_cnv_id, hw_wfpm_id);
+}
+
+/*
+ * In case that there is no OTP on the NIC, map the rf id and cdb info
+ * from the prph registers.
+ */
+static int map_crf_id(struct iwl_trans *iwl_trans,
+		      struct iwl_trans_info *info)
+{
+	int ret = 0;
+	u32 val = info->hw_crf_id;
+	u32 step_id = REG_CRF_ID_STEP(val);
+	u32 slave_id = REG_CRF_ID_SLAVE(val);
+	u32 hw_wfpm_id = iwl_read_umac_prph_no_grab(iwl_trans,
+						    WFPM_OTP_CFG1_ADDR);
+	u32 cdb_id_wfpm = WFPM_OTP_CFG1_IS_CDB(hw_wfpm_id);
+
+	/* Map between crf id to rf id */
+	switch (REG_CRF_ID_TYPE(val)) {
+	case REG_CRF_ID_TYPE_JF_1:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_JF1 << 12);
+		break;
+	case REG_CRF_ID_TYPE_JF_2:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_JF2 << 12);
+		break;
+	case REG_CRF_ID_TYPE_HR_NONE_CDB_1X1:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_HR1 << 12);
+		break;
+	case REG_CRF_ID_TYPE_HR_NONE_CDB:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_HR2 << 12);
+		break;
+	case REG_CRF_ID_TYPE_HR_CDB:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_HR2 << 12);
+		break;
+	case REG_CRF_ID_TYPE_GF:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_GF << 12);
+		break;
+	case REG_CRF_ID_TYPE_FM:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_FM << 12);
+		break;
+	case REG_CRF_ID_TYPE_WHP:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_WH << 12);
+		break;
+	case REG_CRF_ID_TYPE_PE:
+		info->hw_rf_id = (IWL_CFG_RF_TYPE_PE << 12);
+		break;
+	default:
+		ret = -EIO;
+		IWL_ERR(iwl_trans,
+			"Can't find a correct rfid for crf id 0x%x\n",
+			REG_CRF_ID_TYPE(val));
+		goto out;
+	}
+
+	/* Set Step-id */
+	info->hw_rf_id |= (step_id << 8);
+
+	/* Set CDB capabilities */
+	if (cdb_id_wfpm || slave_id) {
+		info->hw_rf_id += BIT(28);
+		IWL_INFO(iwl_trans, "Adding cdb to rf id\n");
+	}
+
+	IWL_INFO(iwl_trans,
+		 "Detected rf-type 0x%x step-id 0x%x slave-id 0x%x from crf id 0x%x\n",
+		 REG_CRF_ID_TYPE(val), step_id, slave_id, info->hw_rf_id);
+	IWL_INFO(iwl_trans,
+		 "Detected cdb-id 0x%x from wfpm id 0x%x\n",
+		 cdb_id_wfpm, hw_wfpm_id);
+out:
+	return ret;
+}
+
+static void iwl_pcie_recheck_me_status(struct work_struct *wk)
+{
+	struct iwl_trans_pcie *trans_pcie = container_of(wk,
+							 typeof(*trans_pcie),
+							 me_recheck_wk.work);
+	u32 val;
+
+	val = iwl_read32(trans_pcie->trans, CSR_HW_IF_CONFIG_REG);
+	trans_pcie->me_present = !!(val & CSR_HW_IF_CONFIG_REG_IAMT_UP);
+}
+
+static void iwl_pcie_check_me_status(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	u32 val;
+
+	trans_pcie->me_present = -1;
+
+	INIT_DELAYED_WORK(&trans_pcie->me_recheck_wk,
+			  iwl_pcie_recheck_me_status);
+
+	/* we don't have a good way of determining this until BZ */
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
+		return;
+
+	val = iwl_read_prph(trans, CNVI_SCU_REG_FOR_ECO_1);
+	if (val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN) {
+		trans_pcie->me_present =
+			!!(val & CNVI_SCU_REG_FOR_ECO_1_WIAMT_PRESENT);
+		return;
+	}
+
+	val = iwl_read32(trans, CSR_HW_IF_CONFIG_REG);
+	if (val & (CSR_HW_IF_CONFIG_REG_ME_OWN |
+		   CSR_HW_IF_CONFIG_REG_IAMT_UP)) {
+		trans_pcie->me_present = 1;
+		return;
+	}
+
+	/* recheck again later, ME might still be initializing */
+	schedule_delayed_work(&trans_pcie->me_recheck_wk, HZ);
+}
+
+int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
+			 const struct pci_device_id *ent,
+			 const struct iwl_mac_cfg *mac_cfg,
+			 u8 __iomem *hw_base, u32 hw_rev)
+{
+	const struct iwl_dev_info *dev_info;
+	struct iwl_trans_info info = {
+		.hw_id = (pdev->device << 16) + pdev->subsystem_device,
+		.hw_rev = hw_rev,
+	};
+	struct iwl_trans *iwl_trans;
+	struct iwl_trans_pcie *trans_pcie;
+	int ret;
+
+	iwl_trans = iwl_trans_pcie_alloc(pdev, mac_cfg, &info, hw_base);
+	if (IS_ERR(iwl_trans))
+		return PTR_ERR(iwl_trans);
+
+	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(iwl_trans);
+
+	iwl_trans_pcie_check_product_reset_status(pdev);
+	iwl_trans_pcie_check_product_reset_mode(pdev);
+
+	/* set the things we know so far for the grab NIC access */
+	iwl_trans_set_info(iwl_trans, &info);
+
+	/*
+	 * Let's try to grab NIC access early here. Sometimes, NICs may
+	 * fail to initialize, and if that happens it's better if we see
+	 * issues early on (and can reprobe, per the logic inside), than
+	 * first trying to load the firmware etc. and potentially only
+	 * detecting any problems when the first interface is brought up.
+	 */
+	ret = iwl_pcie_prepare_card_hw(iwl_trans);
+	if (!ret) {
+		ret = iwl_trans_activate_nic(iwl_trans);
+		if (ret)
+			goto out_free_trans;
+		if (iwl_trans_grab_nic_access(iwl_trans)) {
+			get_crf_id(iwl_trans, &info);
+			/* all good */
+			iwl_trans_release_nic_access(iwl_trans);
+		} else {
+			ret = -EIO;
+			goto out_free_trans;
+		}
+	}
+
+	info.hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
+
+	/*
+	 * The RF_ID is set to zero in blank OTP so read version to
+	 * extract the RF_ID.
+	 * This is relevant only for family 9000 and up.
+	 */
+	if (iwl_trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
+	    !CSR_HW_RFID_TYPE(info.hw_rf_id) && map_crf_id(iwl_trans, &info)) {
+		ret = -EINVAL;
+		goto out_free_trans;
+	}
+
+	IWL_INFO(iwl_trans, "PCI dev %04x/%04x, rev=0x%x, rfid=0x%x\n",
+		 pdev->device, pdev->subsystem_device,
+		 info.hw_rev, info.hw_rf_id);
+
+#if !IS_ENABLED(CONFIG_IWLMLD)
+	if (iwl_drv_is_wifi7_supported(iwl_trans)) {
+		IWL_ERR(iwl_trans,
+			"IWLMLD needs to be compiled to support this device\n");
+		ret = -EOPNOTSUPP;
+		goto out_free_trans;
+	}
+#endif
+
+	dev_info = iwl_pci_find_dev_info(pdev->device, pdev->subsystem_device,
+					 CSR_HW_RFID_TYPE(info.hw_rf_id),
+					 CSR_HW_RFID_IS_CDB(info.hw_rf_id),
+					 IWL_SUBDEVICE_RF_ID(pdev->subsystem_device),
+					 IWL_SUBDEVICE_BW_LIM(pdev->subsystem_device),
+					 !iwl_trans->mac_cfg->integrated);
+	if (dev_info) {
+		iwl_trans->cfg = dev_info->cfg;
+		info.name = dev_info->name;
+	}
+
+#if IS_ENABLED(CONFIG_IWLMVM)
+
+	/*
+	 * special-case 7265D, it has the same PCI IDs.
+	 *
+	 * Note that because we already pass the cfg to the transport above,
+	 * all the parameters that the transport uses must, until that is
+	 * changed, be identical to the ones in the 7265D configuration.
+	 */
+	if (iwl_trans->cfg == &iwl7265_cfg &&
+	    (info.hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D)
+		iwl_trans->cfg = &iwl7265d_cfg;
+#endif
+	if (!iwl_trans->cfg) {
+		pr_err("No config found for PCI dev %04x/%04x, rev=0x%x, rfid=0x%x\n",
+		       pdev->device, pdev->subsystem_device,
+		       info.hw_rev, info.hw_rf_id);
+		ret = -EINVAL;
+		goto out_free_trans;
+	}
+
+	IWL_INFO(iwl_trans, "Detected %s\n", info.name);
+
+	if (iwl_trans->mac_cfg->mq_rx_supported) {
+		if (WARN_ON(!iwl_trans->cfg->num_rbds)) {
+			ret = -EINVAL;
+			goto out_free_trans;
+		}
+		trans_pcie->num_rx_bufs = iwl_trans_get_num_rbds(iwl_trans);
+	} else {
+		trans_pcie->num_rx_bufs = RX_QUEUE_SIZE;
+	}
+
+	if (!iwl_trans->mac_cfg->integrated) {
+		u16 link_status;
+
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &link_status);
+
+		info.pcie_link_speed =
+			u16_get_bits(link_status, PCI_EXP_LNKSTA_CLS);
+	}
+
+	iwl_trans_set_info(iwl_trans, &info);
+
+	pci_set_drvdata(pdev, iwl_trans);
+
+	iwl_pcie_check_me_status(iwl_trans);
+
+	/* try to get ownership so that we'll know if we don't own it */
+	iwl_pcie_prepare_card_hw(iwl_trans);
+
+	iwl_trans->drv = iwl_drv_start(iwl_trans);
+
+	if (IS_ERR(iwl_trans->drv)) {
+		ret = PTR_ERR(iwl_trans->drv);
+		goto out_free_trans;
+	}
+
+	/* register transport layer debugfs here */
+	iwl_trans_pcie_dbgfs_register(iwl_trans);
+
+	return 0;
+
+out_free_trans:
+	iwl_trans_pcie_free(iwl_trans);
+	return ret;
+}
+
+void iwl_pcie_gen1_2_remove(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	cancel_delayed_work_sync(&trans_pcie->me_recheck_wk);
+
+	iwl_drv_stop(trans->drv);
+
+	iwl_trans_pcie_free(trans);
+}
+
+int iwl_pcie_gen1_2_activate_nic(struct iwl_trans *trans)
+{
+	const struct iwl_mac_cfg *mac_cfg = trans->mac_cfg;
+	u32 poll_ready;
+	int err;
+
+	if (mac_cfg->bisr_workaround) {
+		/* ensure the TOP FSM isn't still in previous reset */
+		mdelay(2);
+	}
+
+	/*
+	 * Set "initialization complete" bit to move adapter from
+	 * D0U* --> D0A* (powered-up active) state.
+	 */
+	if (mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ |
+			    CSR_GP_CNTRL_REG_FLAG_MAC_INIT);
+		poll_ready = CSR_GP_CNTRL_REG_FLAG_MAC_STATUS;
+	} else {
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
+		poll_ready = CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY;
+	}
+
+	if (mac_cfg->device_family == IWL_DEVICE_FAMILY_8000)
+		udelay(2);
+
+	/*
+	 * Wait for clock stabilization; once stabilized, access to
+	 * device-internal resources is supported, e.g. iwl_write_prph()
+	 * and accesses to uCode SRAM.
+	 */
+	err = iwl_poll_bits(trans, CSR_GP_CNTRL, poll_ready, 25000);
+	if (err < 0) {
+		IWL_DEBUG_INFO(trans, "Failed to wake NIC\n");
+
+		iwl_pcie_dump_host_monitor(trans);
+	}
+
+	if (mac_cfg->bisr_workaround) {
+		/* ensure BISR shift has finished */
+		udelay(200);
+	}
+
+	return err;
+}
-- 
2.47.3

