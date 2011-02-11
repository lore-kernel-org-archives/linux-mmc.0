From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/5] mmc: sdhci-esdhc: broken card detection is not a
 default quirk
Date: Fri, 11 Feb 2011 13:07:39 +0300
Message-ID: <20110211100739.GA8965@oksana.dev.rtsoft.ru>
References: <1297365291-1038-1-git-send-email-w.sang@pengutronix.de>
 <1297365291-1038-3-git-send-email-w.sang@pengutronix.de>
 <20110210191821.GD2206@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51106 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab1BKKHo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Feb 2011 05:07:44 -0500
Received: by bwz15 with SMTP id 15so3038340bwz.19
        for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 02:07:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110210191821.GD2206@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, Zhu Richard-R65037 <r65037@freescale.com>

On Thu, Feb 10, 2011 at 08:18:21PM +0100, Wolfram Sang wrote:
> 
> Adding Anton to Cc...
[...]
> >  struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
> > -	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA,
> > +	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA
> > +			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,

Minor nit: "|" should be on the previous line.

Otherwise,

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
