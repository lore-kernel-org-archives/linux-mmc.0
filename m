Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0491C54EE9
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Sep 2022 11:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiIPL4I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Sep 2022 07:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIPL4H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2022 07:56:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF8437FA5
        for <linux-mmc@vger.kernel.org>; Fri, 16 Sep 2022 04:56:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dv25so48829498ejb.12
        for <linux-mmc@vger.kernel.org>; Fri, 16 Sep 2022 04:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=x14L5nWN4Vy/JiW326iHsOtIjJf1QJbgmD95EAtZRbE=;
        b=WqJhRC6Jhe9fMZsv5wEIKkEdPLGutrQ7JDTdPexz21O9E3nlaIMpQp6Fp4z2ZVD4pf
         3s7AQByd87b9QM7mkv9RuGz1mwYFXtPe3FBW0/GqyQ9Zh/526EJzoperb/IZV8m4tCTJ
         P+wNPKWgPno/0UhunQqWXGMe97HUhNm5bIey+RCKlNIPmij4Gihfg6GUYAJMhO0LWZOy
         lnzyfrIoWiVfeAzKkvtnaFUvvKx2eVcMHtaLDr3CbAUIhiOUZJvyoeDe7eU/bCF1kXnJ
         uVb/CBJyp0yyzvuisZ/nqwQA6a6FQDHF2U/taSpIByq1MfTL0bPQhDm1tVKjjujjG86u
         z2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=x14L5nWN4Vy/JiW326iHsOtIjJf1QJbgmD95EAtZRbE=;
        b=rZAA+fQNBhiV/76aWuuYQpLlNY5qz9qUG3ixqHPs3VuRuMvqpG1iXmJmDAj7kd8DRu
         XoYxqwiNbxqkZ7j6MARKGtsTEVWtumRHuCysySpb3Nlx7d9qvb6Kx2k2haI5lPZjI1p+
         iYi/75GvNmrEyvQII52ijkBbE9mv/hIKZR488FDiTxkTwMaaKjfE2J7N9SFNFpnHYsqM
         diRsdbP0k8OKM0kUNIxJJfVgV58cfpMgTzZsNjTnopyNSBSnQLXwfoKJkIc0gHGdsfqU
         WQoydhk8W6XGxDk9nYP1CJ8W70C2JyMocUzM00l8CeMbsluXf4YrOEw7xmBivwW8BMhc
         6Drw==
X-Gm-Message-State: ACrzQf0MRTciELuIOEB2i5XFzQeQ4VqwcQBcEWU0O9MHRW6myUNBu+J7
        0J3U9SqRtufEQSGfqyFO60g=
X-Google-Smtp-Source: AMsMyM6kx6YpswciT5Yyc8j/z70Y0Qnb361JxWuJQ94VG8037dOBAvvfWi8mN91Wd6Bgw8hIV6sT+Q==
X-Received: by 2002:a17:907:2e02:b0:77c:405e:e740 with SMTP id ig2-20020a1709072e0200b0077c405ee740mr3228298ejc.139.1663329365113;
        Fri, 16 Sep 2022 04:56:05 -0700 (PDT)
Received: from morpheus.home.roving-it.com (3.e.2.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681::2e3])
        by smtp.googlemail.com with ESMTPSA id w21-20020a1709064a1500b0077a1dd3e7b7sm10233407eju.102.2022.09.16.04.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 04:56:04 -0700 (PDT)
From:   Peter Robinson <pbrobinson@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org
Cc:     Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] mmc: sdhci-of-aspeed: Add dependency on ARCH_ASPEED
Date:   Fri, 16 Sep 2022 12:56:02 +0100
Message-Id: <20220916115602.370003-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The MMC_SDHCI_OF_ASPEED is part of the Aspeed silicon so it makes
sense to depend on ARCH_ASPEED and for compile testing.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e63608834411..f324daadaf70 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -157,6 +157,7 @@ config MMC_SDHCI_OF_ARASAN
 
 config MMC_SDHCI_OF_ASPEED
 	tristate "SDHCI OF support for the ASPEED SDHCI controller"
+	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	depends on OF && OF_ADDRESS
 	select MMC_SDHCI_IO_ACCESSORS
-- 
2.37.3

