From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v1 1/3]Add erase timeout calculation routine for sdhci
 host
Date: Thu, 11 Nov 2010 18:23:00 +0800
Message-ID: <5D8008F58939784290FAB48F549751982EF72ADA67@shsmsx502.ccr.corp.intel.com>
References: <20101111090519.GB18170@intel.com>
 <20101111093341.GA3131@pengutronix.de>
 <5D8008F58939784290FAB48F549751982EF72ADA59@shsmsx502.ccr.corp.intel.com>
 <20101111101536.GB3131@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46863 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755160Ab0KKKXG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2010 05:23:06 -0500
In-Reply-To: <20101111101536.GB3131@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "adrian.hunter@nokia.com" <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

> > You mean can directly set the TIMEOUT CONTROL register to be the maximum
> value?
> 
> Well, just use a #define instead of 0xe. I did not mean more :)
> 
> > And any comment about patch2 and patch3?
> 
> Sadly not. No resources left currently :(
Never matter, thanks.

Regards
Chuanxiao
