From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/8] Fix coding style in sdhci.c
Date: Mon, 12 Nov 2012 02:12:26 -0500
Message-ID: <87a9unnvl1.fsf@octavius.laptop.org>
References: <1352461198-21941-1-git-send-email-tushar.behera@linaro.org>
	<50A05DE9.8070907@samsung.com> <50A07D30.4030705@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40491 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab2KLHMh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Nov 2012 02:12:37 -0500
In-Reply-To: <50A07D30.4030705@linaro.org> (Tushar Behera's message of "Mon,
	12 Nov 2012 10:08:08 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, patches@linaro.org

Hi,

On Sun, Nov 11 2012, Tushar Behera wrote:
> Yes, I can do that. I did split it specifically so that we could drop
> any patches if required.
>
> I will wait for a word from Chris regarding what he prefers.

I would want to merge one patch, but I'm afraid I don't generally want
to merge changes like these.  sdhci.c is one of the most modified files
in drivers/mmc, so a change like this can create merge conflicts that
require many people to update their work, and that's not worth it.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
