From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH] brcmfmac: add support for BCM43455 with modalias sdio:c00v02D0dA9BF
Date: Mon, 16 Jan 2017 11:17:57 +0100
Message-ID: <20170116101757.20483-1-martin.blumenstingl@googlemail.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brcm80211-dev-list.pdl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, franky.lin-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, hante.meuleman-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

BCM43455 is a more recent revision of the BCM4345. Some of the BCM43455
got a dedicated SDIO device ID which is currently not supported by
brcmfmac.
Adding the new sdio_device_id to brcmfmac is enough to get the BCM43455
supported because the chip itself is already supported (due to BCM4345
support in the driver).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
This is the proper patch following the (short) discussion from [0]

[0] https://marc.info/?l=linux-wireless&m=148455981002310&w=2

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 +
 include/linux/mmc/sdio_ids.h                              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 72139b579b18..5bc2ba214735 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1104,6 +1104,7 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4339),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43430),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4345),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43455),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4356),
 	{ /* end: all zeroes */ }
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index d43ef96bf075..71b113e1223f 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -36,6 +36,7 @@
 #define SDIO_DEVICE_ID_BROADCOM_43362		0xa962
 #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
 #define SDIO_DEVICE_ID_BROADCOM_4345		0x4345
+#define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
 #define SDIO_DEVICE_ID_BROADCOM_4354		0x4354
 #define SDIO_DEVICE_ID_BROADCOM_4356		0x4356
 
-- 
2.11.0
