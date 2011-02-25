From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 3/3] dw_mmc: add quirks unreliable detect and capabilities
Date: Fri, 25 Feb 2011 17:58:52 +0000
Message-ID: <AANLkTikfOPtu+oecirTTxrgtaJb_uv+77U1aXuW8STV2@mail.gmail.com>
References: <4D670F0F.6050003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f51.google.com ([74.125.83.51]:40081 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899Ab1BYR6x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Feb 2011 12:58:53 -0500
Received: by gwb15 with SMTP id 15so1234512gwb.10
        for <linux-mmc@vger.kernel.org>; Fri, 25 Feb 2011 09:58:53 -0800 (PST)
In-Reply-To: <4D670F0F.6050003@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Fri, Feb 25, 2011 at 2:08 AM, Jaehoon Chung <jh80.chung@samsung.com>=
 wrote:
> This patch added quirks and capabilities in platdata.
>
> Some card didn't use the CDn pin. In that case, We assume card insert=
ed,
> then the card initialized or not.
> And Some board need other capabilities. So added capabilities in boar=
d platdata.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c =A0| =A0 10 ++++++++--
> =A0include/linux/mmc/dw_mmc.h | =A0 10 +++++++---
> =A02 files changed, 15 insertions(+), 5 deletions(-)

Acked-by: Will Newton <will.newton@imgtec.com>
