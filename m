From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: add ricoh e823 pci id
Date: Sat, 12 Feb 2011 18:29:26 +0100
Message-ID: <201102121829.26608.arnd@arndb.de>
References: <1297463131-3557-1-git-send-email-manoj.iyer@canonical.com> <1297463131-3557-2-git-send-email-manoj.iyer@canonical.com> <20110211224234.GA1958@void.printf.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:49170 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab1BLR3b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 12:29:31 -0500
In-Reply-To: <20110211224234.GA1958@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Manoj Iyer <manoj.iyer@canonical.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Friday 11 February 2011 23:42:34 Chris Ball wrote:
> >  
> >       {
> > +             .vendor         = PCI_VENDOR_ID_RICOH,
> > +             .device         = 0xe823,
> > +             .subvendor      = PCI_ANY_ID,
> > +             .subdevice      = PCI_ANY_ID,
> > +             .driver_data    = (kernel_ulong_t)&sdhci_ricoh_mmc,
> > +     },
> > +
> > +     {
> >               .vendor         = PCI_VENDOR_ID_ENE,
> >               .device         = PCI_DEVICE_ID_ENE_CB712_SD,
> >               .subvendor      = PCI_ANY_ID,
> 
> Thanks, pushed to mmc-next for .39.

Wouldn't this be a candidate for -stable as well?

	Arnd
