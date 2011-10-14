From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: mmci: Do not release spinlock in request_end
Date: Fri, 14 Oct 2011 10:22:09 +0200
Message-ID: <4E97F131.6090406@stericsson.com>
References: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com> <20111013142914.GZ21648@n2100.arm.linux.org.uk> <1318521592.2090.16.camel@linaro1> <4E97E6CF.1000601@stericsson.com> <20111014074224.GQ21648@n2100.arm.linux.org.uk> <4E97EA10.6040800@stericsson.com> <20111014080318.GR21648@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:52154 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751386Ab1JNIW2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Oct 2011 04:22:28 -0400
In-Reply-To: <20111014080318.GR21648@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Jon Medhurst (Tixy)" <jon.medhurst@linaro.org>, Lee Jones <lee.jones@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

>> If you do not update your tree how shall we be able to  
>> continue with integration of new patches that depends on mmc patches  
>> from "next"?
> 
> That's what I'm saying - I can't take the patch as it introduces bugs
> if I do.  It's better to either wait until after the next merge window,
> or we have to sort out merging it via the mmc tree instead.
> 

Thanks, now I really get the problem! :-)

 From mmci host driver perspective this will then be kind of complicated 
since it sometimes will depend on the patches on the mmc "framework".

Now we have the spinlock patch, but I believe this will happen soon 
again. So how can we handle to merge it via mmc tree instead? Will you 
be able to "Ack" patches for mmci so Chris Ball can merge them for the 
mmc tree instead? Of course I only mean patches that really has a 
dependency, the rest can be handled as is I believe.

BR
Uffe



