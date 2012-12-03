From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 1/4] mmc: dw-mmc: relocate the position called dw_mci_setup_bus()
Date: Mon, 03 Dec 2012 14:44:17 -0500
Message-ID: <87zk1uhqem.fsf@octavius.laptop.org>
References: <509B6ED1.7030707@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44278 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880Ab2LCToW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Dec 2012 14:44:22 -0500
In-Reply-To: <509B6ED1.7030707@samsung.com> (Jaehoon Chung's message of "Thu,
	08 Nov 2012 17:35:29 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

Hi,

On Thu, Nov 08 2012, Jaehoon Chung wrote:
> To ensure the stable clock need to enable before set the DW_MMC_CARD_NEED_INIT flag.
> If set DW_MMC_CARD_NEED_INIT flag, wait for 80-clock before first command after power-up.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.8 with Will's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
