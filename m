From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mmc: tmio: Remove bogus un-initialization in tmio_mmc_host_free()
Date: Wed, 18 Feb 2015 17:34:59 +0100
Message-ID: <1424277299-24964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ian Molton <ian.molton@codethink.co.uk>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-mmc@vger.kernel.org

If CONFIG_DEBUG_SLAB=y:

    sh_mobile_sdhi ee100000.sd: Got CD GPIO
    sh_mobile_sdhi ee100000.sd: Got WP GPIO
    platform ee100000.sd: Driver sh_mobile_sdhi requests probe deferral
    ...
    Slab corruption (Not tainted): kmalloc-1024 start=ed8b3c00, len=1024
    2d0: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  ....kkkkkkkkkkkk
    Prev obj: start=ed8b3800, len=1024
    000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
    010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk

Struct tmio_mmc_host is embedded inside struct mmc_host, and thus is
freed by the call to mmc_free_host(). Hence it must not be written to
afterwards, as that will corrupt freed (and perhaps already reused)
memory.

Fixes: 94b110aff8679b14 ("mmc: tmio: add tmio_mmc_host_alloc/free()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/tmio_mmc_pio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index a31c3573d386f8c6..dba7e1c19dd758e7 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1073,8 +1073,6 @@ EXPORT_SYMBOL(tmio_mmc_host_alloc);
 void tmio_mmc_host_free(struct tmio_mmc_host *host)
 {
 	mmc_free_host(host->mmc);
-
-	host->mmc = NULL;
 }
 EXPORT_SYMBOL(tmio_mmc_host_free);
 
-- 
1.9.1

