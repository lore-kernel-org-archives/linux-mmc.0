From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/2] dw_mmc-pci: get resources from a proper BAR
Date: Mon, 12 Aug 2013 19:33:48 +0900
Message-ID: <000101ce9747$6df63fd0$49e2bf70$%jun@samsung.com>
References: <1375958698-10569-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <705D14B1C7978B40A723277C067CEDE2CD73D8@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53682 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab3HLKdt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Aug 2013 06:33:49 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRE00LZ3YO2NDS0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 12 Aug 2013 19:33:48 +0900 (KST)
In-reply-to: <705D14B1C7978B40A723277C067CEDE2CD73D8@IN01WEMBXB.internal.synopsys.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Prabu Thangamuthu' <Prabu.T@synopsys.com>, 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>

On Monday, August 12, 2013, Prabu Thangamuthu wrote:
> 
> Tested-by: Prabu Thangamuthu <Prabu.T@synopsys.com>
> 
> Regards,
> Prabu Thangamuthu.
> 
> On 08/12/2013 04:15 PM, Andy Shevchenko wrote:
> > There is a typo when the mapped space is from BAR 2, but BAR 0 is used
> > instead.
> > This patch fixes the typo.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>


