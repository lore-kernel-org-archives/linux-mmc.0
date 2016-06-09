From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [Linux-kernel] [PATCH] mmc: mmci: add missing include of
 mmci_qcom_dml.h
Date: Thu, 9 Jun 2016 18:45:52 +0100
Message-ID: <a2843535-fbea-927b-226b-e51e49f2761d@codethink.co.uk>
References: <201606100156.EWHSQe2w%fengguang.wu@intel.com>
 <49d030df-f0b5-6bed-7f4c-a101b6e15752@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:58758 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbcFIRp6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 13:45:58 -0400
In-Reply-To: <49d030df-f0b5-6bed-7f4c-a101b6e15752@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: linux-kernel@lists.codethink.co.uk, linux-arm-kernel@lists.infadead.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, kbuild-all@01.org

On 09/06/16 18:16, Ben Dooks wrote:
> On 09/06/16 18:24, kbuild test robot wrote:
>> Hi,
>>
>> [auto build test ERROR on ulf.hansson-mmc/next]
>> [also build test ERROR on v4.7-rc2 next-20160609]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Ben-Dooks/mmc-mmci-add-missing-include-of-mmci_qcom_dml-h/20160609-021829
>> base:   https://git.linaro.org/people/ulf.hansson/mmc next
>> config: arm64-allmodconfig (attached as .config)
>> compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
>> reproduce:
>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=arm64 
>>
>> All errors (new ones prefixed by >>):
>>
>>>> drivers/mmc/host/mmci_qcom_dml.c:58:6: error: redefinition of 'dml_start_xfer'
>>     void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
>>          ^
>>    In file included from drivers/mmc/host/mmci_qcom_dml.c:21:0:
>>    drivers/mmc/host/mmci_qcom_dml.h:26:20: note: previous definition of 'dml_start_xfer' was here
>>     static inline void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
>>                        ^
>>>> drivers/mmc/host/mmci_qcom_dml.c:123:5: error: redefinition of 'dml_hw_init'
>>     int dml_hw_init(struct mmci_host *host, struct device_node *np)
>>         ^
>>    In file included from drivers/mmc/host/mmci_qcom_dml.c:21:0:
>>    drivers/mmc/host/mmci_qcom_dml.h:22:19: note: previous definition of 'dml_hw_init' was here
>>     static inline int dml_hw_init(struct mmci_host *host, struct device_node *np)
>>                       
> 
> Looks like this driver is going to fail to build
> when CONFIG_MMC_QCOM_DML=m as it'll not trigger
> the config in QCOM_DML properly.
> 
> Shall I push a second patch to fix this?
> 

After looking at the build, it looks like this is broken
for the case of building mmci as a module. I think this is
the right fix.

commit be3bf8f3b56d9cfb2fcba88e638ec853d0484cbb
Author: Ben Dooks <ben.dooks@codethink.co.uk>
Date:   Thu Jun 9 18:42:53 2016 +0100

    mmci: fixup module build with new mmci_qcom_dml

    Fix the module build for the mmci code if it is built as
    a module and the MMC_QCOM_DML option is also set. If so
    then we need to build a composite module of the two files
    to ensure they link properly.

    Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index af918d2..b57db76 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -3,7 +3,8 @@
 #

 obj-$(CONFIG_MMC_ARMMMCI)      += mmci.o
-obj-$(CONFIG_MMC_QCOM_DML)     += mmci_qcom_dml.o
+mmci-y                         += mmci_core.o
+mmci-$(subst m,y,$(CONFIG_MMC_QCOM_DML)) += mmci_qcom_dml.o
 obj-$(CONFIG_MMC_PXA)          += pxamci.o
 obj-$(CONFIG_MMC_MXC)          += mxcmmc.o
 obj-$(CONFIG_MMC_MXS)          += mxs-mmc.o
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci_core.c
similarity index 100%
rename from drivers/mmc/host/mmci.c
rename to drivers/mmc/host/mmci_core.c
diff --git a/drivers/mmc/host/mmci_qcom_dml.h
b/drivers/mmc/host/mmci_qcom_dml.h
index 6e405d0..d77873d 100644
--- a/drivers/mmc/host/mmci_qcom_dml.h
+++ b/drivers/mmc/host/mmci_qcom_dml.h
@@ -15,7 +15,7 @@
 #ifndef __MMC_QCOM_DML_H__
 #define __MMC_QCOM_DML_H__

-#ifdef CONFIG_MMC_QCOM_DML
+#if defined(CONFIG_MMC_QCOM_DML) || defined(CONFIG_MMC_QCOM_DML_MODULE)
 int dml_hw_init(struct mmci_host *host, struct device_node *np);
 void dml_start_xfer(struct mmci_host *host, struct mmc_data *data);
 #else


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
