From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/2] mmc: use PM QoS instead of delayed clock gating
Date: Thu, 19 Jan 2012 17:20:48 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201191631210.12537@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55343 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436Ab2ASQU4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2012 11:20:56 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi all

I've already sent one of these two patches yesterday, but I forgot to 
include Rafael on the CC list and forgot to mention, that the patch should 
be treated as a regression fix and should go into 3.3. The reason why the 
commit

commit 7e09bedba1b87f9c7b34ba895b57baf0c36ccdc8
Author: Sujit Reddy Thumma <sthumma@codeaurora.org>
Date:   Mon Nov 14 13:53:29 2011 +0530

    mmc: core: Use delayed work in clock gating framework

can be considered a regression is, that it extends the powered-on time of 
the controller(s) and, possibly, of respective power domains by 200ms (by 
default), which is an essential change in behaviour in the negative 
direction.

However, if this is indeed the desired change, maybe the better approach 
now would be to modify this behaviour in individual drivers, which is 
exactly what the two patches in this series are doing. The tmio_mmc patch 
is just a resend from yesterday:

http://article.gmane.org/gmane.linux.kernel.mmc/12270

- repeated only for added CC and for easier review.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
