From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mxcmmc: Use mmc_regulator_get_supply() API
Date: Thu, 8 May 2014 10:49:09 +0200
Message-ID: <CAPDyKFp4VuG_X3A12nv2qmjFQVvN3qVBxbgquUKXWWYTO2Hd9A@mail.gmail.com>
References: <1399100117-6978-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:42144 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbaEHItJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 May 2014 04:49:09 -0400
Received: by mail-qa0-f50.google.com with SMTP id j15so2247077qaq.9
        for <linux-mmc@vger.kernel.org>; Thu, 08 May 2014 01:49:09 -0700 (PDT)
In-Reply-To: <1399100117-6978-1-git-send-email-shc_work@mail.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 3 May 2014 08:55, Alexander Shiyan <shc_work@mail.ru> wrote:
> This patch replaces regulator manipulation with
> mmc_regulator_get_supply() function from MMC core.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Thanks, I will include this in the next PR I send to Chris.

Kind regards
Ulf Hansson
