From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] mmc: mmci: add missing include of mmci_qcom_dml.h
Date: Thu, 9 Jun 2016 18:16:48 +0100
Message-ID: <49d030df-f0b5-6bed-7f4c-a101b6e15752@codethink.co.uk>
References: <201606100156.EWHSQe2w%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:57791 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594AbcFIRQy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 13:16:54 -0400
In-Reply-To: <201606100156.EWHSQe2w%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@lists.codethink.co.uk, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infadead.org

On 09/06/16 18:24, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on ulf.hansson-mmc/next]
> [also build test ERROR on v4.7-rc2 next-20160609]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Ben-Dooks/mmc-mmci-add-missing-include-of-mmci_qcom_dml-h/20160609-021829
> base:   https://git.linaro.org/people/ulf.hansson/mmc next
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/mmc/host/mmci_qcom_dml.c:58:6: error: redefinition of 'dml_start_xfer'
>     void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
>          ^
>    In file included from drivers/mmc/host/mmci_qcom_dml.c:21:0:
>    drivers/mmc/host/mmci_qcom_dml.h:26:20: note: previous definition of 'dml_start_xfer' was here
>     static inline void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
>                        ^
>>> drivers/mmc/host/mmci_qcom_dml.c:123:5: error: redefinition of 'dml_hw_init'
>     int dml_hw_init(struct mmci_host *host, struct device_node *np)
>         ^
>    In file included from drivers/mmc/host/mmci_qcom_dml.c:21:0:
>    drivers/mmc/host/mmci_qcom_dml.h:22:19: note: previous definition of 'dml_hw_init' was here
>     static inline int dml_hw_init(struct mmci_host *host, struct device_node *np)
>                       

Looks like this driver is going to fail to build
when CONFIG_MMC_QCOM_DML=m as it'll not trigger
the config in QCOM_DML properly.

Shall I push a second patch to fix this?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
