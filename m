From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: add quirk for broken write protect detection
Date: Mon, 24 Feb 2014 02:54:06 +0200
Message-ID: <530A982E.80200@gmail.com>
References: <1393198345-8365-1-git-send-email-eli.billauer@gmail.com>
 <86r46ts70i.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mxout7.netvision.net.il ([194.90.6.2]:39351 "EHLO
	mxout7.netvision.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbaBXBJr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Feb 2014 20:09:47 -0500
Received: from ocho.localdomain ([89.139.18.202]) by mxout7.netvision.net.il
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0N1H00EFD6J2AE20@mxout7.netvision.net.il> for
 linux-mmc@vger.kernel.org; Mon, 24 Feb 2014 02:54:38 +0200 (IST)
In-reply-to: <86r46ts70i.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: michal.simek@xilinx.com, linux-mmc@vger.kernel.org

Hello Chris.

On 24/02/14 02:12, Chris Ball wrote:
> Hi Eli,
>
> On Sun, Feb 23 2014, Eli Billauer wrote:
>    
>> The write protection signal is absent on a board based upon Xilinx' Zynq
>> processor ("ZyBo"). This leads the kernel to think that the MicroSD card is
>> write protected, and causes a kernel panic during boot, as root fails to
>> mount RW.
>>
>> This patch adds a quirk and an optional OF property, sdhci,wp-broken to
>> work around this issue.
>>      
> Just to confirm your motivation for the patch:  wp-inverted would solve
> this problem for you, but you'd rather add a new property that more
> accurately describes the hardware?
>    
Yes, that's the point.
> (We'd probably use broken-wp, for symmetry with the existing broken-cd.)
>    
I picked "sdhci,wp-broken" because of the similarity with 
"sdhci,wp-inverted", as opposed to "broken-cd" (with no "sdhci," prefix).

Would you like me to resubmit the patch with "broken-wp"? Or maybe 
"sdhci,broken-wp"?

Regards,
    Eli
