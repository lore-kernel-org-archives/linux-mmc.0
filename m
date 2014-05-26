From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 09/11] brcmfmac: Fix OOB interrupt not working
 for BCM43362
Date: Mon, 26 May 2014 09:48:04 +0200
Message-ID: <1401090486-4414-10-git-send-email-hdegoede@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBW7DROOAKGQEM7LU5ZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1401090486-4414-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

It has taken me a long long time to get the OOB interrupt working on the
AP6210 sdio wifi/bt module found on various Allwinner A20 boards. In the
end I found these magic register pokes in the cubietruck kernel tree:
https://github.com/cubieboard2/linux-sunxi/commit/7f08ba395617d17e7a711507503d89a50406fe7a

I'm not entirely sure if this specific to the AP6210 module, or if this
should be done for all BCM43362 sdio devices.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
index 0fc707c..2369a0f 100644
--- a/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c
@@ -39,7 +39,9 @@
 #include <brcm_hw_ids.h>
 #include <brcmu_utils.h>
 #include <brcmu_wifi.h>
+#include <chipcommon.h>
 #include <soc.h>
+#include "chip.h"
 #include "dhd_bus.h"
 #include "dhd_dbg.h"
 #include "sdio_host.h"
@@ -119,6 +121,7 @@ int brcmf_sdiod_intr_register(struct brcmf_sdio_dev *sdiodev)
 {
 	int ret = 0;
 	u8 data;
+	u32 addr, gpiocontrol;
 	unsigned long flags;
 
 	if ((sdiodev->pdata) && (sdiodev->pdata->oob_irq_supported)) {
@@ -148,6 +151,21 @@ int brcmf_sdiod_intr_register(struct brcmf_sdio_dev *sdiodev)
 
 		sdio_claim_host(sdiodev->func[1]);
 
+		if (sdiodev->bus_if->chip == BCM43362_CHIP_ID) {
+			addr = CORE_CC_REG(SI_ENUM_BASE, gpiocontrol);
+			gpiocontrol = brcmf_sdiod_regrl(sdiodev, addr, &ret);
+			gpiocontrol |= 0x2;
+			brcmf_sdiod_regwl(sdiodev, addr, gpiocontrol, &ret);
+
+			/* SPROM_ADDR_HIGH ? perhaps the defines name is off */
+			brcmf_sdiod_regwb(sdiodev, SBSDIO_SPROM_ADDR_HIGH, 0xf,
+					  &ret);
+			brcmf_sdiod_regwb(sdiodev, SBSDIO_CHIP_CTRL_DATA, 0,
+					  &ret);
+			brcmf_sdiod_regwb(sdiodev, SBSDIO_CHIP_CTRL_EN, 0x2,
+					  &ret);
+		}
+
 		/* must configure SDIO_CCCR_IENx to enable irq */
 		data = brcmf_sdiod_regrb(sdiodev, SDIO_CCCR_IENx, &ret);
 		data |= 1 << SDIO_FUNC_1 | 1 << SDIO_FUNC_2 | 1;
-- 
1.9.3
