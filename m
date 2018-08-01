From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v4.18-rc8
Date: Wed,  1 Aug 2018 14:24:49 +0200
Message-ID: <20180801122449.32105-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with one MMC fix intended for v4.18-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.18-rc5

for you to fetch changes up to 3b1074bf9817bf43d4da375aa5f4b6c88f1d953e:

  mmc: mxcmmc: Fix missing parentheses and brace (2018-07-16 11:45:44 +0200)

----------------------------------------------------------------
MMC host:
 - mxcmmc: Fix build error for powerpc

----------------------------------------------------------------
Kees Cook (1):
      mmc: mxcmmc: Fix missing parentheses and brace

 drivers/mmc/host/mxcmmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
