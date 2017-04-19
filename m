From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 07/25] mmc: sdhci-pci: Use ACPI DSM to get driver strength
 for some Intel devices
Date: Wed, 19 Apr 2017 11:50:54 +0300
Message-ID: <47372fbd-9c16-725a-7f25-97481f09a6eb@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
 <1490032253-6030-8-git-send-email-adrian.hunter@intel.com>
 <20170404084847.GB1439@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29945 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761071AbdDSI4k (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Apr 2017 04:56:40 -0400
In-Reply-To: <20170404084847.GB1439@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

On 04/04/17 11:48, Wolfram Sang wrote:
> Hi Adrian,
> 
> On Mon, Mar 20, 2017 at 07:50:35PM +0200, Adrian Hunter wrote:
>> Make use  of an Intel ACPI _DSM that provides eMMC driver strength.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> This is an interesting patch for me because it seems I have to deal with
> drive-strength soon, as well, for the SDHI driver. You basically fall
> back here to simply read the drive strength value from ACPI, right?

Yes, it is a single value.  I did not design the _DSM, it was a preexisting
method.

>                                                                     So,
> do you think it makes sense then to have a similar encoded value from DT
> (maybe "mmc-fixed-driver-type-<n>" with n=0..4)?

The _DSM, being a device-specific method does not have to support different
devices with different requirements whereas DT does.

>                                                  This is a largely
> reduced encoding of what you proposed in 2015 [1] but may be more
> pragmatic for soldered on-board devices working on their max speeds with
> fixed voltages and frequencies? Or did I get something wrong?

What I proposed was being forced on me by the requirement to provide a
solution that could meet any conceivable need.  That gets over-complicated.

But as you say, in practice people are probably only interested in providing
one value for the max speed / frequency.

> 
> Thanks,
> 
>    Wolfram
> 
> [1] https://lkml.org/lkml/2015/2/16/273
> 
> 

