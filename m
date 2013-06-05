From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/3] mmc: dw: don't check resource with
 devm_ioremap_resource
Date: Wed, 05 Jun 2013 23:01:10 +0900
Message-ID: <001701ce61f5$220667d0$66133770$%jun@samsung.com>
References: <1370424252-31562-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:61672 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab3FEOBM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jun 2013 10:01:12 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNX00H8DAXZSSW0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 05 Jun 2013 23:01:11 +0900 (KST)
In-reply-to: <1370424252-31562-1-git-send-email-andriy.shevchenko@linux.intel.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 06/05/13 6:24 PM, Andy Shevchenko wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me.
'dw_mmc'(instead of 'dw') as a prefix of subject is expected with other patches, though.
Specially, dw_mmc-pci is for PATCH 3/3.

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>


