From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Write errors on Cherrytrail eMMC
Date: Tue, 20 Oct 2015 11:44:35 +0200
Message-ID: <1445334275.4432.38.camel@hadess.net>
References: <1444436356.28661.47.camel@hadess.net>
	 <56186468.80805@rock-chips.com> <1444585510.28661.68.camel@hadess.net>
	 <1444990095.4432.9.camel@hadess.net> <1445006489.4432.14.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:46168 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515AbbJTJrh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2015 05:47:37 -0400
In-Reply-To: <1445006489.4432.14.camel@hadess.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, adrian.hunter@intel.com

On Fri, 2015-10-16 at 16:41 +0200, Bastien Nocera wrote:
> 
<snip>
> After testing, both patches need to be reverted to get a stable eMMC
> on
> the Surface 3. Where do we go from here?

I filed:
https://bugzilla.kernel.org/show_bug.cgi?id=106331
to make it easier for other Surface 3 users to follow the process.

Cheers
