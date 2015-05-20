From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.1 rc5
Date: Wed, 20 May 2015 14:31:38 +0200
Message-ID: <CAPDyKFrG8QisuV3EAei_pmA-BUuPKyUH6y3um39+9Czz5XuMeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33427 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbbETMbj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2015 08:31:39 -0400
Received: by qgfa63 with SMTP id a63so2841957qgf.0
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2015 05:31:38 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Linus,

Here's one more mmc fix intended for v4.1 rc5 and it's based on v4.1-rc3.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-4.1-rc3

for you to fetch changes up to 60c8f783a18feb95ad967c87e9660caf09fb4700:

  mmc: atmel-mci: fix bad variable type for clkdiv (2015-05-18 09:04:42 +0200)

----------------------------------------------------------------
MMC host:
- atmel-mci: fix bad variable type for clkdiv

----------------------------------------------------------------
Ludovic Desroches (1):
      mmc: atmel-mci: fix bad variable type for clkdiv

 drivers/mmc/host/atmel-mci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
