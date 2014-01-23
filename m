From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc-utils: add eMMC 5.0 FFU support
Date: Thu, 23 Jan 2014 18:45:42 +0000
Message-ID: <86k3dq1qqx.fsf@void.printf.net>
References: <1390501260-8730-1-git-send-email-grundler@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48398 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753709AbaAWSpn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jan 2014 13:45:43 -0500
In-Reply-To: <1390501260-8730-1-git-send-email-grundler@chromium.org> (Grant
	Grundler's message of "Thu, 23 Jan 2014 10:21:00 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>

Hi,

On Thu, Jan 23 2014, Grant Grundler wrote:
> +	cid[13] = 0;	/* make sure string is NULL terminated */

Ah, and if you're respinning the patch anyway, would you object to
using '\0' here?  Just a style preference, either way is okay.

Thanks,

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
