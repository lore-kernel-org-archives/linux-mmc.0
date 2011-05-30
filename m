From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] mmc_spi.c: add support for the regulator framework
Date: Mon, 30 May 2011 18:14:48 +0800
Message-ID: <20110530101447.GA5782@opensource.wolfsonmicro.com>
References: <1303476191-20663-1-git-send-email-ospite@studenti.unina.it>
 <1305110379-17218-1-git-send-email-ospite@studenti.unina.it>
 <20110511130852.GB12469@opensource.wolfsonmicro.com>
 <20110511225337.094839a2.ospite@studenti.unina.it>
 <20110511205703.GA24486@opensource.wolfsonmicro.com>
 <20110518192320.9dd69cb5.ospite@studenti.unina.it>
 <20110518194211.GA5077@opensource.wolfsonmicro.com>
 <20110523171023.4df5af10.ospite@studenti.unina.it>
 <20110530110749.332df87a.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50296 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751139Ab1E3KOz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2011 06:14:55 -0400
Content-Disposition: inline
In-Reply-To: <20110530110749.332df87a.ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Grant Likely <grant.likely@secretlab.ca>, openezx-devel@lists.openezx.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, spi-devel-general@lists.sourceforge.net

On Mon, May 30, 2011 at 11:07:49AM +0200, Antonio Ospite wrote:
> On Mon, 23 May 2011 17:10:23 +0200

> > +#define STRUCT_FIELD(s, f) ((s) && (s)->f ? (s)->f : NULL )

> Any opinion on this macro? See its use below. It is meant to deal with
> driver specific struct fields, which can have arbitrary names, I though
> that using some syntactic sugar to deal with those as arguments when
> calling the function was not that horrible.

> If that looks acceptable to you too I will submit the
> mmc_regulator_set_power () patch, otherwise I would ask to consider the
> simple patch to mmc_spi.c for now.

Would it not be simpler just to provide a standard generic struct that
people can embed into their pdata?
