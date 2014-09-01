From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [ulf.hansson-mmc:next 62/67] drivers/mmc/host/sdhci.c:1199:4:
 error: 'mmc' undeclared
Date: Mon, 1 Sep 2014 09:32:29 +0200
Message-ID: <CAPDyKFo4Xe-rvM0J-Jp3Tu1TzXgfmFBfNMtxAUm1gENy8tnj0g@mail.gmail.com>
References: <54007fae.5BYLcypTZgZbcj+t%fengguang.wu@intel.com>
	<20140901024022.GA24746@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:35631 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbaIAHcb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Sep 2014 03:32:31 -0400
Received: by mail-la0-f53.google.com with SMTP id s18so5665589lam.12
        for <linux-mmc@vger.kernel.org>; Mon, 01 Sep 2014 00:32:30 -0700 (PDT)
In-Reply-To: <20140901024022.GA24746@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 1 September 2014 04:40, Dong Aisheng <b29396@freescale.com> wrote:
> Hi Ulf,
>
> On Fri, Aug 29, 2014 at 09:27:10PM +0800, kbuild test robot wrote:
>> tree:   git://git.linaro.org/people/ulf.hansson/mmc next
>> head:   1a3c4f637e87dbdda6000b5d5cd9b590d3ec6f46
>> commit: cdfd9a2374ab63189ddeb5bf456bd3418ec559ec [62/67] mmc: sdhci: add platfrom get_max_timeout_count hook
>> config: make ARCH=x86_64 allmodconfig
>>
>> Note: the ulf.hansson-mmc/next HEAD 1a3c4f637e87dbdda6000b5d5cd9b590d3ec6f46 builds fine.
>>       It only hurts bisectibility.
>>
>> All error/warnings:
>>
>>    drivers/mmc/host/sdhci.c: In function 'sdhci_set_clock':
>> >> drivers/mmc/host/sdhci.c:1199:4: error: 'mmc' undeclared (first use in this function)
>>        mmc->max_busy_timeout =
>>        ^
>>    drivers/mmc/host/sdhci.c:1199:4: note: each undeclared identifier is reported only once for each function it appears in
>>
>> vim +/mmc +1199 drivers/mmc/host/sdhci.c
>>
>>   1193
>>   1194        clock_set:
>>   1195                if (real_div) {
>>   1196                        host->mmc->actual_clock = (host->max_clk * clk_mul) / real_div;
>>   1197                        if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK) {
>>   1198                                host->timeout_clk = host->mmc->actual_clock / 1000;
>> > 1199                                mmc->max_busy_timeout =
>>   1200                                                host->ops->get_max_timeout_count ?
>>   1201                                                host->ops->get_max_timeout_count(host) :
>>   1202                                                1 << 27;
>>
>
> Sorry for this bisect issue.
> Can you squash the following changes into the original commit to fix it?
>
> commit 94c10a5d2e78f7dddb67e0881799448ed5d650d3
> Author: Dong Aisheng <b29396@freescale.com>
> Date:   Mon Sep 1 10:33:16 2014 +0800
>
>     mmc: sdhci: fix bisect issue
>
>     Signed-off-by: Dong Aisheng <b29396@freescale.com>

Hi Dong,

Thanks for fix, I have squashed it into the original commit.

Additionally, while rebasing the branch the last patch in this series
hit a merge conflict, but managed to fix that myself. Still you may
want to have a look at the end result to verify I didn't screw up.

Kind regards
Uffe
