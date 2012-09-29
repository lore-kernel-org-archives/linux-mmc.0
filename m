From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v5 13/13] mmc: sdhci-pxav3: remove set_uhs_signaling function
Date: Sat, 29 Sep 2012 16:03:53 +0800
Message-ID: <CAMj5BkhO3-YW6Nfi0Ke15fj7bPi=YKNieDp6kc2P1VFxQ+vMKQ@mail.gmail.com>
References: <1348818972-26711-1-git-send-email-keyuan.liu@gmail.com>
	<1348818972-26711-14-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51113 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab2I2IDz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 29 Sep 2012 04:03:55 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so703636wib.1
        for <linux-mmc@vger.kernel.org>; Sat, 29 Sep 2012 01:03:53 -0700 (PDT)
In-Reply-To: <1348818972-26711-14-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

On Fri, Sep 28, 2012 at 3:56 PM, Kevin Liu <keyuan.liu@gmail.com> wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> Because sdhci can do the same thing so no need to implement this.
>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>

Acked-by:  Zhangfei Gao <zhangfei.gao@marvell.com>

If so, (*set_uhs_signaling) can be removed from sdhci.h.
"int     (*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);"

/Zhangfei
