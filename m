From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Boot partition support patch set.
Date: Fri, 8 Apr 2011 05:47:33 +0200
Message-ID: <201104080547.34130.arnd@arndb.de>
References: <1302052193-23317-1-git-send-email-andreiw@motorola.com> <BANLkTik7nDHvNbYRMEpyOvh71pXHuVgUTg@mail.gmail.com> <m339ltpxg6.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54683 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425Ab1DHDrm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2011 23:47:42 -0400
In-Reply-To: <m339ltpxg6.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Andrei Warkentin <andreiw@motorola.com>, linux-mmc@vger.kernel.org

On Thursday 07 April 2011, Chris Ball wrote:
> On Wed, Apr 06 2011, Andrei Warkentin wrote:
> >> This is the latest version of the MMC device partition support.
> >> It relies on a few other changes that were discussed recently.
> >>
> >> Thanks,
> >> A
> >>
> >> TOC:
> >> [PATCH 1/4] MMC: Rename erase_timeout to cmd_timeout.
> >> [PATCH 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
> >> [PATCH 3/4] MMC: Allow setting CMD timeout for CMD6 (SWITCH).
> >> [PATCH 4/4] MMC: MMC boot partitions support.
> >
> > Any problems, comments?
> 
> Looks good to me -- Arnd, did you want to add your Reviewed/Acked-by
> to this?
> 

I haven't done an in-depth review, but please add my Acked-by to the last
patch. For the other three, I have no idea what they do, but they all
seem harmless to me ;-)

	Arnd
