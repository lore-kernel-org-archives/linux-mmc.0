From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH resend] mmc: fix the mmc_app_send_scr() for dma transfer
Date: Fri, 25 Mar 2011 09:20:51 -0400
Message-ID: <m3y643l4jw.fsf@pullcord.laptop.org>
References: <4D8C30DB.1010007@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51053 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446Ab1CYNYZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Mar 2011 09:24:25 -0400
In-Reply-To: <4D8C30DB.1010007@renesas.com> (Yoshihiro Shimoda's message of
	"Fri, 25 Mar 2011 15:06:19 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-mmc@vger.kernel.org

Hi Yoshihiro,

On Fri, Mar 25 2011, Yoshihiro Shimoda wrote:
> This patch is based on the commit "af51715079e7fb6b290e1881d63d815dc4de5011":
>
>    * Bugfix to that mmc_send_cxd_data() code:  dma-to-stack is
>      unsafe/nonportable, so kmalloc a bounce buffer instead.
>
> The driver may invalidate the mmc_card->csd when host driver uses dma.
> So the subroutine also needs kmalloc buffer.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for the resend, pushed to mmc-next for .39-rc2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
