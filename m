Return-Path: <SRS0=IHUQ=Z7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209B8C43603
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Dec 2019 21:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BE0206D5
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Dec 2019 21:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="aFdT+b/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLIVJi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:09:38 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:20946 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfLIVJi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Dec 2019 16:09:38 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47Wwjy6cZpzCS;
        Mon,  9 Dec 2019 22:07:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1575925623; bh=Qc4cMiFfqRcpK1/wEakCiApC7wh9tCxkWxOw2MmHKU0=;
        h=Date:From:Subject:To:Cc:From;
        b=aFdT+b/auaLo+CrXXgBNInWjo2FntKJNOsY7H/vwhIqJiN5dtFsEjGUHWH5i092F2
         o9XEt4YLMpJ5XgvJQQh3ZgoTJLbQ/uFNjdPm8H+YCtBGELbs4r89+N227sg11EAtPL
         v5zeVpOlmV2MeY8niGFydO9uyUKoLZGA2O8ii+H+ylrgJbQET14gGxW+6BTiG3ahtV
         IYPwNwPfkM6eZfim0g8tOCBRzT0OdvVVGrW1Cb1FPbDh68C6D/J9b2PFbQTxNp58NE
         dglh3O6LPrfy+OwAWSvYcKhMMgeG0cIRg5E5eVefT2XNZD+NmIuu4P1AYQ2jpGWwNE
         /SqHYEuIr9g9g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Mon, 09 Dec 2019 22:09:35 +0100
Message-Id: <cover.1575925023.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/4] mmc: simplify WP/CD GPIO handling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series removes convoluted handling of inverted CD and WP lines in
SD/MMC host drivers when using GPIOs.

First patch, sent separately earlier, adds gpiod_toggle_active_low() to
switch line inversion flag in the gpiod structure. Next two patches
modify WP and CD initialization to apply all the inversions onto gpiod's
active-low flag. Final patch removes now-unused argument from init functions.

x86 allyesconfig build-tested.

Michał Mirosław (4):
  gpio: add gpiod_toggle_active_low()
  mmc: rework wp-gpio handling
  mmc: rework cd-gpio handling
  mmc: remove mmc_gpiod_request_*(invert_gpio)

 drivers/gpio/gpiolib-of.c          | 21 -------------------
 drivers/gpio/gpiolib.c             | 11 ++++++++++
 drivers/mmc/core/host.c            | 33 ++++++++----------------------
 drivers/mmc/core/slot-gpio.c       | 30 ++++++++++-----------------
 drivers/mmc/host/davinci_mmc.c     |  4 ++--
 drivers/mmc/host/mmc_spi.c         |  4 ++--
 drivers/mmc/host/mmci.c            |  4 ++--
 drivers/mmc/host/pxamci.c          | 12 +++++------
 drivers/mmc/host/s3cmci.c          |  4 ++--
 drivers/mmc/host/sdhci-acpi.c      |  2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c | 15 +++++++-------
 drivers/mmc/host/sdhci-pci-core.c  |  4 ++--
 drivers/mmc/host/sdhci-sirf.c      |  2 +-
 drivers/mmc/host/sdhci-spear.c     |  2 +-
 drivers/mmc/host/tmio_mmc_core.c   |  2 +-
 include/linux/gpio/consumer.h      |  7 +++++++
 include/linux/mmc/slot-gpio.h      |  5 ++---
 17 files changed, 67 insertions(+), 95 deletions(-)

-- 
2.20.1

