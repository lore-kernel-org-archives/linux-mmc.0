From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: setpower on MMC_POWER_{UP,OFF}
Date: Fri, 22 Mar 2013 12:42:29 -0400
Message-ID: <878v5fo07e.fsf@octavius.laptop.org>
References: <1363085012-9220-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34075 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161013Ab3CVQmd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:42:33 -0400
In-Reply-To: <1363085012-9220-1-git-send-email-james.hogan@imgtec.com> (James
	Hogan's message of "Tue, 12 Mar 2013 10:43:32 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi,

On Tue, Mar 12 2013, James Hogan wrote:
> Call the setpower platform callback in response to set_ios with
> ios->power_mode == MMC_POWER_UP or MMC_POWER_OFF, instead of from the
> card detect work function.
>
> This appears to fix a problem I have where a card stuck in a funny state
> doesn't get properly cleared by the power being turned off, presumably
> due to lack of power sequencing. This resulted in the following log
> messages after boot:

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
