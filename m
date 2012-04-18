From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] dw-mmc: prevent the Null pointer dereference for dma_ops
Date: Wed, 18 Apr 2012 11:02:11 +0100
Message-ID: <CAFbHwiQ5Q8qaog2ZPSs-HkoAnnGTofBFb4tM=XVo_vAYPkts2A@mail.gmail.com>
References: <4F8E6257.5010603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57630 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab2DRKCL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 06:02:11 -0400
Received: by pbcun15 with SMTP id un15so8752789pbc.19
        for <linux-mmc@vger.kernel.org>; Wed, 18 Apr 2012 03:02:11 -0700 (PDT)
In-Reply-To: <4F8E6257.5010603@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

On Wed, Apr 18, 2012 at 7:42 AM, Jaehoon Chung <jh80.chung@samsung.com>=
 wrote:
> Now, dma_ops is assumed that use the IDMAC.
> But if dma_ops is assigned the pdata->dma_ops,
> We didn't ensure that callback function is defined.
>
> If anything of callback didn't define, then should be run the PIO mod=
e.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)

This looks ok.

Acked-by: Will Newton <will.newton@imgtec.com>
