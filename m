From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 05/12] mmc: omap_hsmmc: add DMA engine support
Date: Fri, 27 Apr 2012 22:34:09 +0200
Message-ID: <CACRpkdY926ZWoxhm9hKfhWCF5bSmm36GVsVGJZVYswxh1YJxuQ@mail.gmail.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
	<E1SMLlv-0002WI-8a@rmk-PC.arm.linux.org.uk>
	<CACRpkdZPEnPTpp+vwJed4ZkXLNjEVUz==YVvwg_bhuUOyD3Fxg@mail.gmail.com>
	<20120427190332.GG28062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120427190332.GG28062@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Apr 27, 2012 at 9:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Apr 27, 2012 at 09:00:22PM +0200, Linus Walleij wrote:

>> Are these development artifacts?
>
> Read the commit message. ;)
>
> They're there (and removed by the next patch) so that the driver can
> be easily switched between DMA engine and the private DMA API. =A0Sim=
ply
> change the relevant #if to zero at build time.

Yeah I saw now when reading through the series...

The whole thing looks very good, since I'm not that into OMAP stuff
I'm trying now to glance over the dmaengine semantics part that
I understand a bit atleast.

Thanks,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
