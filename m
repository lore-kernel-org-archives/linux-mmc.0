From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/3] mmc: dw: eliminate useless usage of ret
Date: Wed, 05 Jun 2013 23:01:25 +0900
Message-ID: <001801ce61f5$2afc6970$80f53c50$%jun@samsung.com>
References: <1370424252-31562-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1370424252-31562-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:17799 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab3FEOB1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jun 2013 10:01:27 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNX00EBOAY5AU10@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 05 Jun 2013 23:01:25 +0900 (KST)
In-reply-to: <1370424252-31562-2-git-send-email-andriy.shevchenko@linux.intel.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 06/05/13 6:24 PM, Andy Shevchenko wrote:
> In few places usage of ret variable is not needed. This patch simplifies that
> pieces of code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

