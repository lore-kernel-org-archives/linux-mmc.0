From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: Re: mmc0: Timeout waiting for hardware interrupt.
Date: Fri, 23 Aug 2013 14:26:59 +0000 (UTC)
Message-ID: <loom.20130823T162510-762@post.gmane.org>
References: <CAH9NwWcQ6528NxSShnO2Nfa4dyqD0j68wO9CqfR3i=cpGXQjNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48898 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754732Ab3HWO1n (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Aug 2013 10:27:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1VCsKf-0005LK-Lh
	for linux-mmc@vger.kernel.org; Fri, 23 Aug 2013 16:27:42 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2013 16:27:21 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2013 16:27:21 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

What was the previous command sent before CMD13 when timeout happened?
Can you share some 5 seconds log before the Timeout start happening?
eMMC version being used is 4.41 or 4.5?

