From: Daniel Drake <dsd@laptop.org>
Subject: Re: crash in mmc subsystem during suspend
Date: Fri, 20 Nov 2009 15:10:58 +0000
Message-ID: <1258729858.2235.29.camel@localhost.localdomain>
References: <1258707087.2235.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:42551 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbZKTPKz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Nov 2009 10:10:55 -0500
Received: by fxm21 with SMTP id 21so3776707fxm.21
        for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2009 07:11:01 -0800 (PST)
In-Reply-To: <1258707087.2235.6.camel@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On Fri, 2009-11-20 at 08:51 +0000, Daniel Drake wrote:
> We're busy testing the suspend/resume functionality on the new OLPC
> XO-1.5 laptop. This uses a SD card as its primary disk, which is on a
> SDHCI controller on the VIA VX855 chipset. We are running Linux v2.6.31
> 
> We are occasionally encountering a crash from below mmc_rescan() during
> suspend:

OK, I just realised that our kernel includes various non-upstream
patches (yet), some of which are executing during suspend/resume and may
be a contributing factor to this problem.
(the patches allow us to retain power to our SDIO wifi card during
suspend)

Nevertheless, any help on our battle to stable suspend/resume and the
other bits we're working on is always appreciated. :)

Daniel


