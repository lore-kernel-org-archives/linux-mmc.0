From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 02/12] dmaengine: split out virtual channel DMA support
 from sa11x0 driver
Date: Fri, 27 Apr 2012 20:57:54 +0200
Message-ID: <CACRpkdbC9GhwEs+qEt8-vurpbXJFtRcsgkg+S4Au16WG3RsKLg@mail.gmail.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
	<E1SMLkw-0002W4-HC@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <E1SMLkw-0002W4-HC@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 23, 2012 at 6:04 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Split the virtual slave channel DMA support from the sa11x0 driver so
> this code can be shared with other slave DMA engine drivers.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I really like the direction of this thing.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
