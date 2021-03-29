Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9F1C43618
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 02:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA5261950
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 02:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhC2CAT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 28 Mar 2021 22:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhC2CAE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Mar 2021 22:00:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF060C0613B1
        for <linux-mmc@vger.kernel.org>; Sun, 28 Mar 2021 19:00:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e14so3662084plj.2
        for <linux-mmc@vger.kernel.org>; Sun, 28 Mar 2021 19:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AUT/fx38q5jzHp0KnGD15nyHtPKW1998V0+UJkFXEGk=;
        b=Fatmgx4bbKgLWkUqRoiO8p/pewMHfBVdaojdQ8DnCIAerwmYI168oyuDMwEC046Dkm
         abax/+QVucUuZr6HMyxsyxoV2bp8YOzt7wZStiliDGPY/FMZMWKLCj42wq6hu4JTHdE9
         qd4VArE7xvCnu9/Ddnx9HsL0GVjdLqrKqMuUZD+3vvygCHFDmPDAO2zNpMhsdPZIfwLS
         +3MnxcxKkh3beRViCgwbPVYABlOiRJOB4+QQmUpCvBuQUNnLxV/4LKOzzvCjhmQimQXo
         P9ppgVDwaAm4xzplaUoVrnJWCvluAnQxTbAXcVtgcuDcmnNOGlgqx2F2WZMJQviIRtZV
         tzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AUT/fx38q5jzHp0KnGD15nyHtPKW1998V0+UJkFXEGk=;
        b=IDBXZ4ZQsnERrqEIcrcJBVeluT7lT+OiMibr3jzFcLD7NtymOjY8ML3r1LBJuLO3eq
         qVMFujv4PT5uhKLYVqNPlh9y3pu9WRhG79OoLRfcvLK09mXsEeYIyAws5YdfJHuKWVTo
         m5syinqvk29wnpahfuOGD1YOpvU4uI3yZNVQesV6fRAJf7hz+F0DDRefzkH8OHkoh6Oa
         1fH1UCIt5VrIQFikoKipvjmPlh0AHHOv0BVx6JsMQlEXpV4F89xLKm5dRvrY20oGMvMK
         aEgetqV3QWwS+wNyA/MlbhvwxfkjKUyxJNJD8ZPMLqOXTtwIbDUvToDoJuUOg2JWLGpr
         ohiQ==
X-Gm-Message-State: AOAM533e9ONuqH44BoPPxVckaI8Cz4e3AzUoxfQGUdMBORvm27ft9W8x
        VmF51TKU0yQNOFEWGYIhu1lApw==
X-Google-Smtp-Source: ABdhPJyVsLefzEtdM9V5TgiaRr9fa4c2/h685XCffpBKXzNUaBp5HAE7FMtuN8Bx6CudThzRHfR2Zw==
X-Received: by 2002:a17:90a:d41:: with SMTP id 1mr24992479pju.232.1616983204271;
        Sun, 28 Mar 2021 19:00:04 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id w37sm14728027pgl.13.2021.03.28.19.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 19:00:03 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] gpio: Use linux/gpio/driver.h
Date:   Sun, 28 Mar 2021 18:59:38 -0700
Message-Id: <20210329015938.20316-14-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329015938.20316-1-brad@pensando.io>
References: <20210329015938.20316-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

New drivers should include <linux/gpio/driver.h> instead
of legacy <linux/gpio.h>.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 drivers/gpio/gpio-elba-spics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-elba-spics.c b/drivers/gpio/gpio-elba-spics.c
index 351bbaeea033..c0dce5333f35 100644
--- a/drivers/gpio/gpio-elba-spics.c
+++ b/drivers/gpio/gpio-elba-spics.c
@@ -6,11 +6,10 @@
  */
 
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/init.h>
-//#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-- 
2.17.1

