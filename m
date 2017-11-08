From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] mmc: tmio: fix card detection
Date: Wed,  8 Nov 2017 19:16:57 +0900
Message-ID: <1510136220-31853-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:43214 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdKHKR4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Nov 2017 05:17:56 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>


Masahiro Yamada (3):
  mmc: tmio: move mmc_gpio_request_cd() before mmc_add_host()
  mmc: tmio: use mmc_can_gpio_cd() instead of checking
    TMIO_MMC_USE_GPIO_CD
  mmc: tmio: support IP-builtin card detection logic

 drivers/mmc/host/tmio_mmc_core.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

-- 
2.7.4

