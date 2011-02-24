From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] dw_mmc: support DDR mode
Date: Thu, 24 Feb 2011 10:22:05 +0000
Message-ID: <AANLkTi=1zXrNucgtVqOdeL0hWVjDnY65Q1YZeZGfMpJR@mail.gmail.com>
References: <4D65E293.2040008@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47320 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab1BXKWH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 05:22:07 -0500
Received: by yxs7 with SMTP id 7so201320yxs.19
        for <linux-mmc@vger.kernel.org>; Thu, 24 Feb 2011 02:22:06 -0800 (PST)
In-Reply-To: <4D65E293.2040008@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Thu, Feb 24, 2011 at 4:46 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> This patch is applied DDR mode in dw_mmc.
>
> DW_MMC is supported DDR mode.
> If set any bit in UHS_REG bit[16:31], the card of that slot is supported DDR mode.
> For example, if UHS_REG[16] is set, card number 0 is DDR mode.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

This looks ok to me.

Acked-by: Will Newton <will.newton@imgtec.com>
