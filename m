Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43AAC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Mar 2021 12:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8952364F69
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Mar 2021 12:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhCRMmO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Mar 2021 08:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhCRMlq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Mar 2021 08:41:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F7FC06174A
        for <linux-mmc@vger.kernel.org>; Thu, 18 Mar 2021 05:41:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hq27so3699572ejc.9
        for <linux-mmc@vger.kernel.org>; Thu, 18 Mar 2021 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1sC9U2CDtKPeAWPw0st3mOMarc1XvuSbP6HmZhoqnTs=;
        b=bGluH3hZ2ZqsPgcQUhgy8maSARKnYnTyLwoujscR5VnGZDnt3vTQDxKbuF5PDrPKxa
         JM4iaBc+MN1SSAzCmpZrPfaH1zeunDWPURZQ6wQfuRbI9nNrjAVFRaLCGQCsdpSYqP+c
         8Sxze9MAJt7QkJnqCTx4hk+IJnJGYU6MzO6ltYfsRiMwQKe+dBICltoRDIn+i/iyV10J
         EP61q3GGRW8/PLFOOIyp/k8g9+XYdl+o3sDNRK8WOuipSun9O07cGXQwxyRGZjJJCu7B
         d1V+QnVIEjCpzIjlUwlZjLZZiMOOSKWvpI5EJY5fiKMJpySl0LAFZwJMzP7dAYQ0cXhI
         ulow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1sC9U2CDtKPeAWPw0st3mOMarc1XvuSbP6HmZhoqnTs=;
        b=Ea1rIEeMoDQc26er+VB4gGAEBQkbY777ZC/vsfhoqfffue7ajg533cANXh8bWlEb3r
         dN3q4ZQ/H6iLF23TFd6aJLivaSp4ovt1cmkxFtt49WIObInRDRD7wFGs3yWMt54hUDBK
         mSbRyEw2+29or/sEgD5SdQmXUJ30p5mnrSkINIEdgyTvLUR7+CnbbOos+jlquIbN3oTR
         0VEXLZa4+qek3P8FNVLG3Gd3ymCIsL7G6InckpNYWviW23kyHOMH/EmEoXu3vxMjXaQk
         SXB0V/JR6ThuAoOwHZXT6CwfJaFUa2MxN6fuldupkJWIThyg3+50d4YJReSEruuiRSmm
         8odg==
X-Gm-Message-State: AOAM533Fiv5j0yPDYpw7dzwqfsaE/kHVxucAClWTzu7ze888ljYCgybN
        4HeIXgWD9CMXKRtz8TfyZo++wbZ2iXR5Ig==
X-Google-Smtp-Source: ABdhPJzX9I5HQb3Py6cP+9M3t9rbu6mkiaBBN3p6RcEtQznzL6+gIYsP01/L6XdKSR62AUWaZsu1BQ==
X-Received: by 2002:a17:906:719b:: with SMTP id h27mr40280217ejk.123.1616071304195;
        Thu, 18 Mar 2021 05:41:44 -0700 (PDT)
Received: from orca.lan ([2a02:8010:627e:1:a4f3:857f:9365:b3d9])
        by smtp.gmail.com with ESMTPSA id l1sm1984275edt.59.2021.03.18.05.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 05:41:43 -0700 (PDT)
Sender: James Young <marmarama@gmail.com>
From:   James Young <james@pocketfluff.org>
To:     linux-mmc@vger.kernel.org
Cc:     James Young <james@pocketfluff.org>
Subject: [PATCH] mmc: sdhci-acpi: Add device ID for the AMDI0041 variant of the AMD eMMC controller.
Date:   Thu, 18 Mar 2021 12:40:27 +0000
Message-Id: <20210318124025.3002861-1-james@pocketfluff.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This variant is present on a Lenovo IdeaPad Slim 1, which uses an AMD Dali/Athlon Silver 3050e.
The Windows AMD SD Host Controller driver also lists this as a valid device ID.

Adding this device ID makes the internal eMMC storage on the Lenovo accessible.
Consequently this makes Linux installable and usable on it as well.

Signed-off-by: James Young <james@pocketfluff.org>
---
 drivers/mmc/host/sdhci-acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index b6574e7fd26b..c3fbf8c825c4 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -772,6 +772,7 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
 	{ "QCOM8051", NULL, &sdhci_acpi_slot_qcom_sd_3v },
 	{ "QCOM8052", NULL, &sdhci_acpi_slot_qcom_sd },
 	{ "AMDI0040", NULL, &sdhci_acpi_slot_amd_emmc },
+	{ "AMDI0041", NULL, &sdhci_acpi_slot_amd_emmc },
 	{ },
 };
 
@@ -789,6 +790,7 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 	{ "QCOM8051" },
 	{ "QCOM8052" },
 	{ "AMDI0040" },
+	{ "AMDI0041" },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
-- 
2.25.1

