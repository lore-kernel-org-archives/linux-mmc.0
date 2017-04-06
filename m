From: "Y.B. Lu" <yangbo.lu@nxp.com>
Subject: RE: [v3, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
Date: Thu, 6 Apr 2017 08:02:24 +0000
Message-ID: <DB6PR0401MB2536D6053D42A86F62FE02B9F80D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db5eur01on0084.outbound.protection.outlook.com ([104.47.2.84]:47760
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756675AbdDFIC2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 6 Apr 2017 04:02:28 -0400
In-Reply-To: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Y.B. Lu" <yangbo.lu@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>

Hi all,

Any comments? Thanks.


Best regards,
Yangbo Lu

> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu@nxp.com]
> Sent: Monday, March 27, 2017 3:50 PM
> To: linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; ulf.hansson@linaro.org; Adrian Hunter; Rob
> Herring; Mark Rutland; Catalin Marinas; Will Deacon
> Cc: Xiaobo Xie; Y.B. Lu
> Subject: [v3, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
>=20
> It's complicated to support SD UHS-I and eMMC HS200 for eSDHC because
> there're many differences between eSDHC and SD/eMMC spec. Several
> differences as below must be considered:
> 1. Peripheral clock must be used instead of platform clock.
>     - eSDHC could select peripheral clock or platform clock as its clock
>       source. According to RM, UHS-I/HS200 must use peripheral clock
> since
>       it supports higher frequency than platform clock.
>     - Patch 1 and patch 6 is to support this.
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
> 5. UHS-I/HS200 modes could be enabled in dts node.
>     - Patch 7 is to support this.
>=20
> Please review and merge these patches on mmc git tree if no changes are
> required.
>=20
> Adrian Hunter (1):
>   mmc: sdhci: Control the delay between tuning commands
>=20
> Yangbo Lu (6):
>   mmc: sdhci-of-esdhc: add peripheral clock support
>   mmc: sdhci-of-esdhc: add support for signal voltage switch
>   mmc: sdhci-of-esdhc: add tuning support
>   mmc: sdhci-of-esdhc: add delay between tuning cycles
>   arm64: dts: ls1046a: add clocks property and compatible for eSDHC node
>   arm64: dts: ls1046ardb: add MMC HS200/UHS-1 modes support
>=20
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts |   8 ++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi    |   3 +-
>  drivers/mmc/host/sdhci-esdhc.h                    |   7 +
>  drivers/mmc/host/sdhci-of-esdhc.c                 | 165
> +++++++++++++++++++++-
>  drivers/mmc/host/sdhci.c                          |  11 +-
>  drivers/mmc/host/sdhci.h                          |   2 +
>  6 files changed, 190 insertions(+), 6 deletions(-)
>=20
> --
> 2.1.0.27.g96db324

