Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A233A01C;
	Tue, 19 Aug 2025 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605804; cv=none; b=dSqGm37ovHrfG8Ka7yexe073ws2H9mMrmOdbAR+stxIBDaDqlvlmb/rQDCyvYJe2jSFjongn6vIVdBDNMSihh1bxTPhqCdlvdDyziCt3/jS9SsgqGWJjRDCMqmAIL6dVobb0oJTPTghng5fhCJAyfe96mRT7m0bw7ZDA3vIwS7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605804; c=relaxed/simple;
	bh=i+gz6s1/P4QZJsZ/FOYZ/eYvIn2i6T9S8U1Kd/yz18c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piJ7h9lTf7+Gv12YJ/xwVx7dvgla9hpOlGwxGJ9YSYi7eqqdPIgMSk2bc8uof/2HO1D1lseVjHiD6K68QY1JE0AyjLhHmqYZrk9M1horShEu5QnRip3Xr06r5M6GHQwyii1Um3IsvWCbMlWtMfNDqePRQuGBkF7uCn1jq1IeZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7MbBzNR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7MbBzNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73893C116B1;
	Tue, 19 Aug 2025 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755605804;
	bh=i+gz6s1/P4QZJsZ/FOYZ/eYvIn2i6T9S8U1Kd/yz18c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7MbBzNRv0R9J9Im++yVgscta4px84UvtZzjzQKjFP7HvP6ppcq/9a6gZIeyziKk8
	 Nrd8p39mM/3BmKFiyr20zcIQpyVV1fATUq5lPCFsdPkjVz1HO6/PYsFW6YZnJFKW42
	 clp1zQKRNp16afZyqDBEk7ec3v29sGJyidkvYDAcSbChASRYQs2L0aEbJBVI6seIBH
	 gKSbcpSvQvIyV/MYpGLOCRjLwlTh7sLTMJKUrnY9Lk8+dEKb3FjhXp8CDNpFJGXBln
	 rThMYsZosXNPz9bKOz6CERm9PGl3qyD0jU/KV7m2yS8iqja4Yr6CXImVj+vcL3nHFc
	 b3rSuCnjS2J4g==
Date: Tue, 19 Aug 2025 19:59:23 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Bough Chen <haibo.chen@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	=?utf-8?B?TWljaGHvv73vv70gTWlyb3Pvv73vv71hdw==?= <mirq-linux@rere.qmqm.pl>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Russell King <linux@armlinux.org.uk>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Michal Simek <michal.simek@amd.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ben Dooks <ben-linux@fluff.org>, Viresh Kumar <vireshk@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexey Charkov <alchark@gmail.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/38] mmc: sdhci-esdhc-imx: use modern PM macros
Message-ID: <aKRnG7P_krdC9zKY@xhacker>
References: <20250815013413.28641-1-jszhang@kernel.org>
 <20250815013413.28641-19-jszhang@kernel.org>
 <DU0PR04MB94962993C99F922CCF93FB6F9034A@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <aKAfRFPJQM_EtAKF@xhacker>
 <aKMZWjM536EOHDn9@xhacker>
 <DU0PR04MB9496FAB31EE76054B79E05F99030A@DU0PR04MB9496.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB9496FAB31EE76054B79E05F99030A@DU0PR04MB9496.eurprd04.prod.outlook.com>

On Tue, Aug 19, 2025 at 03:48:57AM +0000, Bough Chen wrote:
> > -----Original Message-----
> > From: Jisheng Zhang <jszhang@kernel.org>
> > Sent: 2025年8月18日 20:15
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>; Aubin Constans
> > <aubin.constans@microchip.com>; Nicolas Ferre
> > <nicolas.ferre@microchip.com>; Alexandre Belloni
> > <alexandre.belloni@bootlin.com>; Claudiu Beznea
> > <claudiu.beznea@tuxon.dev>; Manuel Lauss <manuel.lauss@gmail.com>;
> > Micha�� Miros��aw <mirq-linux@rere.qmqm.pl>; Jaehoon Chung
> > <jh80.chung@samsung.com>; Krzysztof Kozlowski <krzk@kernel.org>; Alim
> > Akhtar <alim.akhtar@samsung.com>; Heiko Stuebner <heiko@sntech.de>;
> > Russell King <linux@armlinux.org.uk>; Chaotian Jing
> > <chaotian.jing@mediatek.com>; Matthias Brugger <matthias.bgg@gmail.com>;
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>;
> > Shawn Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; Adrian Hunter <adrian.hunter@intel.com>; Kamal
> > Dasu <kamal.dasu@broadcom.com>; Al Cooper <alcooperx@gmail.com>;
> > Broadcom internal kernel review list
> > <bcm-kernel-feedback-list@broadcom.com>; Florian Fainelli
> > <florian.fainelli@broadcom.com>; Michal Simek <michal.simek@amd.com>;
> > Eugen Hristev <eugen.hristev@linaro.org>; Vignesh Raghavendra
> > <vigneshr@ti.com>; Ben Dooks <ben-linux@fluff.org>; Viresh Kumar
> > <vireshk@kernel.org>; Orson Zhai <orsonzhai@gmail.com>; Baolin Wang
> > <baolin.wang@linux.alibaba.com>; Chunyan Zhang <zhang.lyra@gmail.com>;
> > Patrice Chotard <patrice.chotard@foss.st.com>; Thierry Reding
> > <thierry.reding@gmail.com>; Jonathan Hunter <jonathanh@nvidia.com>;
> > Chen-Yu Tsai <wens@csie.org>; Jernej Skrabec <jernej.skrabec@gmail.com>;
> > Samuel Holland <samuel@sholland.org>; Alexey Charkov <alchark@gmail.com>;
> > linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 18/38] mmc: sdhci-esdhc-imx: use modern PM macros
> > 
> > On Sat, Aug 16, 2025 at 02:03:48PM +0800, Jisheng Zhang wrote:
> > > On Fri, Aug 15, 2025 at 03:23:56AM +0000, Bough Chen wrote:
> > > > > -----Original Message-----
> > > > > From: Jisheng Zhang <jszhang@kernel.org>
> > > > > Sent: 2025Ҵ8??15?? 9:34
> > > > > To: Ulf Hansson <ulf.hansson@linaro.org>; Aubin Constans
> > > > > <aubin.constans@microchip.com>; Nicolas Ferre
> > > > > <nicolas.ferre@microchip.com>; Alexandre Belloni
> > > > > <alexandre.belloni@bootlin.com>; Claudiu Beznea
> > > > > <claudiu.beznea@tuxon.dev>; Manuel Lauss <manuel.lauss@gmail.com>;
> > > > > Micha?? Miros??aw <mirq-linux@rere.qmqm.pl>; Jaehoon Chung
> > > > > <jh80.chung@samsung.com>; Krzysztof Kozlowski <krzk@kernel.org>;
> > > > > Alim Akhtar <alim.akhtar@samsung.com>; Heiko Stuebner
> > > > > <heiko@sntech.de>; Russell King <linux@armlinux.org.uk>; Chaotian
> > > > > Jing <chaotian.jing@mediatek.com>; Matthias Brugger
> > > > > <matthias.bgg@gmail.com>; AngeloGioacchino Del Regno
> > > > > <angelogioacchino.delregno@collabora.com>;
> > > > > Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > > > > Adrian Hunter <adrian.hunter@intel.com>; Kamal Dasu
> > > > > <kamal.dasu@broadcom.com>; Al Cooper <alcooperx@gmail.com>;
> > > > > Broadcom internal kernel review list
> > > > > <bcm-kernel-feedback-list@broadcom.com>; Florian Fainelli
> > > > > <florian.fainelli@broadcom.com>; Bough Chen <haibo.chen@nxp.com>;
> > > > > Michal Simek <michal.simek@amd.com>; Eugen Hristev
> > > > > <eugen.hristev@linaro.org>; Vignesh Raghavendra <vigneshr@ti.com>;
> > > > > Ben Dooks <ben-linux@fluff.org>; Viresh Kumar
> > > > > <vireshk@kernel.org>; Orson Zhai <orsonzhai@gmail.com>; Baolin
> > > > > Wang <baolin.wang@linux.alibaba.com>; Chunyan Zhang
> > > > > <zhang.lyra@gmail.com>; Patrice Chotard
> > > > > <patrice.chotard@foss.st.com>; Thierry Reding
> > > > > <thierry.reding@gmail.com>; Jonathan Hunter
> > > > > <jonathanh@nvidia.com>; Chen-Yu Tsai <wens@csie.org>; Jernej
> > > > > Skrabec <jernej.skrabec@gmail.com>; Samuel Holland
> > > > > <samuel@sholland.org>; Alexey Charkov <alchark@gmail.com>
> > > > > Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > > Subject: [PATCH 18/38] mmc: sdhci-esdhc-imx: use modern PM macros
> > > > >
> > > > > Use the modern PM macros for the suspend and resume functions to
> > > > > be automatically dropped by the compiler when CONFIG_PM or
> > > > > CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
> > > > >
> > > > > This has the advantage of always compiling these functions in,
> > > > > independently of any Kconfig option. Thanks to that, bugs and
> > > > > other regressions are subsequently easier to catch.
> > > >
> > > > Hi Jisheng,
> > >
> > > Hi,
> > >
> > > >
> > > > When I remove all the configs under Power management options I got the
> > following build warning:
> > > >
> > > > drivers/mmc/host/sdhci-esdhc-imx.c:2079:12: warning:
> > > > ??sdhci_esdhc_resume?? defined but not used [-Wunused-function]
> > > >  2079 | static int sdhci_esdhc_resume(struct device *dev)
> > > >       |            ^~~~~~~~~~~~~~~~~~
> > > >   CC      drivers/mmc/host/cqhci-core.o
> > > > drivers/mmc/host/sdhci-esdhc-imx.c:2017:12: warning:
> > > > ??sdhci_esdhc_suspend?? defined but not used [-Wunused-function]
> > > >  2017 | static int sdhci_esdhc_suspend(struct device *dev)
> > > >       |            ^~~~~~~~~~~~~~~~~~~
> > >
> > > Hmm interesting, what's test toolchain? I tested this patch with gcc14
> > > with below three combinations before sending out, no warnings at all:
> > > PM + PM_SLEEP
> > > PM only
> > > !PM + ! PM_SLEEP
> > >
> > > The sdhci_esdhc_suspend|resume are referenced by
> > SYSTEM_SLEEP_PM_OPS.
> > > The pm_sleep_ptr() macro does the tricky, when both PM and PM_SLEEP
> > > are disabled, they are optimized out.
> > 
> > Hi Haibo,
> > 
> > Could you plz share your toolchain information? And FYI, today I tested clang
> > with the above three combinations, also no warnings. So I'm really interested
> > how to reproduce your warnings.
> > 
> > And the kernel CI build robot hasn't sent out warning email so far.
> 
> I'm not sure whether my test step is correct.
> I find for ARM, it force to enable the CONFIG_PM. to test your patch, I force remove all the PM related configs in .config. then meet this warning. And also many other driver build warning.

Now, I tried arm multi_v7_defconfig, then unselect those platforms which
enable CONFIG_PM, then enable COMPILE_TEST, then unselect CONFIG_PM and
CONFIG_PM_SLEEP, and build with  arm-linux-gnueabihf-gcc-14, stil no
any warning.
So can you plz share your defconfig? you can save it by 'make savedefconfig'
And I asked twice about your toolchain information, can you plz provide
it?

> Seems this test method is not correct, can anyone confirm here?
> 
> I did another test today, I enable the COMPILE_TEST, and use x86, chose the usdhc in menuconfig, disable CONFIG_PM, and build kernel by the following command, do not meet any warning:
> make ARCH=x86 CC=gcc -j64
> Seems this means !PM + !PM_SLEEP verify ok.

I tested not only x86, but also arm64 and riscv...

> 
> What's your method to test these PM related combination?

Similar as yours -- enable COMPILE_TEST.
Sure for the drivers I used: sdhci-of-dwcmshc, sdhci-pxav3 and
sdhci-xenon, I tested them.

B.R
