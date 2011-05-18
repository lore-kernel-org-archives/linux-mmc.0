From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] mmc_spi.c: add support for the regulator framework
Date: Wed, 18 May 2011 12:42:12 -0700
Message-ID: <20110518194211.GA5077@opensource.wolfsonmicro.com>
References: <1303476191-20663-1-git-send-email-ospite@studenti.unina.it>
 <1305110379-17218-1-git-send-email-ospite@studenti.unina.it>
 <20110511130852.GB12469@opensource.wolfsonmicro.com>
 <20110511225337.094839a2.ospite@studenti.unina.it>
 <20110511205703.GA24486@opensource.wolfsonmicro.com>
 <20110518192320.9dd69cb5.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57811 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933793Ab1ERTmN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2011 15:42:13 -0400
Content-Disposition: inline
In-Reply-To: <20110518192320.9dd69cb5.ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, openezx-devel@lists.openezx.org, spi-devel-general@lists.sourceforge.net

On Wed, May 18, 2011 at 07:23:20PM +0200, Antonio Ospite wrote:

> So you mean something like the following:

> mmc_regulator_set_power(...)
> {

Yes.

>   2. Add a proper function with all the needed parameters to abstract
>      the actual var names, this would be something like:
>      mmc_regulator_set_power(mmc, power_mode, vdd, vcc, pdata)
>      and yet checking for pdata->setpower can be tricky as 'setpower' 
>      is an arbitrary name.

This would be good.

>   3. Move stuff from driver structures to subsystem structures, which I 
>      don't think is needed in this case.

Though this option is also common - often you get a mix of subsystem and
device specific things with for example a subsystem wide data structure
which the device keeps and passes into a function provided by the
subsystem at appropriate moments.
