From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Tue, 28 Jun 2011 23:18:03 +0530
Message-ID: <BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
	<1308752314-32079-3-git-send-email-balajitk@ti.com>
	<alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:47873 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758472Ab1F1RsG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Jun 2011 13:48:06 -0400
In-Reply-To: <alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com, adrian.hunter@nokia.com

On Tue, Jun 28, 2011 at 10:52 PM, Paul Walmsley <paul@pwsan.com> wrote:
> (cc'ing Adrian also)
>
> Hi Balaji
>
> On Wed, 22 Jun 2011, Balaji T K wrote:
>
>> Use runtime autosuspend APIs to enable auto suspend delay
>
> Does this really need to use runtime autosuspend? =A0Seems to me that=
 since
> PM runtime is just controlling the MMC IP blocks and not the regulato=
rs in
> this instance, this could simply use pm_runtime_put*() and just avoid=
 the
> extra power wastage and complexity involved in autosuspend.
>

I have seen some instabilities if delay is very less, on some productio=
n boards.
The previous implementation used 100ms delay before disabling the clock=
s.
Is there any specific issue I should be aware of, for using _autosuspen=
d ?

> Besides, the correct autosuspend timeout seems use-case dependent.
>
> By the way, if possible, it would be really good if you could update =
this
> patch series soon to address the comments. =A0If these MMC driver cha=
nges
> can be ready to merge for 3.1, then we also have a chance of
> integrating some hwmod cleanup patches that depend on this driver's P=
M
> runtime conversion.
>
>
Just noticed your mail after I posted my patches..
