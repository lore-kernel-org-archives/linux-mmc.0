From: Mauro Santos <registo.mailling@gmail.com>
Subject: Re: [PATCH 0/2] mmc: rtsx_pci: Enable support for erase/discard/trim
 requests
Date: Wed, 27 Jul 2016 21:35:39 +0100
Message-ID: <cbf35b27-bb85-8bc0-a396-8183b6fa7c28@gmail.com>
References: <1469622338-11158-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFrfsB7ChroiJ_z1Rq5ohaidrg=veSa0fWNi50V6BBB0Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35736 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbcG0Ufn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 16:35:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so8149148wmg.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 13:35:43 -0700 (PDT)
In-Reply-To: <CAPDyKFrfsB7ChroiJ_z1Rq5ohaidrg=veSa0fWNi50V6BBB0Hw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Micky Ching <micky_ching@realsil.com.cn>, Wei WANG <wei_wang@realsil.com.cn>, linux-mmc <linux-mmc@vger.kernel.org>, Roger Tseng <rogerable@realtek.com>, Baolin Wang <baolin.wang@linaro.org>

On 27-07-2016 13:45, Ulf Hansson wrote:
> Mauro, I have applied this for my next branch (based on 4.7), to allow
> it to be easily tested.
> 
> Just clone my tree below and build/replace your kernel.
> git://git.linaro.org/people/ulf.hansson/mmc.git next
> 
> Running fstrim and checking blkdiscard should be sufficient as test cases.
> 
> Don't hesitate to ask if problems occurs!
> 
> Kind regards
> Uffe
> 

I've tested both blkdiscard and fstrim (on ext4) and they both worked.

I haven't noticed any errors or warnings on dmesg or complaints from
blkdiscard/fstrim.

If there are any more specific tests you would like me to do let me know.

Regards,
Mauro Santos
