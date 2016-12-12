From: kbuild test robot <fengguang.wu@intel.com>
Subject: [ulf.hansson-mmc:next 134/134] drivers/mmc/core/block.c:342:14-21:
 WARNING opportunity for memdup_user
Date: Tue, 13 Dec 2016 07:16:47 +0800
Message-ID: <201612130735.n1VmdCAl%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12394 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751756AbcLLXRi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 12 Dec 2016 18:17:38 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: kbuild-all@01.org, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
head:   f397c8d80a5e413984bd9ccdf4161c7156b365ce
commit: f397c8d80a5e413984bd9ccdf4161c7156b365ce [134/134] mmc: block: Move files to core


coccinelle warnings: (new ones prefixed by >>)

>> drivers/mmc/core/block.c:342:14-21: WARNING opportunity for memdup_user

vim +342 drivers/mmc/core/block.c

cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  326  	if (copy_from_user(&idata->ic, user, sizeof(idata->ic))) {
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  327  		err = -EFAULT;
aea253ec drivers/mmc/card/block.c Vladimir Motyka 2011-05-11  328  		goto idata_err;
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  329  	}
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  330  
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  331  	idata->buf_bytes = (u64) idata->ic.blksz * idata->ic.blocks;
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  332  	if (idata->buf_bytes > MMC_IOC_MAX_BYTES) {
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  333  		err = -EOVERFLOW;
aea253ec drivers/mmc/card/block.c Vladimir Motyka 2011-05-11  334  		goto idata_err;
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  335  	}
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  336  
bfe5b1b1 drivers/mmc/card/block.c Ville Viinikka  2016-07-08  337  	if (!idata->buf_bytes) {
bfe5b1b1 drivers/mmc/card/block.c Ville Viinikka  2016-07-08  338  		idata->buf = NULL;
4d6144de drivers/mmc/card/block.c Johan Rudholm   2011-11-23  339  		return idata;
bfe5b1b1 drivers/mmc/card/block.c Ville Viinikka  2016-07-08  340  	}
4d6144de drivers/mmc/card/block.c Johan Rudholm   2011-11-23  341  
1ff8950c drivers/mmc/card/block.c yalin wang      2015-11-12 @342  	idata->buf = kmalloc(idata->buf_bytes, GFP_KERNEL);
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  343  	if (!idata->buf) {
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  344  		err = -ENOMEM;
aea253ec drivers/mmc/card/block.c Vladimir Motyka 2011-05-11  345  		goto idata_err;
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  346  	}
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  347  
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  348  	if (copy_from_user(idata->buf, (void __user *)(unsigned long)
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  349  					idata->ic.data_ptr, idata->buf_bytes)) {
cb87ea28 drivers/mmc/card/block.c John Calixto    2011-04-26  350  		err = -EFAULT;

:::::: The code at line 342 was first introduced by commit
:::::: 1ff8950c04331883b11c5e0d6db96e2da8b6f8c9 mmc: block: change to use kmalloc when copy data from userspace

:::::: TO: yalin wang <yalin.wang2010@gmail.com>
:::::: CC: Ulf Hansson <ulf.hansson@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
