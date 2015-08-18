From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: mmc: Driver for CB710/720 memory card reader (MMC part)
Date: Tue, 18 Aug 2015 20:05:26 +0200
Message-ID: <20150818180526.GA19411@rere.qmqm.pl>
References: <20150812110051.GC22571@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([84.10.57.10]:50895 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601AbbHRSU7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 18 Aug 2015 14:20:59 -0400
Content-Disposition: inline
In-Reply-To: <20150812110051.GC22571@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-mmc@vger.kernel.org

On Wed, Aug 12, 2015 at 02:00:51PM +0300, Dan Carpenter wrote:
> Hello Micha=B3 Miros=B3aw,
>=20
> The patch 5f5bac8272be: "mmc: Driver for CB710/720 memory card reader
> (MMC part)" from May 22, 2009, leads to the following static checker
> warning:
>=20
> 	drivers/mmc/host/cb710-mmc.c:579 cb710_mmc_set_ios()
> 	warn: 'err' can be either negative or positive
>=20
> drivers/mmc/host/cb710-mmc.c
>    112 =20
>    113  static int cb710_check_event(struct cb710_slot *slot, u8 what=
)
>    114  {
>    115          u16 status;
>    116 =20
>    117          status =3D cb710_read_port_16(slot, CB710_MMC_STATUS_=
PORT);
>    118 =20
>    119          if (status & CB710_MMC_S0_FIFO_UNDERFLOW) {
>    120                  /* it is just a guess, so log it */
>    121                  dev_dbg(cb710_slot_dev(slot),
>    122                          "CHECK : ignoring bit 6 in status %04=
X\n", status);
>    123                  cb710_write_port_8(slot, CB710_MMC_STATUS0_PO=
RT,
>    124                          CB710_MMC_S0_FIFO_UNDERFLOW);
>    125                  status &=3D ~CB710_MMC_S0_FIFO_UNDERFLOW;
>    126          }
>    127 =20
>    128          if (status & CB710_MMC_STATUS_ERROR_EVENTS) {
>    129                  dev_dbg(cb710_slot_dev(slot),
>    130                          "CHECK : returning EIO on status %04X=
\n", status);
>    131                  cb710_write_port_8(slot, CB710_MMC_STATUS0_PO=
RT, status & 0xFF);
>    132                  cb710_write_port_8(slot, CB710_MMC_STATUS1_PO=
RT,
>    133                          CB710_MMC_S1_RESET);
>    134                  return -EIO;
>    135          }
>    136 =20
>    137          /* 'what' is a bit in MMC_STATUS1 */
>    138          if ((status >> 8) & what) {
>    139                  cb710_write_port_8(slot, CB710_MMC_STATUS1_PO=
RT, what);
>    140                  return 1;
>=20
> There are two callers to this function.  It appears to me that one
> expects zero on error and one expects non-zero on error.  It is
> confusing and there are no comments explaining the return codes.

Hah. The code is correct, though I admit that it's not obvious at first=
 glance.
=46eel free to send a patch. :-)

Call inside cb710_wait_for_event() is spinning while there's no error a=
nd the
requested event was not signalled. The call from cb710_mmc_powerup() is=
 there
only to check for error condition and since it gets 0 in 'what' it will=
 never
return 1 (>0).

Best Regards,
Micha=B3 Miros=B3aw
