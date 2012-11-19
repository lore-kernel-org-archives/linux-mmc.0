From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [PATCH] Powerpc eSDHC: Use u64 to calculate the timeout value to
 avoid overflow
Date: Sun, 18 Nov 2012 21:02:17 -0800
Message-ID: <20121119050217.GB28159@lizard>
References: <1353296310-10786-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49258 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab2KSFFa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Nov 2012 00:05:30 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so3186755pbc.19
        for <linux-mmc@vger.kernel.org>; Sun, 18 Nov 2012 21:05:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353296310-10786-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

On Mon, Nov 19, 2012 at 11:38:28AM +0800, Haijun Zhang wrote:
> As some mmc cards need large timeout value usually a few seconds,
> so data timeout nanosecond will overflow with u32 variable and
> give the wrong timeout value, so use u64 will be safe.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>

Nope, you should not put my Signed-off-by here, I didn't sign on the
patch, neither I'm in patch's delivery path.

Preserving my exact tags (Acked-by or Reviewed-by) is important, they all
have different meanings.

You can refer to Documentation/SubmittingPatches, the document describes
each tag in detail.

Thanks,
Anton.
