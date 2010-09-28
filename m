From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 5/6] mmc: sdhci-of-esdhc: factor out common stuff
Date: Tue, 28 Sep 2010 16:58:21 +0400
Message-ID: <20100928125821.GA32626@oksana.dev.rtsoft.ru>
References: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
 <1285677406-3359-6-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44567 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab0I1M62 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 08:58:28 -0400
Received: by eyb6 with SMTP id 6so1733089eyb.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 05:58:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285677406-3359-6-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, zhangfei gao <zhangfei.gao@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, Philip Rakity <prakity@marvell.com>

On Tue, Sep 28, 2010 at 02:36:45PM +0200, Wolfram Sang wrote:
> Put everything which can be shared between the OF and platform version
> of this driver into a local .h-file.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> 
> Note: Anton suggested to move the function out of the .h-file into a seperate 
> .c-file. I tried this and it looked overly complicated to me; we ended up with
> a tiny .c _and_ .h file with no gain but a lot of complication added IMHO.
> So, while not being perfect, I hope we can live with this version.

I'd still like to see it as a C file.

[...]
> +static void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)

But if you do this in the .h file, you have to make it 'inline',
otherwise gcc might emit 'defined but not used' warning.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
