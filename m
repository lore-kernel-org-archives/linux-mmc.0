From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] mmc: dw: don't check resource with
 devm_ioremap_resource
Date: Wed, 05 Jun 2013 17:14:19 +0300
Message-ID: <1370441659.29283.295.camel@smile>
References: <1370424252-31562-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <001701ce61f5$220667d0$66133770$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36641 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007Ab3FEOOY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jun 2013 10:14:24 -0400
In-Reply-To: <001701ce61f5$220667d0$66133770$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Wed, 2013-06-05 at 23:01 +0900, Seungwon Jeon wrote: 
> On 06/05/13 6:24 PM, Andy Shevchenko wrote:
> > devm_ioremap_resource does sanity checks on the given resource. No need to
> > duplicate this in the driver.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Looks good to me.
> 'dw_mmc'(instead of 'dw') as a prefix of subject is expected with other patches, though.
> Specially, dw_mmc-pci is for PATCH 3/3.

Shall I resubmit patches?
I think no-one can mess up with this, because we fortunately have only
one mmc designware driver there.


> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks for review.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
