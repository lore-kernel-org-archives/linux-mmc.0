From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc: sdhci-s3c: Remove use of card_tasklet, which no longer exists
Date: Thu, 05 Jun 2014 03:13:16 +0100
Message-ID: <86a99sp0hv.fsf@void.printf.net>
References: <86mwdspk58.fsf@void.printf.net> <538FA40F.5040509@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43008 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354AbaFECNT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Jun 2014 22:13:19 -0400
In-Reply-To: <538FA40F.5040509@samsung.com> (Jaehoon Chung's message of "Thu,
	05 Jun 2014 07:56:15 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>

Hi,

On Wed, Jun 04 2014, Jaehoon Chung wrote:
> Didn't you want to merge the below patch?
>
> https://patchwork.kernel.org/patch/4239541/
>
> I have tested with exynos series, and working fine.

Oops, of course -- thanks!  Pushed to mmc-next for 3.16.

- Chris.
-- 
Chris Ball   <http://printf.net/>
