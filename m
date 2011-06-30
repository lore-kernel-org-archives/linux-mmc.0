From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] mmci: fixup sg buffer handling in pio_write
Date: Thu, 30 Jun 2011 15:33:38 +0100
Message-ID: <20110630143338.GA21898@n2100.arm.linux.org.uk>
References: <1309247869-17220-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57649 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab1F3Odr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jun 2011 10:33:47 -0400
Content-Disposition: inline
In-Reply-To: <1309247869-17220-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>

On Tue, Jun 28, 2011 at 09:57:49AM +0200, Linus Walleij wrote:
> From: Ulf Hansson <ulf.hansson@stericsson.com>
> 
> Earlier code in pio_write was expecting that each
> scatter-gather buffer was 4-bytes aligned which is
> not always the case, especially when dealing with long
> chains of SDIO packages. This patch fix the problem by
> using a 4 bytes buffer to cache unaligned data between
> each unaligned pio_write operation.
> 
> In the last transaction we pad the last write access
> with zeroes.
> 
> Remove older fix for ST Micro since it was not a
> variant-specific problem.

This is horrid, and will probably cause MMCI to underrun on ARM platforms
where it hasn't done so previously due to all the extra overhead at the
start of the interrupt.

Therefore, I don't think this is acceptable.

Plus, what exactly is it trying to solve - writesl() handles unaligned
buffers already.

> +		if (len > sg_miter->consumed)
> +			len = sg_miter->consumed;
> +		else
> +			sg_miter->consumed = len;

sg_miter is supposed to _always_ be written with the number of bytes
consumed.  To start playing these games with it is inviting trouble,
and to start return a length greater than 'remain' from mmci_pio_write
is just silly.

What is probably a better approach is to detect this condition when
we receive the request, and copy the data into a bounce buffer.
