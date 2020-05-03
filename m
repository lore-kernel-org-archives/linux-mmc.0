Return-Path: <SRS0=55DN=6R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364A7C28CBC
	for <linux-mmc@archiver.kernel.org>; Sun,  3 May 2020 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE83206E9
	for <linux-mmc@archiver.kernel.org>; Sun,  3 May 2020 22:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="g5CtopVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgECW2U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 3 May 2020 18:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729151AbgECW2U (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 May 2020 18:28:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D3CC061A0E;
        Sun,  3 May 2020 15:28:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g13so18678983wrb.8;
        Sun, 03 May 2020 15:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y69lAmBUHqgE1AImwpWCVOk5aRft5ihzG6qW/7B3meA=;
        b=g5CtopVisuuYHom2E36JzSmflZ8Vpts4weEltBoFA5PHeqZuw7xpF4tDEugEIDRJTT
         TSB2h+14aRVNkj+RQbcbjhQQdnxc8Kq2mlRrdjUItjzh1V4liq3aYuRgmnadNQ8usjgA
         YM7ogrF4rnFPdpKT6rijBFR9aemkr8yt7UJRt/Ke97sabnwNNB3HqBewu9sbrEh9QOR4
         wCHVpKdtEzfjFb6Ji23FM4HfLGh/FdkDPnpPZWY8pk7HycjmCWAWf3xWDNvYGOVKQT8U
         O7KmlKYW2V/+xzF56s5uTVYaBP3Fmx727jy1s/DXxOdh8wRJhR0IYipKQ8Jck434a0ic
         Ttqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y69lAmBUHqgE1AImwpWCVOk5aRft5ihzG6qW/7B3meA=;
        b=hupEyenWXv84lhfeV9Fw9hUQvZUkLsU8Qh3q5Albj+hADYSJpMFUee5NlhhRNJZTGA
         GFpF6E0bwCNlvtuU2IvPHx0mHshA/JiBlkYCp0gSVFL8bUrA2IvvP6Y2/UbNAWw9Xanw
         o8Vs8X2QOpIF33imRaq9jbF4BPF1hD9M1FNteeLZJA4mY2ac/FKcIuQFqSjN5yy2KPSY
         WT3sRVjBu5OQu8Vx/Ks9TAX0LL1qdQLBCZXrxN1T+iW/4+bMFKD2bxcDljf9LXH0jhs9
         cnx1XIkLYGQbzxtmXeK+0icFYIDOMujZCET7CBBYu2RoiaAhLq4yYaMiRNnHQnRv3UM/
         IFDQ==
X-Gm-Message-State: AGi0PuYe167Q5ofEQqBbwo89Sfdv4KeRyX38SHVOLAIZ5rAXb3Ggho6J
        XXG2C2ghOsRPDxh2un2J73o=
X-Google-Smtp-Source: APiQypKTFvLpzJxWxC/mVKGKRYn8CTyLnoU9CuxJncu5LvibrivSYXR2dENDCWKJUUC+YmHk1ohmUw==
X-Received: by 2002:adf:cd88:: with SMTP id q8mr13169106wrj.67.1588544898444;
        Sun, 03 May 2020 15:28:18 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id i129sm11200081wmi.20.2020.05.03.15.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 15:28:17 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] mmc: meson-mx-sdio: trigger a soft reset after a timeout or CRC error
Date:   Mon,  4 May 2020 00:28:05 +0200
Message-Id: <20200503222805.2668941-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The vendor driver (from the 3.10 kernel) triggers a soft reset every
time before starting a new command. While this fixes a problem where
SDIO cards are not detected at all (because all commands simply
timed out) this hurts SD card read performance a bit (in my tests
between 10% to 20%).

Trigger a soft reset after we got a CRC error or if the previous command
timed out (just like the vendor driver from the same 3.10 kernel for the
newer SDHC controller IP does). This fixes detection of SDIO cards and
doesn't hurt SD card read performance at the same time.

With this patch the initialization of an RTL8723BS SDIO card looks like
this:
  req done (CMD52): -110: 00000000 00000000 00000000 00000000
  clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 1 timing 0
  starting CMD0 arg 00000000 flags 000000c0
  req done (CMD0): 0: 00000000 00000000 00000000 00000000
  clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 0
  starting CMD8 arg 000001aa flags 000002f5
  req done (CMD8): -110: 00000000 00000000 00000000 00000000
  starting CMD5 arg 00000000 flags 000002e1
  req done (CMD5): 0: 90ff0000 00000000 00000000 00000000
  starting CMD5 arg 00200000 flags 000002e1
  req done (CMD5): 0: 90ff0000 00000000 00000000 00000000
  starting CMD3 arg 00000000 flags 00000075
  req done (CMD3): 0: 00010000 00000000 00000000 00000000
  starting CMD7 arg 00010000 flags 00000015
  req done (CMD7): 0: 00001e00 00000000 00000000 00000000
  starting CMD52 arg 00000000 flags 00000195
  req done (CMD52): 0: 00001032 00000000 00000000 00000000
  [... more CMD52 omitted ...]
  clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 2
  clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 2
  starting CMD52 arg 00000e00 flags 00000195
  req done (CMD52): 0: 00001000 00000000 00000000 00000000
  starting CMD52 arg 80000e02 flags 00000195
  req done (CMD52): 0: 00001002 00000000 00000000 00000000
  clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 4 timing 2
  starting CMD52 arg 00020000 flags 00000195
  req done (CMD52): 0: 00001007 00000000 00000000 00000000
  [... more CMD52 omitted ...]
  new high speed SDIO card at address 0001

Fixes: ed80a13bb4c4c9 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Ulf, I consider this non-critical because as long as the meson-mx-sdhc
driver is not merged we only have one MMC driver for these platforms.
I don't know anybody to prefer SDIO wifi over SD card access, so this
can go into -next (in my option at least).


 drivers/mmc/host/meson-mx-sdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 2e58743d83bb..3813b544f571 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -246,6 +246,9 @@ static void meson_mx_mmc_request_done(struct meson_mx_mmc_host *host)
 
 	mrq = host->mrq;
 
+	if (host->cmd->error)
+		meson_mx_mmc_soft_reset(host);
+
 	host->mrq = NULL;
 	host->cmd = NULL;
 
-- 
2.26.2

