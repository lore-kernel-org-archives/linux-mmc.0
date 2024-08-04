Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF70B1E4A4;
	Sun,  4 Aug 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722779351; cv=none; b=I0BG63c2EFstrNcLYiTPMw+7FR42tPcF1hfEODAwEB/IHJur0BXdw7Bxz+8vxj0vst7De5pB8VqXm+N2NlnxRt/OEW5XIsRMnHNkv+6ZYygx1ZoJPL4ZD/YwOhV/E+dnixT8EYo1UI/pVtb1iOpMfZikxu1Qun4ORj8+ZgoU9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722779351; c=relaxed/simple;
	bh=ZEvV73YBlKrPcu6njYHmN/07ygxyiQcHWg7qogNJQPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOcZRHJPYumnXXfkCIpOQRiZlNa6yMM7MdGLXwde8EF14ha1y8pADagVc6aSwQx54LQOy84ba/Q3oY5oc8/ahJTPiIJg+1dnhAisJhywuaQRRN/NxR7JB2w1kDAjVm2bA7JuuQP28Euzi2xcPYHEl7ibrqemF4wYzzpqFHfdFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6RaKhB2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6RaKhB2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722779349; x=1754315349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZEvV73YBlKrPcu6njYHmN/07ygxyiQcHWg7qogNJQPk=;
  b=L6RaKhB26HCjYiBxG1+lyJWCRnZqRCcipkFlMBmO7A0vCZZbHEAOFkgA
   /+slJz6erwXuPSeBadjJFI86yLoImJMIpxMW8Xfnex4eVxlf2ZQx2dSBI
   7lJZ+BkPrKUcVSdDXFuS8KyJtZonQK0TrZ/uNmXbkAG03aDShyvMoidoj
   XuDF4FWbdJmz+P14yBQI9Ze0X/JoVIJB1LmGUIwPMvU8DVfPQkvraZDnM
   0QrrzsBy7zZOeGJdbxF4JyMzPVS+jeaDj4GlX/Vumzd+ViWa8NKlAoWs4
   3vfW8F7qiGuzxPihDqhdkTaSYLrK2D0G+j2RcTqYGTHXCbvOTGIqYwCZB
   A==;
X-CSE-ConnectionGUID: /1df4iaGTBSfBDi2qSAwpA==
X-CSE-MsgGUID: 5udRq937QEK5Rx+E5BySCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="32117724"
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="32117724"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 06:49:08 -0700
X-CSE-ConnectionGUID: qtAM2HN1T0GeKA0Lann3AQ==
X-CSE-MsgGUID: 9yukeT7/QKeGvvlkzvmkfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="56657427"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Aug 2024 06:49:02 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sabbX-0001Sg-1X;
	Sun, 04 Aug 2024 13:48:59 +0000
Date: Sun, 4 Aug 2024 21:48:10 +0800
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
Subject: Re: [PATCH 2/6] nvme: assign of_node to nvme device
Message-ID: <202408042134.wVQ7VdU6-lkp@intel.com>
References: <20240804114108.1893-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804114108.1893-3-ansuelsmth@gmail.com>

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
patch link:    https://lore.kernel.org/r/20240804114108.1893-3-ansuelsmth%40gmail.com
patch subject: [PATCH 2/6] nvme: assign of_node to nvme device
config: i386-buildonly-randconfig-002-20240804 (https://download.01.org/0day-ci/archive/20240804/202408042134.wVQ7VdU6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240804/202408042134.wVQ7VdU6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408042134.wVQ7VdU6-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/nvme/host/core.c: In function 'nvme_uninit_ctrl':
>> drivers/nvme/host/core.c:4654:9: error: implicit declaration of function 'of_node_put'; did you mean 'bpf_token_put'? [-Werror=implicit-function-declaration]
    4654 |         of_node_put(ctrl->device->of_node);
         |         ^~~~~~~~~~~
         |         bpf_token_put
   drivers/nvme/host/core.c: In function 'nvme_init_ctrl':
>> drivers/nvme/host/core.c:4775:33: error: implicit declaration of function 'of_get_compatible_child' [-Werror=implicit-function-declaration]
    4775 |         ctrl->device->of_node = of_get_compatible_child(ctrl->dev->of_node,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/core.c:4775:31: warning: assignment to 'struct device_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    4775 |         ctrl->device->of_node = of_get_compatible_child(ctrl->dev->of_node,
         |                               ^
   cc1: some warnings being treated as errors


vim +4654 drivers/nvme/host/core.c

  4648	
  4649	void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
  4650	{
  4651		nvme_hwmon_exit(ctrl);
  4652		nvme_fault_inject_fini(&ctrl->fault_inject);
  4653		dev_pm_qos_hide_latency_tolerance(ctrl->device);
> 4654		of_node_put(ctrl->device->of_node);
  4655		cdev_device_del(&ctrl->cdev, ctrl->device);
  4656		nvme_put_ctrl(ctrl);
  4657	}
  4658	EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
  4659	
  4660	static void nvme_free_cels(struct nvme_ctrl *ctrl)
  4661	{
  4662		struct nvme_effects_log	*cel;
  4663		unsigned long i;
  4664	
  4665		xa_for_each(&ctrl->cels, i, cel) {
  4666			xa_erase(&ctrl->cels, i);
  4667			kfree(cel);
  4668		}
  4669	
  4670		xa_destroy(&ctrl->cels);
  4671	}
  4672	
  4673	static void nvme_free_ctrl(struct device *dev)
  4674	{
  4675		struct nvme_ctrl *ctrl =
  4676			container_of(dev, struct nvme_ctrl, ctrl_device);
  4677		struct nvme_subsystem *subsys = ctrl->subsys;
  4678	
  4679		if (!subsys || ctrl->instance != subsys->instance)
  4680			ida_free(&nvme_instance_ida, ctrl->instance);
  4681		key_put(ctrl->tls_key);
  4682		nvme_free_cels(ctrl);
  4683		nvme_mpath_uninit(ctrl);
  4684		cleanup_srcu_struct(&ctrl->srcu);
  4685		nvme_auth_stop(ctrl);
  4686		nvme_auth_free(ctrl);
  4687		__free_page(ctrl->discard_page);
  4688		free_opal_dev(ctrl->opal_dev);
  4689	
  4690		if (subsys) {
  4691			mutex_lock(&nvme_subsystems_lock);
  4692			list_del(&ctrl->subsys_entry);
  4693			sysfs_remove_link(&subsys->dev.kobj, dev_name(ctrl->device));
  4694			mutex_unlock(&nvme_subsystems_lock);
  4695		}
  4696	
  4697		ctrl->ops->free_ctrl(ctrl);
  4698	
  4699		if (subsys)
  4700			nvme_put_subsystem(subsys);
  4701	}
  4702	
  4703	/*
  4704	 * Initialize a NVMe controller structures.  This needs to be called during
  4705	 * earliest initialization so that we have the initialized structured around
  4706	 * during probing.
  4707	 *
  4708	 * On success, the caller must use the nvme_put_ctrl() to release this when
  4709	 * needed, which also invokes the ops->free_ctrl() callback.
  4710	 */
  4711	int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
  4712			const struct nvme_ctrl_ops *ops, unsigned long quirks)
  4713	{
  4714		int ret;
  4715	
  4716		WRITE_ONCE(ctrl->state, NVME_CTRL_NEW);
  4717		ctrl->passthru_err_log_enabled = false;
  4718		clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
  4719		spin_lock_init(&ctrl->lock);
  4720		mutex_init(&ctrl->namespaces_lock);
  4721	
  4722		ret = init_srcu_struct(&ctrl->srcu);
  4723		if (ret)
  4724			return ret;
  4725	
  4726		mutex_init(&ctrl->scan_lock);
  4727		INIT_LIST_HEAD(&ctrl->namespaces);
  4728		xa_init(&ctrl->cels);
  4729		ctrl->dev = dev;
  4730		ctrl->ops = ops;
  4731		ctrl->quirks = quirks;
  4732		ctrl->numa_node = NUMA_NO_NODE;
  4733		INIT_WORK(&ctrl->scan_work, nvme_scan_work);
  4734		INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
  4735		INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
  4736		INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
  4737		init_waitqueue_head(&ctrl->state_wq);
  4738	
  4739		INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
  4740		INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
  4741		memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
  4742		ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
  4743		ctrl->ka_last_check_time = jiffies;
  4744	
  4745		BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
  4746				PAGE_SIZE);
  4747		ctrl->discard_page = alloc_page(GFP_KERNEL);
  4748		if (!ctrl->discard_page) {
  4749			ret = -ENOMEM;
  4750			goto out;
  4751		}
  4752	
  4753		ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
  4754		if (ret < 0)
  4755			goto out;
  4756		ctrl->instance = ret;
  4757	
  4758		ret = nvme_auth_init_ctrl(ctrl);
  4759		if (ret)
  4760			goto out_release_instance;
  4761	
  4762		nvme_mpath_init_ctrl(ctrl);
  4763	
  4764		device_initialize(&ctrl->ctrl_device);
  4765		ctrl->device = &ctrl->ctrl_device;
  4766		ctrl->device->devt = MKDEV(MAJOR(nvme_ctrl_base_chr_devt),
  4767				ctrl->instance);
  4768		ctrl->device->class = &nvme_class;
  4769		ctrl->device->parent = ctrl->dev;
  4770		if (ops->dev_attr_groups)
  4771			ctrl->device->groups = ops->dev_attr_groups;
  4772		else
  4773			ctrl->device->groups = nvme_dev_attr_groups;
  4774		ctrl->device->release = nvme_free_ctrl;
> 4775		ctrl->device->of_node = of_get_compatible_child(ctrl->dev->of_node,
  4776								"nvme-card");
  4777		dev_set_drvdata(ctrl->device, ctrl);
  4778	
  4779		return ret;
  4780	
  4781	out_release_instance:
  4782		ida_free(&nvme_instance_ida, ctrl->instance);
  4783	out:
  4784		if (ctrl->discard_page)
  4785			__free_page(ctrl->discard_page);
  4786		cleanup_srcu_struct(&ctrl->srcu);
  4787		return ret;
  4788	}
  4789	EXPORT_SYMBOL_GPL(nvme_init_ctrl);
  4790	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
