From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [ulf.hansson-mmc:next 72/74] drivers/mmc/host/atmel-mci.c:2593:
 error: 'atmci_dev_pm_ops' undeclared here (not in a function)
Date: Wed, 5 Nov 2014 14:00:55 +0100
Message-ID: <CAPDyKFr-yFHdJ3R3R-i0ZDF_cQbdhNQKpj-qFGo62tg+YOJ-GA@mail.gmail.com>
References: <201411052016.dObHXcry%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:42925 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbaKENA6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Nov 2014 08:00:58 -0500
Received: by mail-qc0-f180.google.com with SMTP id o8so437229qcw.39
        for <linux-mmc@vger.kernel.org>; Wed, 05 Nov 2014 05:00:58 -0800 (PST)
In-Reply-To: <201411052016.dObHXcry%fengguang.wu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 5 November 2014 13:16, kbuild test robot <fengguang.wu@intel.com> wrote:
> tree:   https://git.linaro.org/people/ulf.hansson/mmc next
> head:   c78dfc314bb79d5a364b6764f07e1e7fd6229391
> commit: 0ad8e93fc8ad5c815dc3b5a298ce05e2df6da0b8 [72/74] mmc: atmel-mci: add runtime pm support
> config: avr32-atngw100_mrmt_defconfig (attached as .config)
> reproduce:
>   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>   chmod +x ~/bin/make.cross
>   git checkout 0ad8e93fc8ad5c815dc3b5a298ce05e2df6da0b8
>   # save the attached .config to linux build tree
>   make.cross ARCH=avr32
>
> All error/warnings:
>

Hi Wenyou,

No worries this time. I have updated your patch to the fix the compile error.

I moved the declaration of the "atmci_dev_pm_ops" outside the
CONFIG_PM. Please go ahead and have a look at my next branch.

Kind regards
Uffe

>>> drivers/mmc/host/atmel-mci.c:2593: error: 'atmci_dev_pm_ops' undeclared here (not in a function)
>
> vim +/atmci_dev_pm_ops +2593 drivers/mmc/host/atmel-mci.c
>
>   2587
>   2588  static struct platform_driver atmci_driver = {
>   2589          .remove         = __exit_p(atmci_remove),
>   2590          .driver         = {
>   2591                  .name           = "atmel_mci",
>   2592                  .of_match_table = of_match_ptr(atmci_dt_ids),
>> 2593                  .pm             = &atmci_dev_pm_ops,
>   2594          },
>   2595  };
>   2596
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
