From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 0/2] mmc: core: fix the HS200 mode
Date: Wed, 09 May 2012 10:04:46 -0400
Message-ID: <87fwb9o3gh.fsf@laptop.org>
References: <004a01cd22b3$6e343ce0$4a9cb6a0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47126 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757984Ab2EIOEp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 May 2012 10:04:45 -0400
In-Reply-To: <004a01cd22b3$6e343ce0$4a9cb6a0$%jun@samsung.com> (Seungwon
	Jeon's message of "Wed, 25 Apr 2012 16:17:10 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Subhash Jadavani' <subhashj@codeaurora.org>, 'Girish K S' <girish.shivananjappa@linaro.org>

Hi,

On Wed, Apr 25 2012, Seungwon Jeon wrote:
> Includes fixes for eMMC related with HS200.
>
> Changes in v2:
>     - PATCH 1/2: Combine both the if conditions (from Subhash Jadavani)
>
> Seungwon Jeon (2):
>       mmc: core: fix the decision of mmc card-type
>       mmc: core: fix the signalling 1.8V for HS200
>
>  drivers/mmc/core/mmc.c   |   93 +++++++++++++++++++--------------------------
>  include/linux/mmc/card.h |    4 ++
>  include/linux/mmc/mmc.h  |   60 -----------------------------
>  3 files changed, 43 insertions(+), 114 deletions(-)

Thanks, both pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
