From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 2/5] mmc: bcm2835-sdhost: Add new driver for the internal SD controller.
Date: Fri, 09 Sep 2016 11:25:37 -0700
Message-ID: <877falaq1q.fsf@eliezer.anholt.net>
References: <1466595738-2229-1-git-send-email-kraxel@redhat.com> <1466595738-2229-3-git-send-email-kraxel@redhat.com> <CAPDyKFryfGpA+8tZhtkzUVMFhomOevFz8k9R1b2O0oUn8giT1w@mail.gmail.com> <1473347315.6698.53.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:37022 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751463AbcIISZj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Sep 2016 14:25:39 -0400
In-Reply-To: <1473347315.6698.53.camel@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, open list <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Gerd Hoffmann <kraxel@redhat.com> writes:

> On Mi, 2016-08-31 at 14:58 +0200, Ulf Hansson wrote:
>> On 22 June 2016 at 13:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> > From: Eric Anholt <eric@anholt.net>
>> >
>> > The 2835 has two SD controllers: The Arasan SDHCI controller that we
>> > currently use, and a custom SD controller.  The custom one runs faster
>> >
>> > The code was originally written by Phil Elwell in the downstream
>> > Rasbperry Pi tree, and I did a major cleanup on it (+319, -707 lines
>> > out of the original 2055) for inclusion.
>> >
>> > Signed-off-by: Eric Anholt <eric@anholt.net>
>>=20
>> Apologize for the delay!
>
> No problem, I was on summer vacation anyway ...
>
>> Could you start by providing some more information about the driver
>> and the controller in change in the change log please.
>
> Eric?  I don't know much more than what the commit message above says.
>
> Beside the speedup mentioned above driving the sdcard with the custom sd
> controller allows to use the sdhci (handled by sdhci-iproc) to be used
> for the wifi on the rpi3.

Maybe just add that we need both controllers in order to do both wifi
and SD card?  I don't know exactly what Ulf wants to see here.

>> > +static void bcm2835_sdhost_set_power(struct bcm2835_host *host, bool =
on)
>> > +{
>> > +       bcm2835_sdhost_write(host, on ? 1 : 0, SDVDD);
>>=20
>> What exactly does this power on/off?
>
> Dunno.  Eric?

Note: I don't know much about SD, so I'm just trying to play oracle for
you all here.

VDD bit 0 (POWER_ON) starts the power-on setup cycle by the sdhost once
power is already supplied to the card by some other means.  In the
SDHOST docs they assume you're going to use GPIO to control SD card
power, but for Raspberry Pi they just have the SD Card's VDD always on.
It's unclear to me what's controlling power to the Pi3 wifi/BT's SD
client, but I don't have specs to it.

Note that after you've set POWER_ON to 0, you can also set bit 1
(CLOCK_OFF) to 1 to turn off the clock to the power-on FSM.

>> > +       /* Need to send CMD12 if -
>> > +        * a) open-ended multiblock transfer (no CMD23)
>> > +        * b) error in multiblock transfer
>> > +        */
>> > +       if (host->mrq->stop && (data->error || !host->use_sbc)) {
>> > +               if (bcm2835_sdhost_send_command(host, host->mrq->stop)=
) {
>> > +                       /* No busy, so poll for completion */
>> > +                       if (!host->use_busy)
>>=20
>> This looks a bit weird. Can you explain why this is needed?
>
> Eric, any clue?  Some hardware bug workaround?
> Have a pointer to hardware specs?

Would no-CMD23 transfers mean that data->blocks was 0 to mean
indefinite?  That's the only mention of CMD12 in the spec -- when you've
set HBLC to 0, you need to CMD12 or CMD52 when you're done with the
transfer.

>> > +static void bcm2835_sdhost_set_ios(struct mmc_host *mmc, struct mmc_i=
os *ios)
>> > +{
>>=20
>> I don't find any place where you control power to the card here. Don't
>> you need to do that?
>
> Eric?

It looks like the card is always powered.  Do you mean something else by
power (like bringing up the FSM)?  Is there something else needed in
set_ios()?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX0v6hAAoJELXWKTbR/J7o4jkP/iNyFrnwMBm3uJxgTKJ0IVMo
3nM4Lrd4yaB3/Q0+48HJ5YIuQKF5SYfFi5NSgp/9Iz2dN4Aj6XOJr+quIo2zx7oN
TK/3UVbDfw7Spkds3/+K8BwA7yCxO4HC5vLp0SAyuANFPb9kenv24TDEcqMpPRtn
oM4xOVQ69IekHoWQXZj5U/5B5SM3tW8lKt7LF0Q3czOpINFJJQOksnraCst2KACq
C+HDr9bS4QHh8yMTBbuvJGOUYPM7tfIhoZ8sB8WUa/gpTmjUeEjMJb40hBAR0nsb
8YBmq3lGhqAEaJtIx7lT4VoG4XQxA9QOx6aKWID+QOkai/xkooyRMcbT38rS9mo6
DC/fe1GVXBFoWg9x5eXm65Qg+j4ppwpZR6Ou8DhokSEul1+MPcMdnNuaKFUU8KAB
bnJ4p6ZFEG1a2Bb+TiGVa+ZM+Aef+0B0ZmyNIBtcTDLYb1LAHDu7yZu46SAT5XRx
3lhpoy7YbIOGXKaBP+QSJHsslR139tFyTIhx/IWzAObE9LeG8MAOSxQDhb+6FbDu
8hAhb7SpsaElFQIsCgE/3OyCkBjuLkfpdNhrpEoLodEDh9xtEaKn98SWJf0ckezG
Dx7DnSgMa/nYx8Z5HRRdvYamMwCYGj9032UbwAglj9xhdLJxfE5Xk0oUjvWhY69X
SvlEKc77FYB/OBN2AW8m
=REAu
-----END PGP SIGNATURE-----
--=-=-=--
