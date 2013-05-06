From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 06/22] mmc: dw_mmc: remove unnecessary
 platform_set_drvdata()
Date: Mon, 06 May 2013 21:09:45 +0900
Message-ID: <002401ce4a52$98c45360$ca4cfa20$%jun@samsung.com>
References: <005101ce4a21$336eaaf0$9a4c00d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51042 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab3EFMJy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 08:09:54 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD001DOLRNVXK0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 21:09:45 +0900 (KST)
In-reply-to: <005101ce4a21$336eaaf0$9a4c00d0$@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jingoo Han' <jg1.han@samsung.com>, 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>

On Monday, May 06, 2013, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

