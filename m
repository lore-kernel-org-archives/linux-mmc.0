From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv5] mmc: remove MMC_CAP_ERASE to enable trim in eMMC/SD Device
Date: Mon, 26 May 2014 16:44:05 +0200
Message-ID: <CAPDyKFokTVmcVJmFzWF3iG5h2NnATW1JW_TFeo=L+LUFTyRaRQ@mail.gmail.com>
References: <1401092960-16547-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:51849 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbaEZOoH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 May 2014 10:44:07 -0400
Received: by mail-qc0-f173.google.com with SMTP id i8so12137898qcq.18
        for <linux-mmc@vger.kernel.org>; Mon, 26 May 2014 07:44:05 -0700 (PDT)
In-Reply-To: <1401092960-16547-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Gwendal Grignou <gwendal@chromium.org>, Grant Grundler <grundler@chromium.org>, Puthikorn Voravootivat <puthik@chromium.org>

On 26 May 2014 10:29, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> From: Puthikorn Voravootivat <puthik@chromium.org>
>
> Remove MMC_CAP_ERASE from all host as it does not make
> sense that the eMMC/SD device erase feature should be
> controlled by the host cap. This make trim and/or discard
> feature usable in the supported eMMC/SD device.
>
> Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

I like the idea behind this patch.

At same time I know we have some bugs regarding TRIM/ERASE/DISCARD
operations. A better approach is to solve these first.

http://www.spinics.net/lists/linux-mmc/msg26249.html

The are some older threads on this topic as well.

Kind regards
Ulf Hansson
