From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: Re: [PATCH V3 2/3] dt-bindings: mmc: sdhci-msm: Add entries for
 passing load values
Date: Thu, 8 Nov 2018 19:43:00 +0530
Message-ID: <a0781e8c-2448-eecf-2736-150fa5ea8d4f@codeaurora.org>
References: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
 <1539004739-32060-3-git-send-email-vbadigan@codeaurora.org>
 <20181012145516.GA10205@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012145516.GA10205@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, evgreen@chromium.org, dianders@google.com, asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Vijay Viswanath <vviswana@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 10/12/2018 8:25 PM, Rob Herring wrote:
> On Mon, Oct 08, 2018 at 06:48:58PM +0530, Veerabhadrarao Badiganti wrote:
>> From: Vijay Viswanath <vviswana@codeaurora.org>
>>
>> The load a particular sdhc controller should request from a regulator
>> is device specific and hence each device should individually vote for
>> the required load.
>>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 502b3b8..cb22178 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -25,6 +25,10 @@ Required properties:
>>   	"xo"	- TCXO clock (optional)
>>   	"cal"	- reference clock for RCLK delay calibration (optional)
>>   	"sleep"	- sleep clock for RCLK delay calibration (optional)
>> +- qcom,<supply>-current-level-microamp - specifies load levels for supply during BUS_ON and
>> +					BUS_OFF states in power irq. Should be specified in
>> +					pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
>> +					Units uA.
> Seems like something that should be common?

Hi Rob,
Can you please little elaborate your comment?
Do mean this should be common for all vendors, not specific to qcom-mmc?


Thanks,
Veera
