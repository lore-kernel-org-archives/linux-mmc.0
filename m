From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 3/3] mmc: dw: convert to use pcim_* and devm_*
Date: Wed, 05 Jun 2013 23:04:04 +0900
Message-ID: <001901ce61f5$898a5830$9c9f0890$%jun@samsung.com>
References: <1370424252-31562-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1370424252-31562-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:18023 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639Ab3FEOEU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jun 2013 10:04:20 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNX00BYJB2SCVY0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 05 Jun 2013 23:04:04 +0900 (KST)
In-reply-to: <1370424252-31562-3-git-send-email-andriy.shevchenko@linux.intel.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 06/05/13 6:24 PM, Andy Shevchenko wrote:
> The PCI driver is getting simplier and tidier with pcim_* and devm_* functions
> in use.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

