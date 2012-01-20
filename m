From: Alessandro Rubini <rubini@unipv.it>
Subject: Re: [PATCH 29/31] ARM: amba: nomadik: use common amba device
 initializers
Date: Fri, 20 Jan 2012 23:33:47 +0100
Message-ID: <20120120223347.GA9523@mail.gnudd.com>
References: <E1RoApP-0005GE-D8@rmk-PC.arm.linux.org.uk>
  <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail2.gnudd.com ([213.203.150.91]:63895 "EHLO mail.gnudd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755877Ab2ATWeU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Jan 2012 17:34:20 -0500
Content-Disposition: inline
In-Reply-To: <E1RoApP-0005GE-D8@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com

> +static AMBA_APB_DEVICE(uart0, "uart0", 0, NOMADIK_UART0_BASE,
> +	{ IRQ_UART0 }, NULL);

Acked-by: Alessandro Rubini <rubini@unipv.it>

thanks
/alessandro
