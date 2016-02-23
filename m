From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH v3] mmc-utils: Merge the lsmmc tool into mmc-utils
Date: Tue, 23 Feb 2016 04:18:09 +0000
Message-ID: <86bn78dpq6.fsf@void.printf.net>
References: <4230761e156940906a837686e1cc780f417567b7.1456194879.git.baolin.wang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([192.34.86.38]:40822 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757028AbcBWEZ1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Feb 2016 23:25:27 -0500
In-Reply-To: <4230761e156940906a837686e1cc780f417567b7.1456194879.git.baolin.wang@spreadtrum.com>
	(Baolin Wang's message of "Tue, 23 Feb 2016 10:36:46 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, sebras@gmail.com

Hi Baolin,

What is the difference between v2 and v3?  It's good to include a
changelog with each new patch.

Regarding the merge, I don't think it makes sense to merge in lsmmc.c
if the entire EXT_CSD parser inside it can't be used right now.
We might as well just leave it out altogether until it's ready to
be used.  I don't think there's any point in adding a lot of new
unused code just because we might want to use it later.

Does that make sense?  Thanks,

- Chris.
-- 
Chris Ball   <http://printf.net/>
