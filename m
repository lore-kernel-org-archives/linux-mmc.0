From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: Fix use of uninitialized data in mmc_cmd_app.
Date: Wed, 13 Apr 2011 17:40:43 -0400
Message-ID: <m362qhvnhg.fsf@pullcord.laptop.org>
References: <1302726792-4733-1-git-send-email-andreiw@motorola.com>
	<alpine.DEB.2.00.1104131400420.13863@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56532 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933010Ab1DMVgC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Apr 2011 17:36:02 -0400
In-Reply-To: <alpine.DEB.2.00.1104131400420.13863@peruna> (John Calixto's
	message of "Wed, 13 Apr 2011 14:04:57 -0700 (PDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: Andrei Warkentin <andreiw@motorola.com>, linux-mmc@vger.kernel.org

Hi,

On Wed, Apr 13 2011, John Calixto wrote:
> Out of curiosity, why is:
>
> 	memset(&cmd, 0, sizeof(struct mmc_command));
>
> preferred over:
>
> 	struct mmc_command cmd = {0};

Thanks for the question.  I asked around, the verdict seems to be that
it *isn't* preferred, that the compiler can actually (theoretically)
do better with the zero initializer, and the memsets are probably
just holdover from when dynamic initialization of aggregates wasn't
available in C.

An even stronger benefit of the zero initializer is, of course, that
you can do a single-line grep to find out whether someone forgot to
initialize any of them.  (And it's a line shorter, too.)

So, now I'm thinking about a patch to convert all of our uses of
memset(.., 0, struct ..) over to { 0 } initializers.  Yell if
anyone has strong opinions.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
