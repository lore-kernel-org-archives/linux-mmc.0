From: "Y.B. Lu" <yangbo.lu@nxp.com>
Subject: RE: [v2, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
Date: Thu, 9 Mar 2017 02:22:36 +0000
Message-ID: <DB6PR0401MB253672A97F3E14C2BEFF946EF8210@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1488529129-23560-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488529129-23560-1-git-send-email-yangbo.lu@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will.deacon@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Any comments on this patchset ?
Thanks :)


Best regards,
Yangbo Lu

> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu@nxp.com]
> Sent: Friday, March 03, 2017 4:19 PM
> To: linux-mmc@vger.kernel.org; ulf.hansson@linaro.org; Adrian Hunter; Rob
> Herring; Mark Rutland; Catalin Marinas; Will Deacon
> Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Xiaobo Xie; Y.B. Lu
> Subject: [v2, 0/7] Add SD UHS-I and eMMC HS200 support for eSDHC
> 
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
> 
> Please review and merge these patches on mmc git tree if no changes are
> required.
> 
> Yangbo Lu (7):
>   mmc: sdhci-of-esdhc: add peripheral clock support
>   mmc: sdhci-of-esdhc: add support for signal voltage switch
>   mmc: sdhci-of-esdhc: add tuning support
>   mmc: sdhci: add a quirk to restore delay in tuning
>   mmc: sdhci-of-esdhc: add delay between tuning cycles
>   arm64: dts: ls1046a: add clocks property and compatible for eSDHC node
>   arm64: dts: ls1046ardb: add MMC HS200/UHS-1 modes support
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts |   8 ++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi    |   3 +-
>  drivers/mmc/host/sdhci-esdhc.h                    |   7 +
>  drivers/mmc/host/sdhci-of-esdhc.c                 | 167
> +++++++++++++++++++++-
>  drivers/mmc/host/sdhci.c                          |   3 +-
>  drivers/mmc/host/sdhci.h                          |   2 +
>  6 files changed, 186 insertions(+), 4 deletions(-)
> 
> --
> 2.1.0.27.g96db324
