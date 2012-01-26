From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: UHS sdio card that fails should not exceed 50MHz
Date: Thu, 26 Jan 2012 10:02:50 -0500
Message-ID: <m2ipjyo6at.fsf@bob.laptop.org>
References: <prakity@marvell.com>
	<1327589830-2273-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50876 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720Ab2AZPDA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Jan 2012 10:03:00 -0500
In-Reply-To: <1327589830-2273-1-git-send-email-prakity@marvell.com>
	(philipspatches@gmail.com's message of "Thu, 26 Jan 2012 06:57:10
	-0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: philipspatches@gmail.com
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, Bing Zhao <bzhao@marvell.com>

Hi,

On Thu, Jan 26 2012, philipspatches@gmail.com wrote:
> From: Philip Rakity <prakity@marvell.com>
>
> A UHS sdio card that fails initialization at 1.8v signaling
> is not in UHS mode.  We cannot use the speed in the the cis
> to reflect the bus speed as this is the maxiumum value and
> will not reflect the fact that the host is operating at a
> lower (non uhs) bus speed.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> Reviewed-by: Aaron Lu <aaron.lu@amd.com>

Thanks, pushed to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
