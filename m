From: Per Forlin <per.forlin@linaro.org>
Subject: [PATCH --mmotm v5 0/3] Make fault injection available for MMC IO
Date: Mon,  8 Aug 2011 22:07:26 +0200
Message-ID: <1312834049-29910-1-git-send-email-per.forlin@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>, akpm@linux-foundation.org, Linus Walleij <linus.ml.walleij@gmail.com>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, Chris
Cc: linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linaro-dev@lists.linaro.org, linux-mm@kvack.org, Per Forlin <per.forlin@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This patchset is sent to the mm-tree because it depends on Akinobu's patch
"fault-injection: add ability to export fault_attr in..."

change log:
 v2 - Resolve build issue in mmc core.c due to multiple init_module by
      removing the fault inject module.
    - Export fault injection functions to make them available for modules
    - Update fault injection documentation on MMC IO  
 v3 - add function descriptions in core.c
    - use export GPL for fault injection functions
 v4 - make the fault_attr per host. This prepares for upcoming patch from
      Akinobu that adds support for creating debugfs entries in
      arbitrary directory.
 v5 - Make use of fault_create_debugfs_attr() in Akinobu's
      patch "fault-injection: add ability to export fault_attr in...". 

Per Forlin (3):
  fault-inject: export fault injection functions
  mmc: core: add random fault injection
  fault injection: add documentation on MMC IO fault injection

 Documentation/fault-injection/fault-injection.txt |    5 ++
 drivers/mmc/core/core.c                           |   44 +++++++++++++++++++++
 drivers/mmc/core/debugfs.c                        |   24 +++++++++++
 include/linux/mmc/host.h                          |    7 +++
 lib/Kconfig.debug                                 |   11 +++++
 lib/fault-inject.c                                |    2 +
 6 files changed, 93 insertions(+), 0 deletions(-)

-- 
1.7.4.1

