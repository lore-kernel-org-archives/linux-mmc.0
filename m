From: Andy Ross <andy.ross@windriver.com>
Subject: Re: [PATCH] mmc: duplicated trial with same freq when mmc_rescan_try_freq()
Date: Fri, 13 May 2011 09:18:59 -0700
Message-ID: <4DCD59F3.2030105@windriver.com>
References: <4DCB97F3.9060704@samsung.com> <8A2FC72B45BB5A4C9F801431E06AE48F1154C484@039-SN1MPN1-005.039d.mgd.msft.net> <m3fwokypzv.fsf@pullcord.laptop.org> <4DCC9464.3020806@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from li44-10.members.linode.com ([72.14.181.10]:39327 "EHLO
	plausible.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759041Ab1EMQ0R (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 May 2011 12:26:17 -0400
In-Reply-To: <4DCC9464.3020806@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Huang Changming-R66093 <R66093@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

On 05/12/2011 07:16 PM, Jaehoon Chung wrote:
> In other words, first init card with 400KHZ, 
> but second/third to init with 300KHz. 
> i think not necessary that try to initialize the two times with 300KHz.

This sounds like a correct patch to me.  Presumably the board I was
using had a f_min that didn't match one of the table entries exactly,
so I didn't see the mixed up equality condition.  Unfortunately that
board is gone now, so I can't test.  But the logic looks fine.

Andy
