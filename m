From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v2 2/2] mmc: Check CAP_SYS_ADMIN for destructive ioctl
 ACMDs
Date: Tue, 5 Apr 2011 18:05:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104051733180.25803@peruna>
References: <alpine.DEB.2.00.1104051458350.25803@peruna> <BANLkTi=xcPEJxophfymqF5+Nd=aF40H=FQ@mail.gmail.com> <alpine.DEB.2.00.1104051613150.25803@peruna> <BANLkTi=wXpqFGhaBPnoRa+sQJ_eysvrTVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-junco.atl.sa.earthlink.net ([209.86.89.63]:58943 "EHLO
	elasmtp-junco.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752804Ab1DFBF6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 21:05:58 -0400
In-Reply-To: <BANLkTi=wXpqFGhaBPnoRa+sQJ_eysvrTVA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

On Tue, 5 Apr 2011, Andrei Warkentin wrote:
> Could you check the SD behavior for undefined ACMDs? If I do ACMD25,
> and ACMD25 is not defined, will it be executed as CMD25? This is the
> MMC behavior as I have mentioned.

The SD spec has a similar paragraph about unspecified ACMD opcodes -
they should be treated as the equivalent CMD opcodes.  However, all of
the opcodes that I listed are indeed specified.  So, if the card
identifies itself as an SD card, it must implement those opcodes.  If
it identifies itself as an SD card, and it does *not* implement the ACMD
opcodes I listed, then it likely "fell out the back door of the
manufacturing facility and landed on a store shelf" ;) ... its
quality/correct performance/reliability is unlikely.

> If so, that means you will be able to bypass access control and be
> able to (at the very least) read/write block as non-root.
> 

In my opinion, this is where we should defer to the UNIX file
permissions on the device node.  I know that my normal user account does
not have permission to open() the device node directly (do distros
really do that???).  I think that if you are allowing a non-root user to
open() the device node for your mmcblk device, you take on the all the
risk that entails.

> Is there a way for SD to verify which ACMDs the card actually
> supports? As far as MMC is concerned - no. I really wish ACMD had
> their own classes as well.
> 

Unfortunately not.  Would it help to also check (mode & FMODE_WRITE)
before allowing these operations?  At least then, the actions are
limited to what you could already do with plain old read().

John
