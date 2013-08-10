From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH] mmc:bfin_sdh fix build warning in sdh_dma_irq()
Date: Sat, 10 Aug 2013 09:20:49 -0600
Message-ID: <1376148055-2539-4-git-send-email-shuah.kh@samsung.com>
References: <1376148055-2539-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376148055-2539-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sonic.zhang@analog.com, cjb@laptop.org
Cc: Shuah Khan <shuah.kh@samsung.com>, uclinux-dist-devel@blackfin.uclinux.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-mmc@vger.kernel.org

=46ix the following build warning in sdh_dma_irq()
drivers/mmc/host/bfin_sdh.c:466:2: warning: format =E2=80=98%lx=E2=80=99=
 expects argument of type =E2=80=98long unsigned int=E2=80=99, but argu=
ment 5 has type =E2=80=98int=E2=80=99 [-Wformat]
       dev_dbg(mmc_dev(host->mmc), "%s enter, irq_stat: 0x%04x\n", __fu=
nc__,
                get_dma_curr_irqstat(host->dma_ch));

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/mmc/host/bfin_sdh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 7b3e12f..61157c4 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -463,7 +463,7 @@ static irqreturn_t sdh_dma_irq(int irq, void *devid=
)
 {
 	struct sdh_host *host =3D devid;
=20
-	dev_dbg(mmc_dev(host->mmc), "%s enter, irq_stat: 0x%04lx\n", __func__=
,
+	dev_dbg(mmc_dev(host->mmc), "%s enter, irq_stat: 0x%04x\n", __func__,
 		get_dma_curr_irqstat(host->dma_ch));
 	clear_dma_irqstat(host->dma_ch);
 	SSYNC();
--=20
1.7.10.4
