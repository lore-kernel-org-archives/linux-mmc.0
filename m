Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874894D8B9;
	Sun,  4 Aug 2024 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722779954; cv=none; b=mMYWhNKTAltOTHu+W/7VG0sS452CEXW3dDFjNAnuZ/GCLZ/XkBKELvjpSmrJpaaaOYkxEwUdoxiC7yYZBKDseZvpKMRGm1OGJ7Fr97GBiV6RC/2cfboyf6Y/penWXrCgal3SdjnGnZzSfNollqctrr2Rmz7GTrli908MvdKCE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722779954; c=relaxed/simple;
	bh=Hw0uflrUJ7vQqndEmg42vDKC3Kxb745Qp0ejtEqvO+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8iZ1FVyj6XpXZYbkDIxqvQDnhcOv0S573IAhH9RnGSaWEmoUyL7pZFxnewWKqNbNl4Dgy2swm4B3lbIcj8XQLespCaORP0CEFDwyclGyO1F8QZ5/AnkuTaVVxS53BjW8NuDrUdU3V3/giWuzceYY9+NJMLfAJ7/IvS0+M8NAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKxd5yf1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKxd5yf1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722779953; x=1754315953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hw0uflrUJ7vQqndEmg42vDKC3Kxb745Qp0ejtEqvO+c=;
  b=SKxd5yf176Og7QJ1petyMh6Abk0J2I4JEI2wviBq/U8KHBMJYIiGvhdP
   9G2TP75phat0YwkADHBQoDkshRaMF+YjQxPOuWH4fSsC2oa5g11JmzhVI
   8DKkTFFVyYUo7Yc+lHuV7aiS97VrDz7C6s669beBz9tWUdQOJHZlfKE/9
   HmNk1CvsrzVr0z50qxj+P0r9knr6a1ABKmWvkG9Kre8+Kxx7zNyWMMtQq
   9VvX41z0nQCfcFgw/U7T22+VovtX2PmJdfG7VEfh7rE3j+OEXRzfWE6mr
   hpb54CtY2d1qK8zHdP1Az3V9v/kFxwr7vRo9Y7+q9/D1t/W9bP7QJb5QS
   Q==;
X-CSE-ConnectionGUID: uvQckt+3SOijd/LP/t1djw==
X-CSE-MsgGUID: Ut82/kWzSGCqdKli1c4LqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="31323661"
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="31323661"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 06:59:12 -0700
X-CSE-ConnectionGUID: HTLxOMkET+6kj9cLG0Dyew==
X-CSE-MsgGUID: HZ7X5HwaThCOen4fcgsdqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="56658499"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Aug 2024 06:59:06 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sablH-0001Sk-1u;
	Sun, 04 Aug 2024 13:59:03 +0000
Date: Sun, 4 Aug 2024 21:58:32 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4/6] block2mtd: attach device OF node to MTD device
Message-ID: <202408042135.nXaBv2UM-lkp@intel.com>
References: <20240804114108.1893-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804114108.1893-5-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.11-rc1 next-20240802]
[cannot apply to mtd/mtd/next mtd/mtd/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvme-Document-nvme-card-compatible/20240804-194357
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240804114108.1893-5-ansuelsmth%40gmail.com
patch subject: [PATCH 4/6] block2mtd: attach device OF node to MTD device
config: i386-buildonly-randconfig-001-20240804 (https://download.01.org/0day-ci/archive/20240804/202408042135.nXaBv2UM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240804/202408042135.nXaBv2UM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408042135.nXaBv2UM-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/devices/block2mtd.c: In function 'add_device':
>> drivers/mtd/devices/block2mtd.c:332:9: error: 'ddev' undeclared (first use in this function); did you mean 'dev'?
     332 |         ddev = disk_to_dev(dev->blkdev->bd_disk);
         |         ^~~~
         |         dev
   drivers/mtd/devices/block2mtd.c:332:9: note: each undeclared identifier is reported only once for each function it appears in
   In file included from drivers/mtd/devices/block2mtd.c:22:
>> drivers/mtd/devices/block2mtd.c:332:31: error: 'struct block2mtd_dev' has no member named 'blkdev'
     332 |         ddev = disk_to_dev(dev->blkdev->bd_disk);
         |                               ^~
   include/linux/blkdev.h:258:13: note: in definition of macro 'disk_to_dev'
     258 |         (&((disk)->part0->bd_device))
         |             ^~~~
   drivers/mtd/devices/block2mtd.c:333:25: error: 'struct block2mtd_dev' has no member named 'blkdev'
     333 |         if (ddev == &dev->blkdev->bd_device)
         |                         ^~


vim +332 drivers/mtd/devices/block2mtd.c

   260	
   261	static struct block2mtd_dev *add_device(char *devname, int erase_size,
   262			char *label, int timeout)
   263	{
   264		const blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_WRITE;
   265		struct file *bdev_file;
   266		struct block_device *bdev;
   267		struct block2mtd_dev *dev;
   268		loff_t size;
   269		char *name;
   270	
   271		if (!devname)
   272			return NULL;
   273	
   274		dev = kzalloc(sizeof(struct block2mtd_dev), GFP_KERNEL);
   275		if (!dev)
   276			return NULL;
   277	
   278		/* Get a handle on the device */
   279		bdev_file = bdev_file_open_by_path(devname, mode, dev, NULL);
   280		if (IS_ERR(bdev_file))
   281			bdev_file = mdtblock_early_get_bdev(devname, mode, timeout,
   282							      dev);
   283		if (IS_ERR(bdev_file)) {
   284			pr_err("error: cannot open device %s\n", devname);
   285			goto err_free_block2mtd;
   286		}
   287		dev->bdev_file = bdev_file;
   288		bdev = file_bdev(bdev_file);
   289	
   290		if (MAJOR(bdev->bd_dev) == MTD_BLOCK_MAJOR) {
   291			pr_err("attempting to use an MTD device as a block device\n");
   292			goto err_free_block2mtd;
   293		}
   294	
   295		size = bdev_nr_bytes(bdev);
   296		if ((long)size % erase_size) {
   297			pr_err("erasesize must be a divisor of device size\n");
   298			goto err_free_block2mtd;
   299		}
   300	
   301		mutex_init(&dev->write_mutex);
   302	
   303		/* Setup the MTD structure */
   304		/* make the name contain the block device in */
   305		if (!label)
   306			name = kasprintf(GFP_KERNEL, "block2mtd: %s", devname);
   307		else
   308			name = kstrdup(label, GFP_KERNEL);
   309		if (!name)
   310			goto err_destroy_mutex;
   311	
   312		dev->mtd.name = name;
   313	
   314		dev->mtd.size = size & PAGE_MASK;
   315		dev->mtd.erasesize = erase_size;
   316		dev->mtd.writesize = 1;
   317		dev->mtd.writebufsize = PAGE_SIZE;
   318		dev->mtd.type = MTD_RAM;
   319		dev->mtd.flags = MTD_CAP_RAM;
   320		dev->mtd._erase = block2mtd_erase;
   321		dev->mtd._write = block2mtd_write;
   322		dev->mtd._sync = block2mtd_sync;
   323		dev->mtd._read = block2mtd_read;
   324		dev->mtd.priv = dev;
   325		dev->mtd.owner = THIS_MODULE;
   326	
   327		/*
   328		 * Check if we are using root blockdev.
   329		 * If it's the case, connect the MTD of_node to the ddev parent
   330		 * to support providing partition in DT node.
   331		 */
 > 332		ddev = disk_to_dev(dev->blkdev->bd_disk);
   333		if (ddev == &dev->blkdev->bd_device)
   334			dev->mtd.dev.of_node = of_node_get(ddev->parent->of_node);
   335	
   336		if (mtd_device_register(&dev->mtd, NULL, 0)) {
   337			/* Device didn't get added, so free the entry */
   338			goto err_destroy_mutex;
   339		}
   340	
   341		list_add(&dev->list, &blkmtd_device_list);
   342		pr_info("mtd%d: [%s] erase_size = %dKiB [%d]\n",
   343			dev->mtd.index,
   344			label ? label : dev->mtd.name + strlen("block2mtd: "),
   345			dev->mtd.erasesize >> 10, dev->mtd.erasesize);
   346		return dev;
   347	
   348	err_destroy_mutex:
   349		of_node_put(dev->mtd.dev.of_node);
   350		mutex_destroy(&dev->write_mutex);
   351	err_free_block2mtd:
   352		block2mtd_free_device(dev);
   353		return NULL;
   354	}
   355	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
