From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH v2] ARM: mmci:Remove unnecessary #include header file in mmci.c
Date: Mon, 14 Mar 2016 13:44:33 +0800
Message-ID: <1457934273-2977-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>
Cc: Wang Hongcheng <annie.wang@amd.com>
List-Id: linux-mmc@vger.kernel.org

The header file asm/sizes.h is unnecessary.
And it can also be compiled under X86 arch after the removal.

Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
---
 drivers/mmc/host/mmci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index fb26674..e5e5441 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -40,7 +40,6 @@
 
 #include <asm/div64.h>
 #include <asm/io.h>
-#include <asm/sizes.h>
 
 #include "mmci.h"
 #include "mmci_qcom_dml.h"
-- 
1.9.1
