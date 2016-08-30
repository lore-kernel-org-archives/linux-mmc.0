From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v4 3/9] mmc: sdhci-msm: add pltfm_data support to get
 clk-rates from DT
Date: Tue, 30 Aug 2016 19:42:59 +0530
Message-ID: <1a44bb54-d88c-737d-7fb1-e7c3597ac03b@codeaurora.org>
References: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org>
 <1472033024-14890-4-git-send-email-riteshh@codeaurora.org>
 <20160825222747.GU19826@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53461 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbcH3ONI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2016 10:13:08 -0400
In-Reply-To: <20160825222747.GU19826@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, bjorn.andersson@linaro.org, devicetree@vger.kernel.org

Hi Stephen,

On 8/26/2016 3:57 AM, Stephen Boyd wrote:
> On 08/24, Ritesh Harjani wrote:
>> This adds support for sdhc-msm controllers to get supported
>> clk-rates from DT. sdhci-msm would need it's own set_clock
>> ops to be implemented. For this, supported clk-rates needs
>> to be populated in sdhci_msm_pltfm_data.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> ---
>
> Please include the DT binding review list in binding updates.
>
>>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  1 +
>>  drivers/mmc/host/sdhci-msm.c                       | 60 ++++++++++++++++++++++
>>  2 files changed, 61 insertions(+)
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
>
> Why not use OPPv2 binding for this? We already have a way to
> express frequencies for devices with that binding, and we'll need
> to attach voltages to those frequencies at some point in the
> future if we want to handle DVFS on these devices.
>
OPPv2 may not work out in this case. This was also discussed at [1].
These clk-rates are not as per voltage points(or any OPP) but as per bus 
speed mode request from higher layer.

[1] - https://patchwork.kernel.org/patch/9204879/

Thanks
Ritesh
