From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH v4] mmc: documentation of mmc non-blocking request usage
 and design.
Date: Tue, 5 Jul 2011 16:27:05 -0700
Message-ID: <20110705162705.c3081299.rdunlap@xenotime.net>
References: <1309901732-3735-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from oproxy7-pub.bluehost.com ([67.222.55.9]:50570 "HELO
	oproxy7-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754180Ab1GEX1J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2011 19:27:09 -0400
In-Reply-To: <1309901732-3735-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>

On Tue,  5 Jul 2011 23:35:32 +0200 Per Forlin wrote:

> +MMC block driver
> +================
> +
> +The issue_rw_rq() in the MMC block driver is made non-blocking.
> +The increase in throughput is proportional to the time it takes to
> +prepare (major part of preparations are dma_map_sg and dma_unmap_sg)
> +a request and how fast the memory is. The faster the MMC/SD is
> +the more significant the prepare request time becomes. Roughly the expected
> +performance gain is 5% for large writes and 10% on large reads on a L2 cache
> +platform. In power save mode, when clocks run on a lower frequency, the DMA
> +preparation may cost even more. As long as these slower preparations are run
> +in parallel with the transfer performance wont be affected.

                                             won't

Acked-by: Randy Dunlap <rdunlap@xenotime.net>


thanks.
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
