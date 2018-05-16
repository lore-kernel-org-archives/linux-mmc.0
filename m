From: Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] mmc: block: propagate correct returned value in mmc_rpmb_ioctl
Date: Wed, 16 May 2018 21:20:20 +0200
Message-ID: <20180516192022.23541-1-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mathieu Malaterre <malat@debian.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

In commit 97548575bef3 ("mmc: block: Convert RPMB to a character device") a
new function `mmc_rpmb_ioctl` was added. The final return is simply
returning a value of `0` instead of propagating the correct return code.

Discovered during a compilation with W=1, silence the following gcc warning

  drivers/mmc/core/block.c:2470:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 9e923cd1d80e..38a7586b00cc 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2485,7 +2485,7 @@ static long mmc_rpmb_ioctl(struct file *filp, unsigned int cmd,
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.11.0
