From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH] mmc: tmio-mmc: fix bad pointer math
Date: Tue, 11 Jul 2017 09:29:11 -0700
Message-ID: <20170711162911.39114-1-chris.brandt@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
List-Id: linux-mmc@vger.kernel.org

The existing code gives an incorrect value.
The buffer pointer 'buf' was of type unsigned short *, and 'count' was a
number in bytes, so the pointer should have been cast before doing any
pointer arithmetic.

Since we know the code before it is doing as many 4-byte transfers as
possible, we just need a pointer to where it left off in the buffer, hence
zeroing out the bottom 2 bits of count for out math.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 8185e51f358a: ("mmc: tmio-mmc: add support for 32bit data port")
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 77e7b56a9099..5dfc556ccedf 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -428,7 +428,7 @@ static void tmio_mmc_transfer_data(struct tmio_mmc_host *host,
 		if (!(count & 0x3))
 			return;
 
-		buf8 = (u8 *)(buf + (count >> 2));
+		buf8 = (u8 *)buf + (count & ~3);
 		count %= 4;
 
 		if (is_read) {
-- 
2.13.0
