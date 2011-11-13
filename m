From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] SD/MMC: fix the issue of SDHC performance regression
Date: Sun, 13 Nov 2011 11:45:22 -0500
Message-ID: <871utcm0nx.fsf@laptop.org>
References: <1320658589-13143-1-git-send-email-b32616@freescale.com>
	<m2ipmw133p.fsf@bob.laptop.org> <20111108094734.GA1592@ladygaga>
	<m2lirqybtm.fsf@bob.laptop.org> <000301cca21f$5fda9c30$1f8fd490$@org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36261 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829Ab1KMQpV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 13 Nov 2011 11:45:21 -0500
In-Reply-To: <000301cca21f$5fda9c30$1f8fd490$@org> (Subhash Jadavani's message
	of "Sun, 13 Nov 2011 21:44:45 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: 'Aaron Lu' <aaron.lu@amd.com>, 'Qiang Liu' <b32616@freescale.com>, linux-mmc@vger.kernel.org, leoli@freescale.com, kumar.gala@freescale.com

Hi,

On Sun, Nov 13 2011, Subhash Jadavani wrote:
> Using SD_MODE_UHS_SDR25 macro name is not appropriate here. It's really not
> the SDR25 mode (although clock rate is 50mhz), it's High speed mode only.
> "Qiang Liu" patch had defined new marco "SD_MODE_HIGH_SPEED" which looks
> most appropriate to use here.

See the version in current mmc-next, it already uses Qiang Liu's macros.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
