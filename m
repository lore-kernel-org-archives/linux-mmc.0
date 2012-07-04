From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: core: Simplify and fix for SD switch processing
Date: Tue, 03 Jul 2012 20:48:20 -0400
Message-ID: <87r4ss5p2j.fsf@octavius.laptop.org>
References: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
	<1341296172-10645-2-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60010 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756556Ab2GDAsY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jul 2012 20:48:24 -0400
In-Reply-To: <1341296172-10645-2-git-send-email-aaron.lu@amd.com> (Aaron Lu's
	message of "Tue, 3 Jul 2012 14:16:11 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi,

On Tue, Jul 03 2012, Aaron Lu wrote:
> In mmc_read_switch, just do a one time mode 0 switch command to get the
> support bits information, no need to do multiple times as the support
> bits do not change with different arguments.
>
> And no need to check current limit support bits, as these bits is
> fixed according to the signal voltage. If the signal voltage is 1.8V,
> the support bits would be 0xf and if the signal voltage is 3.3V, the
> support bits would be 0x01. We will check host's ability to set the
> current limit.
>
> Signed-off-by: Aaron Lu <aaron.lu@amd.com>

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
