From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-omap: Workaround errata regarding
 SDR104/HS200 tuning failures (i929)
Date: Mon, 7 Jan 2019 16:05:07 +0530
Message-ID: <88ee183f-7997-45dd-d5c3-fab615340b21@ti.com>
References: <20181211142253.23747-1-faiz_abbas@ti.com>
 <20181211142253.23747-3-faiz_abbas@ti.com>
 <CAPDyKFoi+NzS-d8E8oz-h_ab70jY7owwqPXsEoJWnRg6J2zcNA@mail.gmail.com>
 <CAOesGMjXcpY1c0Bpf2tMACVVXNW1W-Gp3HO+yjK8f6dQ-cp5bQ@mail.gmail.com>
 <20190102195626.GA2024@localhost.localdomain>
 <1d83e4df-78dc-10f6-f0c0-60e84b0e1094@ti.com>
 <CAOesGMiTmR6t2h1AzkPRWQon3onXKb5db5q6yVix9D5r+ExKfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOesGMiTmR6t2h1AzkPRWQon3onXKb5db5q6yVix9D5r+ExKfA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Eduardo Valentin <edubezval@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kishon <kishon@ti.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

Hi Olof,

On 05/01/19 6:27 AM, Olof Johansson wrote:
> On Wed, Jan 2, 2019 at 9:58 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>>
>> Hi Olof, Eduardo,
>>
>> On 03/01/19 1:26 AM, Eduardo Valentin wrote:
>>> On Wed, Jan 02, 2019 at 10:29:31AM -0800, Olof Johansson wrote:
>>>> Hi,
>>>>
>>>>
...
>>>>
>>>> This is throwing errors on builds of keystone_defconfig in next and mainline:
>>>>
>>>> http://arm-soc.lixom.net/buildlogs/next/next-20190102/buildall.arm.keystone_defconfig.log.passed
>>>>
>>>> WARNING: unmet direct dependencies detected for TI_SOC_THERMAL
>>>>   Depends on [n]: THERMAL [=y] && (ARCH_HAS_BANDGAP [=n] ||
>>>> COMPILE_TEST [=n]) && HAS_IOMEM [=y]
>>>>   Selected by [y]:
>>>>   - MMC_SDHCI_OMAP [=y] && MMC [=y] && MMC_SDHCI_PLTFM [=y] && OF [=y]
>>>>
>>>> So, thermal depends on ARCH_HAS_BANDGAP, which keystone doesn't provide.
>>>>
>>>> Selecting a major framework such as THERMAL from a driver config is
>>>> likely not the right solution anyway, especially since THERMAL does
>>>> provide stubbed out versions of the functions if it's not enabled.
>>>
>>> Yeah, that seams a bit up-side-down. Can you guys give a bit more of
>>> context? Why do you need the cpu thermal zone ? From patch description,
>>> looks like you want to have your own zone then apply different tuning
>>> values based on temperature (range?). Why do you need to mess up with
>>> cpu_thermal zone? Don't you have a bandgap in the mem controller for
>>> this application?
>>>
>>
>> Thats correct. We don't have a bandgap in the MMC controller and thus we
>> have to use the cpu one to measure temperature.
>>
>> THERMAL is critical for tuning. The interface is supposed to fail if we
>> can't get temperature. So IMO we should ensure that it is present.
>>
>> I can fix this by "select TI_SOC_THERMAL if ARCH_HAS_BANDGAP" if you
>> guys agree.
> 
> Building elaborate select statements is usually fragile, once
> dependencies for TI_SOC_THERMAL changes you need to come back here to
> fixup the select.
> 
> Supposedly this driver works on keystone (or does it?), it doesn't

Yes. This driver works on keystone.

> actually need TI_SOC_THERMAL for basic functionality beyond tuning?
> Or, at least, it needs to fall back to a reasonable behavior if it's
> unavailable on keystone.

The scenario is this. dra7 devices (omap2plus_defconfig) support tuning
which needs THERMAL and TI_SOC_THERMAL. Keystone devices don't need
thermal at all. The tuning part of the code will never be touched by the
keystone device.

In omap2plus_defconfig, THERMAL AND TI_SOC_THERMAL are modules by
default. I need them to be built-in because MMC is built-in.

> 
> Having the driver print a warning and refuse to tune to higher speeds
> is a reasonable way to do this, I think. That would carry to all
> platforms, i.e. even the ones who have TI_SOC_THERMAL and
> ARCH_HAS_BANDGAP, without adding the select.
> 

The MMC core today doesn't support a fallback to lower speeds when
tuning fails. The interface just fails. This means a bunch cards that
were working will now fail. Also, people building with olddefconfig will
get build errors because of THERMAL=m. Thus the Kconfig architecture
should automatically select the dependencies for SDHCI_OMAP in DRA7.

An "imply TI_SOC_THERMAL" is even better here. It won't force
TI_SOC_THERMAL for keystone and doesn't cause any warnings.

So I propose the following patch:

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e26b8145efb3..bc61eefcb695 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -978,7 +978,7 @@ config MMC_SDHCI_OMAP
        tristate "TI SDHCI Controller Support"
        depends on MMC_SDHCI_PLTFM && OF
        select THERMAL
-       select TI_SOC_THERMAL
+       imply TI_SOC_THERMAL
        help
--

Thanks,
Faiz
