From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mmc: mediatek: Preinitialize delay_phase in get_best_delay()
Date: Fri,  6 Nov 2015 12:22:08 +0100
Message-ID: <1446808928-25648-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:34005 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031997AbbKFLWE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 06:22:04 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mmc@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

drivers/mmc/host/mtk-sd.c: In function =E2=80=98get_best_delay=E2=80=99=
:
drivers/mmc/host/mtk-sd.c:1284: warning: =E2=80=98delay_phase.start=E2=80=
=99 is used uninitialized in this function
drivers/mmc/host/mtk-sd.c:1284: warning: =E2=80=98delay_phase.maxlen=E2=
=80=99 is used uninitialized in this function

If delay is zero, these fields are indeed not initialized.
Let the compiler preinitialize the whole struct to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 39568cc29a2a18cf..33dfd7e72516c392 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1276,7 +1276,7 @@ static struct msdc_delay_phase get_best_delay(str=
uct msdc_host *host, u32 delay)
 	int start =3D 0, len =3D 0;
 	int start_final =3D 0, len_final =3D 0;
 	u8 final_phase =3D 0xff;
-	struct msdc_delay_phase delay_phase;
+	struct msdc_delay_phase delay_phase =3D { 0, };
=20
 	if (delay =3D=3D 0) {
 		dev_err(host->dev, "phase error: [map:%x]\n", delay);
--=20
1.9.1

