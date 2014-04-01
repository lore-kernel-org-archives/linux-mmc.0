From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 1/6] mmc: sh-mmcif: print bus clock rate on probe
Date: Tue, 01 Apr 2014 12:37:08 +0100
Message-ID: <533AA4E4.5070805@codethink.co.uk>
References: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk> <1396347954-13740-2-git-send-email-ben.dooks@codethink.co.uk> <5193000.YsnDiAM2O1@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <5193000.YsnDiAM2O1@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk
List-Id: linux-mmc@vger.kernel.org

On 01/04/14 12:08, Laurent Pinchart wrote:
> Hi Ben,
>
> Thank you for the patch.
>
> On Tuesday 01 April 2014 11:25:49 Ben Dooks wrote:
>> Add a print to show the host-bus clock rate for mmcif on probe to allow
>> easy check on what clock rate the bus clock is at.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   drivers/mmc/host/sh_mmcif.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
>> index e8713d7..c48df98 100644
>> --- a/drivers/mmc/host/sh_mmcif.c
>> +++ b/drivers/mmc/host/sh_mmcif.c
>> @@ -1477,7 +1477,8 @@ static int sh_mmcif_probe(struct platform_device
>> *pdev)
>>
>>   	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
>>
>> -	dev_info(&pdev->dev, "driver version %s\n", DRIVER_VERSION);
>> +	dev_info(&pdev->dev, "driver version %s, clock rate %ldMHz\n",
>> +		 DRIVER_VERSION, clk_get_rate(host->hclk) / 1000000);
>>   	dev_dbg(&pdev->dev, "chip ver H'%04x\n",
>>   		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
>>   	return ret;
>
> Given that DRIVER_VERSION is defined as "2010-04-28", I'd take this as an
> opportunity to remove it completely. You could combine the dev_info and
> dev_dbg message into something similar to

Ok, changed to use this.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
