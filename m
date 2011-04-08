From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v3] mmc: Add ioctl to let userspace apps send ACMDs
Date: Fri, 8 Apr 2011 12:20:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104081202550.15086@peruna>
References: <alpine.DEB.2.00.1104071816270.10238@peruna> <BANLkTin9hfr+VfprkDr-Lc+iY0qShmcnng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-1251982212-1302290411=:15086"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-junco.atl.sa.earthlink.net ([209.86.89.63]:36126 "EHLO
	elasmtp-junco.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752348Ab1DHTUM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2011 15:20:12 -0400
In-Reply-To: <BANLkTin9hfr+VfprkDr-Lc+iY0qShmcnng@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-1251982212-1302290411=:15086
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Andrei,

On Fri, 8 Apr 2011, Andrei Warkentin wrote:

> Hi John,
>=20
> On Thu, Apr 7, 2011 at 8:18 PM, John Calixto
> <john.calixto@modsystems.com> wrote:
> > + =A0 =A0 =A0 /* data.flags must already be set before doing this. */
> > + =A0 =A0 =A0 mmc_set_data_timeout(&data, card);
> > + =A0 =A0 =A0 /* Allow overriding the timeout_ns for empirical tuning. =
*/
> > + =A0 =A0 =A0 if (idata->ic.force_timeout_ns)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data.timeout_ns =3D idata->ic.force_timeo=
ut_ns;
> > +
>=20
> Are there any R1B ACMDs?
>=20

Yes, there are.  Do you think this timeout is unnecessary?  We found it
useful to adjust this to be more accepting of some cheaper cards that
exceeded the timeout in the spec (250 ms).

> > + =A0 =A0 =A0 mmc_wait_for_req(card->host, &mrq);
> > +
> > + =A0 =A0 =A0 if (cmd.error) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(card->host), "%s: cmd err=
or %d\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 __func__, cmd.error);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D cmd.error;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto acmd_rel_host;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 if (data.error) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(card->host), "%s: data er=
ror %d\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 __func__, data.error);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D data.error;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto acmd_rel_host;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* According to the SD specs, some commands require a d=
elay after
> > + =A0 =A0 =A0 =A0* issuing the command.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (idata->ic.postsleep_us)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(idata->ic.postsleep_us);
> > +
>=20
> How long can this possibly be? Does usleep make any sense here?
>=20

In practice, 100 us.  Borderline?  Note that this sleep is separate from
the timeout above.  This one is specifically for read operations where
there is no such thing as "busy".

> >
>  +struct mmc_ioc_cmd {
> > + =A0 =A0 =A0 int write_flag; =A0/* implies direction of data. =A0true =
=3D write, false =3D read */
> > + =A0 =A0 =A0 __u32 opcode;
> > + =A0 =A0 =A0 __u32 arg;
> > + =A0 =A0 =A0 __u32 response[4]; =A0/* CMD response */
> > + =A0 =A0 =A0 unsigned int flags;
> > + =A0 =A0 =A0 unsigned int blksz;
> > + =A0 =A0 =A0 unsigned int blocks;
>=20
> I'm not sure I understand why blksz is passed. If you needed to set
> the block size (via CMD16) prior to some command (like MMC password
> protection) I could kind of get it, but then all I see the blk size
> getting used for is calculating the data amount in bytes, so you're
> not doing that. So why not just infer it from the card queue?
>=20

The block size for some commands is strictly specified, and does
change according to the command.  In these cases, you do not call CMD16
to change it.  You just call the command knowing that its block size is
fixed according to spec.

John
---1463811328-1251982212-1302290411=:15086--
