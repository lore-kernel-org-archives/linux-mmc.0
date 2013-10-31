From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH 1/1] mmc: core: fix build warning
Date: Thu, 31 Oct 2013 13:02:47 +0800
Message-ID: <20131031050246.GA18050@b29396-Latitude-E6410>
References: <1383142380-25091-1-git-send-email-b29396@freescale.com>
 <38271231-f570-40ca-99d0-aedd312657d1@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:41637
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750922Ab3JaFFn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Oct 2013 01:05:43 -0400
Content-Disposition: inline
In-Reply-To: <38271231-f570-40ca-99d0-aedd312657d1@email.android.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, wsa@the-dreams.de

On Wed, Oct 30, 2013 at 07:55:32AM -0700, Ulf Hansson wrote:
> 
> 
> Dong Aisheng <b29396@freescale.com> skrev:
> >drivers/mmc/core/mmc_ops.c: In function '__mmc_switch':
> >drivers/mmc/core/mmc_ops.c:484:11: warning: 'status' may be used
> >uninitialized in this function [-Wuninitialized]
> >
> >Signed-off-by: Dong Aisheng <b29396@freescale.com>
> 
> Hi Dong,
> 
> I have already sent a patch for this, it was more or less me causing it.:-)
> 
> Kind regards
> Ulf Hansson

Hi Ulf,

Got it, thanks for the information. :-)

Regards
Dong Aisheng
> >---
> > drivers/mmc/core/mmc_ops.c |    2 +-
> > 1 files changed, 1 insertions(+), 1 deletions(-)
> >
> >diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> >index aae8d8b..651260c 100644
> >--- a/drivers/mmc/core/mmc_ops.c
> >+++ b/drivers/mmc/core/mmc_ops.c
> >@@ -414,7 +414,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8
> >index, u8 value,
> > 	int err;
> > 	struct mmc_command cmd = {0};
> > 	unsigned long timeout;
> >-	u32 status;
> >+	u32 uninitialized_var(status);
> > 	bool ignore_crc = false;
> > 
> > 	BUG_ON(!card);
> 
> 

