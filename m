From: Alessandro Rubini <rubini@unipv.it>
Subject: Re: [PATCH 13/31] ARM: amba: nomadik: get rid of NO_IRQ
 initializers
Date: Fri, 20 Jan 2012 23:33:35 +0100
Message-ID: <20120120223335.GA9479@mail.gnudd.com>
References: <E1RoAkC-0005F9-GQ@rmk-PC.arm.linux.org.uk>
  <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1RoAkC-0005F9-GQ@rmk-PC.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com
List-Id: linux-mmc@vger.kernel.org

> -	.irq = {IRQ_UART0, NO_IRQ},
> +	.irq = {IRQ_UART0},

Acked-by: Alessandro Rubini <rubini@unipv.it>
