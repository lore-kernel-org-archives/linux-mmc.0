From: =?utf-8?Q?Christoph_M=C3=BCllner?=
        <christoph.muellner@theobroma-systems.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: Add a new property
 disable-cqe-dcmd.
Date: Fri, 8 Mar 2019 14:10:45 +0100
Message-ID: <3BCC2A27-3AF4-4E5E-BBD4-6A5B49831D3C@theobroma-systems.com>
References: <20190307084329.25416-1-christoph.muellner@theobroma-systems.com>
 <20190307084329.25416-2-christoph.muellner@theobroma-systems.com>
 <37a96eda-196e-bacf-7ae2-5b9354c70273@intel.com>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <37a96eda-196e-bacf-7ae2-5b9354c70273@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, Heiko Stuebner <heiko@sntech.de>, shawn.lin@rock-chips.com, ulf.hansson@linaro.org, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Michal Simek <michal.simek@xilinx.com>, Douglas Anderson <dianders@chromium.org>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Vicente Bergas <vicencb@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>, Randy Li <ayaka@soulik.info>, Tony Xie <tony.xie@rock-chips.com>, Ezequiel Garcia <ezequiel@collabora.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, Lin Huang <hl@rock-chips.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchi
List-Id: linux-mmc@vger.kernel.org


> On 08.03.2019, at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
> On 7/03/19 10:43 AM, Christoph Muellner wrote:
>> This patch documents the new property disable-cqe-dcmd
>> for the Arasan eMMC 5.1 driver.
>> 
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
>> ---
>> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>> 1 file changed, 4 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index 1edbb049cccb..ec699bf98b7c 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -44,6 +44,10 @@ Optional Properties:
>>     properly. Test mode can be used to force the controller to function.
>>   - xlnx,int-clock-stable-broken: when present, the controller always reports
>>     that the internal clock is stable even when it is not.
>> +  - disable-cqe-dcmd: The eMMC 5.1 standard specifies direct commands (DCMDs)
>> +    as part of the command queue engine (CQE). On controllers with a CQHCI,
>> +    such as the Arasan eMMC 5.1 host controller, the driver has to enable DCMDs.
>> +    This is done unless disable-cqe-dcmd is specified.
> 
> If "supports-cqe" is in mmc.txt, should "disable-cqe-dcmd" be there also?

The file mmc.txt says on top:
"These properties are common to multiple MMC host controllers".
As my patchset introduces "disable-cqe-dcmd" just for sdhci-of-arasan,
I would say it should not go into that file.

Also I wonder why "supports-cqe" is in mmc.txt, because
only sdhci-tegra.c is evaluating that property.
So I would expect it to be documented in
Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt

However, I see that "disable-cqe-dcmd" could go into other drivers as well.
But is this enough to document it in mmc.txt?
