From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] mmc: core add the property for hs200
Date: Tue, 21 Jan 2014 14:36:12 +0100
Message-ID: <201401211436.12279.arnd@arndb.de>
References: <52DE4916.4090603@samsung.com> <CAPDyKFpV4pSxQEHrvqXyQEL2Q6hB2a0ryXgL+nwU16=2Y5brLQ@mail.gmail.com> <52DE6610.4030702@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53464 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707AbaAUNg2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2014 08:36:28 -0500
In-Reply-To: <52DE6610.4030702@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Tuesday 21 January 2014, Jaehoon Chung wrote:
> On 01/21/2014 09:12 PM, Ulf Hansson wrote:
> > On 21 January 2014 11:30, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Tuesday 21 January 2014 19:16:54 Jaehoon Chung wrote:
> >>
> >> Unfortunately, the names are not particularly intuitive (the caps2
> >> part in particular), but it's probably better to stick with that
> >> now.
> > 
> > I would prefer to remove "caps2" from the property name.
> > 
> > Going forward and cleaning up all the non needed caps flags, could
> > mean we may want to move caps2 flags into caps flags, I guess. This
> > would not be suitable if we decide to name the property as above.
> 
> Agreed,caps2 flags can be changed in future.
> I will remove the "caps2" from name.
> And i will add the document in binding/mmc/mmc.txt at next patch.
> 

In general, we have to be very careful changing these things, so we don't
break existing dts files booting with newer kernels.

In this particular case, I think we're fine, since the hs200 properties
are fairly new and haven't made it into any dts files so far.

	Arnd
