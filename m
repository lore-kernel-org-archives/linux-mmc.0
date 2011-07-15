From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/2] maximum discard size
Date: Fri, 15 Jul 2011 17:46:55 -0400
Message-ID: <m2tyanqks0.fsf@bob.laptop.org>
References: <1309270563-28817-1-git-send-email-adrian.hunter@intel.com>
	<4E208E07.2050704@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40676 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395Ab1GOVrD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Jul 2011 17:47:03 -0400
In-Reply-To: <4E208E07.2050704@intel.com> (Adrian Hunter's message of "Fri, 15
	Jul 2011 21:59:19 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@marvell.com>

Hi Adrian,

On Fri, Jul 15 2011, Adrian Hunter wrote:
>> Here is a patch that sets a maximum discard size for host controllers
>> that cannot manage large timeouts.  And another patch putting it into
>> use for shdci.
>
> Can this be applied?
>
>> Adrian Hunter (2):
>>        mmc: queue: let host controllers specify maximum discard timeout
>>        mmc: sdhci: specify maximum discard timeout

These two are already in mmc-next for 3.1 -- looks like I forgot to send
an e-mail letting you know I'd merged them, sorry.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
