Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAC1C433EF
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Nov 2021 14:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9733603E7
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Nov 2021 14:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhKFO0H (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 6 Nov 2021 10:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhKFO0G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Nov 2021 10:26:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2892AC061570;
        Sat,  6 Nov 2021 07:23:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so5402304pjl.2;
        Sat, 06 Nov 2021 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=hq+4Vsu97LBFL6wCsWyPt3va/75TDS9sonocRI27F48=;
        b=IbCYME7dpSm3Tp1aj3zGo8L8h3H+p0ACCWTmZgCX2Zl9US9pKz0eO5yzQWEokCklZB
         zjJ2R3/TtJYBZkARFn/csyoAtvTuzOZlzaCReNIZ61MKyzgDSkPxFvkyNdR3QH/a7nvK
         34F6r63sM8qttDu0XSvlMu0ih32OFiJlTW9X2akSJCCEuyUGqzrKQTWeb09O3DatGZra
         tNi7UD1t9reaXc9Ka6CHPJ/KvxGR1hhmvqkm0Dkq2h79WWzJMRqEtnkZnl44M8duN9wG
         sF9jyKu+7CmBHbeRrmF5djRUvH7gQSfNPqVwQ1iL6YCpSbzprg+Dm6xfQgDG6TzIvdfH
         RglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hq+4Vsu97LBFL6wCsWyPt3va/75TDS9sonocRI27F48=;
        b=Uyu977t6jPRl43o2XlCi/Y9Iqw0jh4hoy2HZa6piwMKW9yWx3wi7hgKeqk5O8Sql4Y
         CTlrznsftMRCEZbKvTjn5vrp4SMatseV+7XaggG452kG7PSH60enCSyKxlQtc4zLvtZW
         oMX2JW+8t3Qr6MJzxXB/rPKa7FEou4oi6XB+LS5nVNQe1Q4xl4jlm8kcQx9gWJHnfnt5
         QcJTAg0K0h6TUWJ4JaKl61lHTRpmGSSJ38sKgI6vbVnXshuy9AS+UVw6L30hVqMbrV3f
         8YW3DNAyek/toswyWIc6Hi+HtUkHHrRIT6bfHE9WYe/3xfcGOpbNTWUtwQEwaAFlYGJO
         4PEw==
X-Gm-Message-State: AOAM533t/fne01v6SrRHL491pMO8vNr3iKmPCIycOf6aZCqXroOHuq+O
        Cl2lt6nrxnBs2BXLsr8AHzXptf1id20=
X-Google-Smtp-Source: ABdhPJzCIvEQFUREbXqSs3e1dOl+iJaYLi0z1ZTfCk80pEBKYApexIvmiUJInDJPbrJ9sGSH4ljiLg==
X-Received: by 2002:a17:90a:bb84:: with SMTP id v4mr38861487pjr.4.1636208604662;
        Sat, 06 Nov 2021 07:23:24 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id m4sm10859258pjs.1.2021.11.06.07.23.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Nov 2021 07:23:24 -0700 (PDT)
From:   Tony Huang <tonyhuang.sunplus@gmail.com>
X-Google-Original-From: Tony Huang <tony.huang@sunplus.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, Tony Huang <tony.huang@sunplus.com>
Subject: [PATCH 0/2] Add mmc driver for Sunplus SP7021 SOC
Date:   Sat,  6 Nov 2021 22:23:16 +0800
Message-Id: <1636208598-18234-1-git-send-email-tony.huang@sunplus.com>
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

 .../devicetree/bindings/mmc/sunplus-mmc.yaml       |   64 +
 MAINTAINERS                                        |    7 +
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sunplus_mmc.c                     | 1593 ++++++++++++++++++++
 drivers/mmc/host/sunplus_mmc.h                     |  181 +++
 6 files changed, 1855 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
 create mode 100644 drivers/mmc/host/sunplus_mmc.c
 create mode 100644 drivers/mmc/host/sunplus_mmc.h

-- 
2.7.4

