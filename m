From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v4] mmc: Add ioctl to let userspace apps send ACMDs
Date: Mon, 18 Apr 2011 09:37:15 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104180931270.16629@peruna>
References: <alpine.DEB.2.00.1104111424140.32082@peruna> <201104130110.46815.arnd@arndb.de> <alpine.DEB.2.00.1104121622120.8483@peruna> <201104181642.48742.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:60349 "EHLO
	elasmtp-galgo.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755720Ab1DRQhY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2011 12:37:24 -0400
In-Reply-To: <201104181642.48742.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrei Warkentin <andreiw@motorola.com>

On Mon, 18 Apr 2011, Arnd Bergmann wrote:
> In v6, it seems you have implemented the full CMD passthrough, if I
> read it correctly. Is there anything still missing?
> 

Hi Arnd,

As far as I have tested, the v6 patch does indeed have full CMD
passthrough.

John
