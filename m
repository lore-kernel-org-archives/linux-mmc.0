Return-Path: <SRS0=zOov=BA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680B4C433E5
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 19:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4043020672
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 19:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y85VM6pV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgGUTSP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGUTSO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2020 15:18:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47431C061794;
        Tue, 21 Jul 2020 12:18:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so3957711wml.3;
        Tue, 21 Jul 2020 12:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d3TKYP4o+8GyD6R3uLACwUhGmVtEHiKUIs+qv7jiKrs=;
        b=Y85VM6pVuzOYBKCzRvBXLnPLXo1Y3B4xiuUr90n0mcLtHpkthkzKATe+IBCDI09cav
         DK4O+PxIV9EBf83Kob7n8UmV78Ee21Mi6Qjef7GCeWXD2T6E7LTz4QZkSoXN4jEx314f
         vAxdv6P2aD12VrXIVj9m9E8xYo48naDU/TxhNzLVSInhSjHcJ5XxuUgeMSEysYAwtXHz
         hrFO0eCodu+wGDlB0GqaCZVT8RuOnkfL6RTWf6D2taparr6bAfSeMypqcuBO0GzwBm07
         jgsbVSO7L7xwbkJvIbRzigWM1JReeRjurWO1yMEfiJ3dnVHLC9/oKGqe/aDIHIobrXtN
         BlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d3TKYP4o+8GyD6R3uLACwUhGmVtEHiKUIs+qv7jiKrs=;
        b=SoMVXhUFv3alicsRcuu4m8pHUZeb3DkoDiuodfjbYb/BnXm2zrznoIyiqgbD5ZMW1l
         eVLWEynNSXwFlnI/xDboVbjFzUwBhLzQ9VXghUBO7CapksBqAq7yg09KLDib8Efmj/Z8
         M9BSxki2Ix2Q8MCcF4pmDS3dQ+xPFEUtZX7D9eeufIR9bDUI5hPhaCPTuJs348yambG9
         K5ZU5NQgGP9LVoCioLt/0EQltPIlusTXNDbVRm4ZYor/zLCMiV8UaUJvuRvJraxaA42c
         VdbwoAUN7vfT11GAjS2EPRJtdTVnW0Akvw7wHdQZHaT5t+q40X65Fs/9sbNrVNSCODe2
         bgtQ==
X-Gm-Message-State: AOAM531MQmEQ0J5lc+TUQSXxt3EVwKPJd6Vvk95Q+l5Y/n7ta0AB1NJq
        j9kWf1uUVgue9+Mpgkry8Ja8QDoA
X-Google-Smtp-Source: ABdhPJzjgAfGACh83dk5biQo13nQNx9k/mgrRnN85rbCJJOO1Ljpf5TnnsKWA7ml0fS8ixPafkJHww==
X-Received: by 2002:a05:600c:2050:: with SMTP id p16mr5099565wmg.44.1595359092626;
        Tue, 21 Jul 2020 12:18:12 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j16sm39876315wrt.7.2020.07.21.12.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 12:18:12 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Bradley Bolen <bradleybolen@gmail.com>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: Some Micron eMMC devices cause reboot to hang
Date:   Tue, 21 Jul 2020 15:17:18 -0400
Message-Id: <20200721191718.29414-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When using eMMC as the boot device, some Micron eMMC devices will
cause reboot to hang. This is a result of the eMMC device not going
into boot mode after the hardware sends CMD0 to reset the eMMC
device. This only happens if the kernel driver sends CMD5 (SLEEP_WAKE),
to put the device into sleep state, before restarting the system.
The fix is to add a quirk that avoids sending the SLEEP command
and to use MMC_FIXUP to set the quirk for these Micron devices.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/core/mmc.c    | 3 ++-
 drivers/mmc/core/quirks.h | 8 ++++++++
 include/linux/mmc/card.h  | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4203303f946a..4d69e8f8fe59 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1895,7 +1895,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 
 static int mmc_can_sleep(struct mmc_card *card)
 {
-	return (card && card->ext_csd.rev >= 3);
+	return card && card->ext_csd.rev >= 3 &&
+		((card->quirks & MMC_QUIRK_BROKEN_SLEEP) == 0);
 }
 
 static int mmc_sleep(struct mmc_host *host)
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 472fa2fdcf13..7263187b6323 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -99,6 +99,14 @@ static const struct mmc_fixup mmc_blk_fixups[] = {
 	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+	/*
+	 * Some Micron eMMC devices will not go into boot mode on
+	 * CMD0 arg: 0XF0F0F0F0 after going into SLEEP state.
+	 * This will hang a reboot.
+	 */
+	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_NUMONYX, 0x014e, add_quirk_mmc,
+		  MMC_QUIRK_BROKEN_SLEEP),
+
 	END_FIXUP
 };
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 7d46411ffaa2..0cdddcb5e17d 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -270,6 +270,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
 #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
+#define MMC_QUIRK_BROKEN_SLEEP	(1<<14)		/* Broken sleep mode */
 
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
 
-- 
2.17.1

