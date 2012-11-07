From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: RE: [PATCH] mmc: sdio: To use multiple scatter gather list
Date: Wed, 07 Nov 2012 14:16:29 +0900
Message-ID: <001801cdbca7$0b12bc70$21383550$%kim@samsung.com>
References: <001101cdb044$8565abf0$903103d0$%kim@samsung.com>
 <87d301q8kb.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:15739 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab2KGFQb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Nov 2012 00:16:31 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MD300DN9QMK8330@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 07 Nov 2012 14:16:29 +0900 (KST)
Received: from DOKI0351KIM04 ([12.23.119.96])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MD300EDMQNHRQ30@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 07 Nov 2012 14:16:29 +0900 (KST)
In-reply-to: <87d301q8kb.fsf@octavius.laptop.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Tue, Oct 30 2012, Chris Ball wrote:
> Hi,
> 
> On Mon, Oct 22 2012, Kyoungil Kim wrote:
> > We used only single sg entry for SDIO transfer.
> > This chagne is to use multiple sg entry.
> > In case of dwmci, it support only up to 4KB size per single sg entry.
> > So if we want to transfer more than 4KB, we should send more than 1 command.
> > This makes performance degradation for large data transfer.
> >
> > Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> 
> Can you share the before/after benchmark on your controller, please?

When we test before apply this patch, it takes around 335 us for 5K(5120) bytes transfer with dwmci controller.
But when we test after apply this patch, it takes 242 us for 5K bytes.
So this patch makes around 38% performance improvement for 5K bytes transfer.
If the transfer size is bigger, then the performance improvement ratio will be increased.

Thanks.

