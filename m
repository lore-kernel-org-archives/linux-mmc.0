From: Dmitry Shmidt <dimitrysh@android.com>
Subject: =?utf-8?b?bW1jX3Jlc2Nhbg==?= failure in case of =?utf-8?b?Q09ORklHX01NQ19VTlNBRkVfUkVTVU1F?=
Date: Sat, 12 Feb 2011 00:33:33 +0000 (UTC)
Message-ID: <loom.20110212T012758-658@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:32799 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752298Ab1BLAdu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Feb 2011 19:33:50 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1Po3Qp-0007Ei-R2
	for linux-mmc@vger.kernel.org; Sat, 12 Feb 2011 01:33:47 +0100
Received: from 216-239-45-4.google.com ([216.239.45.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 01:33:47 +0100
Received: from dimitrysh by 216-239-45-4.google.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sat, 12 Feb 2011 01:33:47 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

Recently new check was added to core.c function mmc_rescan():
    if (host->bus_ops && host->bus_ops->detect && !host->bus_dead
        && mmc_card_is_removable(host)) <<<< This one
        host->bus_ops->detect(host);
mmc_card_is_removable() is checking
 !(host->caps & MMC_CAP_NONREMOVABLE) && mmc_assume_removable;

If we use CONFIG_MMC_UNSAFE_RESUME then
  mmc_assume_removable will be 0 and any card will be always considered
as non-removable. And host->bus_ops->detect() will not be called on card
removal.

Am I missing something?
Thanks,

Dmitry

