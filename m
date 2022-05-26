Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7ADC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 26 May 2022 12:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345367AbiEZMNp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 May 2022 08:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiEZMNp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2022 08:13:45 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B69DB0A5E;
        Thu, 26 May 2022 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653567224; x=1685103224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UYtPQVApD7B6CvdbviLsjmzrkXFvYphc+Nw0S1+fXwA=;
  b=ClHU2Mn/cBEeaFQCIdv82Htowf4MnSb/7Ti6HQJwkPcDMyfqJh1W8c5+
   Vpcl6x47vWE3peSsLvUJK61hEh1cPu7qPimjVX+cCDNmDRUhixIyKOBmy
   kP2+gTTF6c49T5/WwytYAXAsG46/0SLW1sGF8+vyiK8T9pBRt4wmP3k2S
   I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 May 2022 05:13:44 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 May 2022 05:13:43 -0700
X-QCInternal: smtphost
Received: from hu-sartgarg-hyd.qualcomm.com (HELO hu-maiyas-hyd.qualcomm.com) ([10.213.105.147])
  by ironmsg01-blr.qualcomm.com with ESMTP; 26 May 2022 17:43:35 +0530
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2339771)
        id 38B525001B7; Thu, 26 May 2022 17:43:34 +0530 (+0530)
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_kamasali@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, Sarthak Garg <quic_sartgarg@quicinc.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thorsten Scherer <t.scherer@eckelmann.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        lizhe <sensor1010@163.com>
Subject: [PATCH V2 1/2] mmc: core: Define a new vendor ops to enable wakeup capability
Date:   Thu, 26 May 2022 17:42:14 +0530
Message-Id: <20220526121215.25947-2-quic_sartgarg@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220526121215.25947-1-quic_sartgarg@quicinc.com>
References: <20220526121215.25947-1-quic_sartgarg@quicinc.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Define a new vendor ops to let vendor initialize card as wakeup source
and enable wakeup capability specially for SDIO cards which supports
waking host from system suspend through external dedicated pins.

Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
---
 drivers/mmc/core/bus.c   | 3 +++
 include/linux/mmc/host.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 58a60afa650b..6192a52288fd 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -364,6 +364,9 @@ int mmc_add_card(struct mmc_card *card)
 #endif
 	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
 
+	if (card->host->ops->card_init_wakeup)
+		card->host->ops->card_init_wakeup(card);
+
 	device_enable_async_suspend(&card->dev);
 
 	ret = device_add(&card->dev);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c193c50ccd78..3bd4374a64b8 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -193,6 +193,13 @@ struct mmc_host_ops {
 
 	/* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
 	int	(*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
+
+	/*
+	 * Optional for vendor to initialize card as wakeup source and
+	 * enable wakeup capability specially for SDIO cards which supports
+	 * waking host from suspend through external dedicated pins.
+	 */
+	void    (*card_init_wakeup)(struct mmc_card *card);
 };
 
 struct mmc_cqe_ops {
-- 
2.17.1

