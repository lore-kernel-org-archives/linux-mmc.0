From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: Re: mmc0: Timeout waiting for hardware interrupt.
Date: Wed, 28 Aug 2013 07:35:47 +0000 (UTC)
Message-ID: <loom.20130828T090935-8@post.gmane.org>
References: <CAH9NwWcQ6528NxSShnO2Nfa4dyqD0j68wO9CqfR3i=cpGXQjNg@mail.gmail.com> <loom.20130823T162510-762@post.gmane.org> <CAH9NwWePDSADpVm2MzUCYHPfYLb0RrWJL=yqOCqSPwFF1e=tuw@mail.gmail.com> <CAH9NwWfjUQbw6-K5PCtb7KyNhgGRR0wvWu+_w-shje5zOgqarA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46054 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752347Ab3H1HhK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Aug 2013 03:37:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1VEaIS-0005ey-H6
	for linux-mmc@vger.kernel.org; Wed, 28 Aug 2013 09:37:08 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2013 09:36:08 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2013 09:36:08 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello Christian,

Sorry for the late reply. I had faced the similar problem in the past.

There are certain 4.5 features like BKOPS, Sanitize, cache control operations 
which uses CMD6 to trigger the operation and use DAT0 line for busy signalling 
which was not monitored for proper completion.

Although in your case, eMMC is 4.41 and still BKOPS is supported. I see CMD6 
being sent before getting hardware timeout.

I modified the timeout handling to consider such case (including erase as it 
also sometimes for some eMMC takes long time) and resolved these cases of 
"Timeout waiting for hardware interrupt".

I'll soon present the patch in this forum for more discussions on it.

Regards,
Prasana NAVARATNA



