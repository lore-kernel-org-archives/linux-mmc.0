Return-Path: <SRS0=h0nN=A7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B64C433E5
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 14:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE0F22B4D
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 14:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm5XgV/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgGTO2s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgGTO2r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2020 10:28:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947EBC061794;
        Mon, 20 Jul 2020 07:28:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z3so9119274pfn.12;
        Mon, 20 Jul 2020 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3FlUkctU/9Z8JymGDkG+Bf/RRrvEHqZ+B4t/lCBxEH4=;
        b=cm5XgV/yWFRRE9EHS24/EqW66GsPEs3000VF0aMvp2QSusnxfH2P/N4LTQUujMF1lm
         tt8o/sRaKVJvTG/iFb3yhYuU0kldoxnm4qPQ0LRe0leRrGZAApAziZVNeLfDewWpDy5f
         xhRvGSkzenzm6zNKBtqPMohpWbINR40PZKwL2najXJv/1nQM+Sl0hgRo8EWIe3Mtltx9
         iHq6HNwDU49y7+AqKuKnMSr5YTVl+ZuN2ejZlRSIKMXM2yKbqc2NgkbOtVoHQXYK/Ow7
         4Y2F4pG1Nl/Xd1o88dc795XHR5KzUsCG6GnSJOmSkuyLDufEefqpkWcGpk64gX1p74mH
         4n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3FlUkctU/9Z8JymGDkG+Bf/RRrvEHqZ+B4t/lCBxEH4=;
        b=RgwQFkgEDla5Cj68CYGV/Gxdle6SV5ICy2lDqlzSQmdahVS5N5iwK0PydUHvtIW0O/
         lJMmmUjYxMRo5N9ILM3+7PJD2xPdndcGxXo2sP7EcaWwxyCKuKRtMPQWxyhwScQ/C+nG
         DvzQzCO2Hl+epcF+gPqhrJR3ywk7Tggr5E+iqTaOuy0EAW/AYwX7xCNwwkQkdkIL92Mf
         bVkmIwUPven1oaDQvMJJYCvTqT+3grgHXrmtHgK9HwDfzP+WOW0re0tt4R7q5V95oP95
         UgLLgVjWfu4thliTrIRlHqwxV+Q+As7spc6mbYPWBDUfdz8tR76Clm0wuMVOFqznLo5M
         0uqQ==
X-Gm-Message-State: AOAM5309X04ZN7buHIDQsAuEv6G2IL/SabpMYjtdpotXNmvGtZuZanJF
        CaZeFfuHbJ8RdbUChOr3QSE=
X-Google-Smtp-Source: ABdhPJxkd48eXlvOgVHcFNHC7hs+LWba48WNoCpqQ0EXWeCyVxMv2V7/q3ybFxEBtrVMabJk1BAYAA==
X-Received: by 2002:a63:c049:: with SMTP id z9mr14766666pgi.353.1595255327105;
        Mon, 20 Jul 2020 07:28:47 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id i67sm17581282pfg.13.2020.07.20.07.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 07:28:46 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v1] mmc: via-sdmmc: use generic power management
Date:   Mon, 20 Jul 2020 19:56:04 +0530
Message-Id: <20200720142603.577323-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Drivers using legacy PM have to manage PCI states and device's PM states
themselves. They also need to take care of configuration registers.

With improved and powerful support of generic PM, PCI Core takes care of
above mentioned, device-independent, jobs.

This driver makes use of PCI helper functions like
pci_save/restore_state(), pci_enable/disable_device(),
pci_enable_wake() and pci_set_power_state() and to do required operations.
In generic mode, they are no longer needed.

Change function parameter in both .suspend() and .resume() to
"struct device*" type. Use dev_get_drvdata() to get drv data.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/mmc/host/via-sdmmc.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index ef95bce50889..49dab9f42b6d 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1220,9 +1220,7 @@ static void via_sd_remove(struct pci_dev *pcidev)
 		pci_name(pcidev), (int)pcidev->vendor, (int)pcidev->device);
 }
 
-#ifdef CONFIG_PM
-
-static void via_init_sdc_pm(struct via_crdr_mmc_host *host)
+static void __maybe_unused via_init_sdc_pm(struct via_crdr_mmc_host *host)
 {
 	struct sdhcreg *pm_sdhcreg;
 	void __iomem *addrbase;
@@ -1256,30 +1254,27 @@ static void via_init_sdc_pm(struct via_crdr_mmc_host *host)
 	via_print_sdchc(host);
 }
 
-static int via_sd_suspend(struct pci_dev *pcidev, pm_message_t state)
+static int __maybe_unused via_sd_suspend(struct device *dev)
 {
 	struct via_crdr_mmc_host *host;
 
-	host = pci_get_drvdata(pcidev);
+	host = dev_get_drvdata(dev);
 
 	via_save_pcictrlreg(host);
 	via_save_sdcreg(host);
 
-	pci_save_state(pcidev);
-	pci_enable_wake(pcidev, pci_choose_state(pcidev, state), 0);
-	pci_disable_device(pcidev);
-	pci_set_power_state(pcidev, pci_choose_state(pcidev, state));
+	device_wakeup_enable(dev);
 
 	return 0;
 }
 
-static int via_sd_resume(struct pci_dev *pcidev)
+static int __maybe_unused via_sd_resume(struct device *dev)
 {
 	struct via_crdr_mmc_host *sdhost;
 	int ret = 0;
 	u8 gatt;
 
-	sdhost = pci_get_drvdata(pcidev);
+	sdhost = dev_get_drvdata(dev);
 
 	gatt = VIA_CRDR_PCICLKGATT_PAD_PWRON;
 	if (sdhost->power == MMC_VDD_165_195)
@@ -1294,32 +1289,20 @@ static int via_sd_resume(struct pci_dev *pcidev)
 
 	msleep(100);
 
-	pci_set_power_state(pcidev, PCI_D0);
-	pci_restore_state(pcidev);
-	ret = pci_enable_device(pcidev);
-	if (ret)
-		return ret;
-
 	via_restore_pcictrlreg(sdhost);
 	via_init_sdc_pm(sdhost);
 
 	return ret;
 }
 
-#else /* CONFIG_PM */
-
-#define via_sd_suspend NULL
-#define via_sd_resume NULL
-
-#endif /* CONFIG_PM */
+static SIMPLE_DEV_PM_OPS(via_sd_pm_ops, via_sd_suspend, via_sd_resume);
 
 static struct pci_driver via_sd_driver = {
 	.name = DRV_NAME,
 	.id_table = via_ids,
 	.probe = via_sd_probe,
 	.remove = via_sd_remove,
-	.suspend = via_sd_suspend,
-	.resume = via_sd_resume,
+	.driver.pm = &via_sd_pm_ops,
 };
 
 module_pci_driver(via_sd_driver);
-- 
2.27.0

