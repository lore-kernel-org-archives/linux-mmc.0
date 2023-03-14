Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3D0C6FD1F
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Mar 2023 17:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCNRY6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Mar 2023 13:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCNRY5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2023 13:24:57 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6628B9545C
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 10:24:56 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 0140620048F;
        Tue, 14 Mar 2023 18:24:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1678814695;
        bh=2e5jAUF8/ZirLPQZM6YQfIUnTkYXb6j3MWx9iDVhC4Q=;
        h=Date:To:Cc:From:Subject:From;
        b=qFak2Zi44M/RwtD/NtNYnTwkFP1fEnUuhHCR3zcHHXd2a46o+i4G5EMxJ+GzDIvYD
         d30Qz/k+vij8HxGCxOxRDpnFJuKpXL4LNF441xThOJ0vn6UkoLqM4pCcTnaIMK/M0H
         st5Ea+fRrcH1DMrDhwz4KNKpfFbw+dfRBdYBueAVAeymmTCqER2nmDOVXPWzNN9ack
         k4OU+bsTHEyNRa0JcdCo5Vuq/67YXZRx7HPZ/nGZ4YFHn/jMhTncKvcMPpqX4tWQwa
         wVChT6YXL9SzfdP72R4WjQkyYPrcobMUluHR8MG/KuQAQvmqTihVxifgyWzmO6AsSP
         wKsiMzPjEOmAw==
Message-ID: <11a8a0c8-a5b1-8f38-a139-97172ab7be68@free.fr>
Date:   Tue, 14 Mar 2023 18:24:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rong Chen <rong.chen@amlogic.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH] mmc: meson-gx: increase power-up delay
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

With the default power-up delay, on small kernels, the host probes
too soon, and mmc_send_io_op_cond() times out.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
Stress-tested with 80 cold boots, checking every time
mmc2: new ultra high speed SDR50 SDIO card at address 0001
IIUC, this will also slow down SD & MMC probing,
but an additional 20 ms seems acceptable?
---
 drivers/mmc/host/meson-gx-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 6e5ea0213b477..73ecbcf588c65 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1182,6 +1182,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	mmc = mmc_alloc_host(sizeof(struct meson_host), &pdev->dev);
 	if (!mmc)
 		return -ENOMEM;
+	mmc->ios.power_delay_ms = 20;
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->dev = &pdev->dev;
-- 
2.25.1
