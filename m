From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH v1 1/1] mmc: dw_mmc-bluefield: : Fix the license information
Date: Fri, 18 Jan 2019 13:12:06 -0500
Message-ID: <7f45f1c645ec166b25afe51aa9ae1decdae0b600.1547834838.git.lsun@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Greg KH <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, David Woods <dwoods@mellanox.com>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The SPDX license identifier and the boiler plate text are
contradicting. Only the SPDX license identifier is needed. The
other one is removed.

Fixes: 86958dcc5ad7 ("mmc: dw_mmc-bluefield: Add driver extension")
Cc: stable@vger.kernel.org
Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/mmc/host/dw_mmc-bluefield.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mmc-bluefield.c
index ed8f225..aa38b1a 100644
--- a/drivers/mmc/host/dw_mmc-bluefield.c
+++ b/drivers/mmc/host/dw_mmc-bluefield.c
@@ -1,11 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2018 Mellanox Technologies.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include <linux/bitfield.h>
-- 
1.8.3.1
