From: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v5 03/12] mmc: sdhci-msm: add pltfm_data support to get
 clk-rates from DT
Date: Mon, 10 Oct 2016 16:30:09 +0530
Message-ID: <60fd3b94-866a-2198-b7c9-8ce607bec5b0@codeaurora.org>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
 <1475678440-3525-4-git-send-email-riteshh@codeaurora.org>
 <7e5c2bfe-0a67-71e2-d083-49d9a712482e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7e5c2bfe-0a67-71e2-d083-49d9a712482e-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

Thanks for the review. I will address your comments.
Responses inline.

--
Regards
Ritesh

On 10/10/2016 3:05 PM, Adrian Hunter wrote:
> On 05/10/16 17:40, Ritesh Harjani wrote:
>> This adds support for sdhc-msm controllers to get supported
>> clk-rates from DT. sdhci-msm would need it's own set_clock
>> ops to be implemented. For this, supported clk-rates needs
>> to be populated in sdhci_msm_pltfm_data.
>>
>> Signed-off-by: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  1 +
>>  drivers/mmc/host/sdhci-msm.c                       | 48 ++++++++++++++++++++++
>>  2 files changed, 49 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 485483a..6a83b38 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -17,6 +17,7 @@ Required properties:
>>  	"iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock) (required)
>>  	"core"	- SDC MMC clock (MCLK) (required)
>>  	"bus"	- SDCC bus voter clock (optional)
>> +- clk-rates: Array of supported GCC clock frequencies for sdhc, Units - Hz.
>>
>>  Example:
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 85ddaae..042ecb2 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -81,6 +81,8 @@ struct sdhci_msm_host {
>>  	struct clk *clk;	/* main SD/MMC bus clock */
>>  	struct clk *pclk;	/* SDHC peripheral bus clock */
>>  	struct clk *bus_clk;	/* SDHC bus voter clock */
>> +	u32 *clk_table;
>> +	int clk_table_sz;
>>  	struct mmc_host *mmc;
>>  	bool use_14lpp_dll_reset;
>>  };
>> @@ -582,6 +584,50 @@ static const struct sdhci_pltfm_data sdhci_msm_pdata = {
>>  	.ops = &sdhci_msm_ops,
>>  };
>>
>> +static int sdhci_msm_dt_get_array(struct device *dev, const char *prop_name,
>> +				u32 **table, int *size)
>
> It is nice to align to the open parenthesis.  Have a look at the checks from
> checkpatch --strict
Sure, will do that.

>
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	int count, ret;
>> +	u32 *arr;
>> +
>> +	count = of_property_count_elems_of_size(np, prop_name, sizeof(u32));
>
> Shouldn't this be of_property_count_u32_elems()
Yes, I will make the change.

>
>> +	if (count < 0) {
will change this to below to avoid empty property problem in DT which 
you mentioned in the next patch.
	if (count <= 0) {


>> +		dev_warn(dev, "%s: Invalid dt property, err(%d)\n",
>> +				prop_name, count);
>> +		return count;
>> +	}
>> +
>> +	arr = kcalloc(count, sizeof(*arr), GFP_KERNEL);
>> +	if (!arr)
>> +		return -ENOMEM;
>> +
>> +	ret = of_property_read_u32_array(np, prop_name, arr, count);
>> +	if (ret) {
>> +		kfree(arr);
>> +		dev_warn(dev, "%s Invalid dt array property, err(%d)\n",
>
> 'err(%d)' is an unusual style for printing error numbers.  'error %d' looks
> better.
Done.

>
> Also in some messages you have 'DT' and others 'dt'.  Also here it is '%s'
> but above '%s:', and some messages start with a lower case letter and some
> upper case.  Please try to make everything consistent.
>
Sure thanks.

>> +				prop_name, ret);
>> +		return ret;
>> +	}
>> +	*table = arr;
>> +	*size = count;
>> +	return 0;
>> +}
>> +
>> +void sdhci_msm_populate_dt(struct device *dev,
>> +						struct sdhci_msm_host *msm_host)
>
> Align to open parenthesis
Done.

>
>> +{
>> +	int table_sz = 0;
>> +	u32 *table = NULL;
>> +
>> +	if (sdhci_msm_dt_get_array(dev, "clk-rates", &table, &table_sz)) {
>> +		dev_warn(dev, "failed in DT parsing for supported clk-rates\n");
>> +		return;
>> +	}
>> +	msm_host->clk_table = table;
>> +	msm_host->clk_table_sz = table_sz;
>> +}
>> +
>>  static int sdhci_msm_probe(struct platform_device *pdev)
>>  {
>>  	struct sdhci_host *host;
>> @@ -608,6 +654,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>
>>  	sdhci_get_of_property(pdev);
>>
>> +	sdhci_msm_populate_dt(&pdev->dev, msm_host);
>> +
>>  	/* Setup SDCC bus voter clock. */
>>  	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
>>  	if (!IS_ERR(msm_host->bus_clk)) {
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
