From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v5, 0/5] Add SD UHS-I and eMMC HS200 support for eSDHC
Date: Thu, 20 Apr 2017 16:05:54 +0200
Message-ID: <CAPDyKFqstYSENagpSNYcDkfd4Ez-7+vgSEK-Jo1F=n3S1RCaww@mail.gmail.com>
References: <1492676084-28218-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:34392 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031989AbdDTOF4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Apr 2017 10:05:56 -0400
Received: by mail-ua0-f169.google.com with SMTP id h2so51853456uaa.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Apr 2017 07:05:56 -0700 (PDT)
In-Reply-To: <1492676084-28218-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Xiaobo Xie <xiaobo.xie@nxp.com>

On 20 April 2017 at 10:14, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> It's complicated to support SD UHS-I and eMMC HS200 for eSDHC because
> there're many differences between eSDHC and SD/eMMC spec. Several
> differences as below must be considered:
> 1. Peripheral clock must be used instead of platform clock.
>     - eSDHC could select peripheral clock or platform clock as its clock
>       source. According to RM, UHS-I/HS200 must use peripheral clock since
>       it supports higher frequency than platform clock.
>     - Patch 1 is to support this.
> 2. Signal voltage switching requires a control circuit out of eSDHC.
>     - eSDHC supports signal voltage switch from 3.3v to 1.8v by
>       eSDHC_PROCTL[VOLT_SEL] bit. This bit changes the value of output
>       signal SDHC_VS, and there must be a control circuit out of eSDHC
>       to change the signal voltage according to SDHC_VS output signal.
>     - Patch 2 is to support this.
> 3. eSDHC uses tuning block for tuning procedure.
>     - Tuning clock control register must be configured before tuning.
>     - Patch 3 is to support this.
> 4. Delay is needed between tuning cycles for HS200 tuning.
>     - Once a patch removed mdelay between tuning cycles.
>       But eSDHC needs it.
>     - Patch 4 and patch 5 is to support this.
>
> Adrian Hunter (1):
>   mmc: sdhci: Control the delay between tuning commands
>
> Yangbo Lu (4):
>   mmc: sdhci-of-esdhc: add peripheral clock support
>   mmc: sdhci-of-esdhc: add support for signal voltage switch
>   mmc: sdhci-of-esdhc: add tuning support
>   mmc: sdhci-of-esdhc: add delay between tuning cycles
>
>  drivers/mmc/host/sdhci-esdhc.h    |   7 ++
>  drivers/mmc/host/sdhci-of-esdhc.c | 168 +++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci.c          |  11 ++-
>  drivers/mmc/host/sdhci.h          |   2 +
>  4 files changed, 183 insertions(+), 5 deletions(-)
>
> --
> 2.1.0.27.g96db324
>

Thanks, applied for next!

Kind regards
Uffe
