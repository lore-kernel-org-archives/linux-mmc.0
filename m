From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: mmc:  eMMC BKOPS status handling lock for non urgent case
Date: Wed, 03 Sep 2014 10:47:09 +0900
Message-ID: <5406731D.8000802@samsung.com>
References: <5400AF04.2040708@tqsc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:18446 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbaICBrL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 21:47:11 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBA0076ZYAMV6A0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 03 Sep 2014 10:47:10 +0900 (KST)
In-reply-to: <5400AF04.2040708@tqsc.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Markus Niebel <list-09_linux-mmc@tqsc.de>
Cc: linux-mmc@vger.kernel.org

Hi, Markus

Sorry for replying too late.

On 08/30/2014 01:49 AM, Markus Niebel wrote:
> Hello,
> 
> experimenting with the current BKOPS code we found, that when triggering from BKOPS_LEVEL 1,
> the status stored with mmc_card_set_doing_bkops is never reset preventing BKOPS from working.
In now, bkops is working for upper case than LEVEL_2 (urgent case).
Patch of LEVEL_1's case has sent at mailing, maybe you can found it.

> 
> Since I'm not an expert in the mmc subsystem I ask for a hint where to look for completion
> and implement proper status reset.

Could you explain to me more?

Best Regards,
Jaehoon Chung

> 
> Thanks in advance
> 
> Markus Niebel
> 

