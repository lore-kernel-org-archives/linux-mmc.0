From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 1/7] mmc: lock: Use the kernel "KEYS" subsystem to get a card's password
Date: Thu, 15 Aug 2013 01:16:12 +0000 (UTC)
Message-ID: <loom.20130815T031441-68@post.gmane.org>
References: <1376407290-21477-1-git-send-email-alcooperx@gmail.com> <1376407290-21477-2-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38638 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758378Ab3HOBUF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 14 Aug 2013 21:20:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1V9mEN-0007w0-ND
	for linux-mmc@vger.kernel.org; Thu, 15 Aug 2013 03:20:04 +0200
Received: from 5520-maca-inet1-outside.broadcom.com ([216.31.211.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 15 Aug 2013 03:20:03 +0200
Received: from computersforpeace by 5520-maca-inet1-outside.broadcom.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 15 Aug 2013 03:20:03 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Al Cooper <alcooperx@gmail.com> writes:
> From: Al Cooper <acooper@broadcom.com>
> 
> Use the kernel "KEYS" subsystem to get a password for a card based on
> the card's CID. This code was based on a patch set submitted by
> Anderson Briglia in 2006.
> 
> refs #SWLINUX-2545

You'll want to drop these tags, as they don't have any use in Linus' git logs.

Brian

