From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH 1/2] mmc: core: allow a reset gpio to be configured.
Date: Tue, 2 Dec 2014 07:05:24 +0100
Message-ID: <C98E0E67-23ED-4A4F-A90C-9BEEC6921544@goldelico.com>
References: <20141108000919.5629.55381.stgit@notabene.brown> <20141108001411.5629.25179.stgit@notabene.brown> <CAPDyKFrx98NspRU1nV3uJ6XwTuA4tZQkrYTfDoeXGR+f5htODQ@mail.gmail.com> <20141202125539.42f22074@notabene.brown>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:40512 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141AbaLBGFm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Dec 2014 01:05:42 -0500
In-Reply-To: <20141202125539.42f22074@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: List for communicating with real GTA04 owners <gta04-owner@goldelico.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Chris Ball <chris@printf.net>, Mark Brown <broonie@kernel.org>, Olof Johansson <olof@lixom.net>

Hi Neil,

Am 02.12.2014 um 02:55 schrieb NeilBrown <neilb@suse.de>:

> On Fri, 28 Nov 2014 12:56:33 +0100 Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>=20
>> On 8 November 2014 at 01:14, NeilBrown <neilb@suse.de> wrote:
>>> If the regulator supplying an SDIO device is shared
>>> with another device, the turning the regulator 'on' and 'off'
>>> will not actually cycle power and so will not reset
>>> the device.
>>>=20
>>> This is particularly a problem for some wi2si wireless modules whic=
h
>>> have a BT module on chip and can share power lines.
>>> Without the power-cycle, subsequent reset commands fail.
>>>=20
>>> So allow a 'reset' gpio to be specified.  If provided, the
>>> line is asserted during power-up.
>>=20
>> There have been several attempts to fix similar issues as this patch
>> does. The latest one I posted a few month ago, which wasn't accepted=
=2E
>> http://comments.gmane.org/gmane.linux.power-management.general/46635
>=20
> Thanks for that link.
>=20
>>=20
>> There has also been some off-list discussions on especially how we
>> should describe this in DT and there were actually some consensus ma=
de
>> around that. Still I haven't seen any patches on the mailing lists.
>=20
> Wish I could have a link for those off-list discussions :-)
>=20
> Based on what I read and my own thoughts about other devices that I'm=
 having
> trouble managing I wonder if the right approach might be to admit tha=
t these
> buses are *not* 100% discoverable.
>=20
> i.e. you can discover what is there once it is turned on, but you can=
not
> discover how to turn it on.

Indeed.

>=20
> So the *fix* is to allow attached devices to be explicitly listed.
> In my case I would create a child node of the mmc1 node, which is
> compatible=3D=93libertas,wifi" (or whatever the proper name is).

Sounds like a good idea to me.

>=20
> Then when the mmc1 wants to power-up, it does:
>=20
>   device_for_each_child(mmc_dev, NULL, power_up)
>=20
> where:
>=20
> static int power_up(struct device *dev, void *data)
> {
>       pm_runtime_get_sync(dev);
>       return 0;
> }
>=20
> Then I can put my reset-line management in the libertas driver instea=
d of
> trying to include some of it in the mmc driver.
>=20
> This has the advantage of the devicetree actually describing the hard=
ware
> (there is a libertas wifi SDIO chip attached) rather than the behavio=
ur
> (please turn on this regulator and toggle this GPIO to initialise the=
 device).
>=20
> I want to do a very similar thing for UARTs (so my GPS and Bluetooth =
turn on
> when /dev/ttyO? is opened), and I've been thinking about something si=
milar
> for USB - I have a USB attached GSM module, but it also has an Audio =
link and
> some reset/interrupt lines that need to be configured.
> If I could say to device tree "This USB port has this device attached=
", I
> think it would be a step in the right direction.

Thinking a little further, it could either be the core driver of the de=
vice/bus/protocol
or a special driver that only does power management. Or audio.

And we should consider using a list of strings in the compatible entry =
so that
several drivers can be loaded if the subsystem structure shows that thi=
s is simpler.

It could be one for power, one for audio. Or in the case of the liberta=
s a separate
power&reset driver for a specific chip that uses the libertas driver so=
 that chip
specific reset management is not introduced into the libertas core but =
separate.

=46or the usb connected modem the subnode to be attached is likely the =
PHY
where the self-powered device is connected to.

>=20
>=20
>=20
>>=20
>> So to summarize, I am really concerned that we keep having these pow=
er
>> sequence issues for SDIO devices and right now the discussion has be=
en
>> on hold. I am considering to hack on it myself, since I am tired of
>> waiting. :-)
>=20
> Please Cc me if you do.  Meanwhile I'll try to hack together code sup=
porting
> my latest idea and let you know if I get anywhere.
>=20
>>=20
>> Regarding this patch, I don't intent to apply it.
>=20
> Fair enough, I=92m starting to not like it so much anyway.
>=20

BR,
Nikolaus

