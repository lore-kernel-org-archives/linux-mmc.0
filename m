From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Tue, 28 Jun 2011 12:41:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106281240390.2874@utopia.booyaka.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com> <1308752314-32079-3-git-send-email-balajitk@ti.com> <alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com> <BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-16772951-1309286490=:2874"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43454 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760649Ab1F1Slc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2011 14:41:32 -0400
In-Reply-To: <BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-16772951-1309286490=:2874
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 28 Jun 2011, T Krishnamoorthy, Balaji wrote:

> On Tue, Jun 28, 2011 at 10:52 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > On Wed, 22 Jun 2011, Balaji T K wrote:
> >
> >> Use runtime autosuspend APIs to enable auto suspend delay
> >
> > Does this really need to use runtime autosuspend? =A0Seems to me that s=
ince
> > PM runtime is just controlling the MMC IP blocks and not the regulators=
 in
> > this instance, this could simply use pm_runtime_put*() and just avoid t=
he
> > extra power wastage and complexity involved in autosuspend.
>=20
> I have seen some instabilities if delay is very less, on some production =
boards.

Could you be more specific?  What type of instabilities did you see?

> The previous implementation used 100ms delay before disabling the clocks.
> Is there any specific issue I should be aware of, for using _autosuspend =
?


- Paul
--155748971-16772951-1309286490=:2874--
