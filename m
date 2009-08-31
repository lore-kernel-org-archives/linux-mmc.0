From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Mon, 31 Aug 2009 21:19:12 +0200
Message-ID: <200908312119.12121.rjw@sisk.pl>
References: <c4e36d110908310451t7c238e09u5af112fa3321cc23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53639 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbZHaTSb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 31 Aug 2009 15:18:31 -0400
In-Reply-To: <c4e36d110908310451t7c238e09u5af112fa3321cc23@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org

On Monday 31 August 2009, Zdenek Kabelac wrote:
> Hi
> 
> I've noticed that my machine freezes while doing s2r and having
> mounted filesystem from SD card.
> 
> My system: Lenovo T61, 4GB, C2D, kernel 2.6.31-rc8
> 
> Here is the trace of  suspend when SD card is inserted, follows resume
> and again suspend and this time with mounted filesystem from SD card.
> 
> System locks with: PM: Removing info for mmc:mmc0:b368
> Also btusb_bulk_complete: errors are interesting - I've noticed few
> bugzillas in the google.
> I could try bisect to find the patch - but it will take time....
> So hopefully this trace will help.

Not really. :-(

Is this a new regression in 2.6.31-rc, or does 2.6.30 also fail?

Rafael
