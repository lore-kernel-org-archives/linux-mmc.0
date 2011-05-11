From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 10/15] mmc: sdhci: add support for programmable clock mode
Date: Tue, 10 May 2011 23:39:22 -0400
Message-ID: <m3k4dx52j9.fsf@pullcord.laptop.org>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-11-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43593 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883Ab1EKDgy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2011 23:36:54 -0400
In-Reply-To: <1304578151-1775-11-git-send-email-arindam.nath@amd.com> (Arindam
	Nath's message of "Thu, 5 May 2011 12:19:06 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: prakity@marvell.com, zhangfei.gao@gmail.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

Hi,

On Thu, May 05 2011, Arindam Nath wrote:
> Host Controller v3.00 supports programmable clock mode as an optional
> feature. The support for this mode is indicated by non-zero value in
> bits 48-55 of the Capabilities register. If supported, the actual
> value of Clock Multiplier is one more than the value provided in the
> bit fields. We only set Clock Generator Select (bit 5) and SDCLK
> Frequency Select (bits 8-15) of the Clock Control register in case
> Preset Value Enable is not set, otherwise these fields are automatically
> set by the Host Controller based on the UHS mode selected. Also, since
> the maximum and minimum clock frequency in this mode can be
> (Base Clock * Clock Mul) and (Base Clock * Clock Mul)/1024 respectively,
> f_max and f_min have been recalculated to reflect this change.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Thanks, pushed to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
