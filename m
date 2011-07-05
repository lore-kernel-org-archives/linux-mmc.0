From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] mmci: use StartBitErr to detect bad connections
Date: Tue, 5 Jul 2011 12:16:11 +0100
Message-ID: <20110705111611.GW8286@n2100.arm.linux.org.uk>
References: <1309247845-17105-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38732 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab1GELQV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2011 07:16:21 -0400
Content-Disposition: inline
In-Reply-To: <1309247845-17105-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>

On Tue, Jun 28, 2011 at 09:57:25AM +0200, Linus Walleij wrote:
> Stresstesting insert/remove of SD-cards can trigger
> a StartBitErr. This made the driver to hang in forever
> waiting for a non ocurring data timeout.
> 
> This bit and interrupt is documented in the original
> PL180 TRM, just never implemented until now.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>
> Reviewed-by: Jonas Aberg <jonas.aberg@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
