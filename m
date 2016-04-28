From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: refactor set_clock callback
Date: Thu, 28 Apr 2016 16:24:32 +0800
Message-ID: <5721C8C0.40504@rock-chips.com>
References: <1461730486-8830-1-git-send-email-shawn.lin@rock-chips.com>
 <5721C308.6030607@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5721C308.6030607@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 2016/4/28 16:00, Adrian Hunter wrote:
>
> "refactor" typically means no change in behaviour.
> This looks like a fix e.g.
> "Fix set_clock when a phy is supported"

Thanks, will fix it.

>
> On 27/04/16 07:14, Shawn Lin wrote:
>> commit 61b914eb81f8 ("mmc: sdhci-of-arasan: add phy support for
>> sdhci-of-arasan") introduce phy support for arasan. According to
>> the vendor's databook, we should make sure the phy is in poweroff
>> status before we configure the clk stuff. Otherwise it may cause
>> some IO sample timing issues from the test. And we don't need this
>> extra operation while running in low perfermance mode since phy
>
> perfermance -> performance

will fix.

>
>> doesn't trigger sampling block.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/mmc/host/sdhci-of-arasan.c | 20 +++++++++++++++++++-
>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index 2e482b1..20b859e 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -55,8 +55,26 @@ static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
>>   	return freq;
>>   }
>>
>> +static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>> +	bool ctrl_phy = false;
>> +
>> +	if (clock > MMC_HIGH_52_MAX_DTR && (!IS_ERR(sdhci_arasan->phy)))
>> +		ctrl_phy = true;
>> +
>> +	if (ctrl_phy)
>> +		phy_power_off(sdhci_arasan->phy);
>> +
>> +	sdhci_set_clock(host, clock);
>> +
>> +	if (ctrl_phy)
>> +		phy_power_on(sdhci_arasan->phy);
>> +}
>> +
>>   static struct sdhci_ops sdhci_arasan_ops = {
>> -	.set_clock = sdhci_set_clock,
>> +	.set_clock = sdhci_arasan_set_clock,
>>   	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>>   	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
>>   	.set_bus_width = sdhci_set_bus_width,
>>
>
>
>
>


-- 
Best Regards
Shawn Lin
