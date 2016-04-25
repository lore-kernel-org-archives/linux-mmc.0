From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2] mmc: dw_mmc: Fix UHS tuning on some brand of cards.
Date: Mon, 25 Apr 2016 17:18:48 +0200
Message-ID: <1461597529-6470-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

I introduced the cover letter to give some background about this.

I have been investigating a problem related to at least one specific sdcard when
UHS-I is set. The card is not detected due the tuning phase reports a
failure. Since the problem is only reproduced with a single model of a single
brand of card, it is probably a card firmware issue, but the card works fine
on my laptop.

The first attempt to fix this was a patch sent by Doug Anderson [1], but Alim
Akhtar found that this produced randomly a hung task on Peach-pi. I can confirm
that it's easy to reproduce the hung task, either, with cold boots or suspend to
ram tests.

I tried to fix both problems (the original issue and the one introduced by the
patch) in different ways, but I ended thinking that this second proposal is the
most simple that solves both issues. So let's try to fix this by handling the
response CRC error slightly differently when tuning command is happening.

I tested the patch on both platforms, on exynos and on rockhip. I did lots of
tests and at the moment the patch seems to fix the rockchip issue and don't
hung on exynos. I'll continue testing meanwhile we discuss about it.

I think the patch, at least, needs the Doug's approval (as he dig into the issue
before) and the Tested-by Alim. So will be good if you have a slot of time to
look a bit into this.

Thanks in advance.
 Enric

[1] https://lkml.org/lkml/2015/5/18/495

Doug Anderson (1):
  mmc: dw_mmc: Wait for data transfer after response errors.

 drivers/mmc/host/dw_mmc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

-- 
2.1.0
