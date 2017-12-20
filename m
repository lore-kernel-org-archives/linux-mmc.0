From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 0/2] mmc: sunxi: Add runtime PM support
Date: Wed, 20 Dec 2017 11:50:33 +0100
Message-ID: <cover.ac66a754953bedbb7529436b40a7996f4ba3cb95.1513766964.git-series.maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54087 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753283AbdLTKuu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Dec 2017 05:50:50 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi,

Since it's introduction, our MMC controller has had its external clocks
running all the time.

While that was working great, the power usage and most importantly the EMI
that it generated was pretty bad.

Let's implement some runtime_pm hooks with an autosuspend to cut the
external clock when the MMC is not active.

I didn't get all the way to also shutdown the bus clocks since on some
older SoCs (before the A31), it also means that the controler will be reset
which has some quite important implications obviously. And I couldn't make
it work reliably at the moment. Anyway, it can always be implemented as a
second step if needed.

(Quite simple) benchmarks have shown no noticeable regressions since the
controller state is maintained.

Let me know what you think,
Maxime

Maxime Ripard (2):
  mmc: sunxi: Reorder the headers
  mmc: sunxi: Add runtime_pm support

 drivers/mmc/host/sunxi-mmc.c | 133 +++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 53 deletions(-)

base-commit: 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323
-- 
git-series 0.9.1
