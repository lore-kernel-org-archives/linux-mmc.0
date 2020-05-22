Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B4AC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9310B20756
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovG+8Aky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgEVMSp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 08:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgEVMSo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2020 08:18:44 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF98AC061A0E;
        Fri, 22 May 2020 05:18:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z13so2686509ljn.7;
        Fri, 22 May 2020 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Aa2kJuA1Yb9w6Bc3yF55Vxc7cfSMHipyQkpg3bzqjgs=;
        b=ovG+8Aky5OuivUKGM8HqSMIrNNN5BW2K5rpwQO7xCP1IssTlP4K4bHIsdBtL80SWgc
         2UCJvDwcQYmzCnEqX0mDtmNl7TCUroH2CseHVkdgb+hpYNkYkwiBIhaPeR4WI530TGc4
         Iwv1UH6SNB8poMQHgx5BK59uuue+gofj6uFGq/+xN1aS4IrOaUYB4VT/DgcTnkb2GNhQ
         zNaIPrFN4ckwIkIVP1Hg9pALTdKcEudYiLPxB3w2AN82J51A4F2FIu8g6bfnfBRgZn0a
         oprKlS5umxjXgpTN7A6o+1mp2ye1odrwc2MUO2PTho27mUz1eZT26UpBEnv9wMqQqTwb
         aOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aa2kJuA1Yb9w6Bc3yF55Vxc7cfSMHipyQkpg3bzqjgs=;
        b=heWo1e6ALk3FER+FxjcKQSUIi71GOnxYQsBFLyIQ6KHxDMonG+4B8FpaoicvFzZ69+
         beQEwqvyLjqiO5ZY4tt4wmWORfUmbD5dyOBmoVAwOJFuuWEg9hyJQJgMPcYnLuekl6S6
         fXf7DiTfmxzN+XgY4J70J2zelice9OccIb2WPxhbu+zoYz3we0FW39RPkGYjHFAzBoBf
         P+bRIH1ubYE252x7reCbYumUgwQnKSfyJ6RViSpkDZwMd76kPmRSaIo/ZM8wXyKCJG+9
         U7Cp70ZGO9SrLjXd1nrmNt3b/3RM7voPwt1OLt747VzV6ynqNpCsNjaOWk3UUw7PCun1
         K9mQ==
X-Gm-Message-State: AOAM530rGlfBEjiZrhqVDtQdhRWfOi7drtcG2l4YHpO/AL5DYBG+Z5wu
        V3QvjQwI6H/Y9DfbjKu6xLS3YXHc
X-Google-Smtp-Source: ABdhPJyE2ycY1qztBcXwdsdx/pFRwpLx8rLSBYMIPhagAZPyBt+o0B1m8427D2yTtWPfrfm41Q2/Yg==
X-Received: by 2002:a2e:9586:: with SMTP id w6mr7205974ljh.274.1590149921707;
        Fri, 22 May 2020 05:18:41 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-17-204.pppoe.mtu-net.ru. [91.76.17.204])
        by smtp.googlemail.com with ESMTPSA id 130sm2398400lfl.37.2020.05.22.05.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 05:18:41 -0700 (PDT)
Subject: Re: [PATCH v1] sdhci: tegra: Remove warnings about missing
 device-tree properties
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <b634e7a5-9a30-3bd1-126d-be62e4dd73e1@gmail.com>
 <20200519162444.GD2113674@ulmo>
 <b4eb368e-adc2-7b77-3ae9-fefdcfddaf3d@gmail.com>
 <11c93dac-f5ba-2193-6f44-63af27fdce09@nvidia.com>
 <aed72c87-0e16-6dea-a4e2-7fc6a97cd313@nvidia.com>
 <c7469c16-f6f1-f9c0-566f-3b1d3774f130@nvidia.com>
 <c712de1d-cfa4-2746-ec6b-54f318aeaac2@nvidia.com>
 <d2c71267-e696-c459-fbd6-dbb5fd312ed3@gmail.com>
 <CAPDyKFqdeGyQpXpM+xynd_rWbi0S6hCeQS1Dyiy6Hd2E_yfHpg@mail.gmail.com>
 <96f917a3-d822-1c36-d088-3e4a322c1761@nvidia.com>
 <20200522121357.GD2163848@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2fa9db46-e310-dbbc-e1f7-f7058435a688@gmail.com>
Date:   Fri, 22 May 2020 15:18:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522121357.GD2163848@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

22.05.2020 15:13, Thierry Reding пишет:
> On Wed, May 20, 2020 at 09:09:33AM -0700, Sowjanya Komatineni wrote:
>>
>> On 5/20/20 4:26 AM, Ulf Hansson wrote:
>>> On Wed, 20 May 2020 at 04:00, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>> 19.05.2020 23:44, Sowjanya Komatineni пишет:
>>>>> On 5/19/20 12:07 PM, Sowjanya Komatineni wrote:
>>>>>> On 5/19/20 11:41 AM, Sowjanya Komatineni wrote:
>>>>>>> On 5/19/20 11:34 AM, Sowjanya Komatineni wrote:
>>>>>>>> On 5/19/20 9:33 AM, Dmitry Osipenko wrote:
>>>>>>>>> 19.05.2020 19:24, Thierry Reding пишет:
>>>>>>>>>> On Tue, May 19, 2020 at 05:05:27PM +0300, Dmitry Osipenko wrote:
>>>>>>>>>>> 19.05.2020 10:28, Ulf Hansson пишет:
>>>>>>>>>>>> On Sat, 16 May 2020 at 17:44, Dmitry Osipenko <digetx@gmail.com>
>>>>>>>>>>>> wrote:
>>>>>>>>>>>>> Several people asked me about the MMC warnings in the KMSG log and
>>>>>>>>>>>>> I had to tell to ignore them because these warning are
>>>>>>>>>>>>> irrelevant to
>>>>>>>>>>>>> pre-Tegra210 SoCs.
>>>>>>>>>>>> Why are the warnings irrelevant?
>>>>>>>>>>> That's what the DT binding doc says [1].
>>>>>>>>>>>
>>>>>>>>>>> [1]
>>>>>>>>>>> https://www.kernel.org/doc/Documentation/devicetree/bindings/mmc/nvidia%2Ctegra20-sdhci.txt
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Although, looking at the driver's code and TRM docs, it seems
>>>>>>>>>>> that all
>>>>>>>>>>> those properties are really irrelevant only to the older Terga20
>>>>>>>>>>> SoC. So
>>>>>>>>>>> the binding doc is a bit misleading.
>>>>>>>>>>>
>>>>>>>>>>> Nevertheless, the binding explicitly says that the properties are
>>>>>>>>>>> optional, which is correct.
>>>>>>>>>> Optional only means that drivers must not fail if these properties
>>>>>>>>>> aren't found, it doesn't mean that the driver can't warn that they
>>>>>>>>>> are missing.
>>>>>>>>>>
>>>>>>>>>> Quite possibly the only reason why they were made optional is because
>>>>>>>>>> they weren't part of the bindings since the beginning. Anything added
>>>>>>>>>> to a binding after the first public release has to be optional by
>>>>>>>>>> definition, otherwise DT ABI wouldn't be stable.
>>>>>>>>>>
>>>>>>>>>> I think these warnings were added on purpose, though I also see that
>>>>>>>>>> there are only values for these in device tree for Tegra186 and
>>>>>>>>>> Tegra194
>>>>>>>>>> but not Tegra210 where these should also be necessary.
>>>>>>>> dt binding doc we have is common for MMC, SD and SDIO of all Tegras.
>>>>>>>> Its not mandatory to have both 3v3 and 1v8 in device tree as based
>>>>>>>> on signal mode.
>>>>>>>>
>>>>>>>> As these driver strengths are SoC specific, they are part of Tegra
>>>>>>>> SoC specific device tree where same values will be applicable to all
>>>>>>>> Tegra SoC specific platforms.
>>>>>>>>
>>>>>>>> Based on interface usage on platform, we use one or both of them
>>>>>>>> like sdcard supports dual voltage and we use both 3V3 and 1V8 but if
>>>>>>>> same interface is used for WIFI SD we use 1V8 only.
>>>>>>>>
>>>>>>>> So made these dt properties as optional.
>>>>>>>>
>>>>>>>> Other reason they are optional is, Tegra210 and prior has drive
>>>>>>>> strength settings part of apb_misc and Tegra186 and later has driver
>>>>>>>> strengths part of SDMMC controller. So,
>>>>>>>>
>>>>>>>> - Pinctrls "sdmmc-3v3-drv" and "sdmmc-1v8-drv" for driver strengths
>>>>>>>> are applicable for Tegra210 and prior.
>>>>>>>> - dt properties pad-autocal-pull-up/down-offset-1v8/3v3-timeout are
>>>>>>>> for T186 onwards for driver strengths
>>>>>>>>
>>>>>>>> Looks like dt binding doc need fix to clearly document these based
>>>>>>>> on SoC or agree with Yaml we can conditionally specify pinctrl or dt
>>>>>>>> properties based on SoC dependent.
>>>>>>>>
>>>>>>>>
>>>>>>>>>> Adding Sowjanya who wrote this code. Perhaps she can clarify why the
>>>>>>>>>> warnings were added. If these values /should/ be there on a subset of
>>>>>>>>>> Tegra, then I think we should keep them, or add them again, but
>>>>>>>>>> perhaps
>>>>>>>>>> add a better way of identifying when they are necessary and when
>>>>>>>>>> it is
>>>>>>>>>> safe to work without them.
>>>>>>>>>>
>>>>>>>>>> That said, looking at those checks I wonder if they are perhaps just
>>>>>>>>>> wrong. Or at the very least they seem redundant. It looks to me like
>>>>>>>>>> they can just be:
>>>>>>>>>>
>>>>>>>>>>      if (tegra_host->pinctrl_state_XYZ == NULL) {
>>>>>>>>>>          ...
>>>>>>>>>>      }
>>>>>>>>>>
>>>>>>>>>> That !IS_ERR(...) doesn't seem to do anything. But in that case, it's
>>>>>>>>>> also obvious why we're warning about them on platforms where these
>>>>>>>>>> properties don't exist in DT.
>>>>>>>> As drive strengths are through dt properties for T186 and later and
>>>>>>>> thru pinctrl for T210 and prior, driver first checks for dt autocal
>>>>>>>> timeout pull-up/down properties and if they are not found, it then
>>>>>>>> checks for presence of pinctrl_state_xyx_drv only when valid
>>>>>>>> pinctrl_state_xyz is present.
>>>>>>>>
>>>>>>>> Driver expects either pinctrl or dt properties and shows warning
>>>>>>>> when neither of them are present as its mandatory to use fixed
>>>>>>>> driver strengths when auto calibration fails.
>>>>>>>>
>>>>>>>>      err = device_property_read_u32(host->mmc->parent,
>>>>>>>>              "nvidia,pad-autocal-pull-down-offset-3v3-timeout",
>>>>>>>>              &autocal->pull_down_3v3_timeout);
>>>>>>>>      if (err) {
>>>>>>>>          if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
>>>>>>>>              (tegra_host->pinctrl_state_3v3_drv == NULL))
>>>>>>>>              pr_warn("%s: Missing autocal timeout 3v3-pad drvs\n",
>>>>>>>>                  mmc_hostname(host->mmc));
>>>>>>>>          autocal->pull_down_3v3_timeout = 0;
>>>>>>>>      }
>>>>>>>>
>>>>>>>>>> So I think we either need to add those values where appropriate so
>>>>>>>>>> that
>>>>>>>>>> the warning doesn't show, or we need to narrow down where they are
>>>>>>>>>> really needed and add a corresponding condition.
>>>>>>>>>>
>>>>>>>>>> But again, perhaps Sowjanya can help clarify if these really are only
>>>>>>>>>> needed on Tegra210 and later or if these also apply to older chips.
>>>>>>>>> Either way will be cleaner to convert the DT binding to YAML rather
>>>>>>>>> than
>>>>>>>>> clutter the driver, IMO.
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>> Auto calibration is present from Tegra30 onward and looking into
>>>>>>> change where autocalibration was added to sdhci driver somehow it was
>>>>>>> enabled only for T30/T210/T186/T194.
>>>>>>>
>>>>>>> tegra_sdhci_parse_pad_autocal_dt() was added when auto-calibration
>>>>>>> was added to driver and I see this dt parse is being done
>>>>>>> irrespective of NVQUIRK_HAS_PADCALIB quirk so even on platforms
>>>>>>> without auto cal enabled in driver, these messages shows up.
>>>>>>>
>>>>>>> This should be fixed in driver to allow
>>>>>>> tegra_sdhci_parse_pad_autocal_dt() only when NVQUIRK_HAS_PADCALIB is
>>>>>>> set to avoid dt parsing to happen on platforms that don't have auto
>>>>>>> cal enabled.
>>>>>> Warning on missing drive strengths when auto cal is enabled should be
>>>>>> present as we should switch to fixed recommended drive strengths when
>>>>>> auto cal fails.
>>>>>>
>>>>>> So probably proper fix should be
>>>>>>
>>>>>> - allow tegra_sdhci_parse_pad_autocal_dt() only when
>>>>>> NVQUIRK_HAS_PADCALIB is set
>>>>>>
>>>>>> - current driver sets NVQUIRK_HAS_PADCALIB for T30 as well so need to
>>>>>> add pinctrls "sdmmc-3v3-drv" and "sdmmc-1v8-drv" to Tegra30 device tree.
>>>>> [Correction] T30 has same drive strengths to use irrespective of signal
>>>>> voltage and it doesn't have pad control. So for T3- we can update device
>>>>> tree to specify "default" pinctrl with drvup/dn settings.
>>>>>> - Keep warning message of missing auto cal timeouts as its mandatory
>>>>>> to use fixed recommended driver strengths when auto cal fails.
>>>>>>
>>>>> Regarding warnings, I guess simpler and easy fix is to remove warning
>>>>> message on missing 3v3/1v8 drive strengths as pinctrl/dt properties were
>>>>> already added for T210/186/194 where we need and old device tree don't
>>>>> have them but the case where auto cal can fail is very rare.
>>>>>
>>>>> Otherwise should update driver to allow
>>>>> tegra_sdhci_parse_pad_autocal_dt() only when NVQUIRK_HAS_PADCALIB is set
>>>>> and also within tegra_sdhci_parse_pad_autocal_dt() show warning of
>>>>> missing 3v3/1v8 settings only when NVQUIRK_NEEDS_PAD_CONTROL is set.
>>>>>
>>>>> Thierry, please suggest if you prefer to removing warnings or fix driver
>>>>> to show warning based on PADCALIB and PAD_CONTROL quirks.
>>>> The SDIO PINCTRL drive-strengths are usually a part of the board's
>>>> default PINCTRL state, which is either preset by bootloader or by
>>>> PINCTRL driver early at a boot time.
>>>>
>>>> The SDIO drive-strengths values should be board-specific and not
>>>> SoC-specific because they should depend on the electrical properties of
>>>> the board, IIUC.
>>
>> Drive strengths we program here when auto calibration fails are recommended
>> values based on pre-SI circuit analysis and characterized across PVT.
>>
>> So,  these fail safe values are same for all boards of specific SoC as all
>> platform designs follow the design guidelines.
>>
>>>> If the SDIO PINCTRL states are mandatory for the SDHCI nodes in the
>>>> device-trees, then the DT binding is wrong since it says that all
>>>> properties are optional. But I think that the current binding is okay,
>>>> since today SDHCI PINCTRL drive-strengths are specified implicitly in
>>>> the device-trees, and thus, there is no real need to emit the noisy
>>>> warnings in this case.
>>> For now I will keep $subject patch applied, but please tell me if I
>>> should drop it so we can start over.
>>>
>>> In any case, I would appreciate it if someone could have a stab at
>>> converting sdhci and tegra DT bindings to yaml.
>>>
>>> Kind regards
>>> Uffe
>>
>> HI Uffe,
>>
>> Please drop $subject patch. Will send patch that allows parsing for these
>> properties only for SoC where auto cal is enabled as that's where driver
>> needs these properties.
>>
>> So with this fix, warning will not show up on systems where autocal is not
>> enabled.
> 
> Yes, I think that's a better option. Have we ensured that on all systems
> where autocal is enabled these values are part of the device tree? Just
> making sure that we're not going to have some generation still spit out
> these warnings because we forgot to update the device tree.
> 
> For example I see that we set NVQUIRK_HAS_PADCALIB but I don't see these
> properties being set in arch/arm/boot/dts/tegra30.dtsi. Can you add a
> patch that also adds the properties for Tegra30?

I don't see the warnings on T30 using Sowjanya's patch which checks for
NVQUIRK_NEEDS_PAD_CONTROL and not NVQUIRK_HAS_PADCALIB.
