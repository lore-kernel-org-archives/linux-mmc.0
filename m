From: Chris Ball <cjb@laptop.org>
Subject: Re: dw_mmc updates
Date: Fri, 22 Mar 2013 13:15:54 -0400
Message-ID: <87boabl5it.fsf@octavius.laptop.org>
References: <000601ce262f$5adc52b0$1094f810$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47799 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422635Ab3CVRP6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 13:15:58 -0400
In-Reply-To: <000601ce262f$5adc52b0$1094f810$%jun@samsung.com> (Seungwon
	Jeon's message of "Thu, 21 Mar 2013 21:26:46 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>

Hi,

On Thu, Mar 21 2013, Seungwon Jeon wrote:
> Hi Chris,
>
> There are pending patches for dw_mmc a little bit.
> Please could you pick the following patches to your tree?
> These patches are sorted and there are currently no conflicts.
>
> [PATCH v3] mmc: dw_mmc: read all data in FIFO after Data transfer over
> interrupt in pio mode
> [PATCH] mmc: dw-mmc: return the result of mmc_add_host()
> [PATCH 2/2] mmc: dw_mmc: exynos: Remove unnecessary use of of_match_ptr()
> [PATCH] mmc: dw_mmc: fixed a wrong UHS_REG 16 bit clear
> [PATCH v4] mmc: dw_mmc: Add MSHC compatible for Exynos4412
> [PATCH] mmc: dw_mmc: move host->data_offset init earlier
> [PATCH] mmc: dw_mmc: setpower on MMC_POWER_{UP,OFF}
> [PATCH 1/3] dw_mmc: Don't loop when handling an interrupt

Thanks, I've got all of these (and more) now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
