From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 6/9] mmc: cavium: Add MMC PCI driver for ThunderX SOCs
Date: Wed, 15 Feb 2017 13:34:40 +0100
Message-ID: <CAK8P3a2MT2yWaPvy3K9MoPAtjeqkUmGfSB3gxFk1YHdnReeRHQ@mail.gmail.com>
References: <20170206133953.8390-7-jglauber@cavium.com> <201702120922.DE85ulq1%fengguang.wu@intel.com>
 <20170213152408.GB27339@hardcore> <CAPDyKFqMhwt120_J3y293bwMxOEz+LRz6oESfHU0vm8dN0wggQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36236 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbdBOMem (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 07:34:42 -0500
In-Reply-To: <CAPDyKFqMhwt120_J3y293bwMxOEz+LRz6oESfHU0vm8dN0wggQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jan Glauber <jan.glauber@caviumnetworks.com>, "kbuild-all@01.org" <kbuild-all@01.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>

On Mon, Feb 13, 2017 at 4:45 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 13 February 2017 at 16:24, Jan Glauber
> <jan.glauber@caviumnetworks.com> wrote:
>> On Sun, Feb 12, 2017 at 09:09:29AM +0800, kbuild test robot wrote:
>>> Hi Jan,
>>>
>>> [auto build test ERROR on linus/master]
>>> [also build test ERROR on v4.10-rc7 next-20170210]
>>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Jan-Glauber/Cavium-MMC-driver/20170206-214740
>>> config: arm64-allmodconfig (attached as .config)
>>> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>>> reproduce:
>>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # save the attached .config to linux build tree
>>>         make.cross ARCH=arm64
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    In file included from drivers/mmc/host/cavium-mmc.c:28:0:
>>>    drivers/mmc/host/cavium-mmc.h:41:7: warning: "CONFIG_MMC_CAVIUM_THUNDERX" is not defined [-Wundef]
>>>     #elif CONFIG_MMC_CAVIUM_THUNDERX
>>>           ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Hi Ulf,
>>
>> We are aware of this build error, the line above should be:
>> #elif IS_ENABLED(CONFIG_MMC_CAVIUM_THUNDERX)
>
> Please avoid using IS_ENABLED() - unless really needed.
>
> Doesn't "#ifdef" work here?
>

No, CONFIG_MMC_CAVIUM_THUNDERX is a tristate symbol and #ifdef won't
work for =m.

Ideally, the base driver would not have any such preprocessor checks at
all though, and just work either way. While I realize that octeon and thunderx
are mutually exclusive in practice, the patch as it is written here is somewhat
confusing as turning on both options (with COMPILE_TEST) will break
at least one of the two.

    Arnd
