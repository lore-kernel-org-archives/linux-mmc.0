From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] drivers/mmc/host/vub300.c: add missing usb_free_urb
Date: Tue, 07 Aug 2012 23:57:51 -0400
Message-ID: <878vdqujb4.fsf@octavius.laptop.org>
References: <1343142370-27876-2-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55991 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755525Ab2HHD5z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Aug 2012 23:57:55 -0400
In-Reply-To: <1343142370-27876-2-git-send-email-Julia.Lawall@lip6.fr> (Julia
	Lawall's message of "Tue, 24 Jul 2012 17:06:10 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Tony Olech <tony.olech@elandigitalsystems.com>, kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Julia,

On Tue, Jul 24 2012, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
>
> Add missing usb_free_urb on failure path after usb_alloc_urb.

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
