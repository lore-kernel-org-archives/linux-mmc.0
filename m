From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.3 rc7
Date: Wed, 21 Oct 2015 10:35:00 +0200
Message-ID: <CAPDyKFoGwU8r4yq+my5xohBbKexzpczRNRP2xk3fAEcHbpUxkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38841 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbbJUIfC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 04:35:02 -0400
Received: by wicll6 with SMTP id ll6so63123493wic.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2015 01:35:00 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Linus,

Here's yet another MMC fix intended for v4.3 rc7. It's based on v4.3-rc5.
I don't expect to send any further PR for 4.3 rc[n].

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ade622:

  Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.3-rc5

for you to fetch changes up to 08b137d90eec51b0e90c42e123ca8ceb118d233f:

  mmc: core: Fix init_card in 52Mhz (2015-10-21 10:18:11 +0200)

----------------------------------------------------------------
MMC core:
 - Don't re-tune in the reset sequence to allow re-init of the card

----------------------------------------------------------------
Chaotian Jing (1):
      mmc: core: Fix init_card in 52Mhz

 drivers/mmc/card/mmc_test.c | 9 +++------
 drivers/mmc/core/mmc.c      | 7 -------
 2 files changed, 3 insertions(+), 13 deletions(-)
