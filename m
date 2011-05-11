From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] mmc_spi.c: add support for the regulator framework
Date: Wed, 11 May 2011 22:57:04 +0200
Message-ID: <20110511205703.GA24486@opensource.wolfsonmicro.com>
References: <1303476191-20663-1-git-send-email-ospite@studenti.unina.it>
 <1305110379-17218-1-git-send-email-ospite@studenti.unina.it>
 <20110511130852.GB12469@opensource.wolfsonmicro.com>
 <20110511225337.094839a2.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:32857 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755286Ab1EKU5C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2011 16:57:02 -0400
Content-Disposition: inline
In-Reply-To: <20110511225337.094839a2.ospite@studenti.unina.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, openezx-devel@lists.openezx.org, spi-devel-general@lists.sourceforge.net

On Wed, May 11, 2011 at 10:53:37PM +0200, Antonio Ospite wrote:

> OK, avoiding some duplication will be good, I agree.

> I am resending a v4 with the equivalent code:
> 
> 	if (host->vcc) {
> 		int ret;
> 
> 		if (power_mode == MMC_POWER_OFF)
> 			vdd = 0;
> 

This isn't really what I meant - what I meant was that all this logic
looks like it's generic to multiple drivers.  We either set a regulator
or call a pdata callback to set power, both of which are completely
external to the controller.
