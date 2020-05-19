Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A25C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 18:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2D0207E8
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 18:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Yq5wHiBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgESSeS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 14:34:18 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2156 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSeS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 14:34:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec4261b0000>; Tue, 19 May 2020 11:31:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 May 2020 11:34:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 May 2020 11:34:17 -0700
Received: from [10.2.164.184] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 May
 2020 18:34:17 +0000
Subject: Re: [PATCH v1] sdhci: tegra: Remove warnings about missing
 device-tree properties
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200516154314.14769-1-digetx@gmail.com>
 <CAPDyKFo_Xp-zipqE26iMv4CFwUoMCQZy3Zr63Cp=uzePgWX7BA@mail.gmail.com>
 <b634e7a5-9a30-3bd1-126d-be62e4dd73e1@gmail.com>
 <20200519162444.GD2113674@ulmo>
 <b4eb368e-adc2-7b77-3ae9-fefdcfddaf3d@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <11c93dac-f5ba-2193-6f44-63af27fdce09@nvidia.com>
Date:   Tue, 19 May 2020 11:34:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b4eb368e-adc2-7b77-3ae9-fefdcfddaf3d@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589913115; bh=5KWFwdYOoMqfK+gO+F6WRRcLXY6+E6LwiwOO0clvCQU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Yq5wHiBBbPDT7P4f8ego6ZzS3IkPhzFzLIZ8CUYy3RzgG7zraz7NBjEeQh9W5x/Z6
         8Bvz6vZBV7AOsC6QUIc0DRI135Lq5hSNcIsTwGxmSabiPsJRav91kfuoTGepsZ9RH7
         sd4w6AbKdv0i0GvZBn/Ug4AsqwRSyNZI5H2H22NX2nu46P64Cqc+53I/vpPXHIbM7O
         kTkW7pRRxo6OVrRqlv14gQfLfr8luxtGMxo4xy9OgBxehdwzG6qMaKwK67l1QFDySt
         X2bM2VrTylkpP6gXXSnGqpGiSZnSy4M/mQF3wj9ptQU3zf1Bb9R7ISub2XynKLaqgk
         9OZ6GrffZ6Aaw==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 5/19/20 9:33 AM, Dmitry Osipenko wrote:
> 19.05.2020 19:24, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On Tue, May 19, 2020 at 05:05:27PM +0300, Dmitry Osipenko wrote:
>>> 19.05.2020 10:28, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> On Sat, 16 May 2020 at 17:44, Dmitry Osipenko <digetx@gmail.com> wrote=
:
>>>>> Several people asked me about the MMC warnings in the KMSG log and
>>>>> I had to tell to ignore them because these warning are irrelevant to
>>>>> pre-Tegra210 SoCs.
>>>> Why are the warnings irrelevant?
>>> That's what the DT binding doc says [1].
>>>
>>> [1]
>>> https://www.kernel.org/doc/Documentation/devicetree/bindings/mmc/nvidia=
%2Ctegra20-sdhci.txt
>>>
>>> Although, looking at the driver's code and TRM docs, it seems that all
>>> those properties are really irrelevant only to the older Terga20 SoC. S=
o
>>> the binding doc is a bit misleading.
>>>
>>> Nevertheless, the binding explicitly says that the properties are
>>> optional, which is correct.
>> Optional only means that drivers must not fail if these properties
>> aren't found, it doesn't mean that the driver can't warn that they
>> are missing.
>>
>> Quite possibly the only reason why they were made optional is because
>> they weren't part of the bindings since the beginning. Anything added
>> to a binding after the first public release has to be optional by
>> definition, otherwise DT ABI wouldn't be stable.
>>
>> I think these warnings were added on purpose, though I also see that
>> there are only values for these in device tree for Tegra186 and Tegra194
>> but not Tegra210 where these should also be necessary.

dt binding doc we have is common for MMC, SD and SDIO of all Tegras. Its=20
not mandatory to have both 3v3 and 1v8 in device tree as based on signal=20
mode.

As these driver strengths are SoC specific, they are part of Tegra SoC=20
specific device tree where same values will be applicable to all Tegra=20
SoC specific platforms.

Based on interface usage on platform, we use one or both of them like=20
sdcard supports dual voltage and we use both 3V3 and 1V8 but if same=20
interface is used for WIFI SD we use 1V8 only.

So made these dt properties as optional.

Other reason they are optional is, Tegra210 and prior has drive strength=20
settings part of apb_misc and Tegra186 and later has driver strengths=20
part of SDMMC controller. So,

- Pinctrls "sdmmc-3v3-drv" and "sdmmc-1v8-drv" for driver strengths are=20
applicable for Tegra210 and prior.
- dt properties pad-autocal-pull-up/down-offset-1v8/3v3-timeout are for=20
T186 onwards for driver strengths

Looks like dt binding doc need fix to clearly document these based on=20
SoC or agree with Yaml we can conditionally specify pinctrl or dt=20
properties based on SoC dependent.


>> Adding Sowjanya who wrote this code. Perhaps she can clarify why the
>> warnings were added. If these values /should/ be there on a subset of
>> Tegra, then I think we should keep them, or add them again, but perhaps
>> add a better way of identifying when they are necessary and when it is
>> safe to work without them.
>>
>> That said, looking at those checks I wonder if they are perhaps just
>> wrong. Or at the very least they seem redundant. It looks to me like
>> they can just be:
>>
>> 	if (tegra_host->pinctrl_state_XYZ =3D=3D NULL) {
>> 		...
>> 	}
>>
>> That !IS_ERR(...) doesn't seem to do anything. But in that case, it's
>> also obvious why we're warning about them on platforms where these
>> properties don't exist in DT.

As drive strengths are through dt properties for T186 and later and thru=20
pinctrl for T210 and prior, driver first checks for dt autocal timeout=20
pull-up/down properties and if they are not found, it then checks for=20
presence of pinctrl_state_xyx_drv only when valid pinctrl_state_xyz is=20
present.

Driver expects either pinctrl or dt properties and shows warning when=20
neither of them are present as its mandatory to use fixed driver=20
strengths when auto calibration fails.

 =C2=A0=C2=A0=C2=A0 err =3D device_property_read_u32(host->mmc->parent,
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 "nvidia,pad-autoc=
al-pull-down-offset-3v3-timeout",
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 &autocal->pull_do=
wn_3v3_timeout);
 =C2=A0=C2=A0=C2=A0 if (err) {
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (!IS_ERR(tegra_host->pinctrl_stat=
e_3v3) &&
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (tegra_host->pinc=
trl_state_3v3_drv =3D=3D NULL))
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 pr_warn("%s: Miss=
ing autocal timeout 3v3-pad drvs\n",
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 mmc_hostname(host->mmc));
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 autocal->pull_down_3v3_timeout =3D 0=
;
 =C2=A0=C2=A0=C2=A0 }

>>
>> So I think we either need to add those values where appropriate so that
>> the warning doesn't show, or we need to narrow down where they are
>> really needed and add a corresponding condition.
>>
>> But again, perhaps Sowjanya can help clarify if these really are only
>> needed on Tegra210 and later or if these also apply to older chips.
> Either way will be cleaner to convert the DT binding to YAML rather than
> clutter the driver, IMO.
>




