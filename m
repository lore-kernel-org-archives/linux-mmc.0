From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: fix integer assignments to pointer
Date: Tue, 23 Aug 2011 14:28:42 -0400
Message-ID: <m2mxf02d9h.fsf@bob.laptop.org>
References: <1314114363-6767-1-git-send-email-svenkatr@ti.com>
	<1314114363-6767-3-git-send-email-svenkatr@ti.com>
	<m27h643x8k.fsf@bob.laptop.org> <20110823172851.GB1784@leaf>
	<874o18m2cn.fsf@blp.benpfaff.org> <20110823181359.GB3418@leaf>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55161 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754685Ab1HWS25 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Aug 2011 14:28:57 -0400
In-Reply-To: <20110823181359.GB3418@leaf> (Josh Triplett's message of "Tue, 23
	Aug 2011 11:13:59 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: blp@cs.stanford.edu, Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-sparse@vger.kernel.org

Hi,

On Tue, Aug 23 2011, Josh Triplett wrote:
> {} produces the same effect, as far as I know.

Yeah.  I prefer {0}, because {} is a gcc-ism (the ANSI grammar demands
initializer-lists be non-empty) and is less readable for people who
haven't seen the idiom before and are wondering what's going on.

I'm still a little confused -- the {0} or memset(0, struct ..);
formations are used often in the kernel, even with pointers involved.
Is the warning (Wnon_pointer_null) run against the kernel by default,
or did Venkatraman add it manually?  If default, is it catching bugs?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
