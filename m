From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFT] arm64: dts: renesas: salvator-common: enable SDR104 for SD
 cards
Date: Mon, 14 Aug 2017 17:46:54 +0200
Message-ID: <20170814154654.uwtgoya6oroeulgm@ninjato>
References: <20170802201311.1394-1-wsa+renesas@sang-engineering.com>
 <20170803074351.GC19671@verge.net.au>
 <20170803155357.GA3826@verge.net.au>
 <20170803155520.GB3826@verge.net.au>
 <20170808185445.GA2170@katana>
 <20170814051022.GC5654@verge.net.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="npyz65buecwrl272"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170814051022.GC5654@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--npyz65buecwrl272
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Mon, Aug 14, 2017 at 07:10:23AM +0200, Simon Horman wrote:
> On Tue, Aug 08, 2017 at 08:54:45PM +0200, Wolfram Sang wrote:
> >=20
> > > As it is an "RFT" I'm happy to apply it if you repost
> > > it or otherwise indicate that is what you would like to happen.
> >=20
> > As discussed in a chat, I tried SDR104 with my SDIO WiFi cards:
> >=20
> > H3:
> > - one slot worked flawlessly
> > - one slot could load FW but failed to read status
> > (with SDR50: both slots work)
> >=20
> > M3-W:
> > - both slots could not load the firmware
> > (with SDR50: one slot works, one fails to load FW)
> >=20
> > The cards, however, were correctly identified as SDR104 and there were
> > no tuning errors and no other SDHI related warnings.
> >=20
> > Changing TDSEL in the PFC did not change anything.
> >=20
> > The manual of the WiFi card (u-blox EMMY-W1) mentions a maximum line
> > length of 100mm. Measuring a direct line from the SoC to the slots,
> > I'd think we are very much on the edge of that. And given the length
> > of the SDIO adapter, we are surely exceeding that :(
> >=20
> > Maybe we should do more tests with more boards? On the other hand, it
> > seems the WiFi card is running out of the specs.
> >=20
> > So much for now. I'll sleep over it and try to get more data tomorrow.
>=20
> Thanks. Unfortunately my H3 is out of arms length but I can arrange
> some testing if it is helpful.

Do you have UHS-SDIO cards? Otherwise, some more testing in Spain will
be good.

> Is one possibility to enable it for the slots listed above that are now
> thought to work but not for the other one?

I don't think so. We'd need more test coverage. My gut feeling is that
it varies from board to board. Or more precisely: from environment
around the board to environment around the board. I'd like to test a)
more boards) and b) a resoldered WLAN card to skip the extra cabling
there. I still think the wire length of ~23cm (exceeding the spec of max
10cm) is a factor here, so resoldering would save ~6cm. That all sounds
to me like a hacking sprint for our next meeting.

Maybe ULCB has less line lengths? Would be interesting to check, too.

I could also try to apply more shielding here at home, too.

> The SDR50 failure on M3-W seems particularly troubling as that
> has been enabled in upstream for a while, right?

Not nice, yes. Yet, until this thread, there have been no issues
reported. So, it doesn't look like a substantial fault to me (famous
last words?)

Regards,

   Wolfram


--npyz65buecwrl272
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmRxe4ACgkQFA3kzBSg
KbZiXhAAlXYG7tG10ts0loX1+STXdWWwlxSSIBLymkhAyryUtEGT21bXYAkgDWQN
I/6yeqW5or/MuGcVsmwRy1Sz4upDiTk2TFPJFCN2KfpyT3ybFiKATf/zcFw/Pb9z
Pyp7xLnWSJuEtURO2/PR3RPgGZo9gL3PZraalAyw5pZLh6xhPyDN/LgYmbdYmx1d
Ljn8xcSFxG71ggiXS75yjzUq2ZqxpUq5/ZjUmP8wltjPLjaolYLgshiezB2C9k/D
oE1nbWQ+R3o5Pufq0xahZqVNwbyBX/oMSeYthMTZv/9Vdfj1JgPN9xhVY83RuLLR
qNjFpP3KC/dXXU0okFTuVFtB7msSfH7HA2p6tqSaFRQ1YarJJhhNM+p4746j2vTD
SQsZFI77hKK1svXtH6I0PKQux7YYAM0CVsg7zkWX71VSQA/4tKHmHOiCd0gNUJaU
CdKRWrGMyxVDNB4MqwaEBtgyjBcLVp11vkMHwFiD6OxR0bAk6p1B+LX0CQSqu8rL
7DrTW0Sx1Aj+Mi+ZbNGRY6JwxfrrGP3CpcT4M4Gcw1hPjpujd7T3RkSsqtmyub8l
JUKadcTtuoYTwWX84kQibu+wZJJCNJ9k81rk5jI5N8UhpLWzkbW5zcxg3XoMQt36
LrKNmuSrj8xC7q9n73Fy6p3RkfsTmJcGgmgYrxuiZeqhlPGn+dg=
=BQLX
-----END PGP SIGNATURE-----

--npyz65buecwrl272--
