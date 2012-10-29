From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/4] MMC: omap_hsmmc: add DT property for max bus frequency
Date: Mon, 29 Oct 2012 12:56:11 -0400
Message-ID: <87r4ohtdxw.fsf@octavius.laptop.org>
References: <1350317108-10657-1-git-send-email-svenkatr@ti.com>
	<1350317108-10657-2-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56917 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486Ab2J2Q4P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Oct 2012 12:56:15 -0400
In-Reply-To: <1350317108-10657-2-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Mon, 15 Oct 2012 21:35:06 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>

Hi,

On Mon, Oct 15 2012, Venkatraman S wrote:
> From: Daniel Mack <zonque@gmail.com>
>
> Maximum bus frequency can be limited by external circuitry like level
> shifters etc. Allow passing this value from DT.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
