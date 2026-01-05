Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC97234973
	for <linux-mmc@vger.kernel.org>; Mon,  5 Jan 2026 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767595578; cv=none; b=iE5oM+Ca+r4h8FHsdumD8SQ1nMSI6QWIcl/NBO2GMWpNNuWE/yK68iuLcaxCuHv67tNX4sgHy9Qc3zuVaAhIFZAQO56B6jkJ1m42SWoBmxhFCtxmwxHd7+b7f8bt+kjn9jwkOJvXY7jddJ7jqYxn9nV/Gob1mwZKVSu5cQUh/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767595578; c=relaxed/simple;
	bh=8U1kE3jep3pvKVeHM6RwIuITuKbmiyH88Hmm5ceYZg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tx51+sTmQriBuADqCvLP7rPEmj5iyuHlWx5R7vVjJ5+QMowuyOFG5zGWeAPU8Z49No8EOllmvnqEA68OC6/L5zmhZhmGapl5+3gsCq2F5iInT9b/XU8PhfM2ouyVn9tG7yK7Bq8qVMmWo1NjFi0wDZptqoVAezH9hkSFj0w7mW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=V0xLefLA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="V0xLefLA"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b9387df58cso22051235b3a.3
        for <linux-mmc@vger.kernel.org>; Sun, 04 Jan 2026 22:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1767595574; x=1768200374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fIvba1dtnjACs/yRHiJzbXUQbVZum9CYzrKlL1W069s=;
        b=V0xLefLAtmjFuxP1KoJIenNr/nKqBqX6V+4Tx+13vketRl3X0K/BE605n7Mv248C+l
         4z6C9YSjwl9GDM8i98oud1EliFYEn25g++bCKcdRthtmjK6C8C3cuW+v+MUrtYOsLbu0
         EjxFy12CxPB2NlYholsXwSKxS7qEJgCwTASh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767595574; x=1768200374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIvba1dtnjACs/yRHiJzbXUQbVZum9CYzrKlL1W069s=;
        b=CoUVazfBjSXDeamrcYzB/01RcfaogI/CGVV0S58bw9QCd1DQrXGlXrHEI/954MIR68
         aCbEJ/ootK6pAGsp3u6GQSooK7U58XOUGj5sa1aeFlnq0gGITwHJ4Nx3Dng11mus2ps6
         RnES5KHd2cVLxBwJSotbar9x7nxWvD+TcogK2imIvE+Gwra+mhHaCZFW3hKfO8SlFMuA
         oG3ymyNshj+QGa6rys5NV83xycLSw0NnJA9CoNPtw32aJBbzkc+S1el20sKBTUrRhtNe
         auGOyS6W2cK4CkfAiUhxpnHSFemlUB33c/NTr0hu+PQG3K6YZiv/700pR7D9UdYLyzKz
         iHew==
X-Forwarded-Encrypted: i=1; AJvYcCVI3LRmoTxnJsfZn81Un3f2tR/WWKNnLNvAKqqVqL4O4ejrPGmoS/pxrEejGY2xQCSGwhDKswqP3C8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6KEwAAxY60MCFaUv8+bSTUZKgWejJsHIjx9LuHH8rGxXm3nf
	zyppvcJv8vO8oa6DRYdRgQ7mAW8V6DO+o2QTRF+CHc5HLetwLYGGGM12wID/dca4CIMpW3wXU2B
	zA8BzJM8=
X-Gm-Gg: AY/fxX70jC/7yLa6YB4ZG5qy4tC1fpASMTe88cwEtBYNuzeBzdu9H/4u4/CBbRGL/IU
	4sZQ665r1CwU6yJLQMTpz5LThR9eg30f2Jg543CWJ11iHSPhtMvHgSI1NqNHCyDfnA3zSLCe3oT
	XSrSa6TpT1Xv83P+jMkFfHIfmfg9an/9Dd9i+hMpvfCSc5e6Q+yimEXLti5UdhOmcBnureDqgi0
	V+F3tQLlOozVHZoe/vyy1lPDnsoGAteim1MtmaouNh8IkFC42xwMQ+W5wbV0GWLOe2apxLxt6sn
	CaYk/ZHPG0txEbKKStsMXGgcWSDvCBZW3B9srihw6bWZ2zQdO0y5EFXz1gcdrs6oSjakd3cVEdg
	2sSTWjWg3vsERW/Tzjzr7V+V+3U6IyCXvpO2VSRQugSmim9Yd9G4rhonUfVFP5ZrlKe13xDuWuW
	fRKDLhd7fpZDiDvbxJq+Khyv15OOHlsldB+rM8a/p2H/bPkDjJ1B1nvR1z5OPGULS1w6VQOZxAR
	xM=
X-Google-Smtp-Source: AGHT+IFyiAnho/hOZgOid83U5bBcIhekELzt+KCSFr/GAoPB4oDyM0auPkadxsFuf2d8abmC2+1tqw==
X-Received: by 2002:a05:6a20:6a06:b0:34f:1623:2354 with SMTP id adf61e73a8af0-376aa4fc36dmr50058842637.42.1767595574392;
        Sun, 04 Jan 2026 22:46:14 -0800 (PST)
Received: from kinako.work.home.arpa (p1536247-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [122.26.212.247])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7c143aa8sm40938853a12.24.2026.01.04.22.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 22:46:13 -0800 (PST)
From: Daniel Palmer <daniel@thingy.jp>
To: ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH] mmc: sdio: Allow sdio code to be build time disabled
Date: Mon,  5 Jan 2026 15:46:07 +0900
Message-ID: <20260105064607.1554629-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases the sdio support is not needed but the compiler
cannot tell this and it ends up in your binary.

This might not matter so much on generic kernels for systems
with gigabytes of memory but in situations with megabytes
of memory that just have an SD card attached via bitbanged SPI
over GPIO this is wasteful.

For amd64 disabling SDIO reduces the size of the kernel by ~26KiB.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---

RFC because this is probably incomplete, maybe not a good idea,..
I have only tested that this removes the unneeded SDIO code on my
machine with 8MB of RAM and its still able to enumerate and access
a 64GB SD card it has connected over SPI.

 drivers/mmc/core/Kconfig    | 12 +++++++++++-
 drivers/mmc/core/Makefile   |  6 +++---
 drivers/mmc/core/core.h     |  7 +++++++
 drivers/mmc/core/host.c     |  2 ++
 drivers/mmc/core/sdio_bus.h |  5 +++++
 drivers/mmc/core/sdio_cis.h |  4 ++++
 drivers/mmc/core/sdio_ops.h | 14 ++++++++++++++
 7 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 14d2ecbb04d3..4112242a6c98 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -64,9 +64,19 @@ config MMC_BLOCK_MINORS
 
 	  If unsure, say 8 here.
 
+config MMC_SDIO
+	bool "Support SDIO in MMC core" if EXPERT
+	default y
+	help
+	  Enable SDIO support in the MMC core. If you will never use
+	  SDIO because your hardware can't support it or your usecase
+	  will never need it i.e. you have one SD host and it has fixed
+	  eMMC attached to it you can set this to N and remove some
+	  unneeded code.
+
 config SDIO_UART
 	tristate "SDIO UART/GPS class support"
-	depends on TTY
+	depends on MMC_SDIO && TTY
 	help
 	  SDIO function driver for SDIO cards that implements the UART
 	  class, as well as the GPS class which appears like a UART.
diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 15b067e8b0d1..efc354150e8a 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -6,9 +6,9 @@
 obj-$(CONFIG_MMC)		+= mmc_core.o
 mmc_core-y			:= core.o bus.o host.o \
 				   mmc.o mmc_ops.o sd.o sd_ops.o \
-				   sdio.o sdio_ops.o sdio_bus.o \
-				   sdio_cis.o sdio_io.o sdio_irq.o sd_uhs2.o\
-				   slot-gpio.o regulator.o
+				   sd_uhs2.o slot-gpio.o regulator.o
+mmc_core-$(CONFIG_MMC_SDIO)	+= sdio.o sdio_ops.o sdio_bus.o \
+				   sdio_cis.o sdio_io.o sdio_irq.o
 mmc_core-$(CONFIG_OF)		+= pwrseq.o
 obj-$(CONFIG_PWRSEQ_SIMPLE)	+= pwrseq_simple.o
 obj-$(CONFIG_PWRSEQ_SD8787)	+= pwrseq_sd8787.o
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index a028b48be164..8e2a1abc5523 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -85,7 +85,14 @@ int mmc_detect_card_removed(struct mmc_host *host);
 
 int mmc_attach_mmc(struct mmc_host *host);
 int mmc_attach_sd(struct mmc_host *host);
+#ifdef CONFIG_MMC_SDIO
 int mmc_attach_sdio(struct mmc_host *host);
+#else
+static inline int mmc_attach_sdio(struct mmc_host *host)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 int mmc_attach_sd_uhs2(struct mmc_host *host);
 
 /* Module parameters */
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 88c95dbfd9cf..0216953b8906 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -563,7 +563,9 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	spin_lock_init(&host->lock);
 	init_waitqueue_head(&host->wq);
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
+#ifdef CONFIG_MMC_SDIO
 	INIT_WORK(&host->sdio_irq_work, sdio_irq_work);
+#endif
 	timer_setup(&host->retune_timer, mmc_retune_timer, 0);
 
 	INIT_WORK(&host->supply.uv_work, mmc_undervoltage_workfn);
diff --git a/drivers/mmc/core/sdio_bus.h b/drivers/mmc/core/sdio_bus.h
index 27b8069a72ab..ad14784b37d1 100644
--- a/drivers/mmc/core/sdio_bus.h
+++ b/drivers/mmc/core/sdio_bus.h
@@ -14,8 +14,13 @@ struct sdio_func *sdio_alloc_func(struct mmc_card *card);
 int sdio_add_func(struct sdio_func *func);
 void sdio_remove_func(struct sdio_func *func);
 
+#ifdef CONFIG_MMC_SDIO
 int sdio_register_bus(void);
 void sdio_unregister_bus(void);
+#else
+#define sdio_register_bus() 0
+#define sdio_unregister_bus()
+#endif
 
 #endif
 
diff --git a/drivers/mmc/core/sdio_cis.h b/drivers/mmc/core/sdio_cis.h
index 6d76f6fa608c..486eeb802162 100644
--- a/drivers/mmc/core/sdio_cis.h
+++ b/drivers/mmc/core/sdio_cis.h
@@ -13,10 +13,14 @@
 struct mmc_card;
 struct sdio_func;
 
+#ifdef CONFIG_MMC_SDIO
 int sdio_read_common_cis(struct mmc_card *card);
 void sdio_free_common_cis(struct mmc_card *card);
 
 int sdio_read_func_cis(struct sdio_func *func);
 void sdio_free_func_cis(struct sdio_func *func);
+#else
+#define sdio_free_common_cis(card)
+#endif
 
 #endif
diff --git a/drivers/mmc/core/sdio_ops.h b/drivers/mmc/core/sdio_ops.h
index 37f79732a206..dc16e80aa361 100644
--- a/drivers/mmc/core/sdio_ops.h
+++ b/drivers/mmc/core/sdio_ops.h
@@ -12,6 +12,7 @@
 #include <linux/mmc/sdio.h>
 
 struct mmc_host;
+#ifdef CONFIG_MMC_SDIO
 struct mmc_card;
 struct work_struct;
 
@@ -33,6 +34,19 @@ static inline bool sdio_is_io_busy(u32 opcode, u32 arg)
 		(opcode == SD_IO_RW_DIRECT &&
 		!(addr == SDIO_CCCR_ABORT || addr == SDIO_CCCR_SUSPEND)));
 }
+#else
+/* These are referenced in code outside of the sdio files so define dummy versions */
+static inline int sdio_reset(struct mmc_host *host)
+{
+	return 0;
+}
+
+static inline bool sdio_is_io_busy(u32 opcode, u32 arg)
+{
+	return false;
+}
+#endif
+
 
 #endif
 
-- 
2.51.0

