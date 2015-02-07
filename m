From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH V4 1/4] mmc: core: Initial support for MMC power
 sequences
Date: Sat, 7 Feb 2015 12:07:23 +1100
Message-ID: <20150207120723.7e968aec@notabene.brown>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
	<1421658784-11980-2-git-send-email-ulf.hansson@linaro.org>
	<CABxcv==xBNsh+NrVb8PcBVtxQOKDL79YMkwK=wOL0gJZriEUjw@mail.gmail.com>
	<CAPDyKFoze-26fPm+C=D_o3tMSXWeTV4=2ZfOKaC3uLtxCrtjvg@mail.gmail.com>
	<20150131092715.566fa33c@notabene.brown>
	<CAPDyKFo6G+PpV7QpxBEOS_xUxXTQ14v=qVLGpBjT_z6T0vP85A@mail.gmail.com>
	<20150202150537.GE8656@n2100.arm.linux.org.uk>
	<CAPDyKFqjeg0d7r5XSK0d1EYfm2dvET3PQiHsDE_XchqFVYyC6g@mail.gmail.com>
	<20150203091042.379c7948@notabene.brown>
	<CAPDyKFpv4joU54tnO6N7zWmVV_021KFjQsscfpHHLjdqCCe8Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/wv8uU=fq3K24hg4PL5BUmHs"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59795 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbbBGBHe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 Feb 2015 20:07:34 -0500
In-Reply-To: <CAPDyKFpv4joU54tnO6N7zWmVV_021KFjQsscfpHHLjdqCCe8Xw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org
	<linux-arm-kernel@lists.infradead.org>," <mark.rutland@arm.com>, GTA04 owners <gta04-owner@goldelico.com>

--Sig_/wv8uU=fq3K24hg4PL5BUmHs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Feb 2015 13:39:13 +0100 Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:

> On 2 February 2015 at 23:10, NeilBrown <neilb@suse.de> wrote:
> > On Mon, 2 Feb 2015 16:10:29 +0100 Ulf Hansson <ulf.hansson@linaro.org> =
wrote:
> >
> >> On 2 February 2015 at 16:05, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Mon, Feb 02, 2015 at 03:57:37PM +0100, Ulf Hansson wrote:
> >> >> On 30 January 2015 at 23:27, NeilBrown <neilb@suse.de> wrote:
> >> >> > Shortly before this call is
> >> >> >
> >> >> >         host->ios.power_mode =3D MMC_POWER_ON;
> >> >> >         mmc_set_ios(host);
> >> >> >
> >> >> > and omap_hsmmc_set_ios() contains:
> >> >> >
> >> >> >                 switch (ios->power_mode) {
> >> >> >                 ....
> >> >> >                 case MMC_POWER_ON:
> >> >> >                         do_send_init_stream =3D 1;
> >> >> >                         break;
> >> >> >
> >> >> >
> >> >> >         if (do_send_init_stream)
> >> >> >                 send_init_stream(host);
> >> >> >
> >> >> > Which sends the "init stream" to the card.
> >> >> > If the card is still being reset at this time, the stream may not
> >> >> > be effective.
> >> >> >
> >> >> > I find that about 10%-20% of the time when I release the reset li=
ne
> >> >> > *after* the sequence is sent, my card fails to initialised.  When=
 I
> >> >> > release *before* the sequence is sent, it never fails.
> >> >>
> >> >> Okay, thanks for providing these details.
> >> >
> >> > The right thing to do then is to pulse the reset line at the pre-pow=
er-up
> >> > stage.
> >>
> >> I don't think that will work, since the card hasn't yet been powered
> >> and will thus not respond properly to the reset.
> >
> > My understanding, at least in the case of my hardware, is that the powe=
r-on
> > is sufficient to reset the device.
> > In my case, the one supply is shared between two devices (wifi and blue=
tooth)
> > so if the bluetooth is on, then the wifi cannot be power-cycled.  That =
is
> > when the reset is particularly needed.
> >
> > I'll try to arrange some testing to confirm this is the case.  Of cours=
e,
> > this would not be general result, it would only be relevant for my hard=
ware.
>=20
> I refreshed my memory for how the cw1200 WLAN device works on the
> ux500 SOC. I decided to post the complete information here, also for
> my own reference.
>=20
> These resources need to be controlled during the power sequence of CW1200:
> There are two GPIOs (one reset and one for SPI/SDIO selection), one LP
> (low power) clock and a few power supplies.
>=20
> The sequence for power up that needs to be followed are:
> 1. Keep reset GPIO asserted.
> 2. Enable power supplies.
> 3. Enable LP clock.
> 4. Wait a few LP clock cycles to let power/clock stabilize.
> 5. Make sure SPI/SDIO select pin is in SDIO mode. The value will be
> sampled by the WLAN device when reset GPIO is de-asserted.
> 6. De-assert reset GPIO.
> 7. Wait 30 ms for the WLAN device to power up.
>=20
> The power supplies may also be shared with a bluetooth device. That
> also means the reset GPIO must be kept asserted in power off state, to
> prevent power up of the WLAN device.
>=20
> >From the above, it's clear that toggling the reset GPIOs in the
> ->pre_power_on() phase won't work for CW1200/UX500 case.  That in
> conjunction with the "init stream" issue tells me that we need to
> progress with the below patch:
>=20
> "mmc: core: Invoke mmc_pwrseq_post_power_on() prior MMC_POWER_ON state"
> http://www.spinics.net/lists/arm-kernel/msg396592.html
>=20
> Kind regards
> Uffe

+ gta04-owner.

Thanks for those details.  They reminded me that I have seen something
similar for the wifi chip I use, and I found it here:

 http://lists.goldelico.com/pipermail/gta04-owner/2012-March/001917.html

In particular:

  After power-up the reset line should be active for >500us and then
  go high. A short impulse (1-20 us) can later reset the WiFi part.

Also, the wifi and bluetooth share both a power supply and a reset line.
However:

  BT also does not need a reset (unless you try to communicate
  with wrong baudrate and the HCI protocol gets unsynchronized).

  An impulse >5ms does a BT reset. Or a break condition on the
  RX line.


My experiments confirm that if the bluetooth is inactive so that the mmc ho=
st
is actually able to power-cycle the wifi, then the reset line isn't needed.
However if the bluetooth is holding the power supply enabled, then we
definitely need the reset to be pulsed low in mmc_power_up(), or the wifi
doesn't initialise properly.

Putting this all together, it seems like the ideal would be:
 - if power supply is already on, pulse reset for 20us, else
   pull reset low
 - enable power supply
 - wait 1ms
 - raise reset line
 - wait 30ms

This should ensure that the BT doesn't get reset, but that the wifi does.

However my further test results raise some questions.
If I have  BT active and pulse the reset for 1ms (using mdelay(1)), the wifi
doesn't initialise.  I get ETIMEDOUT from mmc_send_io_op_cond.
I need to increase the delay to mdelay(10) before that error goes away.

With that in place the wifi seems to work, but I get regular

  Bluetooth: hci0 hardware error 0x37

errors.  So I'm guessing that tying the two reset lines together might not
have been such a good idea.  I don't know yet how that actually affect any
active bluetooth session.

Even with the 10ms delay I do sometimes get errors ... I think.  I only have
concrete evidence when I was testing with "mmc_delay(1)" which in practice
appears to often delay for 10ms or more, probably due to the cond_resched();

However I sometimes got messages like:

[ 5349.438903] mmc1: queuing unknown CIS tuple 0x36 (1 bytes)
[ 5349.502868] mmc1: queuing unknown CIS tuple 0x0c (97 bytes)
[ 5349.518737] mmc1: queuing unknown CIS tuple 0x01 (16 bytes)

If I still get these with the more reliable mdelay(), I'm leaning towards s=
imply trying
sdio_init_card() within mmc_sdio_power_restore().  The errors occur less th=
an 1% of the
time, so this might be effective.

With respect to the current patch, this all simply means that a 10ms down
pulse on the reset is needed.  You currently have mmc_delay(10) in the and
that should be sufficient.  mmc_delay() may take longer than the requested
time, but should never take less time.

I had thought that a strict upper limit on the pulse might be important for
BT.  It seems that I cannot leave BT completely unaffected but, on my device
at least, holding reset low whenever wifi is not enabled would not be good =
as
it would break BT.

Thanks,
NeilBrown

--Sig_/wv8uU=fq3K24hg4PL5BUmHs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVNVlSznsnt1WYoG5AQKgBBAAjwD+T+6GWPTID8/aTNCf/O2/yb6eojkg
SLYAbynyIzVvxGfdcesptF13OUvm8t8/o7cCf4Fg9tPFexDikCeCbhjScYEC7gOD
uxDQFvnNOCzfEfoCJocB3Lwa0Arfijef1ZhsHBM8HJU49/Q64QwV7QdBUxJdIwP9
QKw0VAEioC0avRdFqeNg/g9GhkFXy6gZEL4/NKiFHtd6KVuuJVusOZTTKDNwrpyK
GQaERptC/UhXb660atNU5oydr9r8Q3egMDCJruvLM2gDv8F8rkrAVmY4Lc4fpl9f
nvGz2H89Chjs2AzeofhW+vmjJT5WZhEUBts8EtOAjSL1dYEZZx9ZfRYlzaINrU63
wtx7q254GhNQX93ifOU5PgHjo0+c1KC2pLp04vGz1vflo22I/uOXqdjJckw4kp40
TnTskSSSAacLqW5y4wVXgrHhGMYNLC0J27KoDVxQFXb17ekndgpO2R7kEUiVNBr9
wHHnQK61193uT9Pgh9IyvNV16T6COlizIhvShnP6SRDhcZXn4sXuSbuBvURN/PQs
PBIluYwA4sUORKlHhV9JH6tc45W871S8Lg4Nz0qDg6bJEX7gYlSPUaZE+gnsxS3v
/4etY6XxKN/3GnxEzphAKDix78fF5iTbY1fOoC26PoA+rGN8GmAeGy1DHEGWCp8a
jwu5r16dxDM=
=l3YJ
-----END PGP SIGNATURE-----

--Sig_/wv8uU=fq3K24hg4PL5BUmHs--
