From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Thu, 24 Jan 2013 12:54:28 +0000
Message-ID: <1359032068.26878.50.camel@hornet>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33492 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab3AXMyc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jan 2013 07:54:32 -0500
In-Reply-To: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Chris,

On Fri, 2012-12-14 at 15:38 +0000, Pawel Moll wrote:
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

This is just a polite, post-holiday, reminder about this patch... It has
been "Reviewed-by: Linus Walleij <linus.walleij@linaro.org>".

Cheers!

Pawel


