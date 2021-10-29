Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEADC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 05:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4076108F
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 05:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhJ2GAJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Oct 2021 02:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhJ2GAH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2021 02:00:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1AAC061570;
        Thu, 28 Oct 2021 22:57:38 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c4so8860136pgv.11;
        Thu, 28 Oct 2021 22:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=/eLfvL2Jbm+xAho2C5JOCgKSfFZCxzezHuhj1zZc88Q=;
        b=LLAk9V2nrWxEHEbs807OY6TPiCcD/Tj8WY3jL2alrwbmMAUx2QrsJVe3eLHWzqgw03
         puO+zBu6qlAKFGGuR5IMOPjEQBi0UbEjCjx2hC6dXV7aw+UZgIyDDQ5EWXvbjfzQlEOS
         CmqvQz3jDoNE1gzBwX4GJng3tZ+lTKWWyRFB7/2QJT8uejlHva2wwGJyy+lakC8BAmzP
         0mG8qG3BBXfkYmAEh7DDS2Y3TOlbD7ov8Dy0ORTyb2eOyUgoCPdwxnEhRaYJ3xGKXqA5
         Ir//bbCIJdKzUR9iLqGvoAF0h36b0wDOiA8CdKrVoqqAqUtJ3ypRVNx/lREESTp5aqCz
         DWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/eLfvL2Jbm+xAho2C5JOCgKSfFZCxzezHuhj1zZc88Q=;
        b=kdO1rGlhDXpjbUr/kv3quBw7U/Q87stK+22XQBiEMOLMFgEgityLiTHW8GbIjUNRwl
         R2uQtOd3reqDow/V/zp30jt0HCcHcqm2LwYyfqvOtYsihieQH2P4Jpf5WBhcEqXSj/R2
         eD6pqs7nnKZBHalMlFI3u0yYl3W2PgLJlYLsTW080p4hR4VHCtAT838+meeDERDmxv8P
         my2jF3W1O5QMQ5zbO5w+6PHjI9Rlzvuu205PCmgC+7wq3aN3e6pypNdkDfzl1XRaXuZi
         iyYUxO61bKQfWQcZ2jymuezAH5b+M6q51sq0bnAnw6cXkLrPUhwYpXZrI2K7o+D9RcXu
         i6QA==
X-Gm-Message-State: AOAM531DP/gDfEozLM76OqFlZrMgms91HS0qxCDGGzvdJcooPnOMbJDE
        abYLzOaV9M/Ey+YOkOPTqgM=
X-Google-Smtp-Source: ABdhPJzTUQO8qbsA2CFCz8IzTdSIKbyCJtZZWJ0fbh1FiLa0m612Ix5kY2j1bzUu12S/Zc6YdhOiFQ==
X-Received: by 2002:a05:6a00:1946:b0:44d:8136:a4a4 with SMTP id s6-20020a056a00194600b0044d8136a4a4mr9011198pfk.46.1635487058167;
        Thu, 28 Oct 2021 22:57:38 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id mr2sm3599648pjb.25.2021.10.28.22.57.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Oct 2021 22:57:37 -0700 (PDT)
From:   "LH.Kuo" <lhjeff911@gmail.com>
X-Google-Original-From: "LH.Kuo" <lh.kuo@sunplus.com>
To:     ulf.hansson@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Subject: [PATCH 0/2] Add SD/SDIO control driver for Sunplus SP7021 SoC
Date:   Fri, 29 Oct 2021 13:57:33 +0800
Message-Id: <1635487055-18494-1-git-send-email-lh.kuo@sunplus.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:														
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

LH.Kuo (2):
  mmc: Add SD/SDIO driver for Sunplus SP7021
  devicetree bindings mmc Add bindings doc for Sunplus SP7021

 .../devicetree/bindings/mmc/sunplus-sd2.yaml       |   82 ++
 MAINTAINERS                                        |   41 +-
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sunplus_sd2.c                     | 1069 ++++++++++++++++++++
 drivers/mmc/host/sunplus_sd2.h                     |  216 ++++
 6 files changed, 1403 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
 create mode 100644 drivers/mmc/host/sunplus_sd2.c
 create mode 100644 drivers/mmc/host/sunplus_sd2.h

-- 
2.7.4

