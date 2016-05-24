From: =?UTF-8?B?7J6l66+87Jqw?= <huskey27@gmail.com>
Subject: use default speed of the eMMC
Date: Tue, 24 May 2016 18:07:06 +0900
Message-ID: <CA+pahgdUP3Zam-cSeW8fJR9AmiUo2_Ok_uDHqWTgwvzCGC58+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34242 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbcEXJHH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2016 05:07:07 -0400
Received: by mail-vk0-f67.google.com with SMTP id k1so1725888vka.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 May 2016 02:07:07 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Dear linux-mmc.

Hello, I'm Minwoo Jang.

I have a question about using default speed of the eMMC.

When default speed is used, mmc_select_bus_width() is never called.

So, eMMC can not be set 4 bit or 8 bit bus width, I think.

Please, give me your opinions on the following diff codes.

Thank you.

=====================================================

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 94b4462..3b1cc4d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -952,6 +952,8 @@ static int mmc_select_bus_width(struct mmc_card *card)

                if (!err) {
                        err = bus_width;
+                       pr_warn("%s: switch to bus width %d\n",
+                               mmc_hostname(host), (1 << bus_width));
                        break;
                } else {
                        pr_warn("%s: switch to bus width %d failed\n",
@@ -1500,6 +1502,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
                        if (err)
                                goto err;
                }
+       } else {
+               /* Select the bus width for normal speed mode */
+               err = mmc_select_bus_width(card);
+               if (IS_ERR_VALUE(err)) {
+                       pr_warn("%s: Selecting bus width failed\n",
+                               mmc_hostname(card->host));
+                       goto err;
+               }
        }

Best regards,

MW Jang.
