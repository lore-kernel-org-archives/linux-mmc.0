Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F7436AB7B;
	Fri, 20 Mar 2026 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019904; cv=none; b=u3rK0a8Pp1bf5/FtbDxN0mMSJgYCZgJVGu3FUH5JGOtgBmlDcvS0Y/99B4EzayvVVthHBy1Tg3A97hK74G5P70O7YLbKsHqE/m0t7S2oumOJyIrsItQ8p455Fzi1I8tLXGQfcsXPfJRqT/Jl7gizq/cQQ37Yf3pyY9+Jsjwv1L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019904; c=relaxed/simple;
	bh=OVANX3vovge/OQuA6IUu9M7SaaFm5vfvJli/2PKs4Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkfefFOMGvSTWhCiAgOJYjunIB4E9+e5I0K3FyVn+xNwvdDpGJuDyevlruThAFWVM9U4w5rnRe2yx983qSrHrq8h/v7PWh5tcCrNxr77aT3pu3vq4mReYo9CRxQvPgflQhF57sxzgCdidEXEPcuZV4qZVNov2wo1wWDwmsQlVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfrXRmTe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfrXRmTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774019903; x=1805555903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OVANX3vovge/OQuA6IUu9M7SaaFm5vfvJli/2PKs4Jo=;
  b=cfrXRmTeKcxLc8J8IN0fuIjFp0f7l0WgXY4jtSaqEnb90ncD+ZQg8T3x
   wcarZHub6csjlLoVkTJDsdSjdATDy3WesJhdD4kEZxaU9859dt++wUxmc
   unEDImjSLO4QP3wHcXrBVmzVn3H5LskMk0s6/3QGrLJlUh4LLDSFEz8q4
   RPI4QxqHnLjQ+alab/REvb6uPd+1JMmvjO7EBiTM1aC/zkeYClJVZ2xJa
   K7kgd9GMMZvJLbNrI0pFYJlnJ5g0zTBVMNr4+BQugSM1TAbjxf7ynJSQi
   n4RQSork4ElvBkTwkYvQQ5y+T5uOm57FlN7wzC5QcaxQGICgPJs2b3GB+
   g==;
X-CSE-ConnectionGUID: +bZNxWnRQpiaKdbtsd1Vfg==
X-CSE-MsgGUID: JLo1uuAHSJ2KMhMeiw58eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="78963384"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="78963384"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 08:18:22 -0700
X-CSE-ConnectionGUID: Dcj3aANiRcKg8sWNMKb4wQ==
X-CSE-MsgGUID: zk0gZN5ITW+8R7Vk9Cdc5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="261219111"
Received: from lkp-server01.sh.intel.com (HELO ba623fe84fe1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2026 08:18:19 -0700
Received: from kbuild by ba623fe84fe1 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3bc7-00000000013-3NVb;
	Fri, 20 Mar 2026 15:18:15 +0000
Date: Fri, 20 Mar 2026 23:17:26 +0800
From: kernel test robot <lkp@intel.com>
To: Kamal Dasu <kamal.dasu@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kees Cook <kees@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kamal Dasu <kamal.dasu@broadcom.com>
Subject: Re: [PATCH v3 4/4] mmc: core: Add MMC pstore backend driver
Message-ID: <202603202338.OYFgRuuU-lkp@intel.com>
References: <20260319185705.1516950-5-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319185705.1516950-5-kamal.dasu@broadcom.com>

Hi Kamal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.0-rc4 next-20260319]
[cannot apply to ulf-hansson-mmc-mirror/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamal-Dasu/mmc-core-Add-panic-context-host-operations-for-pstore-backends/20260320-064639
base:   linus/master
patch link:    https://lore.kernel.org/r/20260319185705.1516950-5-kamal.dasu%40broadcom.com
patch subject: [PATCH v3 4/4] mmc: core: Add MMC pstore backend driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260320/202603202338.OYFgRuuU-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603202338.OYFgRuuU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603202338.OYFgRuuU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mmc/core/mmcpstore.c: In function 'mmcpstore_register_for_card':
>> drivers/mmc/core/mmcpstore.c:1016:23: warning: variable 'offset_bytes' set but not used [-Wunused-but-set-variable]
    1016 |         unsigned long offset_bytes;
         |                       ^~~~~~~~~~~~
--
>> Warning: drivers/mmc/core/mmcpstore.c:250 function parameter 'sect_offset' not described in 'mmcpstore_do_request_internal'
>> Warning: drivers/mmc/core/mmcpstore.c:573 expecting prototype for mmcpstore_read(). Prototype was for mmcpstore_read_zone() instead
>> Warning: drivers/mmc/core/mmcpstore.c:1248 function parameter 'disk' not described in 'mmcpstore_card_add'
>> Warning: drivers/mmc/core/mmcpstore.c:250 function parameter 'sect_offset' not described in 'mmcpstore_do_request_internal'
>> Warning: drivers/mmc/core/mmcpstore.c:1248 function parameter 'disk' not described in 'mmcpstore_card_add'


vim +/offset_bytes +1016 drivers/mmc/core/mmcpstore.c

   998	
   999	/**
  1000	 * mmcpstore_register_for_card - Register pstore for specific MMC card
  1001	 * @card: MMC card to register pstore for
  1002	 * @dev_name_param: Device path (e.g., "/dev/mmcblk1p5")
  1003	 * @disk: gendisk for the card (non-NULL for builtin path, NULL for module)
  1004	 *
  1005	 * Returns: 0 on success, negative error on failure
  1006	 */
  1007	static int mmcpstore_register_for_card(struct mmc_card *card,
  1008					       const char *dev_name_param,
  1009					       struct gendisk *disk)
  1010	{
  1011		struct mmcpstore_context *cxt;
  1012		struct pstore_blk_config conf;
  1013		struct file *bdev_file;
  1014		struct block_device *bdev;
  1015		sector_t partition_sectors;
> 1016		unsigned long offset_bytes;
  1017		unsigned long required_size;
  1018		unsigned long kmsg_records;
  1019		int ret;
  1020	
  1021		/*
  1022		 * Open the block device to get partition start sector and size.
  1023		 * When called from mmc_blk_probe() (builtin path), /dev/ may not
  1024		 * be mounted yet, so use the gendisk + partition number to look
  1025		 * up the dev_t directly.
  1026		 */
  1027		if (disk) {
  1028			int partno = mmcpstore_extract_partno(dev_name_param);
  1029			dev_t devt;
  1030	
  1031			if (partno < 0) {
  1032				pr_warn("Cannot parse partition from %s\n",
  1033					dev_name_param);
  1034				return -EINVAL;
  1035			}
  1036			devt = part_devt(disk, partno);
  1037			if (!devt) {
  1038				pr_warn("Partition %d not found on %s\n",
  1039					partno, disk->disk_name);
  1040				return -ENODEV;
  1041			}
  1042			bdev_file = bdev_file_open_by_dev(devt, BLK_OPEN_READ,
  1043							  NULL, NULL);
  1044		} else {
  1045			bdev_file = bdev_file_open_by_path(dev_name_param,
  1046							   BLK_OPEN_READ, NULL, NULL);
  1047		}
  1048		if (IS_ERR(bdev_file)) {
  1049			ret = PTR_ERR(bdev_file);
  1050			pr_warn("Failed to open device %s: %d\n", dev_name_param, ret);
  1051			return ret;
  1052		}
  1053		bdev = file_bdev(bdev_file);
  1054	
  1055		cxt = mmcpstore_ctx;
  1056		if (!cxt) {
  1057			pr_err("No context available\n");
  1058			fput(bdev_file);
  1059			return -ENODEV;
  1060		}
  1061	
  1062		/* pre-allocated buffer for alignment handling */
  1063		cxt->buffer_size = MMC_PSTORE_MAX_BUFFER_SIZE;
  1064		cxt->buffer = kmalloc(cxt->buffer_size, GFP_KERNEL);
  1065		if (!cxt->buffer) {
  1066			pr_err("Failed to allocate %zu bytes for pstore buffer\n",
  1067			       cxt->buffer_size);
  1068			fput(bdev_file);
  1069			return -ENOMEM;
  1070		}
  1071	
  1072		if (!(card->host->caps & MMC_CAP_NONREMOVABLE)) {
  1073			dev_err(&card->dev, "MMC pstore only supports non-removable cards (eMMC)\n");
  1074			dev_err(&card->dev, "This card is removable and not suitable for pstore\n");
  1075			ret = -EOPNOTSUPP;
  1076			goto err_free;
  1077		}
  1078	
  1079		/* Initialize context */
  1080		cxt->card = card;
  1081		strscpy(cxt->card_name, dev_name_param, sizeof(cxt->card_name));
  1082		cxt->start_sect = bdev->bd_start_sect;
  1083		cxt->size = bdev_nr_bytes(bdev);
  1084	
  1085		/* Apply user-specified sector offset and count within the partition */
  1086		if (part_sect_ofs > 0 || part_sect_cnt > 0) {
  1087			if ((part_sect_ofs > 0 && part_sect_cnt == 0) ||
  1088			    (part_sect_ofs == 0 && part_sect_cnt > 0)) {
  1089				dev_err(&card->dev, "sector_offset and sector_count must be specified\n");
  1090				ret = -EINVAL;
  1091				goto err_free;
  1092			}
  1093	
  1094			/* Validate offset and count */
  1095			partition_sectors = cxt->size >> 9;
  1096			offset_bytes = part_sect_ofs * MMC_PSTORE_SECTOR_SIZE;
  1097	
  1098			if (part_sect_ofs >= partition_sectors) {
  1099				dev_err(&card->dev, "Sector offset %lu >= partition size %llu sectors\n",
  1100					part_sect_ofs, partition_sectors);
  1101				ret = -EINVAL;
  1102				goto err_free;
  1103			}
  1104	
  1105			if (part_sect_ofs + part_sect_cnt > partition_sectors) {
  1106				dev_err(&card->dev, "Sector range %lu-%lu exceeds partition size %llu sectors\n",
  1107					part_sect_ofs,
  1108					part_sect_ofs + part_sect_cnt - 1,
  1109					partition_sectors);
  1110				ret = -EINVAL;
  1111				goto err_free;
  1112			}
  1113	
  1114			cxt->start_sect += part_sect_ofs;
  1115			cxt->size = part_sect_cnt * MMC_PSTORE_SECTOR_SIZE;
  1116	
  1117			pr_info("Pstore will use: sectors %lu-%lu (%llu bytes total)\n",
  1118				part_sect_ofs, part_sect_ofs + part_sect_cnt - 1,
  1119				cxt->size);
  1120		}
  1121	
  1122		fput(bdev_file);
  1123	
  1124		/* Configure pstore */
  1125		memset(&conf, 0, sizeof(conf));
  1126		strscpy(conf.device, dev_name_param, sizeof(conf.device));
  1127		conf.max_reason = KMSG_DUMP_PANIC;
  1128	
  1129		/* Fetch pstore configuration including sizes from module parameters */
  1130		ret = pstore_blk_get_config(&conf);
  1131		if (ret != 0) {
  1132			pr_err("Failed to get pstore block config: %d\n", ret);
  1133			goto err_free;
  1134		}
  1135	
  1136		/* Validate size requirements */
  1137		ret = mmcpstore_calculate_sizes(cxt, &conf, &required_size,
  1138						&kmsg_records);
  1139		if (ret)
  1140			goto err_free;
  1141	
  1142		pr_debug("Pstore requirements: kmsg=%lu KB, pmsg=%lu KB, console=%lu KB, ftrace=%lu KB\n",
  1143			MMC_PSTORE_BYTES_TO_KB(conf.kmsg_size),
  1144			MMC_PSTORE_BYTES_TO_KB(conf.pmsg_size),
  1145			MMC_PSTORE_BYTES_TO_KB(conf.console_size),
  1146			MMC_PSTORE_BYTES_TO_KB(conf.ftrace_size));
  1147		pr_debug("Pstore capacity: ~%lu kmsg records possible (%lu KB each, varies with compression)\n",
  1148			kmsg_records, MMC_PSTORE_BYTES_TO_KB(conf.kmsg_size));
  1149	
  1150		/* Set up pstore device info */
  1151		cxt->dev.flags = 0; /* Support all backends */
  1152		if (conf.kmsg_size > 0)
  1153			cxt->dev.flags |= PSTORE_FLAGS_DMESG;
  1154		if (conf.pmsg_size > 0)
  1155			cxt->dev.flags |= PSTORE_FLAGS_PMSG;
  1156		if (conf.console_size > 0)
  1157			cxt->dev.flags |= PSTORE_FLAGS_CONSOLE;
  1158		if (conf.ftrace_size > 0)
  1159			cxt->dev.flags |= PSTORE_FLAGS_FTRACE;
  1160	
  1161		/* Set up zone structure for pstore/zone API */
  1162		cxt->dev.zone.read = mmcpstore_read_zone;
  1163		cxt->dev.zone.write = mmcpstore_write;
  1164		cxt->dev.zone.panic_write = mmcpstore_panic_write;
  1165		cxt->dev.zone.total_size = cxt->size;
  1166		cxt->dev.zone.kmsg_size = conf.kmsg_size;
  1167		cxt->dev.zone.pmsg_size = conf.pmsg_size;
  1168		cxt->dev.zone.console_size = conf.console_size;
  1169		cxt->dev.zone.ftrace_size = conf.ftrace_size;
  1170		cxt->dev.zone.max_reason = conf.max_reason;
  1171		cxt->dev.zone.name = "mmcpstore";
  1172		cxt->dev.zone.owner = THIS_MODULE;
  1173	
  1174		mutex_init(&cxt->lock);
  1175	
  1176		/*
  1177		 * Set state to READY before registration because register_pstore_device()
  1178		 * triggers pstore_zone recovery which calls our read callback, and the
  1179		 * read callback requires state == READY to proceed.
  1180		 */
  1181		mutex_lock(&mmcpstore_global_lock);
  1182		cxt->state = MMCPSTORE_STATE_READY;
  1183		mutex_unlock(&mmcpstore_global_lock);
  1184	
  1185		ret = register_pstore_device(&cxt->dev);
  1186		if (ret) {
  1187			dev_err(&card->dev, "Failed to register pstore device: %d\n",
  1188				ret);
  1189			mutex_lock(&mmcpstore_global_lock);
  1190			cxt->state = MMCPSTORE_STATE_UNINITIALIZED;
  1191			mutex_unlock(&mmcpstore_global_lock);
  1192			goto err_free;
  1193		}
  1194	
  1195		dev_info(&card->dev, "MMC pstore backend registered successfully\n");
  1196		dev_info(&card->dev, "Device: %s, Size: %llu bytes (%llu KB)\n",
  1197			 dev_name_param, cxt->size, MMC_PSTORE_BYTES_TO_KB(cxt->size));
  1198		dev_info(&card->dev, "Start sector: %llu, Sector count: %llu\n",
  1199			 cxt->start_sect, cxt->size / MMC_PSTORE_SECTOR_SIZE);
  1200		dev_info(&card->dev, "Pstore components: kmsg=%lu KB, pmsg=%lu KB, console=%lu KB, ftrace=%lu KB\n",
  1201			 MMC_PSTORE_BYTES_TO_KB(conf.kmsg_size),
  1202			 MMC_PSTORE_BYTES_TO_KB(conf.pmsg_size),
  1203			 MMC_PSTORE_BYTES_TO_KB(conf.console_size),
  1204			 MMC_PSTORE_BYTES_TO_KB(conf.ftrace_size));
  1205	
  1206		return 0;
  1207	
  1208	err_free:
  1209		kfree(cxt->buffer);
  1210		/* Don't free cxt here - it's the global context */
  1211		return ret;
  1212	}
  1213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
