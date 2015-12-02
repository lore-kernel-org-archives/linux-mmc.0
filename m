From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC v02 03/15] dmaengine: core: Introduce new, universal API to
 request a channel
Date: Wed, 2 Dec 2015 12:00:42 +0200
Message-ID: <565EC14A.6020502@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-4-git-send-email-peter.ujfalusi@ti.com>
 <20151130155142.GZ2517@atomide.com> <565D56A0.2090204@ti.com>
 <20151201170031.GT23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151201170031.GT23396-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 12/01/2015 07:00 PM, Tony Lindgren wrote:
>> I see. The dm81xx basically am33xx/am43xx?
>=20
> Yeah similar to am33xx with different clocks and with a bunch of acce=
lerators.
>=20
>> Actually I would prefer to use the dmaengine's event router framewor=
k and we
>> do have support for the am33xx/am43xx type of crossbar already imple=
mented.
>> I'm going to resend the DTS series for am33xx/am43xx to convert them=
 to use
>> the new DT bindings along with the dma event router support:
>> https://www.mail-archive.com/linux-omap%40vger.kernel.org/msg120828.=
html
>=20
> OK yes a dmaengine event router works too when available. Good to see
> them as separate driver instances now :) Are only the dts changes mis=
sing
> now?
>=20
> FYI, when we have separate interconnect driver instances, we don't wa=
nt to
> and cannot tweak registers outside the interconnect instance because =
of them
> being in separate clock and/or power domains :p

What does this mean in practice? We can not touch these registers? The =
DMA
crossbar is a separate driver from the eDMA driver.

> In any case, it seems there's no harm using pinctrl for evtmux on dm8=
1xx
> until the event router is available. It's currently only needed on th=
e
> t410 emmc that I'm aware of :)

The AM33xx/AM43xx DMA crossbar support is in 4.4 already:
42dbdcc6bf96 dmaengine: ti-dma-crossbar: Add support for crossbar on AM=
33xx/AM43xx

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
