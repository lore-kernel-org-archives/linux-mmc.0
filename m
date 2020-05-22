Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A99C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 15:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185392065F
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 15:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Wa5omr10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgEVPWx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 11:22:53 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4516 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729931AbgEVPWx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2020 11:22:53 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec7edf90006>; Fri, 22 May 2020 08:21:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 22 May 2020 08:22:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 22 May 2020 08:22:50 -0700
Received: from [10.2.164.184] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 May
 2020 15:22:49 +0000
Subject: Re: [PATCH v1] sdhci: tegra: Remove warnings about missing
 device-tree properties
To:     Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <b4eb368e-adc2-7b77-3ae9-fefdcfddaf3d@gmail.com>
 <11c93dac-f5ba-2193-6f44-63af27fdce09@nvidia.com>
 <aed72c87-0e16-6dea-a4e2-7fc6a97cd313@nvidia.com>
 <c7469c16-f6f1-f9c0-566f-3b1d3774f130@nvidia.com>
 <c712de1d-cfa4-2746-ec6b-54f318aeaac2@nvidia.com>
 <d2c71267-e696-c459-fbd6-dbb5fd312ed3@gmail.com>
 <CAPDyKFqdeGyQpXpM+xynd_rWbi0S6hCeQS1Dyiy6Hd2E_yfHpg@mail.gmail.com>
 <96f917a3-d822-1c36-d088-3e4a322c1761@nvidia.com>
 <20200522121357.GD2163848@ulmo>
 <2fa9db46-e310-dbbc-e1f7-f7058435a688@gmail.com>
 <20200522123437.GF2163848@ulmo>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <920b9fdb-4435-b0d1-3f54-08a8ce97946d@nvidia.com>
Date:   Fri, 22 May 2020 08:22:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522123437.GF2163848@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590160890; bh=IaZ9YffEFC3iYJrEkew1x31EbYlZVh1Qx3z9l03lEhg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Wa5omr10c19/wlHL3MOlHFnlPjIjZXK7v3lQ/1RxbzVk3DYBDGG6dPbRtK3fnZ8u3
         /YNjcea/RV3i2eo3JCJ56hxZlcS/R7h1gzT40T2+KJ/QJ+tzcADbMoqZbleWMZr4kK
         9gjWn/vyviBQEOiUXstY1Ch1IkcOF23QmiVmgUHrYsuV6xDrNo5rW7nVGH0c8pnEhE
         thAOqNtODTEAIDvbq7l4uwq69B2NwbLZsJJX8W2TbjR/amrwN998SBI6sDPAFNrdHp
         GO1zQHhFP7bOM/Ih8yrGHI+nOLE2n3ev3qZCKtmQFUQ4R0W3glI2HhhmSN7sMcWIe9
         8wmfWDk657PTA==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 5/22/20 5:34 AM, Thierry Reding wrote:
> On Fri, May 22, 2020 at 03:18:40PM +0300, Dmitry Osipenko wrote:
>> 22.05.2020 15:13, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> On Wed, May 20, 2020 at 09:09:33AM -0700, Sowjanya Komatineni wrote:
>>>> On 5/20/20 4:26 AM, Ulf Hansson wrote:
>>>>> On Wed, 20 May 2020 at 04:00, Dmitry Osipenko <digetx@gmail.com> wrot=
e:
>>>>>> 19.05.2020 23:44, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
>>>>>>> On 5/19/20 12:07 PM, Sowjanya Komatineni wrote:
>>>>>>>> On 5/19/20 11:41 AM, Sowjanya Komatineni wrote:
>>>>>>>>> On 5/19/20 11:34 AM, Sowjanya Komatineni wrote:
>>>>>>>>>> On 5/19/20 9:33 AM, Dmitry Osipenko wrote:
>>>>>>>>>>> 19.05.2020 19:24, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
>>>>>>>>>>>> On Tue, May 19, 2020 at 05:05:27PM +0300, Dmitry Osipenko wrot=
e:
>>>>>>>>>>>>> 19.05.2020 10:28, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>>>>>>>>>> On Sat, 16 May 2020 at 17:44, Dmitry Osipenko <digetx@gmail.=
com>
>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>> Several people asked me about the MMC warnings in the KMSG =
log and
>>>>>>>>>>>>>>> I had to tell to ignore them because these warning are
>>>>>>>>>>>>>>> irrelevant to
>>>>>>>>>>>>>>> pre-Tegra210 SoCs.
>>>>>>>>>>>>>> Why are the warnings irrelevant?
>>>>>>>>>>>>> That's what the DT binding doc says [1].
>>>>>>>>>>>>>
>>>>>>>>>>>>> [1]
>>>>>>>>>>>>> https://www.kernel.org/doc/Documentation/devicetree/bindings/=
mmc/nvidia%2Ctegra20-sdhci.txt
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Although, looking at the driver's code and TRM docs, it seems
>>>>>>>>>>>>> that all
>>>>>>>>>>>>> those properties are really irrelevant only to the older Terg=
a20
>>>>>>>>>>>>> SoC. So
>>>>>>>>>>>>> the binding doc is a bit misleading.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Nevertheless, the binding explicitly says that the properties=
 are
>>>>>>>>>>>>> optional, which is correct.
>>>>>>>>>>>> Optional only means that drivers must not fail if these proper=
ties
>>>>>>>>>>>> aren't found, it doesn't mean that the driver can't warn that =
they
>>>>>>>>>>>> are missing.
>>>>>>>>>>>>
>>>>>>>>>>>> Quite possibly the only reason why they were made optional is =
because
>>>>>>>>>>>> they weren't part of the bindings since the beginning. Anythin=
g added
>>>>>>>>>>>> to a binding after the first public release has to be optional=
 by
>>>>>>>>>>>> definition, otherwise DT ABI wouldn't be stable.
>>>>>>>>>>>>
>>>>>>>>>>>> I think these warnings were added on purpose, though I also se=
e that
>>>>>>>>>>>> there are only values for these in device tree for Tegra186 an=
d
>>>>>>>>>>>> Tegra194
>>>>>>>>>>>> but not Tegra210 where these should also be necessary.
>>>>>>>>>> dt binding doc we have is common for MMC, SD and SDIO of all Teg=
ras.
>>>>>>>>>> Its not mandatory to have both 3v3 and 1v8 in device tree as bas=
ed
>>>>>>>>>> on signal mode.
>>>>>>>>>>
>>>>>>>>>> As these driver strengths are SoC specific, they are part of Teg=
ra
>>>>>>>>>> SoC specific device tree where same values will be applicable to=
 all
>>>>>>>>>> Tegra SoC specific platforms.
>>>>>>>>>>
>>>>>>>>>> Based on interface usage on platform, we use one or both of them
>>>>>>>>>> like sdcard supports dual voltage and we use both 3V3 and 1V8 bu=
t if
>>>>>>>>>> same interface is used for WIFI SD we use 1V8 only.
>>>>>>>>>>
>>>>>>>>>> So made these dt properties as optional.
>>>>>>>>>>
>>>>>>>>>> Other reason they are optional is, Tegra210 and prior has drive
>>>>>>>>>> strength settings part of apb_misc and Tegra186 and later has dr=
iver
>>>>>>>>>> strengths part of SDMMC controller. So,
>>>>>>>>>>
>>>>>>>>>> - Pinctrls "sdmmc-3v3-drv" and "sdmmc-1v8-drv" for driver streng=
ths
>>>>>>>>>> are applicable for Tegra210 and prior.
>>>>>>>>>> - dt properties pad-autocal-pull-up/down-offset-1v8/3v3-timeout =
are
>>>>>>>>>> for T186 onwards for driver strengths
>>>>>>>>>>
>>>>>>>>>> Looks like dt binding doc need fix to clearly document these bas=
ed
>>>>>>>>>> on SoC or agree with Yaml we can conditionally specify pinctrl o=
r dt
>>>>>>>>>> properties based on SoC dependent.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>> Adding Sowjanya who wrote this code. Perhaps she can clarify w=
hy the
>>>>>>>>>>>> warnings were added. If these values /should/ be there on a su=
bset of
>>>>>>>>>>>> Tegra, then I think we should keep them, or add them again, bu=
t
>>>>>>>>>>>> perhaps
>>>>>>>>>>>> add a better way of identifying when they are necessary and wh=
en
>>>>>>>>>>>> it is
>>>>>>>>>>>> safe to work without them.
>>>>>>>>>>>>
>>>>>>>>>>>> That said, looking at those checks I wonder if they are perhap=
s just
>>>>>>>>>>>> wrong. Or at the very least they seem redundant. It looks to m=
e like
>>>>>>>>>>>> they can just be:
>>>>>>>>>>>>
>>>>>>>>>>>>       if (tegra_host->pinctrl_state_XYZ =3D=3D NULL) {
>>>>>>>>>>>>           ...
>>>>>>>>>>>>       }
>>>>>>>>>>>>
>>>>>>>>>>>> That !IS_ERR(...) doesn't seem to do anything. But in that cas=
e, it's
>>>>>>>>>>>> also obvious why we're warning about them on platforms where t=
hese
>>>>>>>>>>>> properties don't exist in DT.
>>>>>>>>>> As drive strengths are through dt properties for T186 and later =
and
>>>>>>>>>> thru pinctrl for T210 and prior, driver first checks for dt auto=
cal
>>>>>>>>>> timeout pull-up/down properties and if they are not found, it th=
en
>>>>>>>>>> checks for presence of pinctrl_state_xyx_drv only when valid
>>>>>>>>>> pinctrl_state_xyz is present.
>>>>>>>>>>
>>>>>>>>>> Driver expects either pinctrl or dt properties and shows warning
>>>>>>>>>> when neither of them are present as its mandatory to use fixed
>>>>>>>>>> driver strengths when auto calibration fails.
>>>>>>>>>>
>>>>>>>>>>       err =3D device_property_read_u32(host->mmc->parent,
>>>>>>>>>>               "nvidia,pad-autocal-pull-down-offset-3v3-timeout",
>>>>>>>>>>               &autocal->pull_down_3v3_timeout);
>>>>>>>>>>       if (err) {
>>>>>>>>>>           if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
>>>>>>>>>>               (tegra_host->pinctrl_state_3v3_drv =3D=3D NULL))
>>>>>>>>>>               pr_warn("%s: Missing autocal timeout 3v3-pad drvs\=
n",
>>>>>>>>>>                   mmc_hostname(host->mmc));
>>>>>>>>>>           autocal->pull_down_3v3_timeout =3D 0;
>>>>>>>>>>       }
>>>>>>>>>>
>>>>>>>>>>>> So I think we either need to add those values where appropriat=
e so
>>>>>>>>>>>> that
>>>>>>>>>>>> the warning doesn't show, or we need to narrow down where they=
 are
>>>>>>>>>>>> really needed and add a corresponding condition.
>>>>>>>>>>>>
>>>>>>>>>>>> But again, perhaps Sowjanya can help clarify if these really a=
re only
>>>>>>>>>>>> needed on Tegra210 and later or if these also apply to older c=
hips.
>>>>>>>>>>> Either way will be cleaner to convert the DT binding to YAML ra=
ther
>>>>>>>>>>> than
>>>>>>>>>>> clutter the driver, IMO.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>> Auto calibration is present from Tegra30 onward and looking into
>>>>>>>>> change where autocalibration was added to sdhci driver somehow it=
 was
>>>>>>>>> enabled only for T30/T210/T186/T194.
>>>>>>>>>
>>>>>>>>> tegra_sdhci_parse_pad_autocal_dt() was added when auto-calibratio=
n
>>>>>>>>> was added to driver and I see this dt parse is being done
>>>>>>>>> irrespective of NVQUIRK_HAS_PADCALIB quirk so even on platforms
>>>>>>>>> without auto cal enabled in driver, these messages shows up.
>>>>>>>>>
>>>>>>>>> This should be fixed in driver to allow
>>>>>>>>> tegra_sdhci_parse_pad_autocal_dt() only when NVQUIRK_HAS_PADCALIB=
 is
>>>>>>>>> set to avoid dt parsing to happen on platforms that don't have au=
to
>>>>>>>>> cal enabled.
>>>>>>>> Warning on missing drive strengths when auto cal is enabled should=
 be
>>>>>>>> present as we should switch to fixed recommended drive strengths w=
hen
>>>>>>>> auto cal fails.
>>>>>>>>
>>>>>>>> So probably proper fix should be
>>>>>>>>
>>>>>>>> - allow tegra_sdhci_parse_pad_autocal_dt() only when
>>>>>>>> NVQUIRK_HAS_PADCALIB is set
>>>>>>>>
>>>>>>>> - current driver sets NVQUIRK_HAS_PADCALIB for T30 as well so need=
 to
>>>>>>>> add pinctrls "sdmmc-3v3-drv" and "sdmmc-1v8-drv" to Tegra30 device=
 tree.
>>>>>>> [Correction] T30 has same drive strengths to use irrespective of si=
gnal
>>>>>>> voltage and it doesn't have pad control. So for T3- we can update d=
evice
>>>>>>> tree to specify "default" pinctrl with drvup/dn settings.
>>>>>>>> - Keep warning message of missing auto cal timeouts as its mandato=
ry
>>>>>>>> to use fixed recommended driver strengths when auto cal fails.
>>>>>>>>
>>>>>>> Regarding warnings, I guess simpler and easy fix is to remove warni=
ng
>>>>>>> message on missing 3v3/1v8 drive strengths as pinctrl/dt properties=
 were
>>>>>>> already added for T210/186/194 where we need and old device tree do=
n't
>>>>>>> have them but the case where auto cal can fail is very rare.
>>>>>>>
>>>>>>> Otherwise should update driver to allow
>>>>>>> tegra_sdhci_parse_pad_autocal_dt() only when NVQUIRK_HAS_PADCALIB i=
s set
>>>>>>> and also within tegra_sdhci_parse_pad_autocal_dt() show warning of
>>>>>>> missing 3v3/1v8 settings only when NVQUIRK_NEEDS_PAD_CONTROL is set=
.
>>>>>>>
>>>>>>> Thierry, please suggest if you prefer to removing warnings or fix d=
river
>>>>>>> to show warning based on PADCALIB and PAD_CONTROL quirks.
>>>>>> The SDIO PINCTRL drive-strengths are usually a part of the board's
>>>>>> default PINCTRL state, which is either preset by bootloader or by
>>>>>> PINCTRL driver early at a boot time.
>>>>>>
>>>>>> The SDIO drive-strengths values should be board-specific and not
>>>>>> SoC-specific because they should depend on the electrical properties=
 of
>>>>>> the board, IIUC.
>>>> Drive strengths we program here when auto calibration fails are recomm=
ended
>>>> values based on pre-SI circuit analysis and characterized across PVT.
>>>>
>>>> So,=C2=A0 these fail safe values are same for all boards of specific S=
oC as all
>>>> platform designs follow the design guidelines.
>>>>
>>>>>> If the SDIO PINCTRL states are mandatory for the SDHCI nodes in the
>>>>>> device-trees, then the DT binding is wrong since it says that all
>>>>>> properties are optional. But I think that the current binding is oka=
y,
>>>>>> since today SDHCI PINCTRL drive-strengths are specified implicitly i=
n
>>>>>> the device-trees, and thus, there is no real need to emit the noisy
>>>>>> warnings in this case.
>>>>> For now I will keep $subject patch applied, but please tell me if I
>>>>> should drop it so we can start over.
>>>>>
>>>>> In any case, I would appreciate it if someone could have a stab at
>>>>> converting sdhci and tegra DT bindings to yaml.
>>>>>
>>>>> Kind regards
>>>>> Uffe
>>>> HI Uffe,
>>>>
>>>> Please drop $subject patch. Will send patch that allows parsing for th=
ese
>>>> properties only for SoC where auto cal is enabled as that's where driv=
er
>>>> needs these properties.
>>>>
>>>> So with this fix, warning will not show up on systems where autocal is=
 not
>>>> enabled.
>>> Yes, I think that's a better option. Have we ensured that on all system=
s
>>> where autocal is enabled these values are part of the device tree? Just
>>> making sure that we're not going to have some generation still spit out
>>> these warnings because we forgot to update the device tree.
>>>
>>> For example I see that we set NVQUIRK_HAS_PADCALIB but I don't see thes=
e
>>> properties being set in arch/arm/boot/dts/tegra30.dtsi. Can you add a
>>> patch that also adds the properties for Tegra30?
>> I don't see the warnings on T30 using Sowjanya's patch which checks for
>> NVQUIRK_NEEDS_PAD_CONTROL and not NVQUIRK_HAS_PADCALIB.

Both of these quirks are different.

PADCALIB is for auto calibration support.

NEEDS_PAD_CONTROL is for SoC having separate 3V3 and 1V8 pads where they=20
have pad state selection and also diff drive strengths apply based on=20
3V3 and 1V8 which are used only when auto cal is not used/failed.

So, above warnings are applicable only for SoC having separate pad=20
controls. Other SoC which don't have separate pads use default drive=20
strengths.

> Yeah, I noticed that too when looking at Sowjanya's patch. The fact that
> we have two of these quirks is somewhat confusing to me. Perhaps we can
> add a comment near their definition to clarify what their purpose is?
>
> Thierry
