From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: block: release host in case of error
Date: Thu, 17 Nov 2011 09:33:27 +0530
Message-ID: <4EC4878F.80002@codeaurora.org>
References: <1321269166-22128-1-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:53326 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab1KQEDb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2011 23:03:31 -0500
In-Reply-To: <1321269166-22128-1-git-send-email-per.forlin@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@stericsson.com>
Cc: linux-mmc@vger.kernel.org, adrian.hunter@intel.com, Chris Ball <cjb@laptop.org>

On 11/14/2011 4:42 PM, Per Forlin wrote:
> Host is claimed as long as there are requests in the block queue
> and all request are completed successfully. If an error occur release
> the host in case someone else needs to claim it, for instance if the card
> is removed during a transfer.
>
> Signed-off-by: Per Forlin<per.forlin@stericsson.com>
> ---
>   drivers/mmc/card/block.c |   37 +++++++++++++++++++++++++++++--------
>   1 files changed, 29 insertions(+), 8 deletions(-)

Tested-by: Sujit Reddy Thumma <sthumma@codeaurora.org>


Thanks
Sujit

