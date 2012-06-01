From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: fix wrong return value when suspend
Date: Fri, 1 Jun 2012 10:11:05 +0800
Message-ID: <CAPDyKFrHjVe4Y-d0zSM4hdc=yqN5JGKoi3ujc+nHJHe6vB+WcA@mail.gmail.com>
References: <4FC756A3.3000803@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64437 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757778Ab2FACLH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 May 2012 22:11:07 -0400
Received: by eaak11 with SMTP id k11so359024eaa.19
        for <linux-mmc@vger.kernel.org>; Thu, 31 May 2012 19:11:05 -0700 (PDT)
In-Reply-To: <4FC756A3.3000803@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Jaehoon,

This make sense to me!

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Ulf Hansson

On 31 May 2012 19:31, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> When mmc_host is not spi mode, mmc/sd is doing mmc_deselect_cards().
> mmc_deselect_cards could be returned error.
> If returned error, we can know something wrong when enter suspend.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
