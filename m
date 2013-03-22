From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH -next] mmc: wmt-sdmmc: remove unused variable in wmt_complete_data_request()
Date: Fri, 22 Mar 2013 12:38:17 -0400
Message-ID: <87li9fo0ee.fsf@octavius.laptop.org>
References: <CAPgLHd-7nVD3=83wpNtw1cBmkr+xs5iD7tuxZM+PdxWPLtwZsQ@mail.gmail.com>
	<1363061028.23051.1.camel@gitbox>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34010 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160999Ab3CVQiZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:38:25 -0400
In-Reply-To: <1363061028.23051.1.camel@gitbox> (Tony Prisk's message of "Tue,
	12 Mar 2013 17:03:48 +1300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Prisk <linux@prisktech.co.nz>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi,

On Tue, Mar 12 2013, Tony Prisk wrote:
> On Mon, 2013-03-11 at 22:36 +0800, Wei Yongjun wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> 
>> The variable 'mmc' is initialized but never used
>> otherwise, so remove the unused variable.
>> 
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> ---
>>  drivers/mmc/host/wmt-sdmmc.c | 2 --
>>  1 file changed, 2 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
>> index 154f0e8..41d5802 100644
>> --- a/drivers/mmc/host/wmt-sdmmc.c
>> +++ b/drivers/mmc/host/wmt-sdmmc.c
>> @@ -348,13 +348,11 @@ static void wmt_complete_data_request(struct wmt_mci_priv *priv)
>>  
>>  static irqreturn_t wmt_mci_dma_isr(int irq_num, void *data)
>>  {
>> -	struct mmc_host *mmc;
>>  	struct wmt_mci_priv *priv;
>>  
>>  	int status;
>>  
>>  	priv = (struct wmt_mci_priv *)data;
>> -	mmc = priv->mmc;
>>  
>>  	status = readl(priv->sdmmc_base + SDDMA_CCR) & 0x0F;
>>  
>> 
>
> Acked-by: Tony Prisk <linux@prisktech.co.nz>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
