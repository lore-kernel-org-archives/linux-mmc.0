From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] mmc: mmci: fix an ages old detection error
Date: Mon,  4 Jan 2016 02:21:55 +0100
Message-ID: <1451870515-21049-1-git-send-email-linus.walleij@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

commit 4956e10903fd3459306dd9438c1e714ba3068a2a
"ARM: 6244/1: mmci: add variant data and default MCICLOCK support"
added variant data for ARM, U300 and Ux500 variants. The
Nomadik NHK8815/8820 variant was erroneously labeled as a
U300 variant, and when the proper Nomadik variant was
later introduced in commit
34fd421349ffc6a4280b71276bf7c6d48f92156f
"ARM: 7378/1: mmci: add support for the Nomadik MMCI variant"
this was not fixes. Let's say this fixes the latter commit
as there was no proper Nomadik support until then.

Cc: stable@vger.kernel.org
Fixes: 34fd421349ff "ARM: 7378/1: mmci: add support for the Nomadik MMCI variant"
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index fb266745f824..acece3299756 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1886,7 +1886,7 @@ static struct amba_id mmci_ids[] = {
 	{
 		.id     = 0x00280180,
 		.mask   = 0x00ffffff,
-		.data	= &variant_u300,
+		.data	= &variant_nomadik,
 	},
 	{
 		.id     = 0x00480180,
-- 
2.4.3
