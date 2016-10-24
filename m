From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/4] mmc: core: Don't use ->card_busy() and CMD13 in
 combination when polling
Date: Mon, 24 Oct 2016 09:49:22 +0200
Message-ID: <CACRpkdbASwAgV2kTzVAMTHwC5fsGuEsJuYXq5n5VKgXmUqMfgA@mail.gmail.com>
References: <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org> <1476951579-26125-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34741 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932954AbcJXHtY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2016 03:49:24 -0400
Received: by mail-qk0-f182.google.com with SMTP id x11so15900952qka.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2016 00:49:23 -0700 (PDT)
In-Reply-To: <1476951579-26125-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>

On Thu, Oct 20, 2016 at 10:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> When polling for busy after sending a MMC_SWITCH command, both the optional
> ->card_busy() callback and CMD13 are being used in conjunction.
>
> This doesn't make sense. Instead it's more reasonable to rely solely on the
> ->card_busy() callback when it exists. Let's change that and instead use
> the CMD13 as a fall-back. In this way we avoid sending CMD13, unless it's
> really needed.
>
> Within this context, let's also take the opportunity to make some
> additional clean-ups and clarifications to the related code.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Tried these four patches but it doesn't make my root mount before
20 minutes on the Dragonboard, but I don't know if that was the
intention even? Just cleanup? Sorry if I got it wrong...

Yours,
Linus Walleij
