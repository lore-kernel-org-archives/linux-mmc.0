From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: recognise SDIO cards with SDIO_CCCR_REV 3.00
Date: Fri, 21 Oct 2011 00:27:16 -0400
Message-ID: <m2vcrj7yvv.fsf@bob.laptop.org>
References: <1319163392-24544-1-git-send-email-bzhao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33299 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644Ab1JUE1U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Oct 2011 00:27:20 -0400
In-Reply-To: <1319163392-24544-1-git-send-email-bzhao@marvell.com> (Bing
	Zhao's message of "Thu, 20 Oct 2011 19:16:32 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-mmc@vger.kernel.org

Hi Bing,

On Thu, Oct 20 2011, Bing Zhao wrote:
> Table 6-2: CCCR bit Definitions, address 00h
> Part E1 SDIO Simplified Specification Version 3.00
> Feb. 25, 2011
>
> This patch has been tested with Marvell WLAN device SD8797.
>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>

Thanks, pushed to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
