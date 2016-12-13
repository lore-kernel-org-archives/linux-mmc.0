From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 2/2] mmc: sdhci-cadence: add Cadence SD4HC support
Date: Tue, 13 Dec 2016 08:52:55 +0100
Message-ID: <CAPDyKFrejOSGVWb=gsuCixxj_OXfLfo22VwLDC_Y4scw+Se8FQ@mail.gmail.com>
References: <1481201455-3483-1-git-send-email-yamada.masahiro@socionext.com>
 <1481201455-3483-3-git-send-email-yamada.masahiro@socionext.com>
 <20161212171408.2yf4jauz7czv44fy@rob-hp-laptop> <CAK7LNATO+vpxmDV-XEupjeXXhPNdrXHNwfwWcAVWLdbJi+37QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNATO+vpxmDV-XEupjeXXhPNdrXHNwfwWcAVWLdbJi+37QA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rob Herring <robh@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

[...]

>>> +
>>> +Optional properties:
>>> +For eMMC configuration, supported speed modes are not indicated by the SDHCI
>>> +Capabilities Register.  Instead, the following properties should be specified
>>> +if supported.  See mmc.txt for details.
>>> +- mmc-ddr-1_8v
>>> +- mmc-ddr-1_2v
>>> +- mmc-hs200-1_8v
>>> +- mmc-hs200-1_2v
>>> +- mmc-hs400-1_8v
>>> +- mmc-hs400-1_2v
>>
>> There's now a property to override SDHCI capabilities register. Maybe
>> you should use that instead? I'll defer to Ulf.
>>
>
> I did not know this new property.
>
> So, now we have two ways to specify MMC speed mode capabilities
> by only touching DT.

Let me clarify a bit.

The point with the new bindings is to be able to override *broken*
SDHCI caps bits. So, not only related to the speed modes.

>
> [1] Add MMC mode flags directly, like I did.
> [2] Use "sdhci-caps-mask" and "sdhci-caps"
>
>
> The problem for [2] is that eMMC capabilities
> do not perfectly correspond to the SDHCI capabilities register.
>
>
>>> +- mmc-hs400-1_8v
>>> +- mmc-hs400-1_2v
>
> If the driver sets SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
> we can use the bit63 of caps for specifying HS400.
>
> But, this is not defined in the SDHCI standard.
> #define  SDHCI_SUPPORT_HS400 0x80000000 /* Non-standard */
>
>
>
>>> +- mmc-ddr-1_8v
>
> For High Speed DDR, perhaps we can imply MMC_CAP_1_8V_DDR
> from MMC_CAP_UHS_DDR50  (bit34 of caps)
>
> This is not supported in the current code, but
> if this is a good idea, I can send a patch.
>
>
>>> +- mmc-ddr-1_2v
>
> This does not have the corresponding bit, but
> 1.2V is not commonly used, so this is not a fatal problem.
>
>
>
> What I can do at most now, is to delete the
> Optional properties section entirely
> so users can choose [1] or [2] as they like.
>

I think a better approach is to use the new sdhci-caps* bindings to
mask those caps that can't be trusted. And then use the generic mmc
bindings for speed modes instead.

That should be a safer approach, right!?

Kind regards
Uffe
