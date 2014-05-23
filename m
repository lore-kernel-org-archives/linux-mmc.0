From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: Fixup compile error
Date: Fri, 23 May 2014 14:18:28 +0100
Message-ID: <864n0gr5uj.fsf@void.printf.net>
References: <1400834204-1933-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53579 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbaEWNSa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 May 2014 09:18:30 -0400
In-Reply-To: <1400834204-1933-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Fri, 23 May 2014 10:36:44 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>

Hi,

On Fri, May 23 2014, Ulf Hansson wrote:
> The commit below introduced compile errors, let's fix them.
> mmc: sdhci-of-esdhc: remove platform_suspend/platform_resume callbacks
>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks, pushed to mmc-next.

- Chris.
-- 
Chris Ball   <http://printf.net/>
