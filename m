From: Per Forlin <per.forlin@linaro.org>
Subject: [PATCH v4 0/3] Make fault injection available for MMC IO
Date: Tue, 26 Jul 2011 22:11:56 +0200
Message-ID: <1311711119-6286-1-git-send-email-per.forlin@linaro.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.ke
Cc: Randy Dunlap <rdunlap@xenotime.net>, Per Forlin <per.forlin@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The first version of this patch is a part of mmc non-blocking v9 patchset:
[PATCH v9 11/12] mmc: core: add random fault injection

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

Per Forlin (3):
  fault-inject: make fault injection available for modules
  mmc: core: add random fault injection
  fault injection: add documentation on MMC IO fault injection

 Documentation/fault-injection/fault-injection.txt |    5 ++
 drivers/mmc/core/core.c                           |   45 +++++++++++++++++++++
 drivers/mmc/core/debugfs.c                        |   26 ++++++++++++
 include/linux/mmc/host.h                          |    7 +++
 lib/Kconfig.debug                                 |   11 +++++
 lib/fault-inject.c                                |    2 +
 6 files changed, 96 insertions(+), 0 deletions(-)

-- 
1.7.4.1

