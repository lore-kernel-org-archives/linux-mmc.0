From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 07/17] mmc: sdhci: avoid unnecessary mapping/unmapping of
 align buffer
Date: Mon, 21 Dec 2015 11:28:15 +0100
Message-ID: <CAPDyKFr9_ieo_HbJgq7YaFMGN5G-EXBuK5aLxOepP86yLQ5EWA@mail.gmail.com>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
	<E1aAO9H-0007yC-Dl@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35061 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbbLUK2Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 05:28:16 -0500
Received: by mail-yk0-f176.google.com with SMTP id v6so126171714ykc.2
        for <linux-mmc@vger.kernel.org>; Mon, 21 Dec 2015 02:28:16 -0800 (PST)
In-Reply-To: <E1aAO9H-0007yC-Dl@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>

On 19 December 2015 at 21:30, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> Unnecessarily mapping and unmapping the align buffer for SD cards is
> expensive: performance measurements on iMX6 show that this gives a hit
> of 10% on hdparm buffered disk reads.
>
> MMC/SD card IO comes from the mm/vfs which gives us page based IO, so
> for this case, the align buffer is not going to be used.  However, we
> still map and unmap this buffer.

What about the SDIO case? How will this change affect SDIO data transfers?

>
> Eliminate this by switching the align buffer to be a DMA coherent
> buffer, which needs no DMA maintanence to access the buffer.

/s/maintanence/maintenance

[...]

Kind regards
Uffe
