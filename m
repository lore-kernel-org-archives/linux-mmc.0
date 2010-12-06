From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v2 1/4]enable background operations for supported eMMC
 card
Date: Mon, 6 Dec 2010 10:28:34 +0800
Message-ID: <5D8008F58939784290FAB48F54975198320B3E464D@shsmsx502.ccr.corp.intel.com>
References: <20101203121338.GB18655@intel.com>
 <AANLkTikPAmpJq7Q7riDPGq5UkhAa9cuXRW7kjuNGv6oB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:4665 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab0LFC25 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Dec 2010 21:28:57 -0500
In-Reply-To: <AANLkTikPAmpJq7Q7riDPGq5UkhAa9cuXRW7kjuNGv6oB@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>

> -----Original Message-----
> From: kyungmin78@gmail.com [mailto:kyungmin78@gmail.com] On Behalf Of
> Kyungmin Park
> Sent: Monday, December 06, 2010 9:12 AM
> To: Dong, Chuanxiao
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; cjb@laptop.org;
> akpm@linux-foundation.org; arjan@linux.intel.com; alan@linux.intel.com
> Subject: Re: [PATCH v2 1/4]enable background operations for supported eMMC
> card
> 
> <Tested-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Note that I'm not yet see any performance improvements :)

Thanks Park. Can you tell me the testing steps you used?
During the test, has there any background operation been started?
I think two cases can be tested to check whether there is performance improvement or not.
One is doing background operations when card is busy for reading/writing. The other is doing background operations when card is idle.

Thanks
Chuanxiao
