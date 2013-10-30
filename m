From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: core: fix build warning
Date: Wed, 30 Oct 2013 07:55:32 -0700
Message-ID: <38271231-f570-40ca-99d0-aedd312657d1@email.android.com>
References: <1383142380-25091-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:53503 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab3J3Ozi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 10:55:38 -0400
Received: by mail-pd0-f182.google.com with SMTP id q10so1071916pdj.41
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2013 07:55:37 -0700 (PDT)
In-Reply-To: <1383142380-25091-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, wsa@the-dreams.de



Dong Aisheng <b29396@freescale.com> skrev:
>drivers/mmc/core/mmc_ops.c: In function '__mmc_switch':
>drivers/mmc/core/mmc_ops.c:484:11: warning: 'status' may be used
>uninitialized in this function [-Wuninitialized]
>
>Signed-off-by: Dong Aisheng <b29396@freescale.com>

Hi Dong,

I have already sent a patch for this, it was more or less me causing it.:-)

Kind regards
Ulf Hansson
>---
> drivers/mmc/core/mmc_ops.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>index aae8d8b..651260c 100644
>--- a/drivers/mmc/core/mmc_ops.c
>+++ b/drivers/mmc/core/mmc_ops.c
>@@ -414,7 +414,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8
>index, u8 value,
> 	int err;
> 	struct mmc_command cmd = {0};
> 	unsigned long timeout;
>-	u32 status;
>+	u32 uninitialized_var(status);
> 	bool ignore_crc = false;
> 
> 	BUG_ON(!card);

