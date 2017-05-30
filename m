From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 3/5] mmc: tmio, renesas-sdhi: update Renesas related copyrights
Date: Tue, 30 May 2017 14:50:52 +0200
Message-ID: <1496148654-20386-4-git-send-email-horms+renesas@verge.net.au>
References: <1496148654-20386-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1496148654-20386-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Update copyrights to reflect work by Wolfram Sang and myself since last
year.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/renesas_sdhi_core.c     | 5 +++--
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 3 +++
 drivers/mmc/host/tmio_mmc.c              | 2 ++
 drivers/mmc/host/tmio_mmc.h              | 5 +++--
 drivers/mmc/host/tmio_mmc_core.c         | 5 +++--
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 82150a966391..f4690cba3443 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1,8 +1,9 @@
 /*
  * Renesas SDHI
  *
- * Copyright (C) 2016 Sang Engineering, Wolfram Sang
- * Copyright (C) 2015-16 Renesas Electronics Corporation
+ * Copyright (C) 2015-17 Renesas Electronics Corporation
+ * Copyright (C) 2016-17 Sang Engineering, Wolfram Sang
+ * Copyright (C) 2016-17 Horms Solutions, Simon Horman
  * Copyright (C) 2009 Magnus Damm
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 7eab55adc5b2..202cf4346fdf 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -1,6 +1,9 @@
 /*
  * DMA function for TMIO MMC implementations
  *
+ * Copyright (C) 2016-17 Renesas Electronics Corporation
+ * Copyright (C) 2016-17 Sang Engineering, Wolfram Sang
+ * Copyright (C) 2017 Horms Solutions, Simon Horman
  * Copyright (C) 2010-2011 Guennadi Liakhovetski
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 59880146e7f9..61cf36fb270b 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -3,6 +3,8 @@
  *
  * TC6393XB TC6391XB TC6387XB T7L66XB ASIC3
  *
+ * Copyright (C) 2017 Renesas Electronics Corporation
+ * Copyright (C) 2017 Horms Solutions, Simon Horman
  * Copyright (C) 2007 Ian Molton
  * Copyright (C) 2004 Ian Molton
  *
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 9c94b6eb9b49..768c8abaedda 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -3,8 +3,9 @@
  *
  * TC6393XB TC6391XB TC6387XB T7L66XB ASIC3
  *
- * Copyright (C) 2016 Sang Engineering, Wolfram Sang
- * Copyright (C) 2015-16 Renesas Electronics Corporation
+ * Copyright (C) 2015-17 Renesas Electronics Corporation
+ * Copyright (C) 2016-17 Sang Engineering, Wolfram Sang
+ * Copyright (C) 2016-17 Horms Solutions, Simon Horman
  * Copyright (C) 2007 Ian Molton
  * Copyright (C) 2004 Ian Molton
  *
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 242d9bcc365a..70516abd50a1 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -3,8 +3,9 @@
  *
  * TC6393XB, TC6391XB, TC6387XB, T7L66XB, ASIC3, SH-Mobile SoCs
  *
- * Copyright (C) 2016 Sang Engineering, Wolfram Sang
- * Copyright (C) 2015-16 Renesas Electronics Corporation
+ * Copyright (C) 2015-17 Renesas Electronics Corporation
+ * Copyright (C) 2016-17 Sang Engineering, Wolfram Sang
+ * Copyright (C) 2017 Horms Solutions, Simon Horman
  * Copyright (C) 2011 Guennadi Liakhovetski
  * Copyright (C) 2007 Ian Molton
  * Copyright (C) 2004 Ian Molton
-- 
2.1.4
