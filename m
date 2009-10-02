From: Ben Dooks <ben@simtec.co.uk>
Subject: Re: [patch 00/11] s3cmci fixes and updates for current merge window
Date: Fri, 02 Oct 2009 07:50:45 +0100
Message-ID: <4AC5A2C5.7070800@simtec.co.uk>
References: <20090921133555.015075699@smtp.local.simtec.co.uk> <20090929155656.28142423.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:43544 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756977AbZJBGun (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2009 02:50:43 -0400
In-Reply-To: <20090929155656.28142423.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, ben-linux@fluff.org

Andrew Morton wrote:
> On Mon, 21 Sep 2009 14:35:55 +0100
> Ben Dooks <ben@simtec.co.uk> wrote:
> 
>> This is a set of the s3cmci updates and fixes for the current merge
>> window. It is a resend of an updated version of a series posted a
>> few weeks ago, which I could not find queued anywhere.
>>
> 
> Sending a pile of stuff in the middle of the merge window is rather
> late for "the current merge window"!

Sorry, but pretty much all of this was posted on the 18th of August
and no-one bothered to comment.

> And this patch series is a mishmash of features and bugfixes.

Since none of this was regression fixes I thought it wasn't
stuff that should have been submitted earlier.

For example, the DMA fixes are in code that hasn't been used in the driver
for ages, the rest are more cleanup than fix.

-- 
Ben Dooks, Software Engineer, Simtec Electronics

http://www.simtec.co.uk/
