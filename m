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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519CFC433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 11:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF692073A
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 11:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGwRVlJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGTLTq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgGTLTp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2020 07:19:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28C8C061794;
        Mon, 20 Jul 2020 04:19:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so10164422pgf.0;
        Mon, 20 Jul 2020 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQcPpyKkBRFTuRsPf+ykezWbH+/TBAg6hCF+bTAYfaw=;
        b=vGwRVlJYh/AkVuaVINdy2mII6b60uD6MxHKaz7apKM6SE9oYrrZfXXA1+wMSO8rJ9Y
         +MTP0iLrtxuaBOsgT+HR2IhaTh1AENAP3HXWyBCnrU8n3XybFx+maS3OAdOfnuVRZ/PQ
         3CVK0VdnK9kjh5ALFY9FrjJ9TfNmqy8xmIR2gNuo7tzJzMeFxN6xhXXDxEOrvM7YFCWr
         TS1DdViCkdydRL+LNznFhhE5waojifM4ArckLLcAZTQma8x1tU6dAQyuJbuxzWObEIre
         Jlfez5qNUyD1re8ixlxbm7onNk4mYNEVI2ZPHtK+Q9SidLTdx2NcZpTdLAi6Q8OugPZC
         W4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQcPpyKkBRFTuRsPf+ykezWbH+/TBAg6hCF+bTAYfaw=;
        b=PYp5sVzjJZe+/pqoohPloK1YMmnbo14m9NoYkn+/COz0Ab34AJag/FMT0cD7OCwKVj
         oMtlg/DzHGnJdP3QkJnhUnDTzWPfqCk+Tik4BOckwfPmuigSYDl+liah8a6kETFj243A
         iLAasLH7LWCShyCGMYOJtPB/UtcWYIJ2wp/GqXROLb7NE/LrRmjHeNEubflv3QmwRM1o
         PWqY49byldmtSSgIkNi79PzgGCv0fA04MTrnOOk6Wsti1aV1d6UOra4i/Yl/mcvBPrg+
         0FSx4QB4KsusYpKiJ3PnZ7VRNJo5hMspeBZuW54Mtss9psuJ4PfIwfEdTHid/oYFF0p1
         vbtQ==
X-Gm-Message-State: AOAM532Sni3twe3Kf7HzXEpOV+u1rfnXikn1XtYmPGk1wKNcgD9co1zt
        zU+jABxCmWJnIb06F8Y5C2s=
X-Google-Smtp-Source: ABdhPJzXMEzFnor2PkcqpQ5qGc99WVqg/PKRsVfkIsJUnsbfgaUljhA3N4EOJlKHIhH3SeYxQI315Q==
X-Received: by 2002:aa7:8f03:: with SMTP id x3mr18278554pfr.64.1595243965196;
        Mon, 20 Jul 2020 04:19:25 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id o4sm11998630pjo.16.2020.07.20.04.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 04:19:24 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH v1] memstick: jmb38x_ms: use generic power management
Date:   Mon, 20 Jul 2020 16:46:26 +0530
Message-Id: <20200720111625.306681-1-vaibhavgupta40@gmail.com>
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
pci_set_power_state() and pci_set_master() to do required operations. In
generic mode, they are no longer needed.

Change function parameter in both .suspend() and .resume() to
"struct device*" type. Use to_pci_dev() and dev_get_drvdata() to get
"struct pci_dev*" variable and drv data.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/memstick/host/jmb38x_ms.c | 38 +++++++++----------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index 0a9c5ddf2f59..2aa9592917d9 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -793,11 +793,10 @@ static int jmb38x_ms_pmos(struct pci_dev *pdev, int flag)
         return 0;
 }
 
-#ifdef CONFIG_PM
-
-static int jmb38x_ms_suspend(struct pci_dev *dev, pm_message_t state)
+static int __maybe_unused jmb38x_ms_suspend(struct device *dev)
 {
-	struct jmb38x_ms *jm = pci_get_drvdata(dev);
+	struct jmb38x_ms *jm = dev_get_drvdata(dev);
+
 	int cnt;
 
 	for (cnt = 0; cnt < jm->host_cnt; ++cnt) {
@@ -806,26 +805,17 @@ static int jmb38x_ms_suspend(struct pci_dev *dev, pm_message_t state)
 		memstick_suspend_host(jm->hosts[cnt]);
 	}
 
-	pci_save_state(dev);
-	pci_enable_wake(dev, pci_choose_state(dev, state), 0);
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
+	device_wakeup_disable(dev);
+
 	return 0;
 }
 
-static int jmb38x_ms_resume(struct pci_dev *dev)
+static int __maybe_unused jmb38x_ms_resume(struct device *dev)
 {
-	struct jmb38x_ms *jm = pci_get_drvdata(dev);
+	struct jmb38x_ms *jm = dev_get_drvdata(dev);
 	int rc;
 
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-	rc = pci_enable_device(dev);
-	if (rc)
-		return rc;
-	pci_set_master(dev);
-
-	jmb38x_ms_pmos(dev, 1);
+	jmb38x_ms_pmos(to_pci_dev(dev), 1);
 
 	for (rc = 0; rc < jm->host_cnt; ++rc) {
 		if (!jm->hosts[rc])
@@ -837,13 +827,6 @@ static int jmb38x_ms_resume(struct pci_dev *dev)
 	return 0;
 }
 
-#else
-
-#define jmb38x_ms_suspend NULL
-#define jmb38x_ms_resume NULL
-
-#endif /* CONFIG_PM */
-
 static int jmb38x_ms_count_slots(struct pci_dev *pdev)
 {
 	int cnt, rc = 0;
@@ -1030,13 +1013,14 @@ static struct pci_device_id jmb38x_ms_id_tbl [] = {
 	{ }
 };
 
+static SIMPLE_DEV_PM_OPS(jmb38x_ms_pm_ops, jmb38x_ms_suspend, jmb38x_ms_resume);
+
 static struct pci_driver jmb38x_ms_driver = {
 	.name = DRIVER_NAME,
 	.id_table = jmb38x_ms_id_tbl,
 	.probe = jmb38x_ms_probe,
 	.remove = jmb38x_ms_remove,
-	.suspend = jmb38x_ms_suspend,
-	.resume = jmb38x_ms_resume
+	.driver.pm = &jmb38x_ms_pm_ops,
 };
 
 module_pci_driver(jmb38x_ms_driver);
-- 
2.27.0

