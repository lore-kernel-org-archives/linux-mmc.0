Return-Path: <SRS0=+qgY=A3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B46C433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jul 2020 18:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A8C2082E
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jul 2020 18:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgGPS3P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:29:15 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39147 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPS3M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jul 2020 14:29:12 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MdNTy-1kVCOk1UTA-00ZNbO; Thu, 16 Jul 2020 20:29:10 +0200
Received: by mail-qk1-f177.google.com with SMTP id 145so6460753qke.9;
        Thu, 16 Jul 2020 11:29:09 -0700 (PDT)
X-Gm-Message-State: AOAM530nNoPjPKzPIluuQKhKCyfzeQyIfDQteLDJU935osUzUM7aJqg8
        wb49PWHP2MTH2Gnqc/T7knIbFjpi42ISaL31aEo=
X-Google-Smtp-Source: ABdhPJwpnVi3yTN8/eCBJobJvERBe9E39v4nmlAu46cNhC03D5mIwa1L0kP09TpwQqOYtQR2/q6zs01B21hw0nyk7DU=
X-Received: by 2002:a37:9dd6:: with SMTP id g205mr5507389qke.352.1594924149045;
 Thu, 16 Jul 2020 11:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200619125801.9530-1-faiz_abbas@ti.com> <20200619125801.9530-8-faiz_abbas@ti.com>
 <3ed03440-7fbd-6abc-8a15-67e7217e2c3d@ti.com> <2e50333c-5387-236f-3fb2-6d8014b224e0@ti.com>
In-Reply-To: <2e50333c-5387-236f-3fb2-6d8014b224e0@ti.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Jul 2020 20:28:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1JpCCCV-CVQj3+eMfWF+=4AuHPpv390Tyj2pKn63_ZVg@mail.gmail.com>
Message-ID: <CAK8P3a1JpCCCV-CVQj3+eMfWF+=4AuHPpv390Tyj2pKn63_ZVg@mail.gmail.com>
Subject: Re: [PATCH 7/7] arm64: defconfig: Enable AM654x SDHCI controller
To:     Sekhar Nori <nsekhar@ti.com>
List-Id: <soc.lore.kernel.org>
Cc:     Faiz Abbas <faiz_abbas@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        ARM-SoC Maintainers <soc@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zNjLXb5vHEpNpoSBwn+Afpdez3i7UM+Ignp814vB+CU/NGZRXjY
 CzKQ/HqpUJ529deZnSVTDd4R9mnkuUz3tafXxuatlxtrS88F+qnGckQls/gpJxAk7ObR8rs
 zfnpUDOW3v3aFNSMZOtGOXlyZnRp4ZsyjBWntlgMxgJJbD3Y0zsQbOBMdg83EtObs+2FGqU
 ATvFhR8HTJPO8GK/O2Gsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x15BDNpakwY=:84QQbrNNE386mCC6/k27Nu
 QZV1WSoV6OARpNoonBgXWLCDNGwidtV3cjeOcHyCNwZcr1p7VoICgSowLe3uBuX692hucIN5D
 W4Q+5YJwnJYoTniobGV6ZNNT5M0E41n2m4YrYmhnZ2pQsY4PwfROz4z8g7wYbGwyvLg3naTYK
 jTyxY8XhuyRUL/x0jGqOgoJBM2afDJqESmIxLVjR6uNid+S8ID5KRRa8cMTVCFbzYMZYwrT9d
 8stKounBeofd/KsNAKqeD/Zi/qmckmBVJjM4Py1qTngvpewRThD36pO5K898e67cq21E+Ubmk
 55IJ7jNpHi0fI1LfN44twQMlCh69Qqu0ubxpGFRNO9nogzrYDcA0WGFaY7Hr5LHcqfqzkORD0
 zEnn+D2W2uw3Wweg2UzdP3OtnSoQcLeH/iTyTtTPgVTJ10ifAXWINOpM/VSo2LtvAW0TTa3pM
 rtalfj2iHWQIDHJh5SG6sUJ1iHUg1m/Flcd7qNH4dp0NA82K5pIJjUSFAd98M4fhblaJdHi9o
 XW2+0ZCWkQZt71CCUlO/gAhtBH80dVW+qHLKlglJ8wT2jF1tivJbIFGFMqjd0YnVi7g4M3nix
 DoOiH4mFJW4aiLVE0EHSNQblhRN4lTh2JbZBoAwLiaWgxwoV61raBubNXdXSifJnZOhuiWFEx
 KpoSKZNpPSoqtf9Lp/JwxGMS6JxYXSILoKD0nXR0MIJG9P81DmvJP0Vlo8wl8BtygAmRSKoWb
 rjAkr7Z65KY8//SGFquv26BuReGc3w07U/3UE2bMrz44C7dqoBnVX2uOFXneOf8jb6GYsaiFY
 9s8h79osEDsDfDbs+G1eeUFI+3N3MzsCJpZ6687JYMVi9PNXMNdwrf72L5rm7YhzIvAy0q1IY
 ieo0mxGswaUFcyz2sQqmg5B6e4JC8kUzVBLRFeu10KbxXKJm4A5PRFBWGDMhnznNidL7UxL2T
 qbV2349dDIsYgqznPbPOx5LsYVn0neJFn+MY23NUW6oSntByrWMvo
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jul 16, 2020 at 3:25 PM Sekhar Nori <nsekhar@ti.com> wrote:
>
> On 7/16/20 5:49 PM, Faiz Abbas wrote:
> > Hi,
> >
> > On 19/06/20 6:28 pm, Faiz Abbas wrote:
> >> Enable CONFIG_SDHCI_AM654 to Support AM65x sdhci controller.
> >>
> >> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> >> ---
> >>  arch/arm64/configs/defconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> >> index 883e8bace3ed..40dd13e0adc5 100644
> >> --- a/arch/arm64/configs/defconfig
> >> +++ b/arch/arm64/configs/defconfig
> >> @@ -731,6 +731,7 @@ CONFIG_MMC_DW_ROCKCHIP=y
> >>  CONFIG_MMC_SUNXI=y
> >>  CONFIG_MMC_BCM2835=y
> >>  CONFIG_MMC_SDHCI_XENON=y
> >> +CONFIG_MMC_SDHCI_AM654=y
> >>  CONFIG_MMC_OWL=y
> >>  CONFIG_NEW_LEDS=y
> >>  CONFIG_LEDS_CLASS=y
> >>
> >
> > Gentle ping. Will, Catalin, can this patch be picked up?
>
> From logs, Arnd has been picking up patches for this file. Looping in
> Arnd and ARM-SoC team.

I tend to ignore individual patches to the defconfig file unless
they are sent to:soc@kernel.org. The best way to get them
included is to have the platform maintainers pick up the
changes and send them that way as a separate pull request
at the same time as sending any DT updates.

The MAINTAINERS file lists Tero and Nishanth as maintainers
for the platform. If they want, I can apply this one directly, but in
the future, send it to them.

        Arnd
