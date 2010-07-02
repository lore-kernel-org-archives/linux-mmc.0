From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND] sdhci-clk-gating-support
Date: Fri, 02 Jul 2010 12:01:45 -0400
Message-ID: <m3eiflx47q.fsf@pullcord.laptop.org>
References: <23314024.108801278080144319.JavaMail.weblogic@epml07>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35163 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758991Ab0GBP7i (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 2 Jul 2010 11:59:38 -0400
In-Reply-To: <23314024.108801278080144319.JavaMail.weblogic@epml07> (MADHAV
	SINGHCHAUHAN's message of "Fri, 02 Jul 2010 14:15:44 +0000 (GMT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: singh.madhav@samsung.com
Cc: linux-mmc@vger.kernel.org, kyungmin.park@samsung.com

Hi Madhav,

> +       host->user = 0;         /*For Clock gating*/
> +       host->clk_restore = 0;

Also, it's not obvious to me why two variables are necessary.  What's
wrong with just setting host->clk_restore when disabling clock, and
testing whether it's non-zero instead of testing host->user?
(host->user would need a more descriptive name, too.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
