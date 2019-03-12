From: =?utf-8?Q?Christoph_M=C3=BCllner?=
        <christoph.muellner@theobroma-systems.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: Add a new property
 disable-cqe-dcmd.
Date: Tue, 12 Mar 2019 15:46:44 +0100
Message-ID: <D7EF0176-0EBD-4401-83BE-E7F951F88CAA@theobroma-systems.com>
References: <20190307084329.25416-1-christoph.muellner@theobroma-systems.com>
 <37a96eda-196e-bacf-7ae2-5b9354c70273@intel.com>
 <3BCC2A27-3AF4-4E5E-BBD4-6A5B49831D3C@theobroma-systems.com>
 <4793843.T1TZ7EF8k3@phil>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4793843.T1TZ7EF8k3@phil>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, robh+dt@kernel.org, mark.rutland@arm.com, shawn.lin@rock-chips.com, ulf.hansson@linaro.org, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Michal Simek <michal.simek@xilinx.com>, Douglas Anderson <dianders@chromium.org>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Vicente Bergas <vicencb@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>, Randy Li <ayaka@soulik.info>, Tony Xie <tony.xie@rock-chips.com>, Ezequiel Garcia <ezequiel@collabora.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, Lin Huang <hl@rock-chips.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.orglinux-
List-Id: linux-mmc@vger.kernel.org


> On 12.03.2019, at 14:17, Heiko Stuebner <heiko@sntech.de> wrote:
> 
> Am Freitag, 8. März 2019, 14:10:45 CET schrieb Christoph Müllner:
>> 
>>> On 08.03.2019, at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> 
>>> On 7/03/19 10:43 AM, Christoph Muellner wrote:
>>>> This patch documents the new property disable-cqe-dcmd
>>>> for the Arasan eMMC 5.1 driver.
>>>> 
>>>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>>>> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
>>>> ---
>>>> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>>>> 1 file changed, 4 insertions(+)
>>>> 
>>>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>>> index 1edbb049cccb..ec699bf98b7c 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>>>> @@ -44,6 +44,10 @@ Optional Properties:
>>>>    properly. Test mode can be used to force the controller to function.
>>>>  - xlnx,int-clock-stable-broken: when present, the controller always reports
>>>>    that the internal clock is stable even when it is not.
>>>> +  - disable-cqe-dcmd: The eMMC 5.1 standard specifies direct commands (DCMDs)
>>>> +    as part of the command queue engine (CQE). On controllers with a CQHCI,
>>>> +    such as the Arasan eMMC 5.1 host controller, the driver has to enable DCMDs.
>>>> +    This is done unless disable-cqe-dcmd is specified.
> 
> This needs a rewording please. See below for hw-description vs. driver, so
> the description should be centered around why this is a property of the hw
> [like faulty controller implementation or whatever]

I understand, that you prefer a HW-specific name for a property
over one, that explains the actual effect.
However, using disable-<feature> (which is always a directive for the driver
and not a HW description) is not uncommon:

* disable-wp should be "no-wp-line-connection"
* disable-over-current -> "no-over-current-line-connection"
* srp-disable -> "not-existing-srp-implementation"
* ...

But I don't mind using something else.
Would "broken-cqe-dcmd" (like broken-cd or broken-flash-reset) be ok?
Or other suggestions?

Also I'd like to mention, that my first implementation was "supports-cqe-dcmd".
I guess that would be a good choice, if it would have been there
from the beginning. Introducing it now, would silently disable DCMD
for existing DTBs. Therefore I went on to "disable-cqe-dcmd".

> 
> 
>>> If "supports-cqe" is in mmc.txt, should "disable-cqe-dcmd" be there also?
>> 
>> The file mmc.txt says on top:
>> "These properties are common to multiple MMC host controllers".
>> As my patchset introduces "disable-cqe-dcmd" just for sdhci-of-arasan,
>> I would say it should not go into that file.
>> 
>> Also I wonder why "supports-cqe" is in mmc.txt, because
>> only sdhci-tegra.c is evaluating that property.
>> So I would expect it to be documented in
>> Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
>> 
>> However, I see that "disable-cqe-dcmd" could go into other drivers as well.
>> But is this enough to document it in mmc.txt?
> 
> Devicetree is always about describing the hardware capabilites and never
> about the actual nitty-gritty of driver implementation, aka it is not meant
> as a space for hardware-independent config-settings or such.
> 
> As for only tegra evaluating this, is probably because it is still so new, like
> january 2019 and Rob explicitly suggested it becoming common [0], which
> suggests that the disable-cqe-dcmds should probably also be common.

So mmc.txt lists "standardised" names for properties to reduce the risk
of having similar, but distinct names for different MMC drivers.
So whenever you want to introduce a new property for a driver,
check if there isn't already something defined in mmc.txt.

When seeing it this way, it clearly makes sense to have the property there.

Thanks,
Christoph
