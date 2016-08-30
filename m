From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 1/3] DT: bindings: mmc: Add property for 3.3V only support
Date: Tue, 30 Aug 2016 11:26:28 +0200
Message-ID: <CAPDyKFr8X93oqiPzkQxPnfMGyV9UBEybvfODX5if3VwMbheKcw@mail.gmail.com>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
 <1470488140-10104-2-git-send-email-stefan.wahren@i2se.com>
 <20160810184451.GA13473@rob-hp-laptop> <853617027.179290.63a6f478-ad48-40c8-82ca-760dd1afc040.open-xchange@email.1und1.de>
 <CAL_JsqJ09hXYrp_pgAw9FXrBv+=grkm_zip6qB9XefujPECTxQ@mail.gmail.com>
 <468a6704-a9f0-1715-ff64-9e331a6a80b1@rock-chips.com> <8f87c885-3c55-cac8-a9f5-e121ae031f90@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38667 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbcH3J0b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2016 05:26:31 -0400
Received: by mail-wm0-f42.google.com with SMTP id o80so25035516wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 30 Aug 2016 02:26:31 -0700 (PDT)
In-Reply-To: <8f87c885-3c55-cac8-a9f5-e121ae031f90@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Sascha Hauer <kernel@pengutronix.de>, Otavio Salvador <otavio@ossystems.com.br>, Holger Schurig <holgerschurig@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marek Vasut <marex@denx.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>

On 18 August 2016 at 14:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 11/08/16 03:48, Shawn Lin wrote:
>> + Adrian
>>
>> Let's queue Adrian here who now maintains SDHCI stuff.
>
> SDHCI drivers may not implement no-1-8-v in a consistent manner, but as far
> as I can see, the meaning is still clear: 1.8V will not be used for either
> supply or signaling.

Okay.

>
> SDHCI is complicated because the SDHCI specification does not cover eMMC.
> From the perspective of SDHCI, the only 1.8V modes are the UHS-I modes, so
> support for 1.8V signaling is the same as support for one of those modes
> (the spec even says as much).  But what happens is that the host controller
> can support those modes but the board can't supply 1.8V so the drivers
> remove capability for the modes.  Support for 1.8V supply has a capability
> bit which drivers can override if necessary but removable SD cards don't
> support 1.8V supply anyway, so the issue doesn't arise if the host
> controller is only used for uSD cards.

By looking how SDHCI uses the SDHCI_SUPPORT_DDR50 in conjunction with
SDHCI_QUIRK2_NO_1_8_V (which is set when no-1-8-v DT property is
provided), this becomes a bit messy.

>From Adrian's summary above, it then seems appropriate to limit the
no-1-8-v DT property to apply only to capabilities related to SD
cards, as I assume that also was the original purpose.

Do you think it's possible to clean up this in sdhci when assigning
the caps masks, and then also clarify the no-1-8-v DT binding in the
documentation?

Regarding the new DT binding proposed to be added, mmc-ddr-3_3v, it
seems we need this to be able to properly describe the HW.
Rob, do you have an issue with adding this binding? I am thinking that
we already have mmc-ddr-1_8v and mmc-ddr-1_2v, so it just follow
existing pattern.

[...]

Kind regards
Uffe
