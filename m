From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 2/3] dw_mmc: support mmc power control with regulator
Date: Fri, 25 Feb 2011 17:57:40 +0000
Message-ID: <AANLkTi=4_BanAR4+Sq4AKy6fwHptsyR41b66FP_-ETjQ@mail.gmail.com>
References: <4D670F0E.7000800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:37648 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab1BYR5l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Feb 2011 12:57:41 -0500
Received: by yib19 with SMTP id 19so816982yib.19
        for <linux-mmc@vger.kernel.org>; Fri, 25 Feb 2011 09:57:41 -0800 (PST)
In-Reply-To: <4D670F0E.7000800@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Fri, Feb 25, 2011 at 2:08 AM, Jaehoon Chung <jh80.chung@samsung.com>=
 wrote:
> This patch is applied the power control with regulator.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c =A0| =A0 25 +++++++++++++++++++++++++
> =A0include/linux/mmc/dw_mmc.h | =A0 =A02 ++
> =A02 files changed, 27 insertions(+), 0 deletions(-)

This looks ok from an mmc point of view. I'm not that familiar with
the regulator API however, so it would be good to get a review from
someone who is.

Acked-by: Will Newton <will.newton@imgtec.com>
