From: "Tardy, Pierre" <pierre.tardy@intel.com>
Subject: RE: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Tue, 18 Jan 2011 16:39:02 +0000
Message-ID: <8250E4885F9967469CAC3FB5CBA2CE69934E7AAB20@irsmsx501.ger.corp.intel.com>
References: <20110114082310.GB27523@intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
 <5D8008F58939784290FAB48F54975198351D4FA654@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34610 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168Ab1ARQjI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2011 11:39:08 -0500
In-Reply-To: <5D8008F58939784290FAB48F54975198351D4FA654@shsmsx502.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "ohad@wizery.com" <ohad@wizery.com>

> > I'm also worried about this patch not taking in account the 8 clock cycles before
> > shutting down the clock, contrary to the clock gating fw.
> > If you power down hc, you will also gate the clock. So the sdio protocol might not be
> > strictly followed.
> As mmc spec said, 8 clock cycles is needed. That is right.
> But I think if we have set the auto suspended delay for host, runtime pm core could make sure host to
> wait at least the auto suspended delay before shutting down the power of the device. So if the auto
> suspended delay is longer than 8 clock cycles, the mmc protocol can be followed, right?
I disagree. You cannot enforce this. It depends on clock speed, that can vary with sdio cards. 
User can change the autosuspend delay to whatever he wants, it should just change performance, but not functionality.

Why don't you just take my clock gating version?
Its working well, I'm using this for 2 weeks, and follow the linux-mmc latest improvement.

Regards,
Pierre


---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

