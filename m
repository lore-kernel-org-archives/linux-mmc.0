From: Adrien Schildknecht <adrien+dev@schischi.me>
Subject: [PATCH v2] mmc: kconfig: replace FAULT_INJECTION with FAULT_INJECTION_DEBUG_FS
Date: Tue, 10 Nov 2015 20:12:19 +0100
Message-ID: <1447182739-8996-1-git-send-email-adrien+dev@schischi.me>
References: <CAPDyKFq39uWPTBou+CUDqbWj8_RENeZMmokV3LRA5LBpG7fAVw@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq39uWPTBou+CUDqbWj8_RENeZMmokV3LRA5LBpG7fAVw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, linus.walleij@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Adrien Schildknecht <adrien+dev@schischi.me>
List-Id: linux-mmc@vger.kernel.org

Fault-injection capability for MMC IO uses debugfs entries to configure
the attributes.
FAULT_INJECTION_DEBUG_FS must be enabled to use FAIL_MMC_REQUEST.

Replace FAULT_INJECTION with FAULT_INJECTION_DEBUG_FS.
Also remove 'select DEBUG_FS' since FAULT_INJECTION_DEBUG_FS depends on
it.

Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
---
 lib/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 749e886..5c038d2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1523,8 +1523,7 @@ config FAIL_IO_TIMEOUT
 
 config FAIL_MMC_REQUEST
 	bool "Fault-injection capability for MMC IO"
-	select DEBUG_FS
-	depends on FAULT_INJECTION && MMC
+	depends on FAULT_INJECTION_DEBUG_FS && MMC
 	help
 	  Provide fault-injection capability for MMC IO.
 	  This will make the mmc core return data errors. This is
-- 
2.6.2
