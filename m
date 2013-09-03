From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: Re: [PATCH] mmc: enable BKOPS for supported eMMC(4.41)
Date: Tue, 3 Sep 2013 08:58:51 +0000 (UTC)
Message-ID: <loom.20130903T105514-341@post.gmane.org>
References: <loom.20130830T140917-496@post.gmane.org> <52242F31.4030103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46070 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299Ab3ICI7O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Sep 2013 04:59:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1VGmS8-0002Ko-Fp
	for linux-mmc@vger.kernel.org; Tue, 03 Sep 2013 10:59:12 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2013 10:59:12 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2013 10:59:12 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello Jaehoon,

> Why do you use MMC_CAP2_BKOPS_EN?
Because BKOPS on eMMC4.41 is optional. So the capability is provided for the
platform to either enable/disable this feature (its not mandatory to always
enable BKOPS on 4.41)

> Maybe we had discussed about this point. i know that we can enable the
BKOPS with the mmc-util.
> (Actually, This code had included into my first patch. but it's removed.)
I'm not aware of this discussion and currently I'm running on eMMC4.41 and
bkops is supported but not enabled. So i suggested this patch.
Do you mean to say, right now, i can enable it using mmc-utils?
Will you please elaborate?

Thanks,
Prasanna

