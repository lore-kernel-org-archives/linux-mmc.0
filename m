Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4521E80A99
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Sep 2023 06:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjI0Glm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Sep 2023 02:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI0Gll (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Sep 2023 02:41:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7014BDD
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 23:41:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8153284d6eso16321360276.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 23:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695796898; x=1696401698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+yP0qHUJH7sO2KgRz3yivnxn+m8P4l8V6unnDvl/tBE=;
        b=uRVFJfyPRzEDUZ0USgKfyN6ajnoXp6oPASneL/q6udY7wsGbT3kKtk+VdCtulyIPjr
         z/toV/qvw+m9JqDDxdTucQWvANd0oSL9hGwxIcvIaK7oDY5h7MDbzrn8PwKxvWWeu9A1
         AXEbaiEJ0Bahv/XICyiwpcXcacYGybAhXEFikVvQBN9ChhkzCdEjqu+ehofPgFBBLj8C
         2XQZM7DEfCdicmtOFHb/aqzmbb3g8oNOCDyNntvCF01pSaiSZk1kwUPWFjoAc3bgl9rd
         60Zf0dOChb0lQedxKVzw2GKdNG7FkLIJmCBSkDMnZlcwhRBv5T+eNy/hTt2WtmoeLldL
         I6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695796898; x=1696401698;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yP0qHUJH7sO2KgRz3yivnxn+m8P4l8V6unnDvl/tBE=;
        b=ZLCm8FW9vA3p8xD7mNWw0vp8XcIsH+ShRi8c8zXkgP3FTmGNlRPIUzVrdJD6xMLtyY
         HW5Szf1CKoG4aG+QX3qAohA3Vr+XcjohWP/HAnCjcwKlVLRsuQRBfzCKXqGHQHU0JvRD
         Je4Rm3RrwgrbyVyFqFGS1nrkNYPWDuUbZ56lEMcmhI3BTVn+6+QvIcgLWl8LsPP6vpgt
         IfYLZTFK2mZkZR4ZteOp8B++FyncKZWnpMSpP7mhvlh1wd/aZFIrKsJQiFkedjG+Dmfi
         n30pSt09ig4VAn4PeWshqXyhpNfg9lYqrLcrLRMr7h3cqhdhQHIb5FofdkrKBhjuctV7
         CLzQ==
X-Gm-Message-State: AOJu0YxM1RiO1w49iMRphVyWJupnDEf1fRw3RFeQxntUqRaRsCNx6Spx
        enj3nDk7xqq+9X0GUR6Hw9GgjJsObpsnMWqPtw==
X-Google-Smtp-Source: AGHT+IEVCCuMI/uy+Ltg5u5M7A4hgRyW/gCmF8sn1IuFuDTTOBFPGmO2kHmy+heH9Iq0t3g3VcTknBCD7VhmotgVLA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1682:b0:d81:78ec:c403 with
 SMTP id bx2-20020a056902168200b00d8178ecc403mr13774ybb.12.1695796898745; Tue,
 26 Sep 2023 23:41:38 -0700 (PDT)
Date:   Wed, 27 Sep 2023 06:41:37 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKHOE2UC/x3NMQ6DMAxA0asgz7WUJiCgV6kYmmDAAwHZIWqFu
 Hsjxrf8f4KSMCm8qhOEMitvseD5qCAsnzgT8lgM1lhnetuiJolh/+EonEkU1zXgsmnCfHhnDAb 0rXf91FlquhpKZxea+Hs/3sN1/QGl6Ar9cwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695796897; l=5550;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=YPZfe2Wyy7QnsQhjAGzhJqwDXvMubl0PpcqCu4zLYvI=; b=DVmX3rW9B9/NdIy6Sx1tPZhSRgJUBHuGbPKG2EobRxqUmLqriHBIfHZa6/44chl99vMNeGrDV
 ufoIE9dRsqwDdET0IHyIJy7USZl/n6oXtJwqFm9YsEIrFepousjKoKk
X-Mailer: b4 0.12.3
Message-ID: <20230927-strncpy-drivers-mmc-host-vub300-c-v1-1-77426f62eef4@google.com>
Subject: [PATCH] mmc: vub300: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect `vub300->vub_name` to be NUL-terminated based on its uses with
format strings:
| 	dev_info(&vub300->udev->dev, "using %s for SDIO offload processing\n",
| 		 vub300->vub_name);

NUL-padding is not needed. We can see cleaning out vub_name simply
consists of:
|       vub300->vub_name[0] = 0;

Considering the above, for all 11 cases a suitable replacement is
`strscpy` [2] due to the fact that it guarantees NUL-termination on the
destination buffer without unnecessarily NUL-padding.

To be clear, there is no existing bug in the current implementation as
the string literals are all small enough as to not cause a buffer
overread. Nonetheless, this gets us 11 steps closer to removing strncpy
uses.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/mmc/host/vub300.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 9ec593d52f0f..de3f443f5fdc 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -512,7 +512,7 @@ static void new_system_port_status(struct vub300_mmc_host *vub300)
 		vub300->card_present = 1;
 		vub300->bus_width = 0;
 		if (disable_offload_processing)
-			strncpy(vub300->vub_name, "EMPTY Processing Disabled",
+			strscpy(vub300->vub_name, "EMPTY Processing Disabled",
 				sizeof(vub300->vub_name));
 		else
 			vub300->vub_name[0] = 0;
@@ -1216,7 +1216,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 		dev_err(&vub300->udev->dev,
 			"corrupt offload pseudocode in firmware %s\n",
 			vub300->vub_name);
-		strncpy(vub300->vub_name, "corrupt offload pseudocode",
+		strscpy(vub300->vub_name, "corrupt offload pseudocode",
 			sizeof(vub300->vub_name));
 		return;
 	}
@@ -1250,7 +1250,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 				"not enough memory for xfer buffer to send"
 				" INTERRUPT_PSEUDOCODE for %s %s\n", fw->data,
 				vub300->vub_name);
-			strncpy(vub300->vub_name,
+			strscpy(vub300->vub_name,
 				"SDIO interrupt pseudocode download failed",
 				sizeof(vub300->vub_name));
 			return;
@@ -1259,7 +1259,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 		dev_err(&vub300->udev->dev,
 			"corrupt interrupt pseudocode in firmware %s %s\n",
 			fw->data, vub300->vub_name);
-		strncpy(vub300->vub_name, "corrupt interrupt pseudocode",
+		strscpy(vub300->vub_name, "corrupt interrupt pseudocode",
 			sizeof(vub300->vub_name));
 		return;
 	}
@@ -1293,7 +1293,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 				"not enough memory for xfer buffer to send"
 				" TRANSFER_PSEUDOCODE for %s %s\n", fw->data,
 				vub300->vub_name);
-			strncpy(vub300->vub_name,
+			strscpy(vub300->vub_name,
 				"SDIO transfer pseudocode download failed",
 				sizeof(vub300->vub_name));
 			return;
@@ -1302,7 +1302,7 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 		dev_err(&vub300->udev->dev,
 			"corrupt transfer pseudocode in firmware %s %s\n",
 			fw->data, vub300->vub_name);
-		strncpy(vub300->vub_name, "corrupt transfer pseudocode",
+		strscpy(vub300->vub_name, "corrupt transfer pseudocode",
 			sizeof(vub300->vub_name));
 		return;
 	}
@@ -1336,13 +1336,13 @@ static void __download_offload_pseudocode(struct vub300_mmc_host *vub300,
 		dev_err(&vub300->udev->dev,
 			"corrupt dynamic registers in firmware %s\n",
 			vub300->vub_name);
-		strncpy(vub300->vub_name, "corrupt dynamic registers",
+		strscpy(vub300->vub_name, "corrupt dynamic registers",
 			sizeof(vub300->vub_name));
 		return;
 	}
 
 copy_error_message:
-	strncpy(vub300->vub_name, "SDIO pseudocode download failed",
+	strscpy(vub300->vub_name, "SDIO pseudocode download failed",
 		sizeof(vub300->vub_name));
 }
 
@@ -1370,11 +1370,11 @@ static void download_offload_pseudocode(struct vub300_mmc_host *vub300)
 		 vub300->vub_name);
 	retval = request_firmware(&fw, vub300->vub_name, &card->dev);
 	if (retval < 0) {
-		strncpy(vub300->vub_name, "vub_default.bin",
+		strscpy(vub300->vub_name, "vub_default.bin",
 			sizeof(vub300->vub_name));
 		retval = request_firmware(&fw, vub300->vub_name, &card->dev);
 		if (retval < 0) {
-			strncpy(vub300->vub_name,
+			strscpy(vub300->vub_name,
 				"no SDIO offload firmware found",
 				sizeof(vub300->vub_name));
 		} else {
@@ -1758,7 +1758,7 @@ static void vub300_cmndwork_thread(struct work_struct *work)
 			 * has been already downloaded to the VUB300 chip
 			 */
 		} else if (0 == vub300->mmc->card->sdio_funcs) {
-			strncpy(vub300->vub_name, "SD memory device",
+			strscpy(vub300->vub_name, "SD memory device",
 				sizeof(vub300->vub_name));
 		} else {
 			download_offload_pseudocode(vub300);

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230927-strncpy-drivers-mmc-host-vub300-c-b7b39f82e584

Best regards,
--
Justin Stitt <justinstitt@google.com>

