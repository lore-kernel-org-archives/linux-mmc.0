From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw-mmc: modify the condition for platdata of blk-setting
Date: Mon, 16 Jan 2012 10:20:59 +0000
Message-ID: <CAFbHwiR5yD+_GMK4ZEZ0uV3Gq7Wh-n8fM7M_RrPOX0o_cN4+6g@mail.gmail.com>
References: <4F138F47.7040709@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42990 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab2APKU7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2012 05:20:59 -0500
Received: by pbaa10 with SMTP id a10so495203pba.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2012 02:20:59 -0800 (PST)
In-Reply-To: <4F138F47.7040709@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

On Mon, Jan 16, 2012 at 2:45 AM, Jaehoon Chung <jh80.chung@samsung.com>=
 wrote:
> When use the IDMAC, we can also want to use the pdata->blk-setting.
> So if pdata->blk-setting is unset, use the default value.
> if not, use the pdata->blk-setting.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 16 ++++++++--------
> =A01 files changed, 8 insertions(+), 8 deletions(-)

Looks good.

Acked-by: Will Newton <will.newton@imgtec.com>
