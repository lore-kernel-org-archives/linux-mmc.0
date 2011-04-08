From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v3] mmc: Add ioctl to let userspace apps send ACMDs
Date: Fri, 8 Apr 2011 14:25:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104081404210.15584@peruna>
References: <alpine.DEB.2.00.1104071816270.10238@peruna> <BANLkTin9hfr+VfprkDr-Lc+iY0qShmcnng@mail.gmail.com> <alpine.DEB.2.00.1104081202550.15086@peruna> <BANLkTi=wPYkrj72ixpN52WewVwsb9Ar-Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-1457432272-1302297946=:15584"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:41914 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751735Ab1DHVZ5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2011 17:25:57 -0400
In-Reply-To: <BANLkTi=wPYkrj72ixpN52WewVwsb9Ar-Vg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-1457432272-1302297946=:15584
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Andrei,

On Fri, 8 Apr 2011, Andrei Warkentin wrote:
> Is the timeout fixed or variable (I've seen all timeouts in the
> simplified ASSD to be specified in units of 250ms in fields of
> ASSD-PR)? Are you using this force_timeout_ns for DAT-transfer
> commands also, or just for R1B commands?

Actually, ASSD is a different-but-similarly-named-so-it's-confusing set
of functionality from that which I am using.  Do you have access to
"Part 3, Security Specification"?  There is no "simplified" version of
this spec.

As for the usage of the force_timeout_ns, yes, it is also used for
DAT-transfer commands.

>=20
> Do you always invoke commands that only involve transfers?

No.

> If not, I can see how your code handles R1B command timeouts correctly
> (always pretends it's a data transfer, even if 0-byte sized - thus
> host driver sets timeout correctly). In my boot partition patch set,
> there are two changes that add cmd_timeout (for DAT-busy commands) and
> enable proper handling of it for SDHCI. Obviously, none of the other

I'll have a look.

> hosts are fixed, so I guess what you are doing is okay for now. Could
> you add a "cmd_timeout" field to your ioctl, however, so in the future
> this is not a breaking change? Then right now you could add something
> like -
>=20
> if (blksz * blocks =3D=3D 0) {
>=20
>     /*
>      * We're doing a R1B command and relying on the host driver to
> compute timeout as if
>      * we were doing a data transfer. When all host drivers are fixed
> to handle R1B right, we won't have to rely
>      * on this behavior, and can make mrq.data NULL in this case, and
> pass the timeout
>      * through cmd.cmd_timeout.
>      */
>     data.timeout_ns =3D idata->cmd_timeout;
> }
>=20
> and in the future it can be changed to -
>=20
> if (blksz * blocks =3D=3D 0) {
>    mrq.data =3D NULL;
>    cmd.cmd_timeout =3D idata->cmd_timeout;
> }
>=20
>=20

Sure.  Like you said, this sounds reasonable while there's still
variation in timeout setting between the host drivers.

> >
> > In practice, 100 us. =A0Borderline? =A0Note that this sleep is separate=
 from
> > the timeout above. =A0This one is specifically for read operations wher=
e
> > there is no such thing as "busy".
> >
>=20
> You mean 'write'? I don't know. Nasty, really, in my opinion. If

Unfortunately, I really do mean "read".  I suspect it's meant to give
the card enough time to do the crypto <shrug>.

> you're doing ASSD operations then you know if the card is busy or not
> (via ASSD-state) . As in something like this paragraph from the
> simplified ASSD?
>=20
>          "The card shall not assert the BUSY signal for time periods
> longer then the WR_SEC_BUS_BUSY as
>          defined in the card properties register. The only indication
> for completion of a secure Token execution is
>          the ASSD_STATE field in the card status register. The host
> shall validate that the card is in the correct
>          state before attempting any ASSD command."
>=20
> If so, maybe it's worthwhile to just make your user code use SEND_PSI
> to get the ASSD_STATE registers and verify that previous secure
> operation completed before sending another one.
>=20
> Anyone else have an opinion on this?
>=20
> If this is not ASSD but something else, maybe you have a status
> register to query someplace?
>=20
> >> I'm not sure I understand why blksz is passed. If you needed to set
> >> the block size (via CMD16) prior to some command (like MMC password
> >> protection) I could kind of get it, but then all I see the blk size
> >> getting used for is calculating the data amount in bytes, so you're
> >> not doing that. So why not just infer it from the card queue?
> >>

I can't quote directly from this spec (it would be nice if some other
SDA member could corroborate here... Part 3, anybody???), but it is
clear that there is nothing to do but wait.  However, speaking to your
initial question about usleep() vs. udelay(), I'll try testing with
usleep().

John
---1463811328-1457432272-1302297946=:15584--
