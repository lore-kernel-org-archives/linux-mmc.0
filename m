From: Sean Lanigan <sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org>
Subject: [PATCH] brcmfmac: Add support for bcm43364 wireless chipset
Date: Fri,  4 May 2018 16:48:23 +1000
Message-ID: <1525416503-832-1-git-send-email-sean@lano.id.au>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
Cc: franky.lin-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, hante.meuleman-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, chi-hsien.lin-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, wright.feng-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brcm80211-dev-list-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sean Lanigan <sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add support for the BCM43364 chipset via an SDIO interface, as used in 
e.g. the Murata 1FX module. 

The BCM43364 uses the same firmware as the BCM43430 (which is already 
included), the only difference is the omission of Bluetooth. 

However, the SDIO_ID for the BCM43364 is 02D0:A9A4, giving it a MODALIAS 
of sdio:c00v02D0dA9A4, which doesn't get recognised and hence doesn't 
load the brcmfmac module. Adding the 'A9A4' ID in the appropriate place 
triggers the brcmfmac driver to load, and then correctly use the 
firmware file 'brcmfmac43430-sdio.bin'. 


Signed-off-by: Sean Lanigan <sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 +
 include/linux/mmc/sdio_ids.h                              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 0b68240..4648a3d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -963,6 +963,7 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43340),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43341),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43362),
+ 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43364),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4335_4339),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4339),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43430),
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index cdd66a5..0a7abe8 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -35,6 +35,7 @@
 #define SDIO_DEVICE_ID_BROADCOM_4335_4339	0x4335
 #define SDIO_DEVICE_ID_BROADCOM_4339		0x4339
 #define SDIO_DEVICE_ID_BROADCOM_43362		0xa962
+#define SDIO_DEVICE_ID_BROADCOM_43364		0xa9a4
 #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
 #define SDIO_DEVICE_ID_BROADCOM_4345		0x4345
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
-- 
2.7.4
