From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] MMCI: fetch pinctrl handle and set default state
Date: Mon, 29 Oct 2012 12:17:23 +0000
Message-ID: <20121029121723.GG21164@n2100.arm.linux.org.uk>
References: <1350892326-5125-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33097 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978Ab2J2MRa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Oct 2012 08:17:30 -0400
Content-Disposition: inline
In-Reply-To: <1350892326-5125-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@stericsson.com>, Anmar Oueja <anmar.oueja@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

On Mon, Oct 22, 2012 at 09:52:06AM +0200, Linus Walleij wrote:
> +	/* enable pins to be muxed in and configured */
> +	if (!IS_ERR(host->pins_default)) {
> +		ret = pinctrl_select_state(host->pinctrl, host->pins_default);
> +		if (ret)
> +			dev_err(&dev->dev, "could not set default pins\n");
> +	} else
> +		dev_err(&dev->dev, "could not get default pinstate\n");

Umm, are these errors or warnings?  Arguably, because we continue,
these seem to me to be warnings.

In my mind, a warning message is one which is reporting a condition which
we can continue from, whereas an error message is a condition which causes
immediate failure.  (Think about GCC... with warnings you still get code,
but the code may not be correct, but if you see an error message you don't
get any code.)
