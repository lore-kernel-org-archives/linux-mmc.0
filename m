From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: =?utf-8?b?TU1DX0NBUF9XQUlUX1dISUxFX0JVU1k=?= in sdhci
Date: Mon, 19 Aug 2013 10:41:17 +0000 (UTC)
Message-ID: <loom.20130819T123319-371@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39496 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930Ab3HSKll (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 19 Aug 2013 06:41:41 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1VBMtz-0006DD-GQ
	for linux-mmc@vger.kernel.org; Mon, 19 Aug 2013 12:41:36 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 19 Aug 2013 12:41:35 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 19 Aug 2013 12:41:35 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

As far as I know, the Secure Digital Host Controller do support to wait
while the card signals busy. There is a capability MMC_CAP_WAIT_WHILE_BUSY
which utilizes this and will significantly improve performances during
certain operations like resume, switch etc.

If this capability is not defined then it will be replaced by msleep for
maximum timeout value according to operation being performed.

I am wondering why can't we utilize by enabling this capability in sdhci.c
(or)
This was considered and there were some corner case bugs and hence rejected
to define?

Any thoughts/answers?

Regards,
Prasanna NAVARATNA

