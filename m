From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdio: support SDIO UHS cards
Date: Mon, 14 Nov 2011 20:33:11 -0500
Message-ID: <87mxbyjhk8.fsf@laptop.org>
References: <5E6C4F13-16DC-4C62-A30E-B8FF235A93AE@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51606 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726Ab1KOBdO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Nov 2011 20:33:14 -0500
In-Reply-To: <5E6C4F13-16DC-4C62-A30E-B8FF235A93AE@marvell.com> (Philip
	Rakity's message of "Mon, 14 Nov 2011 11:23:37 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Bing Zhao <bzhao@marvell.com>, Aaron Lu <Aaron.Lu@amd.com>, Arindam Nath <arindam.nath@amd.com>

Hi Philip,

On Mon, Nov 14 2011, Philip Rakity wrote:
> This patch adds support for sdio UHS cards per the version 3.0
> spec.
>
> UHS mode is only enabled for version 3.0 cards when both the
> host and the controller support UHS modes.
>
> 1.8v signaling support is removed if both the card and the
> host do not support UHS.  This is done to maintain
> compatibility and some system/card combinations break when
> 1.8v signaling is enabled when the host does not support UHS.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Aaron Lu <Aaron.lu@amd.com>
> Reviewed-by: Arindam Nath <arindam.nath@amd.com>
> Tested-by: Bing Zhao <bzhao@marvell.com>

Against mmc-next, please:

error: patch failed: drivers/mmc/core/bus.c:303
error: drivers/mmc/core/bus.c: patch does not apply
error: patch failed: drivers/mmc/core/sd.c:959
error: drivers/mmc/core/sd.c: patch does not apply
error: patch failed: drivers/mmc/core/sdio.c:102
error: drivers/mmc/core/sdio.c: patch does not apply
error: patch failed: include/linux/mmc/card.h:363
error: include/linux/mmc/card.h: patch does not apply
error: patch failed: include/linux/mmc/sdio.h:85
error: include/linux/mmc/sdio.h: patch does not apply

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
