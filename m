Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31212C19F39
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 00:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1725F6044F
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 00:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhHQA4I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 20:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbhHQAzv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 20:55:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1686BC0613A4
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 17:55:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x7so30109856ljn.10
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 17:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJ5eiPWaLvWUNxF9WbotbzWszu9llFOajdlXgdOU7d0=;
        b=qMAiUgEGNh+9rlauuO1jEMSV8lgH5wtHqDnO1B0ckyR/jLV2muMdSXsRMwgzqmcn05
         m59J6xNAKDhl6kmrHHmie1HaxTIuUhvFdFHqfw+GUhBoEbR5Yp7bnTYpu1kkOetHKFCw
         2ikcgMCkNDkIzXKQBmN/Pu15kh6MULoZ4GM20FeWdFh++3Hs8Q1ZaA/t//MD6e4BoE4W
         9oo6yiYO3a74WGzwgz9Rm2jMI1OSavobPI+ziU33bcl5xuzoZmd8UQvxDuPZZIaiO0Q6
         CyBN0bIZ6vrzOlnRYOG/YApJ6LFUTNeyLDxLILpZhMcI5+xFPOKJlSoaIzbQ+PXUnQ1t
         1sqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJ5eiPWaLvWUNxF9WbotbzWszu9llFOajdlXgdOU7d0=;
        b=juanr0QIEOB8TKpAkiOihQuE7b3LByDPKc99ist23dl3vvVSa0YVT/CWDLzgxC00lH
         JNsMf3Orp3bR42brtZX3HlyLb/FWJuO0/0IlsC3GfSyY0r5NtXG0toz6NEst7TGi3h8Y
         1EkPKgUxD/63lm6Kip4e6Z/ywSankfwCTu309/wpbO/j3IpZf0wO83O0AxROqMQjMy5+
         bqJAocSAlNhs3nm2LsvIGsH7U4GiOh9fj6g/irQvWlSB2Z5gIg6xBtJvRZL1VQu9sWA4
         AMZb2Zfx0s+oPXX5g5RtXbFB4FtR+wQF4fkStb6yiU0B4mlLHbw1yBj6FHC82Enh26XZ
         /OBA==
X-Gm-Message-State: AOAM5302Xjb4/h5Z9TsaW8IfyAnEiKolkBYxu/LlZeFqBBtlTqTiAkZq
        fUee1oyexfXZrXetVED8Fn4zBw==
X-Google-Smtp-Source: ABdhPJzGmIlWBq0I5j5m1JI2zbtOW50H9nlDmsNz7c6bsSxYOPOHpku/kkRIXTEliyjxJIRth96PwA==
X-Received: by 2002:a2e:bd11:: with SMTP id n17mr785200ljq.480.1629161717429;
        Mon, 16 Aug 2021 17:55:17 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id z6sm40719lfb.251.2021.08.16.17.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 17:55:17 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [RFC PATCH 05/15] Bluetooth: hci_qca: merge qca_power into qca_serdev
Date:   Tue, 17 Aug 2021 03:54:57 +0300
Message-Id: <20210817005507.1507580-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
References: <20210817005507.1507580-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There is no need to separate struct qca_power from the rest of struct
qca_serdev. Squash qca_power into the main struct, to simplify the
driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 60 +++++++++++++------------------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 53deea2eb7b4..a21cec44720a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -205,23 +205,15 @@ struct qca_device_data {
 	uint32_t capabilities;
 };
 
-/*
- * Platform data for the QCA Bluetooth power driver.
- */
-struct qca_power {
-	struct device *dev;
-	struct regulator_bulk_data *vreg_bulk;
-	int num_vregs;
-	bool vregs_on;
-};
-
 struct qca_serdev {
 	struct hci_uart	 serdev_hu;
 	struct gpio_desc *bt_en;
 	struct gpio_desc *sw_ctrl;
 	struct clk	 *susclk;
 	enum qca_btsoc_type btsoc_type;
-	struct qca_power *bt_power;
+	struct regulator_bulk_data *vreg_bulk;
+	int num_vregs;
+	bool vregs_on;
 	u32 init_speed;
 	u32 oper_speed;
 	const char *firmware_name;
@@ -1602,7 +1594,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	 * off the voltage regulator.
 	 */
 	qcadev = serdev_device_get_drvdata(hu->serdev);
-	if (!qcadev->bt_power->vregs_on) {
+	if (!qcadev->vregs_on) {
 		serdev_device_close(hu->serdev);
 		ret = qca_regulator_enable(qcadev);
 		if (ret)
@@ -1940,20 +1932,19 @@ static int qca_power_off(struct hci_dev *hdev)
 
 static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power = qcadev->bt_power;
 	int ret;
 
 	/* Already enabled */
-	if (power->vregs_on)
+	if (qcadev->vregs_on)
 		return 0;
 
-	BT_DBG("enabling %d regulators)", power->num_vregs);
+	BT_DBG("enabling %d regulators)", qcadev->num_vregs);
 
-	ret = regulator_bulk_enable(power->num_vregs, power->vreg_bulk);
+	ret = regulator_bulk_enable(qcadev->num_vregs, qcadev->vreg_bulk);
 	if (ret)
 		return ret;
 
-	power->vregs_on = true;
+	qcadev->vregs_on = true;
 
 	ret = clk_prepare_enable(qcadev->susclk);
 	if (ret)
@@ -1964,38 +1955,34 @@ static int qca_regulator_enable(struct qca_serdev *qcadev)
 
 static void qca_regulator_disable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power;
-
 	if (!qcadev)
 		return;
 
-	power = qcadev->bt_power;
-
 	/* Already disabled? */
-	if (!power->vregs_on)
+	if (!qcadev->vregs_on)
 		return;
 
-	regulator_bulk_disable(power->num_vregs, power->vreg_bulk);
-	power->vregs_on = false;
+	regulator_bulk_disable(qcadev->num_vregs, qcadev->vreg_bulk);
+	qcadev->vregs_on = false;
 
 	clk_disable_unprepare(qcadev->susclk);
 }
 
-static int qca_init_regulators(struct qca_power *qca,
+static int qca_init_regulators(struct qca_serdev *qcadev, struct device *dev,
 				const struct qca_vreg *vregs, size_t num_vregs)
 {
 	struct regulator_bulk_data *bulk;
 	int ret;
 	int i;
 
-	bulk = devm_kcalloc(qca->dev, num_vregs, sizeof(*bulk), GFP_KERNEL);
+	bulk = devm_kcalloc(dev, num_vregs, sizeof(*bulk), GFP_KERNEL);
 	if (!bulk)
 		return -ENOMEM;
 
 	for (i = 0; i < num_vregs; i++)
 		bulk[i].supply = vregs[i].name;
 
-	ret = devm_regulator_bulk_get(qca->dev, num_vregs, bulk);
+	ret = devm_regulator_bulk_get(dev, num_vregs, bulk);
 	if (ret < 0)
 		return ret;
 
@@ -2005,8 +1992,8 @@ static int qca_init_regulators(struct qca_power *qca,
 			return ret;
 	}
 
-	qca->vreg_bulk = bulk;
-	qca->num_vregs = num_vregs;
+	qcadev->vreg_bulk = bulk;
+	qcadev->num_vregs = num_vregs;
 
 	return 0;
 }
@@ -2037,21 +2024,15 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	    (qca_is_wcn399x(data->soc_type) ||
 	    qca_is_wcn6750(data->soc_type))) {
 		qcadev->btsoc_type = data->soc_type;
-		qcadev->bt_power = devm_kzalloc(&serdev->dev,
-						sizeof(struct qca_power),
-						GFP_KERNEL);
-		if (!qcadev->bt_power)
-			return -ENOMEM;
-
-		qcadev->bt_power->dev = &serdev->dev;
-		err = qca_init_regulators(qcadev->bt_power, data->vregs,
+
+		err = qca_init_regulators(qcadev, &serdev->dev, data->vregs,
 					  data->num_vregs);
 		if (err) {
 			BT_ERR("Failed to init regulators:%d", err);
 			return err;
 		}
 
-		qcadev->bt_power->vregs_on = false;
+		qcadev->vregs_on = false;
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
@@ -2135,11 +2116,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = qcadev->bt_power;
 
 	if ((qca_is_wcn399x(qcadev->btsoc_type) ||
 	     qca_is_wcn6750(qcadev->btsoc_type)) &&
-	     power->vregs_on)
+	     qcadev->vregs_on)
 		qca_power_shutdown(&qcadev->serdev_hu);
 	else if (qcadev->susclk)
 		clk_disable_unprepare(qcadev->susclk);
-- 
2.30.2

