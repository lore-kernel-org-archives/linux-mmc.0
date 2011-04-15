From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc: initialize struct mmc_command at declaration time
Date: Fri, 15 Apr 2011 14:06:45 -0400
Message-ID: <m3zknrs822.fsf@pullcord.laptop.org>
References: <1302753463-31005-1-git-send-email-cjb@laptop.org>
	<alpine.LFD.2.00.1104141931100.24613@xanadu.home>
	<m3fwpktdhp.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46187 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755639Ab1DOSCJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Apr 2011 14:02:09 -0400
In-Reply-To: <m3fwpktdhp.fsf@pullcord.laptop.org> (Chris Ball's message of
	"Thu, 14 Apr 2011 23:11:46 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org

Hi,

On Thu, Apr 14 2011, Chris Ball wrote:
> Here's a sample disassembly of one function on ARM with gcc-4.6.0, and
> diff -y.  Explicit memset (which calls __memzero) on the left, and {0}
> initializer (which calls memset) on the right:

(I checked on x86_64 too, and the code's identical -- it's inlined into
a "rep stos %eax,%es:(%rdi)" either way.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
