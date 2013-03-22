From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Add in support to expose PRV for v4 MMCs
Date: Fri, 22 Mar 2013 12:11:15 -0400
Message-ID: <87obebpg7w.fsf@octavius.laptop.org>
References: <1361996357-9925-1-git-send-email-bhthompson@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43261 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499Ab3CVQLT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:11:19 -0400
In-Reply-To: <1361996357-9925-1-git-send-email-bhthompson@chromium.org>
	(Bernie Thompson's message of "Wed, 27 Feb 2013 12:19:17 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bernie Thompson <bhthompson@chromium.org>
Cc: linux-mmc@vger.kernel.org, olof@lixom.net

Hi,

On Wed, Feb 27 2013, Bernie Thompson wrote:
> The JEDEC MMC v4 spec defines a new PRV value in place of the original
> fwrev and hwrev specified in v1. We can expose this in the kernel to enable
> user space to more easily determine the product revision of a given MMC.
>
> Signed-off-by: Bernie Thompson <bhthompson@chromium.org>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
