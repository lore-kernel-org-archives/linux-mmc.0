From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] mmc: Bad device can cause mmc driver to hang
Date: Sat, 17 Nov 2012 09:34:50 -0500
Message-ID: <87ehjs9u2d.fsf@octavius.laptop.org>
References: <87k3tpkz53.fsf@octavius.laptop.org>
	<1353079901-8773-1-git-send-email-tramsay@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39345 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585Ab2KQOe5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 09:34:57 -0500
In-Reply-To: <1353079901-8773-1-git-send-email-tramsay@linux.vnet.ibm.com>
	(Trey Ramsay's message of "Fri, 16 Nov 2012 09:31:41 -0600")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Trey Ramsay <tramsay@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Rich Rattanni <rattanni@gmail.com>, Radovan Lekanovic <lekanovic@gmail.com>

Hi,

On Fri, Nov 16 2012, Trey Ramsay wrote:
> There are infinite loops in the mmc code that can be caused by bad hardware.
> The code will loop forever if the device never comes back from program mode,
> R1_STATE_PRG, and it is not ready for data, R1_READY_FOR_DATA.
>
> A long timeout will be added to prevent the code from looping forever.
> The timeout will occur if the device never comes back from program
> state or the device never becomes ready for data.
>
> Signed-off-by: Trey Ramsay <tramsay@linux.vnet.ibm.com>

Thanks for doing this; pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
