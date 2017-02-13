From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v11 6/9] mmc: cavium: Add MMC PCI driver for ThunderX SOCs
Date: Mon, 13 Feb 2017 16:45:02 +0100
Message-ID: <CAPDyKFqMhwt120_J3y293bwMxOEz+LRz6oESfHU0vm8dN0wggQ@mail.gmail.com>
References: <20170206133953.8390-7-jglauber@cavium.com> <201702120922.DE85ulq1%fengguang.wu@intel.com>
 <20170213152408.GB27339@hardcore>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35547 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753552AbdBMPpI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2017 10:45:08 -0500
Received: by mail-ua0-f169.google.com with SMTP id y9so68231169uae.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2017 07:45:08 -0800 (PST)
In-Reply-To: <20170213152408.GB27339@hardcore>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>

On 13 February 2017 at 16:24, Jan Glauber
<jan.glauber@caviumnetworks.com> wrote:
> On Sun, Feb 12, 2017 at 09:09:29AM +0800, kbuild test robot wrote:
>> Hi Jan,
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v4.10-rc7 next-20170210]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Jan-Glauber/Cavium-MMC-driver/20170206-214740
>> config: arm64-allmodconfig (attached as .config)
>> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=arm64
>>
>> All errors (new ones prefixed by >>):
>>
>>    In file included from drivers/mmc/host/cavium-mmc.c:28:0:
>>    drivers/mmc/host/cavium-mmc.h:41:7: warning: "CONFIG_MMC_CAVIUM_THUNDERX" is not defined [-Wundef]
>>     #elif CONFIG_MMC_CAVIUM_THUNDERX
>>           ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Hi Ulf,
>
> We are aware of this build error, the line above should be:
> #elif IS_ENABLED(CONFIG_MMC_CAVIUM_THUNDERX)

Please avoid using IS_ENABLED() - unless really needed.

Doesn't "#ifdef" work here?

>
> instead of:
> #elif CONFIG_MMC_CAVIUM_THUNDERX
>
> Unless you want it otherwise I'll wait for your review of the series
> and fix this build error with the next revision.

I have started to look at the series (I have comments). So, unless
some other provides you with relevant comments, you can wait for mine
before re-spin.

[...]

Kind regards
Uffe
