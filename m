From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.13 rc7
Date: Fri, 25 Aug 2017 11:42:40 +0200
Message-ID: <CAPDyKFotJccsFkdfaaAWriEP7C7zDRS2aRSdFV3QBQwv3tnqXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35485 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755771AbdHYJml (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Aug 2017 05:42:41 -0400
Received: by mail-oi0-f51.google.com with SMTP id k77so16447571oib.2
        for <linux-mmc@vger.kernel.org>; Fri, 25 Aug 2017 02:42:40 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>

Hi Linus,

Here's one mmc fix intended for v4.13-rc7.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 14ccee78fc82f5512908f4424f541549a5705b89:

  Linux 4.13-rc6 (2017-08-20 14:13:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.13-rc6

for you to fetch changes up to d83c2dbaa90a9bd6346e234d9802080a9c7b2fea:

  mmc: block: prevent propagating R1_OUT_OF_RANGE for open-ending mode
(2017-08-21 13:32:31 +0200)

----------------------------------------------------------------
MMC core:
 - Don't return error code R1_OUT_OF_RANGE for open-ending mode

----------------------------------------------------------------
Shawn Lin (1):
      mmc: block: prevent propagating R1_OUT_OF_RANGE for open-ending mode

 drivers/mmc/core/block.c | 49 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)
