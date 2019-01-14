From: Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] mmc: core: annotate implicit fall through
Date: Mon, 14 Jan 2019 21:42:11 +0100
Message-ID: <20190114204211.21386-1-malat@debian.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mathieu Malaterre <malat@debian.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

In this particular case rewrote the comment to start with the string "fall
through", so as to match the regular expression expected by GCC. Truncate
the comment slightly to fit the max line length of 80 characters.

This commit remove the following warning:

  drivers/mmc/core/host.c:196:14: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/mmc/core/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index f57f5de54206..0052d6fed7c8 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -194,7 +194,7 @@ int mmc_of_parse(struct mmc_host *host)
 	switch (bus_width) {
 	case 8:
 		host->caps |= MMC_CAP_8_BIT_DATA;
-		/* Hosts capable of 8-bit transfers can also do 4 bits */
+		/* fall through - Hosts capable of 8-bit can also do 4 bits */
 	case 4:
 		host->caps |= MMC_CAP_4_BIT_DATA;
 		break;
-- 
2.19.2
