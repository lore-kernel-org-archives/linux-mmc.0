From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v8 05/16] dt-bindings: sdhci-msm: Add xo_clock property
Date: Thu, 17 Nov 2016 06:11:05 +0530
Message-ID: <07895935-39af-5609-cf4b-2aee09974cab@codeaurora.org>
References: <1479312052-22396-1-git-send-email-riteshh@codeaurora.org>
 <1479312052-22396-6-git-send-email-riteshh@codeaurora.org>
 <20161116191335.GH25626@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20161116191335.GH25626@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, andy.gross@linaro.org, shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On 11/17/2016 12:43 AM, Stephen Boyd wrote:
> On 11/16, Ritesh Harjani wrote:
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 485483a..243c9f0 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -17,6 +17,7 @@ Required properties:
>>  	"iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock) (required)
>>  	"core"	- SDC MMC clock (MCLK) (required)
>>  	"bus"	- SDCC bus voter clock (optional)
>> +	"xo_clock" - TCXO clock (optional)
>
> I'd prefer we just call it "xo". We usually leave out _clk or
> _clock from clock names because it's redundant.
Ok. I will send patch 004(DT), 005(DT-documentation), 006(driver) & 
012(DT conflicts) again. Since these will be affected with above change.

>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
