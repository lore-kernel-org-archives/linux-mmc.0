From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v4, 5/6] mmc: kconfig: select FSL_GUTS for MMC_SDHCI_OF_ESDHC
Date: Thu, 14 Jan 2016 11:31:03 +0100
Message-ID: <CAPDyKFog=YTMBORsf-DpbnxeogW5N0XzsK9FTS6jjiQSdn-GtQ@mail.gmail.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
	<1450067067-44869-6-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFo1g5_4bpYnTO96tGfVGStysN0FnmbSx-Se4tOa7f3rZQ@mail.gmail.com>
	<1450116253.15946.353.camel@freescale.com>
	<CAPDyKFrKSMC0uo8re3CxjNCUsVnEMau=GTKq=v_3ooNnQxw2Eg@mail.gmail.com>
	<CAPDyKFoYxM4Nv_pHCZbGzuswMCXTLyj6CYgLjYnRguscUs9LrQ@mail.gmail.com>
	<1451328478.18314.138.camel@freescale.com>
	<HE1PR04MB088973C32016C805D0E4B1E3F8F40@HE1PR04MB0889.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36067 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbcANKbE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2016 05:31:04 -0500
Received: by mail-qk0-f178.google.com with SMTP id q19so234019214qke.3
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2016 02:31:03 -0800 (PST)
In-Reply-To: <HE1PR04MB088973C32016C805D0E4B1E3F8F40@HE1PR04MB0889.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Scott Wood <scottwood@freescale.com>, Yangbo Lu <yangbo.lu@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, "X.Xie@freescale.com" <X.Xie@freescale.com>, Leo li <LeoLi@freescale.com>

> [Lu Yangbo-B47093] For the 'optional or not optional' problem, I think Scott's opinion is reasonable.
> If we use guts driver, 'select' could avoid missing the workaround.
> If we use syscon, select is better than 'depend on' since 'depend on' needs user self to find out the dependency.
>
> Anyway, we should continue the discussion to come to an agreement finally.
> I would very appreciate!

Please, go ahead and use the "select guts driver" option, as you both
seems to feel that strong about it.

Kind regards
Uffe
