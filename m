From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 3/3] mmc: pwrseq: convert to proper platform device
Date: Wed, 20 Jan 2016 14:12:55 +0000
Message-ID: <569F95E7.4080305@linaro.org>
References: <201601202021.zTCtxQVb%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33674 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbcATONK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2016 09:13:10 -0500
Received: by mail-wm0-f41.google.com with SMTP id 123so134421447wmz.0
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2016 06:13:09 -0800 (PST)
In-Reply-To: <201601202021.zTCtxQVb%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Ulf,
Just realized that this patch is totally broken when mmc support is 
built as module. I will fix it and resend after v4.5-rc1

Thanks for kbuild test robot :-)

--srini

On 20/01/16 12:53, kbuild test robot wrote:
> Hi Srinivas,
>
> [auto build test ERROR on ulf.hansson-mmc/next]
> [also build test ERROR on next-20160120]
> [cannot apply to v4.4]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Srinivas-Kandagatla/mmc-pwrseq-convert-to-proper-driver/20160120-185020
> base:   https://git.linaro.org/people/ulf.hansson/mmc next
> config: openrisc-allmodconfig (attached as .config)
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=openrisc
>
> All error/warnings (new ones prefixed by >>):
>
>>> drivers/mmc/core/pwrseq_emmc.c:120:1: warning: data definition has no type or storage class
>>> drivers/mmc/core/pwrseq_emmc.c:120:1: error: type defaults to 'int' in declaration of 'device_initcall'
>     drivers/mmc/core/pwrseq_emmc.c:120:1: warning: parameter names (without types) in function declaration
>     drivers/mmc/core/pwrseq_emmc.c:120:1: warning: 'mmc_pwrseq_emmc_driver_init' defined but not used
>
> vim +120 drivers/mmc/core/pwrseq_emmc.c
>
>     114		.driver = {
>     115			.name = "pwrseq_emmc",
>     116			.of_match_table = mmc_pwrseq_emmc_of_match,
>     117		},
>     118	};
>     119	
>   > 120	builtin_platform_driver(mmc_pwrseq_emmc_driver);
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
