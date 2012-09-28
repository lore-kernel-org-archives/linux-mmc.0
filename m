From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: convert the variable type of irq
Date: Fri, 28 Sep 2012 11:00:24 +0100
Message-ID: <CAFbHwiSZ9Wi+cTxvMWLm2U84jOVstrZNhwjDgXJZzW3ZSCB8gg@mail.gmail.com>
References: <00f901cd9d39$2f84c720$8e8e5560$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48905 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757182Ab2I1KAZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 06:00:25 -0400
Received: by bkcjk13 with SMTP id jk13so3105367bkc.19
        for <linux-mmc@vger.kernel.org>; Fri, 28 Sep 2012 03:00:24 -0700 (PDT)
In-Reply-To: <00f901cd9d39$2f84c720$8e8e5560$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

On Fri, Sep 28, 2012 at 6:21 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Even though platform_get_irq returns error, 'host->irq'
> always has an unsigned value. Less-than-zero comparison
> of an unsigned value is never true. Type of 'unsigned int'
> will be changed for 'int'.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  include/linux/mmc/dw_mmc.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Will Newton <will.newton@imgtec.com>
