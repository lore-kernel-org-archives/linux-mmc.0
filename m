From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 03/12] mmc: sdhci-msm: add pltfm_data support to get
 clk-rates from DT
Date: Tue, 11 Oct 2016 07:31:33 -0500
Message-ID: <CAL_JsqJbkDX3yAf6EGOcZiN=Fk-cz-7VeQxPK7_YOMyN7Pg0zA@mail.gmail.com>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
 <1475678440-3525-4-git-send-email-riteshh@codeaurora.org> <20161010125738.GA26940@rob-hp-laptop>
 <1a7f9c09-70a6-da2a-ca84-78a0331e3b4d@codeaurora.org> <CAL_JsqKfBjR9sTqzOMdM-ifDJiL_2RNrjAn3cvezvisLqZu-Wg@mail.gmail.com>
 <9db96ae7-9a5e-1494-2371-e5b346a08155@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <9db96ae7-9a5e-1494-2371-e5b346a08155@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, David Brown <david.brown@linaro.org>, Andy Gross <andy.gross@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, venkatg@codeaurora.org, Stephen Boyd <sboyd@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, pramod.gurav@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Oct 11, 2016 at 4:06 AM, Ritesh Harjani <riteshh@codeaurora.org> wrote:
> Hi Rob
>
>
> On 10/11/2016 12:59 AM, Rob Herring wrote:
>>
>> On Mon, Oct 10, 2016 at 11:07 AM, Ritesh Harjani <riteshh@codeaurora.org>
>> wrote:
>>>
>>> Hi Rob,
>>>
>>> Thanks for review.
>>>
>>> On 10/10/2016 6:27 PM, Rob Herring wrote:
>>>>
>>>>
>>>> On Wed, Oct 05, 2016 at 08:10:31PM +0530, Ritesh Harjani wrote:
>>>>>
>>>>>
>>>>> This adds support for sdhc-msm controllers to get supported
>>>>> clk-rates from DT. sdhci-msm would need it's own set_clock
>>>>> ops to be implemented. For this, supported clk-rates needs
>>>>> to be populated in sdhci_msm_pltfm_data.
>>>>>
>>>>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>>>>> ---
>>>>>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  1 +
>>>>>  drivers/mmc/host/sdhci-msm.c                       | 48
>>>>> ++++++++++++++++++++++
>>>>>  2 files changed, 49 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>>> b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>>> index 485483a..6a83b38 100644
>>>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>>>>> @@ -17,6 +17,7 @@ Required properties:
>>>>>         "iface" - Main peripheral bus clock (PCLK/HCLK - AHB Bus clock)
>>>>> (required)
>>>>>         "core"  - SDC MMC clock (MCLK) (required)
>>>>>         "bus"   - SDCC bus voter clock (optional)
>>>>> +- clk-rates: Array of supported GCC clock frequencies for sdhc, Units
>>>>> -
>>>>> Hz.
>>>>
>>>>
>>>>
>>>> Why can't some combination of assigned-clock-rates and querying the
>>>> clock provider for rates be used here?
>>>
>>>
>>> From what I understood, assigned-clock-rates would only work for setting
>>> some default clock rates for certain clocks by calling
>>> of_clk_set_defaults.
>>>
>>> Whereas the requirement here is -
>>> That since SDHC msm directly controls the clk(core clock) at source, it's
>>> sdhci-msm driver needs to know the supported clk-rates by the underlying
>>> platform to configure the nearest floor value supported on this platform
>>> (when the request arrives from the core layer to switch the clock).
>>
>>
>> Why does clk_round_rate not work for you? That will round down to the
>> nearest frequency supported.
>
> clk_round_rate will round off to nearest supported "ceil" frequency.
> But we require nearest rounded off "floor" frequency.

Then fix the clk framework to do what you want. This doesn't need to be in DT.

Rob
