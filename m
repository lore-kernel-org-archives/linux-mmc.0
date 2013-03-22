From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 RESEND] mmc: sdhci-s3c: Use devm_clk_get()
Date: Fri, 22 Mar 2013 11:53:17 -0400
Message-ID: <87a9pvqvma.fsf@octavius.laptop.org>
References: <01c101ce08d0$7d8808d0$78981a70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46791 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933516Ab3CVPxV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 11:53:21 -0400
In-Reply-To: <01c101ce08d0$7d8808d0$78981a70$%han@samsung.com> (Jingoo Han's
	message of "Tue, 12 Feb 2013 12:24:39 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Ben Dooks' <ben-linux@fluff.org>

Hi,

On Mon, Feb 11 2013, Jingoo Han wrote:
> Use devm_clk_get() rather than clk_get() to make cleanup paths
> more simple.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Changes since v1:
> - modified the commit message

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
