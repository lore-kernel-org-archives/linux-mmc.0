From: Daniel Yerushalmi <danielye@gmail.com>
Subject: Re: [RFC] mmc: Do no export the rpmb as a partition
Date: Sun, 15 Feb 2015 10:14:45 +0000 (UTC)
Message-ID: <loom.20150215T110718-321@post.gmane.org>
References: <1423672220-13744-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33972 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582AbbBOKUH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 15 Feb 2015 05:20:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1YMwJ2-00063t-NR
	for linux-mmc@vger.kernel.org; Sun, 15 Feb 2015 11:20:05 +0100
Received: from bzq-25-79-130.cust.bezeqint.net ([212.25.79.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sun, 15 Feb 2015 11:20:04 +0100
Received: from danielye by bzq-25-79-130.cust.bezeqint.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Sun, 15 Feb 2015 11:20:04 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy <at> linutronix.de> writes:

> So my question is basically, is it okay to read from this partition?

You can read from RPMB only after sending RPMB command (25) according to
RPMB protocol. So the RPMB is not "first class" partition.


