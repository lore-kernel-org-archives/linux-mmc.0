From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Kconfig: Add dependency on GPIOLIB for MMC_SDHCI
Date: Thu, 27 Aug 2015 13:32:12 +0200
Message-ID: <CAPDyKFoPDMcO_19_pg7=aFUUCQrnxnoZD+YGpjYaBcRWu4ArJw@mail.gmail.com>
References: <6906e34b62f162018984a5fbd12b3ef6cd5e3a29.1438839562.git.michal.simek@xilinx.com>
	<CAPDyKFqgLonYZT86ixOAwJ3G5tsozxee6dEs+QRFYzwOWFUNNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33555 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbbH0LcO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2015 07:32:14 -0400
Received: by wicne3 with SMTP id ne3so952087wic.0
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2015 04:32:13 -0700 (PDT)
In-Reply-To: <CAPDyKFqgLonYZT86ixOAwJ3G5tsozxee6dEs+QRFYzwOWFUNNQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Scott Branden <sbranden@broadcom.com>, Weijun Yang <Weijun.Yang@csr.com>, Andrew Bresticker <abrestic@chromium.org>, Jean Delvare <jdelvare@suse.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, addy ke <addy.ke@rock-chips.com>, Stephen Boyd <sboyd@codeaurora.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Kevin Hao <haokexin@gmail.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>

On 25 August 2015 at 14:04, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 6 August 2015 at 07:39, Michal Simek <michal.simek@xilinx.com> wrote:
>> Add GPIOLIB dependency for MMC_SDHCI.
>>
>> Problem was observed after adding the patch
>> "mmc: sdhci-of-arasan: Call OF parsing for MMC"
>> (sha1: 16b23787fc709fe60c5d2bd05927b1a3da33d4e9) which calls
>> mmc_of_parse() -> mmc_gpiod_request_cd() (slot-gpio.c) which
>> calls devm_gpiod_get_index() which returns -ENOSYS.
>>
>> Error log:
>> sdhci-arasan ff160000.sdhci: parsing dt failed (4294967258)
>> sdhci-arasan: probe of ff160000.sdhci failed with error -38
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>
> Thanks, applied for next!

kbuild test robot reports a warning for this one, so I am dropping it
from my next branch.

-----
warning: (AKEBONO) selects MMC_SDHCI which has unmet direct
dependencies (MMC && HAS_DMA && GPIOLIB)
https://lists.01.org/pipermail/kbuild-all/2015-August/011824.html
-----

Perhaps we should just live with this kind of configuration problems
as this patch is trying to fix?
Looking into drivers in general I don't think we normally specify all
the Kconfig dependencies to be able to meet a successfully probe().
The GPIOLIB is just one thing out of many.

Or you have a better idea? :-)

Kind regards
Uffe
