From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH mmc-utils 0/6] mmc-utils: various cleanups
Date: Thu, 11 Jan 2018 21:57:43 +0100
Message-ID: <20180111205743.uinigacopk5eklgu@pengutronix.de>
References: <20171221133316.19466-1-u.kleine-koenig@pengutronix.de>
 <CAPDyKFova9BpB7jMLav8Y3BP2426WLy=LOoj_ato7eUCeTcrxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52197 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754713AbeALK1Z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Jan 2018 05:27:25 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFova9BpB7jMLav8Y3BP2426WLy=LOoj_ato7eUCeTcrxA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Sascha Hauer <kernel@pengutronix.de>

On Thu, Dec 21, 2017 at 03:21:33PM +0100, Ulf Hansson wrote:
> On 21 December 2017 at 14:33, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > while trying to teach barebox to do what can be achived in Linux with
> >
> >         mmc enh_area set ...
> >
> > (not only by reading but also by stealing code from mmc-utils) I noticed
> > a few things that when fixed make it easier for me to copy code. These
> > (and a few more) are fixed in this series.
> >
> > I hope I sent this series to the right people and list. If not, please
> > excuse me not knowing it better. I'm thankful for hints where to send
> > patches like this instead in the future.
> 
> This is the right place!
> 
> Chris maintains mmc-utils, however, I haven't heard from him for quite
> a while, let's hope that he sees this!

I heard nothing yet from Chris. So to ease not loosing my work I cloned
Chris' repository to https://github.com/ukleinek/mmc-utils and pushed my
patches there.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
