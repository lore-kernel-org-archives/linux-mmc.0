From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v5 03/12] mmc: sdhci-msm: add pltfm_data support to get
 clk-rates from DT
Date: Mon, 10 Oct 2016 21:37:52 +0530
Message-ID: <1a7f9c09-70a6-da2a-ca84-78a0331e3b4d@codeaurora.org>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
 <1475678440-3525-4-git-send-email-riteshh@codeaurora.org>
 <20161010125738.GA26940@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20161010125738.GA26940@rob-hp-laptop>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, david.brown@linaro.org, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, sboyd@codeaurora.org, bjorn.andersson@linaro.org, pramod.gurav@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

Thanks for review.

On 10/10/2016 6:27 PM, Rob Herring wrote:
> On Wed, Oct 05, 2016 at 08:10:31PM +0530, Ritesh Harjani wrote:
>> This adds support for sdhc-msm controllers to get supported
>> clk-rates from DT. sdhci-msm would need it's own set_clock
>> ops to be implemented. For this, supported clk-rates needs
>> to be populated in sdhci_msm_pltfm_data.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
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
>
> Why can't some combination of assigned-clock-rates and querying the
> clock provider for rates be used here?
 From what I understood, assigned-clock-rates would only work for 
setting some default clock rates for certain clocks by calling
of_clk_set_defaults.

Whereas the requirement here is -
That since SDHC msm directly controls the clk(core clock) at source, 
it's sdhci-msm driver needs to know the supported clk-rates by the 
underlying platform to configure the nearest floor value supported on 
this platform (when the request arrives from the core layer to switch 
the clock).

Hence the table of clk-rates is provided for sdhci-msm.

>
> Minimally this would need unit suffix and either be made common or have
> a vendor prefix.
Sure will this work in that case - "qcom-clk-rates"

>
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
