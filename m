From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2] mmc: sd.c Set Non Default Drive Strength via platform
Date: Sat, 09 Jul 2011 18:02:00 -0400
Message-ID: <m239ifkt9j.fsf@bob.laptop.org>
References: <2728818A-C26F-4BF7-8115-A3A37810AE34@marvell.com>
	<614DD9DA-4F3C-4650-8412-6CC900537836@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41542 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704Ab1GIWCG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 9 Jul 2011 18:02:06 -0400
In-Reply-To: <614DD9DA-4F3C-4650-8412-6CC900537836@marvell.com> (Philip
	Rakity's message of "Wed, 6 Jul 2011 08:51:32 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Arindam Nath <arindam.nath@amd.com>

Hi Philip,

On Wed, Jul 06 2011, Philip Rakity wrote:
> V2
> --
> Include host.h change for callback to select_drive_strength

Thanks, pushed to mmc-next for 3.1 with Arindam's Reviewed-by.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
