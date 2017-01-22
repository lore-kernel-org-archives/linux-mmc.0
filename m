From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2] mmc: sdio: check the buffer address for sdio API
Date: Sun, 22 Jan 2017 15:37:28 +0800
Message-ID: <d7160d8e-12f5-1e52-6f34-97a234e64ebb@rock-chips.com>
References: <201701210957.6046mF6U%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:56742 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdAVHuh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Jan 2017 02:50:37 -0500
In-Reply-To: <201701210957.6046mF6U%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: shawn.lin@rock-chips.com, kbuild-all@01.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On 2017/1/21 9:52, kbuild test robot wrote:
> Hi Shawn,
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.10-rc4 next-20170120]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Shawn-Lin/mmc-sdio-check-the-buffer-address-for-sdio-API/20170121-043940
> config: x86_64-rhel (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>>> ERROR: "is_vmalloc_or_module_addr" [drivers/mmc/core/mmc_core.ko] undefined!

Thanks lkp. I check the code and your config more, and this API
should fall back to is_vmalloc_addr and shouldn't be used for built-
as-module code. So I will fix that.

>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>


-- 
Best Regards
Shawn Lin

