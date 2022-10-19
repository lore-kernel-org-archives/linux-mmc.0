Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7045DC4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Oct 2022 12:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiJSMFf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Oct 2022 08:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiJSMFL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2022 08:05:11 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E44422F1;
        Wed, 19 Oct 2022 04:41:24 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id s185so8199243vkb.0;
        Wed, 19 Oct 2022 04:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ56b3Pd2/JFz9ikCbuTIxSmT+ihwbhXOqm2bkZLHfk=;
        b=L8YBH+bJRG7658QN/fyihnDWDpl7YNkmWYkfpF3lr13cw5o52FPW6xP3dTsqejrdye
         4FJrG10jFh5zZcTdKgli0C5Me929K7orCjqtgph6H7lW5uAiyAcPql5ZcHEeoKNQbUYb
         Ib8or7ALte4+3ZYegAdJNVLguIUsfg2nf1VX4sco0sx5PkbWMribnsEtFYJ9977JwyIW
         BGbCQU8S5xEIx6ORFIX9iemmF4umWb82fnYmR4734dXDFP2zymZrZeUIg+mJe+mGU1Xd
         jt8kVMuYGydiltoumeobjT6wvdKfudyGb+bjJT5B3NsTUDH8Am4+arK+TBvtDS/mGp6n
         Dc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZ56b3Pd2/JFz9ikCbuTIxSmT+ihwbhXOqm2bkZLHfk=;
        b=QCrs0wSIACZKI9J64vZ6IFcHdf3h04JoBM7YSPYgEGzypCqQf0tdTjeekIufZ0JD6S
         HVzKvPaaQOkqi2+hFlxXJJw0C3PzoDtqu/hBB7V1F2vm4xj7qN3Ssh3gtoKhgZjLFYDu
         ULg+e/ZhTgYMwb2jYrZNAOcxWBk6Pj37Tq1eoB4H5JnhTqSUbKQzxKq0QVARKTqOCd0U
         X6KAlFYD28l3sM7/LjW+SsbYHlXasZ7gGKpzlXWZVfa43LqizcIMAipps4ocxFkQTzx0
         2x2zoupE5O9whYXRjtNV/n4pW41k2NSvX/IHELOR+PSw6tP404Vo+9n33QnBqbnCHj4Y
         GHbw==
X-Gm-Message-State: ACrzQf2iTeiyjvM0blyXsXpFUuatN/eK0ymPXgSAgsMwC2yMtzoDL8Ef
        mtbX6mJZFQbICs3W1H+F3eOZlNUj394=
X-Google-Smtp-Source: AMsMyM7X7dAib7XGCq9JLvEFthcoBlf3pLSsYKTyjE4lZaUc6jAWdAjKZs8bMyH/TGT5Z44OYm2Zmg==
X-Received: by 2002:a17:902:b597:b0:182:8547:ae57 with SMTP id a23-20020a170902b59700b001828547ae57mr7940543pls.92.1666177637658;
        Wed, 19 Oct 2022 04:07:17 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:07:17 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 07/26] mmc: sdhci: add a kernel configuration for enabling UHS-II support
Date:   Wed, 19 Oct 2022 19:06:28 +0800
Message-Id: <20221019110647.11076-8-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This kernel configuration, CONFIG_MMC_SDHCI_UHS2, will be used
in the following commits to indicate UHS-II specific code in sdhci
controllers.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index f324daadaf70..7e53cca97934 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -89,6 +89,15 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 
 	  This is the case for the Nintendo Wii SDHCI.
 
+config MMC_SDHCI_UHS2
+	tristate "UHS2 support on SDHCI controller"
+	depends on MMC_SDHCI
+	help
+	  This option is selected by SDHCI controller drivers that want to
+	  support UHS2-capable devices.
+
+	  If you have a controller with this feature, say Y or M here.
+
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
-- 
2.25.1

