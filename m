From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 05/15] mmc: sd: add support for uhs bus speed mode selection
Date: Tue, 10 May 2011 23:36:49 -0400
Message-ID: <m3r58552ni.fsf@pullcord.laptop.org>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-6-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43545 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090Ab1EKDeV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2011 23:34:21 -0400
In-Reply-To: <1304578151-1775-6-git-send-email-arindam.nath@amd.com> (Arindam
	Nath's message of "Thu, 5 May 2011 12:19:01 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: prakity@marvell.com, zhangfei.gao@gmail.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

Hi,

On Thu, May 05 2011, Arindam Nath wrote:
> This patch adds support for setting UHS-I bus speed mode during UHS-I
> initialization procedure. Since both the host and card can support
> more than one bus speed, we select the highest speed based on both of
> their capabilities. First we set the bus speed mode for the card using
> CMD6 mode 1, and then we program the host controller to support the
> required speed mode. We also set High Speed Enable in case one of the
> UHS-I modes is selected. We take care to reset SD clock before setting
> UHS mode in the Host Control2 register, and then re-enable it as per
> the Host Controller spec v3.00. We then set the clock frequency for
> the UHS-I mode selected.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Thanks, pushed to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
