From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-s3c: Use CONFIG_PM_SLEEP to ifdef
	system suspend
Date: Mon, 2 Jan 2012 17:32:02 +0000
Message-ID: <20120102173202.GB14102@opensource.wolfsonmicro.com>
References: <1325211872-12567-1-git-send-email-broonie@opensource.wolfsonmicro.com> <4F01117F.6000206@samsung.com> <20120102114925.GF2899@opensource.wolfsonmicro.com> <CAELcNGTVj854nre5zNSmPXEHcWA2ujvauQm2eiYtv5PBYxUJvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55135 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752986Ab2ABRcF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2012 12:32:05 -0500
Content-Disposition: inline
In-Reply-To: <CAELcNGTVj854nre5zNSmPXEHcWA2ujvauQm2eiYtv5PBYxUJvw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jae hoon Chung <jh80.chung@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Kukjin Kim <kgene.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

On Tue, Jan 03, 2012 at 12:24:53AM +0900, Jae hoon Chung wrote:
> 2012/1/2 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> >> On 12/30/2011 11:24 AM, Mark Brown wrote:

> >> > +#include <linux/pm.h>
> >> I think this include is unnecessary.

> > I think you are wrong. =A0What makes you say that you think it is n=
ot
> > needed?

> If that didn't include,,what's happen?

The code won't compile as we're relying on a macro defined in the
header.

> I think that is already included...Anyway..this patch looks fine to m=
e..
> (if use with your patch[2/2]..)

It's not included directly (or indirectly as far as I remember).
