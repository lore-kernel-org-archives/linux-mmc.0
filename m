From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 2/2] mmc: dw_mmc-pltm: Remove Rockchip's custom dw_mmc driver structure
Date: Sat, 7 Dec 2013 01:12:10 +0100
Message-ID: <201312070112.10617.heiko@sntech.de>
References: <1386346223-18464-1-git-send-email-dinguyen@altera.com> <201312070022.03414.heiko@sntech.de> <52A25D45.7000500@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:42489 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754285Ab3LGAMX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 Dec 2013 19:12:23 -0500
In-Reply-To: <52A25D45.7000500@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinh.linux@gmail.com>
Cc: dinguyen@altera.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, linux-mmc@vger.kernel.org

Am Samstag, 7. Dezember 2013, 00:27:01 schrieb Dinh Nguyen:
> On 12/6/13 5:22 PM, Heiko St=FCbner wrote:
> > Am Samstag, 7. Dezember 2013, 00:18:07 schrieb Dinh Nguyen:
> >> On 12/6/13 5:14 PM, Heiko St=FCbner wrote:
> >>> Am Freitag, 6. Dezember 2013, 17:10:23 schrieb dinguyen@altera.co=
m:@@
> >>> -42,7 +42,7 @@
> >>>=20
> >>>  /* Common flag combinations */
> >>>  #define DW_MCI_DATA_ERROR_FLAGS        (SDMMC_INT_DRTO |
> >>>  SDMMC_INT_DCRC | \
> >>> =20
> >>>                                  SDMMC_INT_HTO | SDMMC_INT_SBE  |=
 \
> >>>=20
> >>> -                                SDMMC_INT_EBE)
> >>> +                                SDMMC_INT_EBE | SDMMC_INT_FRUN)
> >>>=20
> >>>  #define DW_MCI_CMD_ERROR_FLAGS (SDMMC_INT_RTO | SDMMC_INT_RCRC |=
 \
> >>> =20
> >>>> From: Dinh Nguyen <dinguyen@altera.com>
> >>>>=20
> >>>> Rockchip's implementation of the dw_mmc controller only requires=
 the
> >>>> setting of the SDMMC_CMD_USE_HOLD_REG on every command. With the=
 patch
> >>>> to set the SDMMC_CMD_USE_HOLD_REG by checking the slot's speed m=
ode,
> >>>> this Rockchip custom driver structure is no longer necessary.
> >>>>=20
> >>>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> >>>=20
> >>> hmm, testing will need a bit more time, as it seems one of the ch=
anges
> >>> merged during the 3.13 merge window broke the dw-mmc on the rockc=
hip.
> >>=20
> >> Thanks Heiko. Don't bother with v1, I overlooked another aspect of=
 using
> >> the hold
> >> reg. Let me send out a v2 for you to test.
> >=20
> > Don't worry ... as I've said, first I need to find the current issu=
e :-)
>=20
> What behavior are you seeing?

forget that I said anything :-)

It seems I messed up when bringing my rockchip development tree forward=
 to the=20
current 3.13-rc. It's working now with and without the change you sent.

So now I can wait for your v2 and test it then.

bedtime now,


Heiko

