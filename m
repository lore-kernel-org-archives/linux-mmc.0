From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: Re: [PATCH 0/3] mmc: sdhci: Card detection fixes
Date: Fri, 26 Jun 2015 14:05:56 +0300
Message-ID: <1435316756.32171.6.camel@linaro.org>
References: <1435312810-23957-1-git-send-email-ivan.ivanov@linaro.org>
	 <558D29EA.2040203@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36351 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbbFZLGA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2015 07:06:00 -0400
Received: by wguu7 with SMTP id u7so85454040wgu.3
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2015 04:05:58 -0700 (PDT)
In-Reply-To: <558D29EA.2040203@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Tim Kryger <tim.kryger@gmail.com>, Aisheng Dong <b29396@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org


On Fri, 2015-06-26 at 19:31 +0900, Jaehoon Chung wrote:
> Hi, Ivan.
> 
> On 06/26/2015 07:00 PM, Ivan T. Ivanov wrote:
> > Following changes aimed to fix some aspects of card detection, when
> > BROKEN_CARD_DETECTION quirk is set.
> 
> As i know, when there is no card detection scheme, BROKEN_CARD_DETECTION quirks is set.
> If it can use CD_GPIO, doesn't it need to set BROKEN_CARD_DETECTION?
> Just wondering..
> 

I am not sure that I get this. My understanding is that if controller have 
issues reporting card present state, users could use GPIO for card state sensing.

Probably this don't sound reasonable, but someone could just want to ignore
controller capabilities and use GPIO explicitly.

Regards,
Ivan

> Best Regards,
> Jaehoon Chung
> 
> > Ivan T. Ivanov (3):
> >   mmc: sdhci: let GPIO based card detection have higher precedence
> >   mmc: sdhci: don't use card state polling when CD GPIO is defined
> >   mmc: sdhci: properly check card present state when quirk
> >     NO_CARD_NO_RESET is set
> > 
> >  drivers/mmc/host/sdhci.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> > --
> > 1.9.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
