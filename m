Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251B0C433E0
	for <linux-mmc@archiver.kernel.org>; Sat,  9 Jan 2021 03:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD6872399C
	for <linux-mmc@archiver.kernel.org>; Sat,  9 Jan 2021 03:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbhAIDTm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Jan 2021 22:19:42 -0500
Received: from foss.arm.com ([217.140.110.172]:59730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbhAIDTm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 8 Jan 2021 22:19:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FA0731B;
        Fri,  8 Jan 2021 19:18:56 -0800 (PST)
Received: from [192.168.122.166] (unknown [10.119.48.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EACD3F66E;
        Fri,  8 Jan 2021 19:18:55 -0800 (PST)
Subject: Re: [PATCH] mmc: sdhci-iproc: Add ACPI bindings for the rpi4
To:     kernel test robot <lkp@intel.com>, linux-mmc@vger.kernel.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        bcm-kernel-feedback-list@broadcom.com, sbranden@broadcom.com,
        rjui@broadcom.com, ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com
References: <20210108211339.1724769-1-jeremy.linton@arm.com>
 <202101090943.lYXU9GHI-lkp@intel.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <58062024-ca6a-f763-3634-9995f494e81e@arm.com>
Date:   Fri, 8 Jan 2021 21:18:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <202101090943.lYXU9GHI-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 1/8/21 7:10 PM, kernel test robot wrote:
> Hi Jeremy,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.11-rc2 next-20210108]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Jeremy-Linton/mmc-sdhci-iproc-Add-ACPI-bindings-for-the-rpi4/20210109-051645
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6279d812eab67a6df6b22fa495201db6f2305924
> config: riscv-randconfig-r012-20210108 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project bc556e5685c0f97e79fb7b3c6f15cc5062db8e36)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install riscv cross compiling tool for clang build
>          # apt-get install binutils-riscv64-linux-gnu
>          # https://github.com/0day-ci/linux/commit/659eacf5a5de971ea94390dd6c7443c82d53ea5e
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Jeremy-Linton/mmc-sdhci-iproc-Add-ACPI-bindings-for-the-rpi4/20210109-051645
>          git checkout 659eacf5a5de971ea94390dd6c7443c82d53ea5e
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):

(trimming)

>     include/asm-generic/io.h:1005:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>             return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>                                                       ~~~~~~~~~~ ^
>>> drivers/mmc/host/sdhci-iproc.c:272:38: warning: unused variable 'bcm_arasan_data' [-Wunused-const-variable]
>     static const struct sdhci_iproc_data bcm_arasan_data = {

I think this is the only one caused by this patch, and its because the 
new structures are only used inside the #ifdef ACPI block.

I will post a v2.

>                                          ^
>     8 warnings generated.
> 
> 
> vim +/bcm_arasan_data +272 drivers/mmc/host/sdhci-iproc.c
> 
>     271	
>   > 272	static const struct sdhci_iproc_data bcm_arasan_data = {
>     273		.pdata = &sdhci_bcm_arasan_data,
>     274	};
>     275	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

