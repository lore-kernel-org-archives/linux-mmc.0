From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] mmc: sdhci only set 200ma support for 1.8v if 200ma is available
Date: Wed, 27 Jun 2012 04:28:05 -0400
Message-ID: <877gut88h6.fsf@octavius.laptop.org>
References: <prakity@marvell.com>
	<1338168993-2087-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50857 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806Ab2F0I2K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Jun 2012 04:28:10 -0400
In-Reply-To: <1338168993-2087-1-git-send-email-prakity@marvell.com>
	(philipspatches@gmail.com's message of "Sun, 27 May 2012 18:36:33
	-0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: philipspatches@gmail.com
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

Hi,

On Sun, May 27 2012, philipspatches@gmail.com wrote:
> From: Philip Rakity <prakity@marvell.com>
>
> max_current_caps can return 0 if not available from the sd controller.
> if no regulator is present or the regulator specifies a current
> less then 200ma we will set the 200ma caps bit by default.
>
> do not do this.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Reviewed-by: Aaron Lu <aaron_lu@amd.com>

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
