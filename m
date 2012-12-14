From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Fri, 14 Dec 2012 20:44:51 +0100
Message-ID: <CACRpkdbDgVw2TozPxWrLkvfQaUi6H4myXSo7hAMgNnO6Z9G3Gg@mail.gmail.com>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:38321 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237Ab2LNTox (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 14:44:53 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so1461726eaa.19
        for <linux-mmc@vger.kernel.org>; Fri, 14 Dec 2012 11:44:52 -0800 (PST)
In-Reply-To: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>

On Fri, Dec 14, 2012 at 4:38 PM, Pawel Moll <pawel.moll@arm.com> wrote:

> The Versatile Express IOFPGA as shipped on VECD 5.0 (bitfiles v108/208
> and v116/216) contains a modified version of the PL180 MMCI, with
> PeriphID Configuration value changed to 0x2.
>
> This version adds an optional "hardware flow control" feature. When
> enabled MMC card clock will be automatically disabled when FIFO is
> about to over/underflow and re-enabled once the host retrieved some
> data. This makes the controller immune to over/underrun errors caused
> by big interrupt handling latencies.
>
> This patch adds relevant device variant in the driver.
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Code seems to do the right thing compared to what U300 and
Ux500 does with its similar HW flow control.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
