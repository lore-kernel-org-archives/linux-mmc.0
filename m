From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] plat-pxa: Enable ability to adjust SD/MMC clocks
Date: Thu, 28 Apr 2011 10:51:27 +0100
Message-ID: <20110428095127.GX17290@n2100.arm.linux.org.uk>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com> <20110427093328.GU17290@n2100.arm.linux.org.uk> <161C3F6C-0986-4364-B458-DBA4D08456FD@marvell.com> <1F336A22-BAC3-41E3-8D4E-5DF27874D1EA@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49883 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758088Ab1D1Jvj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2011 05:51:39 -0400
Content-Disposition: inline
In-Reply-To: <1F336A22-BAC3-41E3-8D4E-5DF27874D1EA@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Zhangfei Gao <zgao6@marvell.com>

On Wed, Apr 27, 2011 at 01:49:45PM -0700, Philip Rakity wrote:
> The patches were submitted a while ago.

It would be a good idea to reference them so that people know where to
find then and what the status of them is.  It's also a good idea to
Cc interested parties on related patches.

A couple of points in one of those patches though:

> +	if(gpio_request(reset, "sd8xxx reset")) {

space between if and (.

> +		printk(KERN_INFO "gpio %d request failed\n", reset);
> +		return;
> +	}
> +
> +	if(gpio_request(poweron, "sd8xxx PDn")) {
> +		gpio_free(reset);
> +		printk(KERN_INFO "gpio %d request failed\n", poweron);
> +		return;
> +	}
> +
> +	gpio_direction_output(poweron, 1);
> +	msleep (1);

No space between msleep and (.
