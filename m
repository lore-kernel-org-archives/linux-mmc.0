From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 4/9] mmc: omap_hsmmc: use devm_request_mem_region
Date: Fri, 21 Mar 2014 21:57:52 +0530
Message-ID: <532C6888.5090904@ti.com>
References: <1395404448-30030-2-git-send-email-afenkart@gmail.com> <1395418658-2375-1-git-send-email-balajitk@ti.com> <1395418658-2375-5-git-send-email-balajitk@ti.com> <20140321161844.GK12310@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46373 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057AbaCUQ14 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Mar 2014 12:27:56 -0400
In-Reply-To: <20140321161844.GK12310@saruman.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balbi@ti.com
Cc: linux-mmc@vger.kernel.org, chris@printf.net, linux-omap@vger.kernel.org

On Friday 21 March 2014 09:48 PM, Felipe Balbi wrote:
> On Fri, Mar 21, 2014 at 09:47:33PM +0530, Balaji T K wrote:
>> With devm_request_mem_region conversion release_mem_region can be
>> removed in clean up path
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> ---
>>   drivers/mmc/host/omap_hsmmc.c |   11 ++---------
>>   1 files changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 8e35a6e..9952673 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1881,7 +1881,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>>   	if (res == NULL || irq < 0)
>>   		return -ENXIO;
>>
>> -	res = request_mem_region(res->start, resource_size(res), pdev->name);
>> +	res = devm_request_mem_region(&pdev->dev, res->start,
>> +					resource_size(res), pdev->name);
>
> while at that, why don't you switch over to devm_ioremap_resource()
> already ?

I can't do that because of 0x100 reg_offset on OMAP4+ and am335x+

Thanks and Regards,
Balaji T K
