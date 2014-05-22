From: Chris Ball <chris@printf.net>
Subject: Re: [GIT PULL] MMC updates for mmc-next for 3.16, take 3
Date: Thu, 22 May 2014 13:34:41 +0100
Message-ID: <86sio2q9em.fsf@void.printf.net>
References: <CAPDyKFo44fucVebB3f_qby1iWqjyq5P4XPAyD6og5ZWpqgO4=A@mail.gmail.com>
	<86zjiaqarn.fsf@void.printf.net>
	<CAPDyKFqhsErJvw-GYFq=x0xQigt=Tr3Luw=-n12cL5o5D5eGNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34242 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755280AbaEVMen (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 May 2014 08:34:43 -0400
In-Reply-To: <CAPDyKFqhsErJvw-GYFq=x0xQigt=Tr3Luw=-n12cL5o5D5eGNw@mail.gmail.com>
	(Ulf Hansson's message of "Thu, 22 May 2014 14:15:09 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Stephen Warren <swarren@nvidia.com>, Markus Pargmann <mpa@pengutronix.de>

Hi,

On Thu, May 22 2014, Ulf Hansson wrote:
> "mmc: sdhci: convert sdhci_set_uhs_signaling() into a library function"
>
> The following lines...
> +       else if ((ios->timing == MMC_TIMING_UHS_DDR50) ||
> +                (ios->timing == MMC_TIMING_MMC_DDR52))
> +               ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
>
> Should be replaced by;
> +       else if ((timing == MMC_TIMING_UHS_DDR50) ||
> +                (timing == MMC_TIMING_MMC_DDR52))
> +               ctrl_2 |= SDHCI_CTRL_UHS_DDR50;

Done and pushed out, thanks.

- Chris.
-- 
Chris Ball   <http://printf.net/>
