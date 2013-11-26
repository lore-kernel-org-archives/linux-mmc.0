From: Bing Zhao <bzhao@marvell.com>
Subject: RE: [PATCH v2] mmc/sdio: add a quirk for broken SDIO_CCCR_INTx
 polling
Date: Tue, 26 Nov 2013 15:31:27 -0800
Message-ID: <477F20668A386D41ADCC57781B1F70430F52C17A96@SC-VEXCH1.marvell.com>
References: <1385496293-26365-1-git-send-email-bzhao@marvell.com>
 <CAPDyKFrrBpVw+J8zF8n8_9LGGvWET3WQ1vEqAS3hytKOapApJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:60528 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755223Ab3KZXbi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Nov 2013 18:31:38 -0500
In-Reply-To: <CAPDyKFrrBpVw+J8zF8n8_9LGGvWET3WQ1vEqAS3hytKOapApJg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Paul Stewart <pstew@chromium.org>, Doug Anderson <dianders@chromium.org>

Hi Ulf,

> > diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
> > index 06ee1ae..02c94b5 100644
> > --- a/drivers/mmc/core/quirks.c
> > +++ b/drivers/mmc/core/quirks.c
> > @@ -13,6 +13,9 @@
> >  #include <linux/kernel.h>
> >  #include <linux/export.h>
> >  #include <linux/mmc/card.h>
> > +#include <linux/mmc/sdio_ids.h>
> > +
> > +#include "sdio_ops.h"
> 
> So these includes is not needed any more, I guess.

Yes, you are right. It will be fixed in v3.

Thanks,
Bing

