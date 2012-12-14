From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci: update signal voltage switch code
Date: Fri, 14 Dec 2012 23:32:05 +0800
Message-ID: <CADz5_gKkybVUU9R8gKiDSotNWHdb5buQbvoZT6ghFKy1eDkF-Q@mail.gmail.com>
References: <1355482438-16836-1-git-send-email-kliu5@marvell.com>
	<1355482438-16836-4-git-send-email-kliu5@marvell.com>
	<CA+20K0B02KJeJZ54j3DqzstWUO2B_CiUBd0+9NCr-=ZxX2YMCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57528 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955Ab2LNPcH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 10:32:07 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so1559725wey.19
        for <linux-mmc@vger.kernel.org>; Fri, 14 Dec 2012 07:32:05 -0800 (PST)
In-Reply-To: <CA+20K0B02KJeJZ54j3DqzstWUO2B_CiUBd0+9NCr-=ZxX2YMCQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, johan.rudholm@stericsson.com, per.forlin@stericsson.com, ulf.hansson@linaro.org, fredrik.soderstedt@stericsson.com, dsd@laptop.org, leafy.myeh@allwinnertech.com, subhashj@codeaurora.org, prakity@nvidia.com, zhangfei.gao@gmail.com, haojian.zhuang@gmail.com, cxie4@marvell.com

2012/12/14 Johan Rudholm <jrudholm@gmail.com>:
> Hi Kevin,
>
> 2012/12/14 Kevin Liu <kliu5@marvell.com>:
>> The protocal related code is moved to core stack. So update the host
>> driver accordingly.
>>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> ---
>>  drivers/mmc/host/sdhci.c |  188 +++++++++++++++++++---------------------------
>>  1 files changed, 77 insertions(+), 111 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 6f0bfc0..d19b2aa 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>
> ...
>
>> +static int sdhci_card_busy(struct mmc_host *mmc)
>> +{
>> +       struct sdhci_host *host = mmc_priv(mmc);
>> +       u32 present_state;
>> +
>> +       /* Check whether DAT[3:0] is 0000 */
>> +       present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
>> +
>> +       return !(present_state & SDHCI_DATA_LVL_MASK);
>> +}
>> +
>
> I'm not that familiar with SDHCI, but don't you need some calls to
> sdhci_runtime_pm_get / put here?
>

Oh, yes. I will add this.

Thanks
Kevin
