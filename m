From: Seunguk Shin <seunguk.shin@samsung.com>
Subject: [PATCH] mmc: Support FFU for eMMC v5.0 for Samsung
Date: Fri, 04 Apr 2014 21:07:29 +0900
Message-ID: <000101cf4ffe$73484f80$59d8ee80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:55755 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaDDMH3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Apr 2014 08:07:29 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N3I00IL59OGXD10@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 04 Apr 2014 21:07:28 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, cpgs@samsung.com

This change adds support to field firmware update (ffu) for Samsung emmc
v5.0

Some of Samsung eMMC does not show the argument for ffu in ext_csd.
In case of this, eMMC shows 0x0 from ext_csd, Host has to modify the
argument.

And ffu for Samsung eMMC should transfer f/w through not multiple commands
but one command.
Because of f/w size, MMC_IOC_MAX_BYTES should be increased.
Usually normal io uses 512KB as the max chunk size,
So I think it does not cause the problem.

This patch depends on patch mmc: Support-FFU-for-eMMC-v5.0 committed by Avi
Shchislowski <avi.shchislowski@sandisk.com>

---
 drivers/mmc/card/ffu.c         | 7 +++++++
 include/linux/mmc/card.h       | 1 +
 include/uapi/linux/mmc/ioctl.h | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/ffu.c b/drivers/mmc/card/ffu.c
index 41aad31..092a791 100644
--- a/drivers/mmc/card/ffu.c
+++ b/drivers/mmc/card/ffu.c
@@ -444,6 +444,8 @@ static int mmc_host_set_ffu(struct mmc_card *card, u32
ffu_enable)
        return 0;
 }

+#define CID_MANFID_SAMSUNG             0x15
+
 int mmc_ffu_download(struct mmc_card *card, struct mmc_command *cmd,
        u8 *data, int buf_bytes)
 {
@@ -490,6 +492,11 @@ int mmc_ffu_download(struct mmc_card *card, struct
mmc_command *cmd,
                ext_csd[EXT_CSD_FFU_ARG + 2] << 16 |
                ext_csd[EXT_CSD_FFU_ARG + 3] << 24;

+       /* If arg is zero, should be set to a special value for samsung eMMC
*/
+       if (card->quirks & MMC_QUIRK_SEC_FIX_FFU_ARG &&
+           card->cid.manfid == CID_MANFID_SAMSUNG && cmd->arg == 0x0)
+               cmd->arg = 0xc7810000;
+
        err = mmc_ffu_write(card, data, cmd->arg, buf_bytes);

 exit_normal:
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index b730272..3e781f9 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -275,6 +275,7 @@ struct mmc_card {
 #define MMC_QUIRK_LONG_READ_TIME (1<<9)                /* Data read time >
CSD says */
 #define MMC_QUIRK_SEC_ERASE_TRIM_BROKEN (1<<10)        /* Skip secure for
erase/trim */
 #define MMC_QUIRK_BROKEN_IRQ_POLLING   (1<<11) /* Polling SDIO_CCCR_INTx
could create a fake interrupt */
+#define MMC_QUIRK_SEC_FIX_FFU_ARG (1<<12)      /* Fix ffu argument */

        unsigned int            erase_size;     /* erase size in sectors */
        unsigned int            erase_shift;    /* if erase unit is power 2
*/
diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioctl.h
index 1f5e689..af9ea62 100644
--- a/include/uapi/linux/mmc/ioctl.h
+++ b/include/uapi/linux/mmc/ioctl.h
@@ -53,5 +53,5 @@ struct mmc_ioc_cmd {
  * is enforced per ioctl call.  For larger data transfers, use the normal
  * block device operations.
  */
-#define MMC_IOC_MAX_BYTES  (512L * 256)
+#define MMC_IOC_MAX_BYTES  (512L * 1024)
 #endif /* LINUX_MMC_IOCTL_H */
--
1.8.3.2


