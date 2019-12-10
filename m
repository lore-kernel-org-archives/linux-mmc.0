Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E0C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 01:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC72A20637
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 01:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmJF6Qvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLJBk7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Dec 2019 20:40:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39866 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfLJBk7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Dec 2019 20:40:59 -0500
Received: by mail-lj1-f196.google.com with SMTP id e10so17915288ljj.6;
        Mon, 09 Dec 2019 17:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vlZI4rEGeiq9jWtOY0aFxUeSEkD9VPU1bYTxW9kWFdQ=;
        b=BmJF6QvuU9k+gicud6GQqh3PEAWQm7BMYysarKVmqLASdkf9Y2zuA2/X2c5UPAqrBq
         5mt5MzpfDukUo5XlzsMHZp0F6wE+pX+BbqLCZm6TEB1VZoO4azosLsQlSNz5ohVmskmj
         ofagIgmQ/nDydCKMIWjkDlHfEzb7L8sczSGADD4+vb8yE48LLcvdooCU0y86FL/HANB2
         MrerD/9WjyqPPX3ggAw51HsaMZadtv6CN6NwZQc5bDRT6O6Yp9ZTz8+YjLDy7DcYIGCD
         YfcWFZNUAB7DLa3YiqNQHpf5twwfAdxPCimo6doMmWi7emJuc5KK/wkQtxcPlaQ00Vn7
         lNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vlZI4rEGeiq9jWtOY0aFxUeSEkD9VPU1bYTxW9kWFdQ=;
        b=a/NWDOy0x6j6279sDqva/SeQLCN4hd/7oMXEVuFptQt8srOYuabapS79gtTbaxpLD9
         w8DqA7olQonq8OH2YhzCMAVfkwkn7ZR645pMpbu0F2cZlPCHkotiHHmG7L+VnkhWohOx
         1qO2i3AMYQIhj9aAqNAM2IjL7aA6thsC52sYf8fNNGL3gKtJTuOZZphwwmgWYJgQqpCF
         4qiYIxkMGD5xnuDZoXk5Z46lmRVXJneX/X5kDsJe6cLv5Wc6sFh/qZzXYnZuzv95gm30
         82hzc4Uf8iYhuytmrIDTls1QofPmC2i5Za2rBKqjLHHPXY9b7kQ6ZLLqePJ75K4YxuHg
         sRDg==
X-Gm-Message-State: APjAAAUCObs5gkvzSCtchGqYp2eoHPwhy3VVyHcy8BKG4jy2a9/Y+j1h
        xYGOomT8BHTvSx1hZgO0vyF5SEdW
X-Google-Smtp-Source: APXvYqwq8U1I4QevksCt7+Ui2gdfuQtFkkgMtrKqkyij2iotR9ysDAJHihyh7B9qC1ZNBOAMNUsYEA==
X-Received: by 2002:a2e:144b:: with SMTP id 11mr18625869lju.216.1575942056544;
        Mon, 09 Dec 2019 17:40:56 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r125sm522813lff.70.2019.12.09.17.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 17:40:56 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] sdhci: tegra: Add workaround for Broadcom WiFi
Date:   Tue, 10 Dec 2019 04:40:11 +0300
Message-Id: <20191210014011.21987-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

All Tegra20 boards that have embedded Broadcom WiFi SDIO chip are affected
by a problem where WiFi chip reports CCCR v1.10, while it should v1.20.
In a result high-speed mode isn't enabled for the WiFi card and this
results in a malfunctioning SDIO communication.

 brcmfmac: brcmf_sdio_readframes: read 304 bytes from channel 1 failed: -84
 brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame, send NAK

Downstream kernels are overriding card's CCCR info in SDHCI driver to fix
the problem, let's do the same in upstream.

The change is inspired by omap_hsmmc_init_card() of OMAP's HSMMC driver,
which overrides card's info for the TI wl1251 WiFi.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/host/sdhci-tegra.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 7bc950520fd9..2ad87da98f2c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1501,6 +1501,32 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
 	return ret;
 }
 
+static void sdhci_tegra_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	if (card->type == MMC_TYPE_SDIO) {
+		struct device_node *np = mmc_dev(mmc)->of_node;
+
+		np = of_get_compatible_child(np, "brcm,bcm4329-fmac");
+		if (np) {
+			dev_info(mmc_dev(mmc), "found bcm4329\n");
+
+			/*
+			 * All Tegra20 boards that have embedded BCM4329
+			 * chip need to enable high speed for SDIO, otherwise
+			 * further communication with the card doesn't work
+			 * well.
+			 *
+			 * Later BCM43xx chips do not need this workaround,
+			 * but there is no good way to differentiate chip's
+			 * version at this stage and it doesn't cause any
+			 * harm for the later chips.
+			 */
+			card->cccr.high_speed = 1;
+			of_node_put(np);
+		}
+	}
+}
+
 static int sdhci_tegra_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -1545,6 +1571,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		host->mmc_host_ops.execute_tuning =
 				tegra_sdhci_execute_hw_tuning;
 
+	host->mmc_host_ops.init_card = sdhci_tegra_init_card;
+
 	rc = mmc_of_parse(host->mmc);
 	if (rc)
 		goto err_parse_dt;
-- 
2.24.0

