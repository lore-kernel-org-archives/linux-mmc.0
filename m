From: Raul E Rangel <rrangel@chromium.org>
Subject: [stable/4.14.y PATCH 0/3] mmc: Fix a potential resource leak when shutting down request queue.
Date: Mon, 13 May 2019 11:55:18 -0600
Message-ID: <20190513175521.84955-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Chris Boot <bootc@bootc.net>, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

I think we should cherry-pick 41e3efd07d5a02c80f503e29d755aa1bbb4245de
https://lore.kernel.org/patchwork/patch/856512/ into 4.14. It fixes a
potential resource leak when shutting down the request queue.

Once this patch is applied, there is a potential for a null pointer dereference.
That's what the second patch fixes.

The third patch is just an optimization to stop processing earlier.

See https://patchwork.kernel.org/patch/10925469/ for the initial motivation.

This commit applies to v4.14.116. It is already included in 4.19. 4.19 doesn't
suffer from the null pointer dereference because later commits migrate the mmc
stack to blk-mq.

I tested this patch set by randomly connecting/disconnecting the SD
card. I got over 189650 itarations without a problem.

Thanks,
Raul


Adrian Hunter (1):
  mmc: block: Simplify cleaning up the queue

Raul E Rangel (2):
  mmc: Fix null pointer dereference in mmc_init_request
  mmc: Kill the request if the queuedata has been removed

 drivers/mmc/core/block.c | 17 ++++++++++++-----
 drivers/mmc/core/queue.c | 14 +++++++++++---
 2 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog
