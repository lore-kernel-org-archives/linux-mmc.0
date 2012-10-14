From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH] mmc: fix async request mechanism for sequential read scenarios
Date: Sun, 14 Oct 2012 18:12:51 +0200
Message-ID: <sval785hvhevse18konsgf63l8s106eor2@4ax.com>
References: <1349192378-1676-1-git-send-email-kdorfman@codeaurora.org> <1349192378-1676-2-git-send-email-kdorfman@codeaurora.org> <CAFEEs1=zU88dwY1K0+Q9PxdqyOpsNMtj6mZ3YkwebPugofyEEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49542 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756212Ab2JXNKB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 24 Oct 2012 09:10:01 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1TR0ih-00006K-Ho
	for linux-mmc@vger.kernel.org; Wed, 24 Oct 2012 15:10:03 +0200
Received: from 212.199.104.198.static.012.net.il ([212.199.104.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 24 Oct 2012 15:10:03 +0200
Received: from kdorfman by 212.199.104.198.static.012.net.il with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 24 Oct 2012 15:10:03 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On Thu, 11 Oct 2012 17:19:01 +0200, Per Forlin <per.lkml@gmail.com>
wrote:
Hello Per,

>I would like to start with some basic comments.
>
>1. Is this read sequential issue specific to MMC?
>2. Or is it common with all other block-drivers that gets data from
>the block layer (SCSI/SATA etc) ?
>If (#2) can the issue be addressed inside the block layer instead?
>
>BR
>Per
This issue specific to MMC, others block drivers probably not using
MMC mechanism for async request (or have more kernel threads for
processing incoming blk requests). 
I think, since MMC actively fetches requests from block layer queue,
the solution has nothing to do with block layer context.

>
>On Tue, Oct 2, 2012 at 5:39 PM, Konstantin Dorfman
><kdorfman@codeaurora.org> wrote:
>> The main assumption of the async request design is that the file
>> system adds block requests to the block device queue asynchronously
>> without waiting for completion (see the Rationale section of
>> https://wiki.linaro.org/WorkingGroups/Kernel/Specs
>> /StoragePerfMMC-async-req).
>>
>> We found out that in case of sequential read operations this is not
>> the case, due to the read ahead mechanism.
>Would it be possible to improve this mechanism to achieve the same result?
>Allow an outstanding read ahead request on top of the current ongoing one.
>

I need to look on this mechanism,  but from first glance such
behaviour may be result of libc/vfs/fs decisions and too complex
comparing to the patch we are talking about.

Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

