From: Charles Johnson <charles.f.johnson@intel.com>
Subject: Re: [RFC][PATCH] mmc: add an ioctl for erasing
Date: Mon, 24 May 2010 23:16:35 +0000 (UTC)
Message-ID: <loom.20100525T010840-267@post.gmane.org>
References: <4BF68EFC.70101@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:33246 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758557Ab0EXXUG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 May 2010 19:20:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1OGgwE-00038g-OD
	for linux-mmc@vger.kernel.org; Tue, 25 May 2010 01:20:02 +0200
Received: from jfdmzpr04-ext.jf.intel.com ([134.134.139.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 25 May 2010 01:20:02 +0200
Received: from charles.f.johnson by jfdmzpr04-ext.jf.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 25 May 2010 01:20:02 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

What would be calling these new ioctls ?? With file systems such as btrfs 
having implemented TRIM, why not check for a discard request and then do the 
TRIM ??



