From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] mmc: sdhci-tegra: Set DMA mask
Date: Wed, 24 Feb 2016 10:08:54 -0700
Message-ID: <56CDE3A6.9080903@wwwdotorg.org>
References: <1456305079-27779-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:55816 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbcBXRI5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Feb 2016 12:08:57 -0500
In-Reply-To: <1456305079-27779-1-git-send-email-acourbot@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

On 02/24/2016 02:11 AM, Alexandre Courbot wrote:
> On T210, the sdhci controller can address more than 32 bits of address
> space. Failing to express this fact results in the use of bounce
> buffers and affects performance.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> I am pretty sure this one is wrong in some way, but just to get the ball
> rolling as the use of bounce buffers is currently quite heavy on Jetson TX1.
>
> Thierry, Stephen, could you confirm that I got the DMA masks correctly? I
> am not sure about the actual addressable size on TX1, and also suspect TK1 can
> also address more than 32 bits.

I don't actually know what the HW capabilities are. You had best track 
down one of NVIDIA's HW designers/integrators; hopefully the can provide 
all kinds of gory details.

One thing I will say: in U-Boot, we deliberately clip usable RAM size to 
2GiB so that the PA of all RAM fits into 32 bits, specifically because 
of IO controllers that can only address 32 bits. It is possible this was 
only required on earlier chips and T210 fixed it though; I don't know. 
Equally, I suppose the restriction might only apply to a subset of IO 
controllers (USB would be another one relevant to U-Boot).
