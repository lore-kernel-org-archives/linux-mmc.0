From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCHv3 1/3] mmc: dw_mmc: Enable the hold reg for certain
 speed modes
Date: Mon, 9 Dec 2013 10:15:31 -0600
Message-ID: <1386605731.29889.8.camel@linux-builds1>
References: <1386564668-24738-1-git-send-email-dinguyen@altera.com>
	 <1386564668-24738-2-git-send-email-dinguyen@altera.com>
	 <201312091056.42790.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [207.46.163.26] ([207.46.163.26]:18432 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932989Ab3LIQTk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Dec 2013 11:19:40 -0500
In-Reply-To: <201312091056.42790.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, linux-mmc@vger.kernel.org

On Mon, 2013-12-09 at 10:56 +0100, Heiko St=C3=BCbner wrote:
> Hi,
>=20
> Am Montag, 9. Dezember 2013, 05:51:06 schrieb dinguyen@altera.com:
> > From: Dinh Nguyen <dinguyen@altera.com>
> >=20
> > This patch will enable the SDMMC_CMD_USE_HOLD_REG bit when the slot=
 is
> > operating all timing modes, except for SDR50, DDR50, SDR104, and MM=
C_HS200.
> >=20
> > According to the Synopsys databook :"To meet the relatively high In=
put Hold
> > Time requirement for SDR12, SDR25, and other MMC speed modes, you s=
hould
> > program bit[29]use_hold_Reg of the CMD register to 1'b1;"..."Howeve=
r, for
> > the higher speed modes of SDR104, SDR50 and DDR50, you can meet the=
 much
> > smaller Input Hold Time requirement of 0.8ns by bypassing the Hold =
Register
> > (Path A in Figure 10-8, programming CMD.use_hold_reg =3D 1'b0) and =
then
> > adding delay elements on the output path as indicated.
> >=20
> > Also, "Never set CMD.use_hold_reg =3D 1 and cclk_in_drv phase shift=
 to 0 at
> > the same time. This would add an extra one-cycle delay on the outpu=
t path,
> > resulting in incorrect behavior."
> >=20
> > This patch also checks the IHR(Implement Hold Register) in the HCON
> > register.
> >=20
> > This information is taking from the v2.50a of the Synopsys Designwa=
re Cores
> > Mobile Storage Host Databook.
> >=20
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > Acked-by: Heiko Stuebner <heiko@sntech.de>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > v3: Read the IHR(Implement Hold Register) in the HCON
> > v2: Add check for cclk_in_drv phase shift in conjunction with use_h=
old_reg.
>=20
> just to say it still works with the v3 changes.

Thanks for testing.
>=20
> Interestingly, the rockchip manual does not specify the hcon register=
 at all,=20
> but reading it, I get a value of 0x4c534c1 - letting BIT(22) be the r=
equired=20
> one.

I believe that the hcon register is there for all versions of this IP,
as the driver is reading this register to get the bus data width.

But then again there this comment before the read:
/*
 * Get the host data width - this assumes that HCON has been set with
 * the correct values.
*/

Dinh
>=20
>=20
> Heiko
>=20



