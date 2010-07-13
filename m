From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Subject: Re: [PATCH] tmio_mmc: Revise a limit of the data size
Date: Tue, 13 Jul 2010 11:32:33 +0900
Message-ID: <4C3BD041.3020705@renesas.com>
References: <4C33DFF0.3040804@renesas.com>
 <20100708144647.1e77364b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.renesas.com ([202.234.163.13]:59177 "EHLO
	mail03.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752351Ab0GMCdp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jul 2010 22:33:45 -0400
In-reply-to: <20100708144647.1e77364b.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Andrew

Andrew Morton wrote:
> On Wed, 07 Jul 2010 11:01:20 +0900
> Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:
> 
>> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
>> ---
>>  drivers/mmc/host/tmio_mmc.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
>> index ee7d0a5..cac1c97 100644
>> --- a/drivers/mmc/host/tmio_mmc.c
>> +++ b/drivers/mmc/host/tmio_mmc.c
>> @@ -661,7 +661,7 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
>>  		 data->blksz, data->blocks);
>>
>>  	/* Hardware cannot perform 1 and 2 byte requests in 4 bit mode */
>> -	if (data->blksz < 4 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
>> +	if (data->blksz < 2 && host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
>>  		pr_err("%s: %d byte block unsupported in 4 bit mode\n",
>>  		       mmc_hostname(host->mmc), data->blksz);
>>  		return -EINVAL;
> 
> Again, please provide a suitable description for this change.
I think the data size is not limited by MMC_BUS_WIDTH_x.
I confirmed that data transmission of 2Byte was performed without a problem.

Thanks,
Goda

