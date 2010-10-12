From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
Date: Wed, 13 Oct 2010 00:06:23 +0200
Message-ID: <87aamjxe00.fsf@lechat.rtp-net.org>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lechat.rtp-net.org ([88.191.19.38]:51181 "EHLO
	lechat.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab0JLV53 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 17:57:29 -0400
In-Reply-To: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de> (Wolfram Sang's message of "Mon\, 11 Oct 2010 16\:21\:00 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Zhu Richard-R65037 <r65037@freescale.com>, linux-arm-kernel@lists.infradead.org

Wolfram Sang <w.sang@pengutronix.de> writes:

Hi,

> Here is the hopefully final (famous last words) version of my patch series. The
> first four are still updates/improvements for sdhci and sdhci-pltfm and are of
> generic interest, too. Thanks to Eric for the tests on MX25/35. Looking forward
> to comments/applied-to-mmc-next-messages ;)
>
> The series is based on mmc-next as of today and also available at
>
> 	git://git.pengutronix.de/git/wsa/linux-2.6.git pcm043-mmc

I've tried it on a efika mx (to2 version) and I've a problem with the
write-protect. It's on a GPIO and I don't see any way to configure the
esdhc-imx driver to use it. Any idea on how it should be done ?


thanks,
Arnaud
