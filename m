From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: fixed wrong bit operation for SDMMC_GET_FCNT()
Date: Thu, 5 Jan 2012 10:20:52 +0000
Message-ID: <CAFbHwiTUjLUX2oRie2L5xDMg9BA+sLdYcg3H1w+vVJcQMVUwrg@mail.gmail.com>
References: <4F0577A9.5080302@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38198 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab2AEKUx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2012 05:20:53 -0500
Received: by pbdu13 with SMTP id u13so218746pbd.19
        for <linux-mmc@vger.kernel.org>; Thu, 05 Jan 2012 02:20:53 -0800 (PST)
In-Reply-To: <4F0577A9.5080302@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

On Thu, Jan 5, 2012 at 10:12 AM, Jaehoon Chung <jh80.chung@samsung.com>=
 wrote:
> In status register, fifo_count is bit[29:17].
> (0x1FFF is correctly)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.h | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)

Good catch, thanks!

Acked-by: Will Newton <will.newton@imgtec.com>
