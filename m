From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Only execute tuning for SDR50 and SDR104
Date: Sun, 26 May 2013 13:17:58 -0400
Message-ID: <87y5b1r77d.fsf@octavius.laptop.org>
References: <1366199453-6135-1-git-send-email-fredrik.soderstedt@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47451 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754424Ab3EZRSD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 May 2013 13:18:03 -0400
In-Reply-To: <1366199453-6135-1-git-send-email-fredrik.soderstedt@stericsson.com>
	(Fredrik Soderstedt's message of "Wed, 17 Apr 2013 13:50:53 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>

Hi,

On Wed, Apr 17 2013, Fredrik Soderstedt wrote:
> Only execute tuning for sd and sdio devices that are using
> SDR50 or SDR104.
>
> Make sure clock is hold during tuning for sdio devices.
>
> Signed-off-by: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
