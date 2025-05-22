Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831F01A23A6;
	Thu, 22 May 2025 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911828; cv=none; b=XhVkAqSzLI90q2Vg4JscsEoeLFU1KWmLNFFudMsTP4KT4d4nDQJOPXGeLYWO+u3vIODs4Pm96X6GzEPqwSCNhsWbwMn7dXO1O6ZMuM5tN3TsReHRiKS7XoEbfbzNO+M6wH1a3CvQe4eY8lFgMyJfGkND/DpIzj4W3bu+QpI/iGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911828; c=relaxed/simple;
	bh=eEvo3LknW+2PwByaViXA1NM51KqZpfaAISstO/YCbc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgFZhe1d0NK9zjYD6h2J9EagveaQxi1KjFpg2CRl6S31CWrxXjr4kmv41z14SPTu9Sy3mTH4Axa0HXctTSKpue4T/WIf52PkP5wXjjRgIALDjbZQB3XK3Tdxc0Fbwz27uFA2UM7erRv7ZebLvmb0Ab7dvHGuTmuSvSh4hHDUWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3B7F63430BD;
	Thu, 22 May 2025 11:03:44 +0000 (UTC)
Date: Thu, 22 May 2025 11:03:33 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alex Elder <elder@riscstar.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-k1: add support for SpacemiT K1 SoC
Message-ID: <20250522110333-GYA30672@gentoo>
References: <20250501-20-k1-sdhci-v2-0-3e7005fae29b@gentoo.org>
 <20250501-20-k1-sdhci-v2-2-3e7005fae29b@gentoo.org>
 <CAPDyKFoDWS6DWdKOaxTDEYeKv3hjVDoR7XGi19nESVssc-RG8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoDWS6DWdKOaxTDEYeKv3hjVDoR7XGi19nESVssc-RG8g@mail.gmail.com>

Hi Ulf,

On 13:34 Mon 19 May     , Ulf Hansson wrote:
> On Thu, 1 May 2025 at 10:51, Yixun Lan <dlan@gentoo.org> wrote:
> >
> > The SDHCI controller found in SpacemiT K1 SoC features SD,
> > SDIO, eMMC support, such as:
> >
> > - Compatible for 4-bit SDIO 3.0 UHS-I protocol, up to SDR104
> > - Compatible for 4-bit SD 3.0 UHS-I protocol, up to SDR104
> > - Compatible for 8bit eMMC5.1, up to HS400
> >
> > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > ---
> >  drivers/mmc/host/Kconfig       |  14 ++
> >  drivers/mmc/host/Makefile      |   1 +
> >  drivers/mmc/host/sdhci-of-k1.c | 306 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 321 insertions(+)
> >
> > [...]
> > +
> > +#include "sdhci.h"
> > +#include "sdhci-pltfm.h"
> > +
> > +#define SDHC_MMC_CTRL_REG              0x114
I will add 'SPACEMIT_' prefix for the register definitions,
AFAIK, vendor will continue to reuse this IP for their next generation SoC

> > +#define  MISC_INT_EN                   BIT(1)
> > +#define  MISC_INT                      BIT(2)
for BITs definition, it's also quite generic.. I could add
'SDHC_' prefix to make them slightly unique, and as all those registers
fall into SDHC category..

> 
> These define-names look a bit too generic to me. Please add some
> additional prefixes so it becomes more clear what they are.
> 
Initially, I've followed the datasheet closely for creating those naming..

https://developer.spacemit.com/documentation?token=WZNvwFDkYinYx0k9jzPcMK5WnIe#12.5.4.36-sdhc_mmc_ctrl_reg-register

> This applies to all the others below too.
> 
> > +#define  ENHANCE_STROBE_EN             BIT(8)
> > +#define  MMC_HS400                     BIT(9)
> > +#define  MMC_HS200                     BIT(10)
> > +#define  MMC_CARD_MODE                 BIT(12)
> > +
> > +#define SDHC_TX_CFG_REG                        0x11C
> > +#define  TX_INT_CLK_SEL                        BIT(30)
> > +#define  TX_MUX_SEL                    BIT(31)
> > +
> > +#define SDHC_PHY_CTRL_REG              0x160
> > +#define  PHY_FUNC_EN                   BIT(0)
> > +#define  PHY_PLL_LOCK                  BIT(1)
> > +#define  HOST_LEGACY_MODE              BIT(31)
> > +
> > +#define SDHC_PHY_FUNC_REG              0x164
> > +#define  PHY_TEST_EN                   BIT(7)
> > +#define  HS200_USE_RFIFO               BIT(15)
> > +
> > +#define SDHC_PHY_DLLCFG                        0x168
> > +#define  DLL_PREDLY_NUM                        GENMASK(3, 2)
> > +#define  DLL_FULLDLY_RANGE             GENMASK(5, 4)
> > +#define  DLL_VREG_CTRL                 GENMASK(7, 6)
> > +#define  DLL_ENABLE                    BIT(31)
> > +
> > +#define SDHC_PHY_DLLCFG1               0x16C
> > +#define  DLL_REG1_CTRL                 GENMASK(7, 0)
> > +#define  DLL_REG2_CTRL                 GENMASK(15, 8)
> > +#define  DLL_REG3_CTRL                 GENMASK(23, 16)
> > +#define  DLL_REG4_CTRL                 GENMASK(31, 24)
> > +
> > +#define SDHC_PHY_DLLSTS                        0x170
> > +#define  DLL_LOCK_STATE                        BIT(0)
> > +
> > +#define SDHC_PHY_PADCFG_REG            0x178
> > +#define  PHY_DRIVE_SEL                 GENMASK(2, 0)
> > +#define  RX_BIAS_CTRL                  BIT(5)
> 
> [...]
> 
> > +
> > +static int spacemit_sdhci_pre_select_hs400(struct mmc_host *mmc)
> > +{
> > +       struct sdhci_host *host = mmc_priv(mmc);
> > +
> > +       spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
> > +       host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> 
> At least this deserves a comment. Isn't MMC_CAP_WAIT_WHILE_BUSY
> working for all cases?
> 
I mostly copy the logic from vendor driver while refactoring the code,
and again check the logic, it sounds a little bit weird that the flag
is enabled in pre_select_hs400(), then disabled in post_select_hs400(),
I really don't understand the logic behind this, or even any quirk?..

while, I've tested both cases of enabling or disabling the flag globally,
they both works fine as result.. so to be conservative, I plan to drop
this "enable-and-disable" logic, and would revisit them once adding
"SD card/SDIO" support in the future

> > +
> > +       return 0;
> > +}
> > +
> > +static void spacemit_sdhci_post_select_hs400(struct mmc_host *mmc)
> > +{
> > +       struct sdhci_host *host = mmc_priv(mmc);
> > +
> > +       spacemit_sdhci_phy_dll_init(host);
> > +       host->mmc->caps &= ~MMC_CAP_WAIT_WHILE_BUSY;
> 
> Dito.
> 
> [...]
> 
> Kind regards
> Uffe

-- 
Yixun Lan (dlan)
