From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v4 0/4]implement eMMC4.4 standard HW reset feature
Date: Tue, 7 Dec 2010 10:26:00 +0800
Message-ID: <5D8008F58939784290FAB48F54975198320B3E4B5A@shsmsx502.ccr.corp.intel.com>
References: <20101201124842.GA5421@intel.com>
	<5D8008F58939784290FAB48F54975198320B3E4A2D@shsmsx502.ccr.corp.intel.com>
 <AANLkTinrPd9p4ocmE+Krj7t4yV8SMPsDeDFuTByy2=Q4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8337 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888Ab0LGC1a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Dec 2010 21:27:30 -0500
In-Reply-To: <AANLkTinrPd9p4ocmE+Krj7t4yV8SMPsDeDFuTByy2=Q4@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Mai, Leonard" <leonard.mai@intel.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>

> -----Original Message-----
> From: kyungmin78@gmail.com [mailto:kyungmin78@gmail.com] On Behalf Of
> Kyungmin Park
> Sent: Tuesday, December 07, 2010 9:34 AM
> To: Dong, Chuanxiao
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; cjb@laptop.org;
> arjan@linux.intel.com; alan@linux.intel.com; akpm@linux-foundation.org; Mai,
> Leonard; Arnd Bergmann; Wolfram Sang
> Subject: Re: [PATCH v4 0/4]implement eMMC4.4 standard HW reset feature
> 
> On Tue, Dec 7, 2010 at 1:03 AM, Dong, Chuanxiao
> <chuanxiao.dong@intel.com> wrote:
> > Hello all,
> > How about these patches? It implemented HW reset feature. When card
> occurred a timeout error during reading/writing/erasing, these patches will allow
> driver to reset eMMC card by trigger a HW reset signal.
> > Does anyone have any comments about the implementation of these patches?
> Wolfram and Arnd already pointed out the unsuitable patch headers. Thanks! :)
> 
> Hi,
> I'm not yet find a reason to use this feature. Now it uses the samsung
> and sandisk v4.41 but still no problem.
> I wonder what's the purpose and effect if it uses or not?

This feature will only be used when card occurs a timeout error during reading/writing/erasing.
When host send a command to card, for some reason, if card didn't have any response to host, then host controller will generate a timeout interrupt to indicate this command is timeout.
At this time, card maybe cannot response any command unless be reset. If driver did nothing at such scenario, RFC may be crashed. So I think when timeout error occurs, reset card is needed.
Host sends CMD0 also can reset the card, but card may be dead and cannot response any command. So this patch will pull up a GPIO line to trigger a reset signal and let eMMC card reset itself, not send a command to do that.
That is my understanding of this feature.

Thanks
Chuanxiao
