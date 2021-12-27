Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E775FC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Dec 2021 10:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhL0KpD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Dec 2021 05:45:03 -0500
Received: from smtp1.axis.com ([195.60.68.17]:1911 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236302AbhL0KpC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Dec 2021 05:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1640601902;
  x=1672137902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nJS/ETimqqXYVsd/Q/t4na/gDjkqxe+CdxQx23HcRPo=;
  b=caERFSJU+mmHLJi0uNxDQ2vh84Xq8HvnuvAG+FtMWJVCRv+uBhE9HMrP
   dYJz2qO7oGKDzqX4bvdokb03TAwHttbROGKimM6rMJqGl9pss8Y1kh3Xj
   l+ebrnY+nvHm+/vDOMotwuXs0O+aT22U2asmIbaPu2ft3CXXV8wXPcEIe
   rLZDv8iZPSHsmwAzCSKj/U42M+fdcbXJE5mjw1hqxaDJUdHBzJxb+Od7y
   3w2u/ZhA05ON3tflBJ2ODiqVD4sRhkJxBbBql8GnUcJhQh6rg2qKjL7yD
   3d78Bs0WEdTNck/3jh19wwMOCtJfdG4Mgw4wiCC/rsGPsmY9Q9DzJtkNo
   w==;
Date:   Mon, 27 Dec 2021 11:45:01 +0100
From:   Jesper Nilsson <Jesper.Nilsson@axis.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Lars Persson <Lars.Persson@axis.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>
Subject: Re: [PATCH RFC 13/13] mmc: usdhi60rol0: fix deferred probing
Message-ID: <20211227104501.GP5179@axis.com>
References: <20211223171202.8224-1-s.shtylyov@omp.ru>
 <20211223171202.8224-14-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211223171202.8224-14-s.shtylyov@omp.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Dec 23, 2021 at 06:12:02PM +0100, Sergey Shtylyov wrote:
> The driver overrides the error codes returned by platform_get_irq() to
> -ENODEV, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the
> error codes upstream.
> 
> Fixes: 9ec36cafe43b ("of/irq: do irq resolution in platform_get_irq")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Looks good to me.

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
