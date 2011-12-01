From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 20/62] mmc: remove the second argument of k[un]map_atomic()
Date: Thu, 01 Dec 2011 13:47:12 -0500
Message-ID: <87vcq0jfin.fsf@laptop.org>
References: <1322371662-26166-1-git-send-email-amwang@redhat.com>
	<1322371662-26166-21-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49347 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753437Ab1LASrb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Dec 2011 13:47:31 -0500
In-Reply-To: <1322371662-26166-21-git-send-email-amwang@redhat.com> (Cong
	Wang's message of "Sun, 27 Nov 2011 13:27:00 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cong Wang <amwang@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Nicolas Ferre <nicolas.ferre@atmel.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Alex Dubov <oakad@yahoo.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hi,

On Sun, Nov 27 2011, Cong Wang wrote:
> Signed-off-by: Cong Wang <amwang@redhat.com>
> ---
>  drivers/mmc/host/at91_mci.c |    8 ++++----
>  drivers/mmc/host/msm_sdcc.c |    6 +++---
>  drivers/mmc/host/sdhci.c    |    4 ++--
>  drivers/mmc/host/tifm_sd.c  |   16 ++++++++--------
>  drivers/mmc/host/tmio_mmc.c |    1 -
>  drivers/mmc/host/tmio_mmc.h |    4 ++--
>  6 files changed, 19 insertions(+), 20 deletions(-)

Looks good, thanks, pushed to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
