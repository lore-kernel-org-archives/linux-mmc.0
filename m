From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 29 Jun 2011 08:42:42 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106290841160.2874@utopia.booyaka.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com> <1308752314-32079-3-git-send-email-balajitk@ti.com> <alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com> <BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com> <alpine.DEB.2.00.1106281240390.2874@utopia.booyaka.com>
 <BANLkTikni_xO7NQXQyv7XVeEH4Nowpr1Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-850960283-1309358562=:2874"
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <BANLkTikni_xO7NQXQyv7XVeEH4Nowpr1Ow@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com
List-Id: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-850960283-1309358562=:2874
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 29 Jun 2011, T Krishnamoorthy, Balaji wrote:

> On Wed, Jun 29, 2011 at 12:11 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Tue, 28 Jun 2011, T Krishnamoorthy, Balaji wrote:
> >
> >> On Tue, Jun 28, 2011 at 10:52 PM, Paul Walmsley <paul@pwsan.com> wrote=
:
> >> >
> >> > On Wed, 22 Jun 2011, Balaji T K wrote:
> >> >
> >> >> Use runtime autosuspend APIs to enable auto suspend delay
> >> >
> >> > Does this really need to use runtime autosuspend? =A0Seems to me tha=
t since
> >> > PM runtime is just controlling the MMC IP blocks and not the regulat=
ors in
> >> > this instance, this could simply use pm_runtime_put*() and just avoi=
d the
> >> > extra power wastage and complexity involved in autosuspend.
> >>
> >> I have seen some instabilities if delay is very less, on some producti=
on boards.
> >
> > Could you be more specific? =A0What type of instabilities did you see?
>=20
> There have been some experiments on our customer programs to reduce this=
=20
> value to a few ms and infrequent crashes were observed (stress testing=20
> for several hours) while trying to access the controller registers.

Was there an oops?  Any analysis, etc.?


- Paul
--155748971-850960283-1309358562=:2874--
