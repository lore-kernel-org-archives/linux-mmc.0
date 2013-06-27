From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc-utils: Correctly handle CARD_TYPE.
Date: Thu, 27 Jun 2013 10:42:21 -0400
Message-ID: <877ghfsjhu.fsf@octavius.laptop.org>
References: <1369354267-18632-1-git-send-email-olegm@lab126.com>
	<1369354267-18632-2-git-send-email-olegm@lab126.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56304 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663Ab3F0Om0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 10:42:26 -0400
In-Reply-To: <1369354267-18632-2-git-send-email-olegm@lab126.com> (Oleg
	Matcovschi's message of "Thu, 23 May 2013 17:11:07 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Oleg Matcovschi <olegm@lab126.com>
Cc: linux-mmc@vger.kernel.org

Hi,

On Thu, May 23 2013, Oleg Matcovschi wrote:
> Analysis was based on value of EXT_CSD_BOOT_INFO, not CARD_TYPE.
> CARD_TYPE should be handled using bitmask, not values.
>
> Signed-off-by: Oleg Matcovschi <olegm@lab126.com>

Thanks, pushed to mmc-utils.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
