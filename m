From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] SD/MMC: fix the issue of SDHC performance regression
Date: Tue, 08 Nov 2011 08:37:41 -0500
Message-ID: <m2lirqybtm.fsf@bob.laptop.org>
References: <1320658589-13143-1-git-send-email-b32616@freescale.com>
	<m2ipmw133p.fsf@bob.laptop.org> <20111108094734.GA1592@ladygaga>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35943 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab1KHNiA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Nov 2011 08:38:00 -0500
In-Reply-To: <20111108094734.GA1592@ladygaga> (Aaron Lu's message of "Tue, 8
	Nov 2011 17:47:36 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Qiang Liu <b32616@freescale.com>, linux-mmc@vger.kernel.org, leoli@freescale.com, kumar.gala@freescale.com, subhashj@codeaurora.org

Hi,

On Tue, Nov 08 2011, Aaron Lu wrote:
> SDR25 is also 50MHZ, the same frequency as high speed.
> Or we can add a new macro for high speed like qiang has done,
> which one you prefer?

The new macro makes most sense to me -- if no-one disagrees, I'll
convert Liu's patch into a rename patch and queue it as a cleanup
for 3.2.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
