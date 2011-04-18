From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4] mmc: Add ioctl to let userspace apps send ACMDs
Date: Mon, 18 Apr 2011 16:42:48 +0200
Message-ID: <201104181642.48742.arnd@arndb.de>
References: <alpine.DEB.2.00.1104111424140.32082@peruna> <201104130110.46815.arnd@arndb.de> <alpine.DEB.2.00.1104121622120.8483@peruna>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56471 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab1DROm4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2011 10:42:56 -0400
In-Reply-To: <alpine.DEB.2.00.1104121622120.8483@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrei Warkentin <andreiw@motorola.com>

On Wednesday 13 April 2011, John Calixto wrote:
> > Since the code is limited to ACMD and cannot do arbitrary commands, it's actually
> > not possible to use this for the passthrough scenario, so you should not mention
> > it in the changelog.
> > 
> > I would also still advocate something more high-level here because it's limited
> > to a single use case. If you make the ioctl interface do the security commands
> > directly, you would not need to rely on CAP_SYS_RAWIO.
> > 
> 
> I'm happy to remove the text about passthrough from the changelog, but
> it is a valid use for this ioctl.  I agree that ACMD by itself is not
> sufficient for full passthrough, but this patch is a starting point for
> anyone wanting to implement full CMD passthrough.
> 
> There are also several ACMD opcodes that are not related to security,
> but to functionality like requesting to change the signalling voltage,
> setting bus width, setting pre-erase block count, etc...  I think those
> commands are what caused others to request some kind of capability
> restriction.
> 

Ok, I see.

In v6, it seems you have implemented the full CMD passthrough, if I
read it correctly. Is there anything still missing?

	Arnd
