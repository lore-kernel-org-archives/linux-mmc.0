From: Edward Falk <falk@efalk.org>
Subject: Features vs versions (Was: Patch: eMMC boot partition needs to be
 deactivated for linux to find user partitions)
Date: Mon, 15 Mar 2010 11:32:45 -0700
Message-ID: <4B9E7D4D.1030807@efalk.org>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com> <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com> <4B9DEAE2.3030707@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from a.mail.sonic.net ([64.142.16.245]:57791 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932739Ab0COSqv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Mar 2010 14:46:51 -0400
Received: from peregrine.palm1.palmone.com (palm-64-28-152-131.palm.com [64.28.152.131])
	(authenticated bits=0)
	by a.mail.sonic.net (8.13.8.Beta0-Sonic/8.13.7) with ESMTP id o2FIWjaa030722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mmc@vger.kernel.org>; Mon, 15 Mar 2010 11:32:46 -0700
In-Reply-To: <4B9DEAE2.3030707@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Adrian Hunter wrote:

> That switch command should not be used for devices that do not
> support it e.g. eMMC 4.3 and before.

I've been wondering about this -- how can you tell which feature is 
available in which version of the standard?  I have 84-A44 in front of 
me now, and I can't see it.  Do I need to just obtain older versions of 
the standards doc and compare them by hand?

	-ed falk
