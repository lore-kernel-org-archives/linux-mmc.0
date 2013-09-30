From: Bojan Prtvar <bojan.prtvar@rt-rk.com>
Subject: Re: [PATCH] Re: How to trigger sdio bus probing from user space
Date: Mon, 30 Sep 2013 11:56:50 +0000 (UTC)
Message-ID: <loom.20130930T135052-748@post.gmane.org>
References: <52455BCD.5040309@rt-rk.com> <l242pu$fog$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43593 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218Ab3I3MAG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 Sep 2013 08:00:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1VQc8y-0006tS-7V
	for linux-mmc@vger.kernel.org; Mon, 30 Sep 2013 14:00:04 +0200
Received: from cable-89-216-124-204.static.sbb.rs ([89.216.124.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 30 Sep 2013 14:00:04 +0200
Received: from bojan.prtvar by cable-89-216-124-204.static.sbb.rs with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 30 Sep 2013 14:00:04 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Romain Izard <romain.izard.pro <at> gmail.com> writes:

> 
> For internal use I have added a 'rescan' sysfs entry to the mmc
> controller, instead of the sdio device itself. It is quite similar to
> the way it is done in the scsi subsystem, and uses the same
> 'mmc_detect_change' function as you do .
> 
> Updated to use the new attribute groups syntax for 3.12, I obtain the
> following patch - compile-tested only, nothing more, as I do not have a
> 3.12 test system available.

Hi Romain,

Than you. This is exactly what I was looking for. My kernel version is
3.4.19 so I had back port your patch a little. At the and it is working OK.

Regards,
Bojan



