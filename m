From: Jaehoon Chung <jh80.chung@gmail.com>
Subject: [GIT PULL] Update dw-mmc controller
Date: Tue, 11 Aug 2015 01:54:21 +0900
Message-ID: <55C8D73D.10709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34239 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636AbbHJQy1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Aug 2015 12:54:27 -0400
Received: by pdbfa8 with SMTP id fa8so33249612pdb.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2015 09:54:26 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Addy Ke <addy.ke@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>

Dear, Ulf.

Could you pull these patches into your repository?

Best Regards,
Jaehoon Chung

The following changes since commit 77a5f675e2d80469b93c3dea1913c0450c4942be:

  mmc: block: add fixup of broken CMD23 for Sandisk card (2015-07-23 14:28:47 +0200)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git tags/dw-mmc-for-ulf-v4.2

for you to fetch changes up to a4c8b2edf78584dc7148ce06208d0f12d3b04a1b:

  mmc: dw_mmc: add quirk for broken data transfer over scheme (2015-08-11 01:33:32 +0900)

----------------------------------------------------------------
Addy Ke (1):
      mmc: dw_mmc: add quirk for broken data transfer over scheme

Alexey Brodkin (1):
      mmc: dw_mmc: handle data blocks > than 4kB if IDMAC is used

Heiko Stuebner (1):
      mmc: dw_mmc: fix pio mode when internal dmac is enabled

Jaehoon Chung (3):
      mmc: dw_mmc: fix the wrong condition checking
      mmc: dw_mmc: remove the unused blk_setting
      mmc: dw_mmc: print the message for deprecated property

Shawn Lin (1):
      mmc: dw_mmc: Fix coding style issues

 drivers/mmc/host/dw_mmc-rockchip.c |   3 +
 drivers/mmc/host/dw_mmc.c          | 284 +++++++++++++++++++++++++------------
 include/linux/mmc/dw_mmc.h         |   5 +-
 3 files changed, 204 insertions(+), 88 deletions(-)
