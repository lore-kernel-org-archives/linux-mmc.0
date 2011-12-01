From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Remove old and misprototyped suspend operations
Date: Thu, 01 Dec 2011 13:08:37 -0500
Message-ID: <87zkfckvve.fsf@laptop.org>
References: <1321898451-5347-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4ED4F4C4.2020805@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50745 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755487Ab1LASIe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Dec 2011 13:08:34 -0500
In-Reply-To: <4ED4F4C4.2020805@samsung.com> (Jaehoon Chung's message of "Wed,
	30 Nov 2011 00:05:40 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-mmc@vger.kernel.org, patches@opensource.wolfsonmicro.com

Hi,

On Tue, Nov 29 2011, Jaehoon Chung wrote:
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> On 11/22/2011 03:00 AM, Mark Brown wrote:
>
>> Now that the driver is using dev_pm_ops the suspend operations in the
>> platform_driver structure won't get called so don't need to be there,
>> and certainly shouldn't be the same function as dev_pm_ops since the
>> signatures are different.
>> 
>> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> ---
>>  drivers/mmc/host/sdhci-s3c.c |    2 --
>>  1 files changed, 0 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
>> index 4cb272c..9a20d1f 100644
>> --- a/drivers/mmc/host/sdhci-s3c.c
>> +++ b/drivers/mmc/host/sdhci-s3c.c
>> @@ -647,8 +647,6 @@ static const struct dev_pm_ops sdhci_s3c_pmops = {
>>  static struct platform_driver sdhci_s3c_driver = {
>>  	.probe		= sdhci_s3c_probe,
>>  	.remove		= __devexit_p(sdhci_s3c_remove),
>> -	.suspend	= sdhci_s3c_suspend,
>> -	.resume	        = sdhci_s3c_resume,
>>  	.driver		= {
>>  		.owner	= THIS_MODULE,
>>  		.name	= "s3c-sdhci",

Thanks, pushed to mmc-next for 3.2 with Jaehoon's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
