From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC] MMC-4.5 Context ID
Date: Sat, 04 Feb 2012 21:45:18 -0500
Message-ID: <m2mx8y6ls1.fsf@bob.laptop.org>
References: <1328110021-15199-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52862 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609Ab2BECp1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 21:45:27 -0500
In-Reply-To: <1328110021-15199-1-git-send-email-saugata.das@stericsson.com>
	(Saugata Das's message of "Wed, 1 Feb 2012 20:57:01 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@stericsson.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Wed, Feb 01 2012, Saugata Das wrote:
> From: Saugata Das <saugata.das@linaro.org>
>
> This patch groups the read or write transfers to eMMC in different contexts
> based on the block number. Transfers to consecutive blocks are grouped to a
> common context. So several small transfers combine to give performance like
> a large multi block transfer.
>
> The patch creates a context of 1MB multiple in non-large unit mode. Reliable
> mode is enabled in the context based on whether reliable write is enabled.

Do you see any performance changes with this patchset?  If so, can you
give details?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
