From: kbuild test robot <fengguang.wu@intel.com>
Subject: [ulf.hansson-mmc:acpi_pm_domain_wip 7/9]
 drivers/acpi/acpi_lpss.c:1044:0: error: unterminated argument list invoking
 macro "if"
Date: Wed, 21 Jun 2017 00:41:55 +0800
Message-ID: <201706210052.gcAtehWm%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:29501 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbdFTQmY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 20 Jun 2017 12:42:24 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: kbuild-all@01.org, linux-mmc@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git acpi_pm_domain_wip
head:   bc3f10d6d60972e92bdaf1696669aa6679f0fff1
commit: bb07d8dee211eb570c780cda9c1d47b66de278e0 [7/9] PM / ACPI: Enable the runtime PM centric approach for system sleep
config: i386-randconfig-x008-201725 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout bb07d8dee211eb570c780cda9c1d47b66de278e0
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/acpi/acpi_lpss.c: In function 'acpi_lpss_runtime_suspend':
>> drivers/acpi/acpi_lpss.c:1044:0: error: unterminated argument list invoking macro "if"
    #endif /* CONFIG_X86_INTEL_LPSS */
    
>> drivers/acpi/acpi_lpss.c:860:2: error: expected '(' at end of input
     if (!pm_runtime_enabled(dev)
     ^~
>> drivers/acpi/acpi_lpss.c:860:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
   drivers/acpi/acpi_lpss.c:1044:0: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
    #endif /* CONFIG_X86_INTEL_LPSS */
    
>> drivers/acpi/acpi_lpss.c:860:2: error: expected declaration or statement at end of input
     if (!pm_runtime_enabled(dev)
     ^~
   drivers/acpi/acpi_lpss.c:853:28: warning: unused variable 'pdata' [-Wunused-variable]
     struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
                               ^~~~~
   At top level:
   drivers/acpi/acpi_lpss.c:851:12: warning: 'acpi_lpss_runtime_suspend' defined but not used [-Wunused-function]
    static int acpi_lpss_runtime_suspend(struct device *dev)
               ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_lpss.c:829:13: warning: 'lpss_iosf_exit_d3_state' defined but not used [-Wunused-function]
    static void lpss_iosf_exit_d3_state(void)
                ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_lpss.c:784:13: warning: 'lpss_iosf_enter_d3_state' defined but not used [-Wunused-function]
    static void lpss_iosf_enter_d3_state(void)
                ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_lpss.c:744:12: warning: 'acpi_lpss_resume_early' defined but not used [-Wunused-function]
    static int acpi_lpss_resume_early(struct device *dev)
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_lpss.c:715:12: warning: 'acpi_lpss_suspend_late' defined but not used [-Wunused-function]
    static int acpi_lpss_suspend_late(struct device *dev)
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_lpss.c:699:13: warning: 'acpi_lpss_dismiss' defined but not used [-Wunused-function]
    static void acpi_lpss_dismiss(struct device *dev)
                ^~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_lpss.c:676:12: warning: 'acpi_lpss_activate' defined but not used [-Wunused-function]
    static int acpi_lpss_activate(struct device *dev)
               ^~~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_lpss.c:584:13: warning: 'acpi_lpss_set_ltr' defined but not used [-Wunused-function]
    static void acpi_lpss_set_ltr(struct device *dev, s32 val)
                ^~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_lpss.c:579:31: warning: 'lpss_attr_group' defined but not used [-Wunused-variable]
    static struct attribute_group lpss_attr_group = {
                                  ^~~~~~~~~~~~~~~
   drivers/acpi/acpi_lpss.c:417:12: warning: 'acpi_lpss_create_device' defined but not used [-Wunused-function]
    static int acpi_lpss_create_device(struct acpi_device *adev,
               ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpi_lpss.c:97:21: warning: 'lpss_quirks' defined but not used [-Wunused-variable]
    static unsigned int lpss_quirks;
                        ^~~~~~~~~~~

vim +/if +1044 drivers/acpi/acpi_lpss.c

cb39dcdd4 Andy Shevchenko   2014-11-05   854  	int ret;
c78b08306 Heikki Krogerus   2014-05-23   855  
cb39dcdd4 Andy Shevchenko   2014-11-05   856  	ret = pm_generic_runtime_suspend(dev);
c78b08306 Heikki Krogerus   2014-05-23   857  	if (ret)
c78b08306 Heikki Krogerus   2014-05-23   858  		return ret;
c78b08306 Heikki Krogerus   2014-05-23   859  
bb07d8dee Ulf Hansson       2017-06-19  @860  	if (!pm_runtime_enabled(dev)
bb07d8dee Ulf Hansson       2017-06-19   861  		return lpss_suspend_late(dev);
bb07d8dee Ulf Hansson       2017-06-19   862  
cb39dcdd4 Andy Shevchenko   2014-11-05   863  	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
cb39dcdd4 Andy Shevchenko   2014-11-05   864  		acpi_lpss_save_ctx(dev, pdata);
cb39dcdd4 Andy Shevchenko   2014-11-05   865  
eebb3e8d8 Andy Shevchenko   2015-12-12   866  	ret = acpi_dev_runtime_suspend(dev);
eebb3e8d8 Andy Shevchenko   2015-12-12   867  
eebb3e8d8 Andy Shevchenko   2015-12-12   868  	/*
eebb3e8d8 Andy Shevchenko   2015-12-12   869  	 * This call must be last in the sequence, otherwise PMC will return
eebb3e8d8 Andy Shevchenko   2015-12-12   870  	 * wrong status for devices being about to be powered off. See
eebb3e8d8 Andy Shevchenko   2015-12-12   871  	 * lpss_iosf_enter_d3_state() for further information.
eebb3e8d8 Andy Shevchenko   2015-12-12   872  	 */
eebb3e8d8 Andy Shevchenko   2015-12-12   873  	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
eebb3e8d8 Andy Shevchenko   2015-12-12   874  		lpss_iosf_enter_d3_state();
eebb3e8d8 Andy Shevchenko   2015-12-12   875  
eebb3e8d8 Andy Shevchenko   2015-12-12   876  	return ret;
c78b08306 Heikki Krogerus   2014-05-23   877  }
c78b08306 Heikki Krogerus   2014-05-23   878  
c78b08306 Heikki Krogerus   2014-05-23   879  static int acpi_lpss_runtime_resume(struct device *dev)
c78b08306 Heikki Krogerus   2014-05-23   880  {
cb39dcdd4 Andy Shevchenko   2014-11-05   881  	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
cb39dcdd4 Andy Shevchenko   2014-11-05   882  	int ret;
c78b08306 Heikki Krogerus   2014-05-23   883  
bb07d8dee Ulf Hansson       2017-06-19   884  	if (pm_runtime_enabled(dev)) {
eebb3e8d8 Andy Shevchenko   2015-12-12   885  		/*
eebb3e8d8 Andy Shevchenko   2015-12-12   886  		 * This call is kept first to be in symmetry with
eebb3e8d8 Andy Shevchenko   2015-12-12   887  		 * acpi_lpss_runtime_suspend() one.
eebb3e8d8 Andy Shevchenko   2015-12-12   888  		 */
bb07d8dee Ulf Hansson       2017-06-19   889  		if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON &&
bb07d8dee Ulf Hansson       2017-06-19   890  		    iosf_mbi_available())
eebb3e8d8 Andy Shevchenko   2015-12-12   891  			lpss_iosf_exit_d3_state();
eebb3e8d8 Andy Shevchenko   2015-12-12   892  
cb39dcdd4 Andy Shevchenko   2014-11-05   893  		ret = acpi_dev_runtime_resume(dev);
c78b08306 Heikki Krogerus   2014-05-23   894  		if (ret)
c78b08306 Heikki Krogerus   2014-05-23   895  			return ret;
c78b08306 Heikki Krogerus   2014-05-23   896  
02b985404 Andy Shevchenko   2015-12-04   897  		acpi_lpss_d3_to_d0_delay(pdata);
02b985404 Andy Shevchenko   2015-12-04   898  
cb39dcdd4 Andy Shevchenko   2014-11-05   899  		if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
cb39dcdd4 Andy Shevchenko   2014-11-05   900  			acpi_lpss_restore_ctx(dev, pdata);
cb39dcdd4 Andy Shevchenko   2014-11-05   901  
bb07d8dee Ulf Hansson       2017-06-19   902  	} else {
bb07d8dee Ulf Hansson       2017-06-19   903  		ret = lpss_resume_early(dev);
bb07d8dee Ulf Hansson       2017-06-19   904  		if (ret)
bb07d8dee Ulf Hansson       2017-06-19   905  			return ret;
bb07d8dee Ulf Hansson       2017-06-19   906  	}
bb07d8dee Ulf Hansson       2017-06-19   907  
c78b08306 Heikki Krogerus   2014-05-23   908  	return pm_generic_runtime_resume(dev);
c78b08306 Heikki Krogerus   2014-05-23   909  }
c78b08306 Heikki Krogerus   2014-05-23   910  #endif /* CONFIG_PM */
c78b08306 Heikki Krogerus   2014-05-23   911  
c78b08306 Heikki Krogerus   2014-05-23   912  static struct dev_pm_domain acpi_lpss_pm_domain = {
c3a49cf35 Andy Shevchenko   2015-12-04   913  #ifdef CONFIG_PM
c3a49cf35 Andy Shevchenko   2015-12-04   914  	.activate = acpi_lpss_activate,
c3a49cf35 Andy Shevchenko   2015-12-04   915  	.dismiss = acpi_lpss_dismiss,
c3a49cf35 Andy Shevchenko   2015-12-04   916  #endif
c78b08306 Heikki Krogerus   2014-05-23   917  	.ops = {
5de21bb99 Rafael J. Wysocki 2014-11-27   918  #ifdef CONFIG_PM
c78b08306 Heikki Krogerus   2014-05-23   919  #ifdef CONFIG_PM_SLEEP
c78b08306 Heikki Krogerus   2014-05-23   920  		.prepare = acpi_subsys_prepare,
0ccc14c35 Ulf Hansson       2017-06-15   921  		.complete = acpi_subsys_complete,
c78b08306 Heikki Krogerus   2014-05-23   922  		.suspend = acpi_subsys_suspend,
f4168b617 Fu Zhonghui       2014-09-09   923  		.suspend_late = acpi_lpss_suspend_late,
f4168b617 Fu Zhonghui       2014-09-09   924  		.resume_early = acpi_lpss_resume_early,
c78b08306 Heikki Krogerus   2014-05-23   925  		.freeze = acpi_subsys_freeze,
c78b08306 Heikki Krogerus   2014-05-23   926  		.poweroff = acpi_subsys_suspend,
f4168b617 Fu Zhonghui       2014-09-09   927  		.poweroff_late = acpi_lpss_suspend_late,
f4168b617 Fu Zhonghui       2014-09-09   928  		.restore_early = acpi_lpss_resume_early,
c78b08306 Heikki Krogerus   2014-05-23   929  #endif
c78b08306 Heikki Krogerus   2014-05-23   930  		.runtime_suspend = acpi_lpss_runtime_suspend,
c78b08306 Heikki Krogerus   2014-05-23   931  		.runtime_resume = acpi_lpss_runtime_resume,
c78b08306 Heikki Krogerus   2014-05-23   932  #endif
c78b08306 Heikki Krogerus   2014-05-23   933  	},
c78b08306 Heikki Krogerus   2014-05-23   934  };
c78b08306 Heikki Krogerus   2014-05-23   935  
2e0f8822d Rafael J. Wysocki 2013-03-06   936  static int acpi_lpss_platform_notify(struct notifier_block *nb,
2e0f8822d Rafael J. Wysocki 2013-03-06   937  				     unsigned long action, void *data)
2e0f8822d Rafael J. Wysocki 2013-03-06   938  {
2e0f8822d Rafael J. Wysocki 2013-03-06   939  	struct platform_device *pdev = to_platform_device(data);
2e0f8822d Rafael J. Wysocki 2013-03-06   940  	struct lpss_private_data *pdata;
2e0f8822d Rafael J. Wysocki 2013-03-06   941  	struct acpi_device *adev;
2e0f8822d Rafael J. Wysocki 2013-03-06   942  	const struct acpi_device_id *id;
2e0f8822d Rafael J. Wysocki 2013-03-06   943  
2e0f8822d Rafael J. Wysocki 2013-03-06   944  	id = acpi_match_device(acpi_lpss_device_ids, &pdev->dev);
2e0f8822d Rafael J. Wysocki 2013-03-06   945  	if (!id || !id->driver_data)
2e0f8822d Rafael J. Wysocki 2013-03-06   946  		return 0;
2e0f8822d Rafael J. Wysocki 2013-03-06   947  
2e0f8822d Rafael J. Wysocki 2013-03-06   948  	if (acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev))
2e0f8822d Rafael J. Wysocki 2013-03-06   949  		return 0;
2e0f8822d Rafael J. Wysocki 2013-03-06   950  
2e0f8822d Rafael J. Wysocki 2013-03-06   951  	pdata = acpi_driver_data(adev);
cb39dcdd4 Andy Shevchenko   2014-11-05   952  	if (!pdata)
2e0f8822d Rafael J. Wysocki 2013-03-06   953  		return 0;
2e0f8822d Rafael J. Wysocki 2013-03-06   954  
cb39dcdd4 Andy Shevchenko   2014-11-05   955  	if (pdata->mmio_base &&
cb39dcdd4 Andy Shevchenko   2014-11-05   956  	    pdata->mmio_size < pdata->dev_desc->prv_offset + LPSS_LTR_SIZE) {
2e0f8822d Rafael J. Wysocki 2013-03-06   957  		dev_err(&pdev->dev, "MMIO size insufficient to access LTR\n");
2e0f8822d Rafael J. Wysocki 2013-03-06   958  		return 0;
2e0f8822d Rafael J. Wysocki 2013-03-06   959  	}
2e0f8822d Rafael J. Wysocki 2013-03-06   960  
c78b08306 Heikki Krogerus   2014-05-23   961  	switch (action) {
de16d5520 Andy Shevchenko   2015-12-04   962  	case BUS_NOTIFY_BIND_DRIVER:
989561de9 Tomeu Vizoso      2016-01-07   963  		dev_pm_domain_set(&pdev->dev, &acpi_lpss_pm_domain);
b5f88dd1d Andy Shevchenko   2015-12-04   964  		break;
de16d5520 Andy Shevchenko   2015-12-04   965  	case BUS_NOTIFY_DRIVER_NOT_BOUND:
b5f88dd1d Andy Shevchenko   2015-12-04   966  	case BUS_NOTIFY_UNBOUND_DRIVER:
5be6ada39 Andy Shevchenko   2016-02-01   967  		dev_pm_domain_set(&pdev->dev, NULL);
b5f88dd1d Andy Shevchenko   2015-12-04   968  		break;
b5f88dd1d Andy Shevchenko   2015-12-04   969  	case BUS_NOTIFY_ADD_DEVICE:
989561de9 Tomeu Vizoso      2016-01-07   970  		dev_pm_domain_set(&pdev->dev, &acpi_lpss_pm_domain);
ff8c1af5e Heikki Krogerus   2014-09-02   971  		if (pdata->dev_desc->flags & LPSS_LTR)
c78b08306 Heikki Krogerus   2014-05-23   972  			return sysfs_create_group(&pdev->dev.kobj,
c78b08306 Heikki Krogerus   2014-05-23   973  						  &lpss_attr_group);
01ac170ba Andy Shevchenko   2014-11-05   974  		break;
c78b08306 Heikki Krogerus   2014-05-23   975  	case BUS_NOTIFY_DEL_DEVICE:
ff8c1af5e Heikki Krogerus   2014-09-02   976  		if (pdata->dev_desc->flags & LPSS_LTR)
2e0f8822d Rafael J. Wysocki 2013-03-06   977  			sysfs_remove_group(&pdev->dev.kobj, &lpss_attr_group);
989561de9 Tomeu Vizoso      2016-01-07   978  		dev_pm_domain_set(&pdev->dev, NULL);
01ac170ba Andy Shevchenko   2014-11-05   979  		break;
c78b08306 Heikki Krogerus   2014-05-23   980  	default:
c78b08306 Heikki Krogerus   2014-05-23   981  		break;
c78b08306 Heikki Krogerus   2014-05-23   982  	}
2e0f8822d Rafael J. Wysocki 2013-03-06   983  
c78b08306 Heikki Krogerus   2014-05-23   984  	return 0;
2e0f8822d Rafael J. Wysocki 2013-03-06   985  }
2e0f8822d Rafael J. Wysocki 2013-03-06   986  
2e0f8822d Rafael J. Wysocki 2013-03-06   987  static struct notifier_block acpi_lpss_nb = {
2e0f8822d Rafael J. Wysocki 2013-03-06   988  	.notifier_call = acpi_lpss_platform_notify,
2e0f8822d Rafael J. Wysocki 2013-03-06   989  };
2e0f8822d Rafael J. Wysocki 2013-03-06   990  
1a8f83515 Rafael J. Wysocki 2014-02-11   991  static void acpi_lpss_bind(struct device *dev)
1a8f83515 Rafael J. Wysocki 2014-02-11   992  {
1a8f83515 Rafael J. Wysocki 2014-02-11   993  	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
1a8f83515 Rafael J. Wysocki 2014-02-11   994  
ff8c1af5e Heikki Krogerus   2014-09-02   995  	if (!pdata || !pdata->mmio_base || !(pdata->dev_desc->flags & LPSS_LTR))
1a8f83515 Rafael J. Wysocki 2014-02-11   996  		return;
1a8f83515 Rafael J. Wysocki 2014-02-11   997  
1a8f83515 Rafael J. Wysocki 2014-02-11   998  	if (pdata->mmio_size >= pdata->dev_desc->prv_offset + LPSS_LTR_SIZE)
1a8f83515 Rafael J. Wysocki 2014-02-11   999  		dev->power.set_latency_tolerance = acpi_lpss_set_ltr;
1a8f83515 Rafael J. Wysocki 2014-02-11  1000  	else
1a8f83515 Rafael J. Wysocki 2014-02-11  1001  		dev_err(dev, "MMIO size insufficient to access LTR\n");
1a8f83515 Rafael J. Wysocki 2014-02-11  1002  }
1a8f83515 Rafael J. Wysocki 2014-02-11  1003  
1a8f83515 Rafael J. Wysocki 2014-02-11  1004  static void acpi_lpss_unbind(struct device *dev)
1a8f83515 Rafael J. Wysocki 2014-02-11  1005  {
1a8f83515 Rafael J. Wysocki 2014-02-11  1006  	dev->power.set_latency_tolerance = NULL;
1a8f83515 Rafael J. Wysocki 2014-02-11  1007  }
1a8f83515 Rafael J. Wysocki 2014-02-11  1008  
f58b082ae Rafael J. Wysocki 2013-03-06  1009  static struct acpi_scan_handler lpss_handler = {
f58b082ae Rafael J. Wysocki 2013-03-06  1010  	.ids = acpi_lpss_device_ids,
f58b082ae Rafael J. Wysocki 2013-03-06  1011  	.attach = acpi_lpss_create_device,
1a8f83515 Rafael J. Wysocki 2014-02-11  1012  	.bind = acpi_lpss_bind,
1a8f83515 Rafael J. Wysocki 2014-02-11  1013  	.unbind = acpi_lpss_unbind,
f58b082ae Rafael J. Wysocki 2013-03-06  1014  };
f58b082ae Rafael J. Wysocki 2013-03-06  1015  
f58b082ae Rafael J. Wysocki 2013-03-06  1016  void __init acpi_lpss_init(void)
f58b082ae Rafael J. Wysocki 2013-03-06  1017  {
eebb3e8d8 Andy Shevchenko   2015-12-12  1018  	const struct x86_cpu_id *id;
eebb3e8d8 Andy Shevchenko   2015-12-12  1019  	int ret;
eebb3e8d8 Andy Shevchenko   2015-12-12  1020  
eebb3e8d8 Andy Shevchenko   2015-12-12  1021  	ret = lpt_clk_init();
eebb3e8d8 Andy Shevchenko   2015-12-12  1022  	if (ret)
eebb3e8d8 Andy Shevchenko   2015-12-12  1023  		return;
eebb3e8d8 Andy Shevchenko   2015-12-12  1024  
eebb3e8d8 Andy Shevchenko   2015-12-12  1025  	id = x86_match_cpu(lpss_cpu_ids);
eebb3e8d8 Andy Shevchenko   2015-12-12  1026  	if (id)
eebb3e8d8 Andy Shevchenko   2015-12-12  1027  		lpss_quirks |= LPSS_QUIRK_ALWAYS_POWER_ON;
eebb3e8d8 Andy Shevchenko   2015-12-12  1028  
2e0f8822d Rafael J. Wysocki 2013-03-06  1029  	bus_register_notifier(&platform_bus_type, &acpi_lpss_nb);
f58b082ae Rafael J. Wysocki 2013-03-06  1030  	acpi_scan_add_handler(&lpss_handler);
f58b082ae Rafael J. Wysocki 2013-03-06  1031  }
d6ddaaac8 Rafael J. Wysocki 2014-05-30  1032  
d6ddaaac8 Rafael J. Wysocki 2014-05-30  1033  #else
d6ddaaac8 Rafael J. Wysocki 2014-05-30  1034  
d6ddaaac8 Rafael J. Wysocki 2014-05-30  1035  static struct acpi_scan_handler lpss_handler = {
d6ddaaac8 Rafael J. Wysocki 2014-05-30  1036  	.ids = acpi_lpss_device_ids,
d6ddaaac8 Rafael J. Wysocki 2014-05-30  1037  };
d6ddaaac8 Rafael J. Wysocki 2014-05-30  1038  
d6ddaaac8 Rafael J. Wysocki 2014-05-30  1039  void __init acpi_lpss_init(void)
d6ddaaac8 Rafael J. Wysocki 2014-05-30  1040  {
d6ddaaac8 Rafael J. Wysocki 2014-05-30  1041  	acpi_scan_add_handler(&lpss_handler);
d6ddaaac8 Rafael J. Wysocki 2014-05-30  1042  }
d6ddaaac8 Rafael J. Wysocki 2014-05-30  1043  
d6ddaaac8 Rafael J. Wysocki 2014-05-30 @1044  #endif /* CONFIG_X86_INTEL_LPSS */

:::::: The code at line 1044 was first introduced by commit
:::::: d6ddaaac8f5c37ad84db3e6e019981f392389cf0 ACPI / scan: always register ACPI LPSS scan handler

:::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ZGiS0Q5IWpPtfppv--
