From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/3] mmc: initialize struct mmc_command at declaration time
Date: Thu, 14 Apr 2011 19:37:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104141931100.24613@xanadu.home>
References: <1302753463-31005-1-git-send-email-cjb@laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:21009 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab1DNXhV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2011 19:37:21 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LJO00DTI1L68S20@vl-mo-mrz24.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 14 Apr 2011 19:36:42 -0400 (EDT)
In-reply-to: <1302753463-31005-1-git-send-email-cjb@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Wed, 13 Apr 2011, Chris Ball wrote:

> Converts from:
> 	struct mmc_command cmd;
> 	memset(&cmd, 0, sizeof(struct mmc_command));
> 
> to:
> 	struct mmc_command cmd = {0};
> 
> because it's shorter, as performant, and easier to work out whether
> initialization has happened.

Did you disassemble the resulting binary to make sure this is actually 
as performant?

I'm asking because gcc used to do a horrible dumb job with such patterns 
where it would allocate two instances of the structure on the stack i.e. 
one for the named variable and one for the initializer, then fill the 
later with zeroes, and then call memcpy() to copy the initializer over 
to the named instance.


Nicolas
