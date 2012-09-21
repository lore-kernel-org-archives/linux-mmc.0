From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Fri, 21 Sep 2012 13:36:12 -0500
Message-ID: <6A474F70-46DB-43ED-92C0-5D111AA64D48@kernel.crashing.org>
References: <1348223135-6435-1-git-send-email-r66093@freescale.com> <m3y5k3e4tq.fsf@pullcord.laptop.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50997 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757577Ab2IUSg3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Sep 2012 14:36:29 -0400
In-Reply-To: <m3y5k3e4tq.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: r66093@freescale.com, linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Shaohui Xie <Shaohui.Xie@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>


On Sep 21, 2012, at 11:08 AM, Chris Ball wrote:

> Hi,
> 
> On Fri, Sep 21 2012, r66093@freescale.com wrote:
>> --- a/drivers/mmc/host/sdhci-of-esdhc.c
>> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>> @@ -143,6 +143,35 @@ static void esdhc_of_resume(struct sdhci_host *host)
>> }
>> #endif
>> 
>> +static const u32 non_cmd23_processor_table[] = {
>> +	/* P1020 Dual/Single core */
>> +	0x80EC00, 0x80E400, 0x80ED00, 0x80E500,
>> +	/* P1021 Dual/Single core */
>> +	0x80EC01, 0x80E401, 0x80ED01, 0x80E501,
>> +	/* P1022 Dual/Single core */
>> +	0x80EE00, 0x80E600, 0x80EF00, 0x80E700,
>> +	/* P1024 Dual/Single core */
>> +	0x80EC02, 0x80E402, 0x80ED02, 0x80E502,
>> +	/* P1025 Dual/Single core */
>> +	0x80EC03, 0x80E403, 0x80ED03, 0x80E503,
>> +	/* P4080 and P4040 */
>> +	0x820000, 0x820800, 0x820100, 0x820900
> 
> I don't see how this method improves on either of the previous two we've
> discussed.  If anything, Kumar's suggested method seems better than this
> one:  it detected the MMC IP revision, which I'd expect to be more
> reliable than building a list of which SoCs contain that IP.
> 
> Why is this better than using DT or detecting the MMC revision?
> 
> Thanks,

I feel like I missed this patch, but I'd rather we go with the version I sent since the # of IP versions we have is 3 or 4, instead of the 30 or 40 SoCs we have.

- k