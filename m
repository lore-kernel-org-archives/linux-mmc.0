From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdio: support SDIO UHS cards
Date: Tue, 15 Nov 2011 10:31:02 -0500
Message-ID: <87aa7xiert.fsf@laptop.org>
References: <5E6C4F13-16DC-4C62-A30E-B8FF235A93AE@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59737 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756329Ab1KOPa7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Nov 2011 10:30:59 -0500
In-Reply-To: <5E6C4F13-16DC-4C62-A30E-B8FF235A93AE@marvell.com> (Philip
	Rakity's message of "Mon, 14 Nov 2011 11:23:37 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Bing Zhao <bzhao@marvell.com>, Aaron Lu <Aaron.Lu@amd.com>, Arindam Nath <arindam.nath@amd.com>

Hi,

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

This patch doesn't apply because it has all tabs converted to spaces,
but you sent me a zip file in private mail that does apply, and I'll
use that for this patch while you investigate your mail setup.

Pushed to mmc-next for 3.3, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
