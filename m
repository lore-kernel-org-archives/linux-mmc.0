From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/1] ARM: mxc: fix card interrupt losing issue on freescale eSDHC
Date: Tue, 02 Aug 2011 20:16:29 -0400
Message-ID: <m2ty9z73j6.fsf@bob.laptop.org>
References: <1311837360-16179-1-git-send-email-tony.lin@freescale.com>
	<1311837360-16179-2-git-send-email-tony.lin@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43581 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380Ab1HCAQk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Aug 2011 20:16:40 -0400
In-Reply-To: <1311837360-16179-2-git-send-email-tony.lin@freescale.com> (Tony
	Lin's message of "Thu, 28 Jul 2011 15:16:00 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lin <tony.lin@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On Thu, Jul 28 2011, Tony Lin wrote:
> apply workaround for imx eSDHC controller to avoid missing
> the card interrupt so that SDIO function is workable
>
> Signed-off-by: Tony Lin <tony.lin@freescale.com>

Thanks, pushed to mmc-next for 3.1.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
