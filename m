From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdio: To use multiple scatter gather list
Date: Mon, 29 Oct 2012 17:20:36 -0400
Message-ID: <87d301q8kb.fsf@octavius.laptop.org>
References: <001101cdb044$8565abf0$903103d0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35423 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760988Ab2J2VUl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Oct 2012 17:20:41 -0400
In-Reply-To: <001101cdb044$8565abf0$903103d0$%kim@samsung.com> (Kyoungil Kim's
	message of "Mon, 22 Oct 2012 20:01:00 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyoungil Kim <ki0351.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Mon, Oct 22 2012, Kyoungil Kim wrote:
> We used only single sg entry for SDIO transfer.
> This chagne is to use multiple sg entry.
> In case of dwmci, it support only up to 4KB size per single sg entry.
> So if we want to transfer more than 4KB, we should send more than 1 command.
> This makes performance degradation for large data transfer.
>
> Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>

Can you share the before/after benchmark on your controller, please?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
