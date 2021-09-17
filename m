Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7493DC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 13:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FA0611C3
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 13:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbhIQNmr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 09:42:47 -0400
Received: from smtp1.axis.com ([195.60.68.17]:39634 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238835AbhIQNmr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Sep 2021 09:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1631886085;
  x=1663422085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BXIhmjeQOvzVdk6My5DdxNPU+JozfdwYeoFFjVfD5xA=;
  b=gyKSLvcG7eSMVA3iKnewDSbmT9isnJJBjXis2THQScSknHySf8dPKJKS
   o9/qvuDRCZDBnFoM7Bg/iVuIfJzRFT8SaOfysSQc1rMXKLEJvcaYoYk22
   bskpKNTesiBGcq/dGApNtavraA2L4KU1yAVodv9zE+9b3/UJ9DtlXCv/r
   bqt8K5zySqzr10AzzkCnnJ0c3Id8r9ofpH/W9sXA9hbBmzelLBckka46G
   Nx3iwIrpzCo9pjvShVPTjI/B7GPoDzvWgJDCe+AkinhBg3E8leP3TuDhw
   0AD75ZHU4sozH6TWJkGm1YCH7YBqbBk8hg56yOea7onczf+E5Jfkep/tr
   w==;
Date:   Fri, 17 Sep 2021 15:41:23 +0200
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Christian =?iso-8859-1?Q?L=F6hle?= <CLoehle@hyperstone.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "marten.lindahl@axis.com" <marten.lindahl@axis.com>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: avoid long timeout if register invalid
Message-ID: <20210917134123.GL12780@axis.com>
References: <bf19053cf6f547bcbb364975cda84c30@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf19053cf6f547bcbb364975cda84c30@hyperstone.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Sep 17, 2021 at 07:50:44AM +0000, Christian Löhle wrote:
> Set the limit to 1s if the register is at reset value.

One second could be to short, we have seen some cards take up
to 10s on write operations. Although that was quite a few years ago.

TMOUT is only used for reads if I understand correctly,
so it should be ok anyways.

/Jesper

> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6578cc64ae9e..cd9a6e0a7449 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1983,6 +1983,14 @@ static void dw_mci_set_drto(struct dw_mci *host)
>  	/* add a bit spare time */
>  	drto_ms += 10;
>  
> +	/*
> +	 * If TMOUT register still holds the reset value the above calculation
> +	 * would yield a timeout of over 167 seconds, limit it to 1000ms.
> +	 * Normal reads/writes should not take anywhere close to 120s.
> +	 */
> +	if (drto_ms > 120000)
> +		drto_ms = 1000;
> +
>  	spin_lock_irqsave(&host->irq_lock, irqflags);
>  	if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
>  		mod_timer(&host->dto_timer,
> -- 
> 2.32.0
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
