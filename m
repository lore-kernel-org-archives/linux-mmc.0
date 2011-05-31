From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] mmc_spi.c: add support for the regulator framework
Date: Tue, 31 May 2011 11:05:28 +0100
Message-ID: <20110531100528.GB7067@opensource.wolfsonmicro.com>
References: <1305110379-17218-1-git-send-email-ospite@studenti.unina.it>
 <20110511130852.GB12469@opensource.wolfsonmicro.com>
 <20110511225337.094839a2.ospite@studenti.unina.it>
 <20110511205703.GA24486@opensource.wolfsonmicro.com>
 <20110518192320.9dd69cb5.ospite@studenti.unina.it>
 <20110518194211.GA5077@opensource.wolfsonmicro.com>
 <20110523171023.4df5af10.ospite@studenti.unina.it>
 <20110530110749.332df87a.ospite@studenti.unina.it>
 <20110530101447.GA5782@opensource.wolfsonmicro.com>
 <20110530125757.483d6f4c.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51070 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751475Ab1EaKFa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2011 06:05:30 -0400
Content-Disposition: inline
In-Reply-To: <20110530125757.483d6f4c.ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Grant Likely <grant.likely@secretlab.ca>, openezx-devel@lists.openezx.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, spi-devel-general@lists.sourceforge.net

On Mon, May 30, 2011 at 12:57:57PM +0200, Antonio Ospite wrote:

> It is cleaner and more uniform indeed, but it does not solve the problem
> I am seeing, the issue is still there when pdata is NULL, we are at the
> same point as before (the current code checks for (pdata &&
> pdata->field)), and we cannot pass pdata directly as a function argument
> (can we?) as it is driver specific as well.

You can do a nasty type punning trick if the generic pdata is the first
member of the platform data, otherwise the easiest thing is usually to
provide a defualt pdata if the pdata is NULL.

I'd expect that in a lot of cases the standard platform data would be
the only platform data so for many drivers they wouldn't need to worry
about extra data but perhaps MMC isn't like that, I've never really
looked at the code.
