From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] mmc: block: prevent propagating R1_OUT_OF_RANGE for
 open-ending mode
Date: Mon, 7 Aug 2017 13:13:23 +0800
Message-ID: <20170807051321.GZ31819@dragon>
References: <1502069565-114396-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbdHGFOh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 7 Aug 2017 01:14:37 -0400
Content-Disposition: inline
In-Reply-To: <1502069565-114396-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On Mon, Aug 07, 2017 at 09:32:45AM +0800, Shawn Lin wrote:
> We to some extent should tolerate R1_OUT_OF_RANGE for open-ending
> mode as it is expected behaviour and most of the backup partition
> tables should be located near some the last blocks which will always
> make open-ending read exceed the capcity of cards.
> 
> Fixes: 9820a5b11101 ("mmc: core: for data errors, take response of stop cmd into account")
> Fixes: a04e6bae9e6f (mmc: core: check also R1 response for stop commands)
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Tested-by: Shawn Guo <shawnguo@kernel.org>
