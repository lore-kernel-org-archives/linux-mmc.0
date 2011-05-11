From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 06/15] mmc: sd: set current limit for uhs cards
Date: Tue, 10 May 2011 23:37:12 -0400
Message-ID: <m3pqnp52mv.fsf@pullcord.laptop.org>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-7-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43554 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab1EKDeo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2011 23:34:44 -0400
In-Reply-To: <1304578151-1775-7-git-send-email-arindam.nath@amd.com> (Arindam
	Nath's message of "Thu, 5 May 2011 12:19:02 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: prakity@marvell.com, zhangfei.gao@gmail.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

Hi,

On Thu, May 05 2011, Arindam Nath wrote:
> We decide on the current limit to be set for the card based on the
> Capability of Host Controller to provide current at 1.8V signalling,
> and the maximum current limit of the card as indicated by CMD6
> mode 0. We then set the current limit for the card using CMD6 mode 1.
> As per the Physical Layer Spec v3.01, the current limit switch is
> only applicable for SDR50, SDR104, and DDR50 bus speed modes. For
> other UHS-I modes, we set the default current limit of 200mA.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Thanks, pushed to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
