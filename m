Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B46C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 06:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DC360F13
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 06:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245186AbhIQGNF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 02:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245071AbhIQGM7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 02:12:59 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AA0C0613D9
        for <linux-mmc@vger.kernel.org>; Thu, 16 Sep 2021 23:11:37 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d20-20020ac81194000000b002a53ffbd04dso47999902qtj.12
        for <linux-mmc@vger.kernel.org>; Thu, 16 Sep 2021 23:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zwfeLGWcGDafTQfqNliurZp8teU/yYhkf3GW28JYz+0=;
        b=XM1DlrAUXX2ajvUBnMZhB99NjvFhfz+ZGq/7y3SKrZpGYit5SzYCLoZx+1fd1Pg2OM
         CE/DbVbB2zZOnd5RWwlYnvAIN/0FZuFvCYMAI3FUkH9+/WHs5czJ0XzDCRQOpbNttkDV
         rzNjCdkEp3wvo4sWkksIcRpcsW3Lpa4/N4OeJL02V5hrqG39IyQJLBkSwhLLcjvNJf1P
         J33Z8VNQpjjPrqBYeac07pb5MmLB0B8MJ5t+DBo6UEAJOnLuMozpyMAijqsFw2f6JbS1
         kjf8/RoduSl/18uPTMCiFBlHPGodsfgn0U2c6pVB8BmGNGic9LVrNxfbRPmKqI20Z1nX
         qACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zwfeLGWcGDafTQfqNliurZp8teU/yYhkf3GW28JYz+0=;
        b=Oder+NFj8zUFEfr+++dxDOB5vSjZ3zBS7z8ilvsYrtPFwCi2ir/9tNsXQ+8hIB/qeD
         rzzHu2rwPZpQUf0iDFeS/wlZdae0+4CP9ETFzd3/zdUbegqKSS/D79QN4uBGchGk36lr
         xLsskHhLEF5b3mFWqGTau4yidMet47JwkEIFNfuG8v+e36YW+un1D8C2350dMU68DftT
         LZfoqF84NBXVXEGWeg07OH3msWfQ19pAT4yOtOJf2EPE53JXVfkNjWB36qTk4P0Ty3WL
         3S0U9/+/Nm9mROi0Q3qOCuOagpSaXSWLMhePoZ5uOqusYzMRfI3kgyubSbcSGfLWLHu5
         4pyw==
X-Gm-Message-State: AOAM533FXJdg4RAv3xtjcvqEySA/ORoCKCBkd1XPcqnjz7TVhY8Kcut2
        gSriW8uWZhtpJV5o1oJBIH3k6Le13YSXSglyEPYVkA==
X-Google-Smtp-Source: ABdhPJx6RzYNzo1jNBe3N3oA2ojvmyemjqyjcW1MLw7H9/OVIjCsIqeL5PNY5fZLW55/k0Aj9lw0rd78dTvNRFgK+Smr+Q==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:4845:43ba:3ff5:2de1])
 (user=brendanhiggins job=sendgmr) by 2002:a25:4655:: with SMTP id
 t82mr11189168yba.289.1631859096878; Thu, 16 Sep 2021 23:11:36 -0700 (PDT)
Date:   Thu, 16 Sep 2021 23:11:03 -0700
In-Reply-To: <20210917061104.2680133-1-brendanhiggins@google.com>
Message-Id: <20210917061104.2680133-6-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v1 5/6] mmc: sdhci-of-aspeed: build kunit tests without
 structleak plugin
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The structleak plugin causes the stack frame size to grow immensely when
used with KUnit.

Turn it off.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/mmc/host/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 14004cc09aaad..2ab083931f8fd 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
 obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
 obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
 obj-$(CONFIG_MMC_SDHCI_OF_ASPEED)	+= sdhci-of-aspeed.o
+CFLAGS_sdhci-of-aspeed.o		+= $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
 obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
-- 
2.33.0.464.g1972c5931b-goog

