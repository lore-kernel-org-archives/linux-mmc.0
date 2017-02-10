From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.10 rc8
Date: Fri, 10 Feb 2017 15:47:49 +0100
Message-ID: <CAPDyKFqbXuLNmqg=CxghV5NmS-qe+ndV6BdvK=2GVXueGH14uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's one mmc fix intended for v4.10 rc8 (or final if no new rc).
Based on v4.10-rc7.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d5adbfcd5f7bcc6fa58a41c5c5ada0e5c826ce2c:

  Linux 4.10-rc7 (2017-02-05 15:10:58 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.10-rc7

for you to fetch changes up to 5cad24d835772f9f709971a8d6fcf12afe53b2a7:

  mmc: mmci: avoid clearing ST Micro busy end interrupt mistakenly
(2017-02-08 12:22:27 +0100)

----------------------------------------------------------------
MMC host:
 - mmci: Fix hang while waiting for busy-end interrupt

----------------------------------------------------------------
Jean-Nicolas Graux (1):
      mmc: mmci: avoid clearing ST Micro busy end interrupt mistakenly

 drivers/mmc/host/mmci.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)
