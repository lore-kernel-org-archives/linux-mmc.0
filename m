Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D7C43334
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jul 2022 05:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiGYFCN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Jul 2022 01:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGYFCM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2022 01:02:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C927654;
        Sun, 24 Jul 2022 22:02:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d10so9409942pfd.9;
        Sun, 24 Jul 2022 22:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=TAXwUevh74c/caGE66B3o+XhqvQ3T/ugif6Pif5fSn8=;
        b=M2cfVIJ9XfOk5Y/jpz9NEu9uLrW2BP0yUEGLHx5lszgCNogo+4OyjV83PUy9lHdxdW
         qd5fylFGpMWfoNbKQgD1YoW3sh9MMHdEhK+9KOH0r0PQvn535/K5oheTi9TUvK22rmzH
         FTobVJpperiaLj//Yzwbb5aejxU9neTpPPJr1cps8jE4vO7nhmTjyAkbbpz7YXFduOLT
         a/+gVmtHLttOhj4VWHG2DYDPPO0Jq4fTUbif6OBI03PNR0LGPqllsS+LR6duIr/XUWUy
         HwFcnaEWrPxfvLJJy4WxVysTn759d5zzVocUvHFTworYaqGD6hYvRdn0sqmfEDfwmZFR
         VdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=TAXwUevh74c/caGE66B3o+XhqvQ3T/ugif6Pif5fSn8=;
        b=gXakjn5AtWdQPwxQOINi+NIz82jXQvNvKkDx+RGKPY66QhlkXcW4vVW7p11DSQNahP
         jL7EEz7RdkJ7BbNrqs575s+a8kEfIGZm5z1fvFoPopLHJ/U2N5gzGkNIqgUoDub/qnXh
         A/m2pf6+7gl1cGJWXbFklko142togeMvPQ89X8gxjnXYaQ64gfvJksGvVTFWHBG0E2i7
         xDeC7lOL770jZEzsRnHk1P0qJOq780rLyWOMSJ8lDfuFF4Z9IKQLNcIR2ngJjxA6yxca
         c3wratgfoGpy5IAEiqIM6XGklKyAgzmloEDcBgHMzH89QIPrTJJm65iI90JugexW4Nek
         GuBw==
X-Gm-Message-State: AJIora8+gXrZ6ww/nGct7iDB/kQ1RbL5XU6R9d71BWy5lgW5jeEYZ8JB
        anX8C3WWG1V7Z4HyjkHYmKA=
X-Google-Smtp-Source: AGRyM1upxmn+zhI3mq9ZRHOXQ1tSVc4IAluR34Hdb8FIRizUPx8/ho5wxa9LnruoooX/KsCCqwCz1w==
X-Received: by 2002:a63:1648:0:b0:41a:49f9:77ae with SMTP id 8-20020a631648000000b0041a49f977aemr9591012pgw.377.1658725328054;
        Sun, 24 Jul 2022 22:02:08 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id x194-20020a6286cb000000b0052ad49292f0sm8347423pfd.48.2022.07.24.22.02.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2022 22:02:07 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kerenl@vger.kernel.org, p.zabel@pengutronix.de,
        kuba@kernel.org, davem@davemloft.net,
        colin.foster@in-advantage.com, vladimir.oltean@nxp.com,
        tonyhuang.sunplus@gmail.com, wells@sunplus.com,
        tony.huang@sunplus.com
Subject: [PATCH v8 0/2] Add mmc driver for Sunplus SP7021 SOC
Date:   Mon, 25 Jul 2022 13:01:37 +0800
Message-Id: <cover.1658719324.git.tonyhuang.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a patch series for mmc driver for Sunplus SP7021 SOC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Tony Huang (2):
  dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
  mmc: Add mmc driver for Sunplus SP7021

 .../devicetree/bindings/mmc/sunplus,mmc.yaml       |   62 ++
 MAINTAINERS                                        |    7 +
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sunplus-mmc.c                     | 1012 ++++++++++++++++++++
 5 files changed, 1091 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus-mmc.c

-- 
2.7.4

