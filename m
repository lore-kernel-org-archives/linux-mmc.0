From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.1 rc1
Date: Wed, 22 Apr 2015 10:05:34 +0200
Message-ID: <CAPDyKFr8njV4GAcR=W4BcRHKf1nZyBuw3kmOQeaNOtKjWk-d6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34738 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbbDVIFf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2015 04:05:35 -0400
Received: by qkgx75 with SMTP id x75so216414209qkg.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2015 01:05:34 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Linus,

Here is two mmc fixes for v.4.1 rc1, based on your master branch a few days ago.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 4fc8adcfec3da639da76e8314c9ccefe5bf9a045:

  Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2015-04-16
23:27:56 -0400)

are available in the git repository at:


  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-4.1-rc1

for you to fetch changes up to 96541bac0b4e62efa42e7900d9b32e6baa9a214c:

  Revert "mmc: core: Convert mmc_driver to device_driver" (2015-04-17
11:48:01 +0200)

----------------------------------------------------------------
MMC core:
- Fix error code propagation in mmc_pwrseq_simple_alloc()
- Revert "mmc: core: Convert mmc_driver to device_driver"

----------------------------------------------------------------
Javier Martinez Canillas (1):
      mmc: pwrseq: Fix error code propagation in mmc_pwrseq_simple_alloc()

Ulf Hansson (1):
      Revert "mmc: core: Convert mmc_driver to device_driver"

 drivers/mmc/card/block.c    | 34 +++++++++++++++++-----------------
 drivers/mmc/card/mmc_test.c | 18 +++++++-----------
 drivers/mmc/core/bus.c      | 41 +++++++++++++++++++++++++++++++++--------
 drivers/mmc/core/pwrseq.c   |  2 +-
 include/linux/mmc/card.h    | 14 ++++++++++++--
 5 files changed, 70 insertions(+), 39 deletions(-)
