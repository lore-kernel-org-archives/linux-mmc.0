From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 29 Jun 2011 18:40:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106291813580.2874@utopia.booyaka.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com> <1308752314-32079-3-git-send-email-balajitk@ti.com> <alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com> <BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com> <87ei2dy9zk.fsf@ti.com>
 <BANLkTimccmdwXW2=jnAhv4GbzhcNPsUDQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1961410799-1309393046=:2874"
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <BANLkTimccmdwXW2=jnAhv4GbzhcNPsUDQA@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1106291817560.2874@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, "S, Venkatraman" <svenkatr@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com
List-Id: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1961410799-1309393046=:2874
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1106291817561.2874@utopia.booyaka.com>

+ Venkat

Hi Balaji

On Wed, 29 Jun 2011, T Krishnamoorthy, Balaji wrote:

> On Wed, Jun 29, 2011 at 2:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> > "T Krishnamoorthy, Balaji" <balajitk@ti.com> writes:
> >>
> >> I have seen some instabilities if delay is very less, on some=20
> >> production boards. The previous implementation used 100ms delay=20
> >> before disabling the clocks.
> >
> > And your new one is using 50ms. =A0How did this value come about?
>
> I don't have any specific affinity to this number, but when requests are=
=20
> bursty, they arrive within a few 10s of ms within each other. Didn't=20
> want to have the context/save restore penalty associated with every=20
> request.

Kevin and I just chatted a little bit about this.  It seems best to=20
separate the work done on the autosuspend timeout from the runtime PM=20
conversion. =20

So how about this: please send a new version of these patches with the=20
previous value, 100ms, for the autosuspend timeout.  That should hopefully=
=20
minimize the behavior change here for existing users.  And hopefully we'll=
=20
be able to get the series in for this merge window.

Then later, we need to come back to this autosuspend timeout issue.


- Paul
--155748971-1961410799-1309393046=:2874--
