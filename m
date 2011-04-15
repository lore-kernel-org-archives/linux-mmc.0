From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/3] mmc: initialize struct mmc_command at declaration time
Date: Fri, 15 Apr 2011 18:37:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104151836290.24613@xanadu.home>
References: <1302753463-31005-1-git-send-email-cjb@laptop.org>
 <alpine.LFD.2.00.1104141931100.24613@xanadu.home>
 <m3fwpktdhp.fsf@pullcord.laptop.org> <m3zknrs822.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:27972 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab1DOWhl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2011 18:37:41 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LJP0071LTISGN90@VL-MR-MRZ22.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Fri, 15 Apr 2011 18:37:40 -0400 (EDT)
In-reply-to: <m3zknrs822.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Fri, 15 Apr 2011, Chris Ball wrote:

> Hi,
> 
> On Thu, Apr 14 2011, Chris Ball wrote:
> > Here's a sample disassembly of one function on ARM with gcc-4.6.0, and
> > diff -y.  Explicit memset (which calls __memzero) on the left, and {0}
> > initializer (which calls memset) on the right:
> 
> (I checked on x86_64 too, and the code's identical -- it's inlined into
> a "rep stos %eax,%es:(%rdi)" either way.)

Glad to know that gcc is not as dumb as it used to be.


Nicolas
