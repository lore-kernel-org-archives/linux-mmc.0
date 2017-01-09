From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 04/21] mmc: sh_mmcif: Remove unused ->get_cd() platform callback
Date: Mon, 9 Jan 2017 16:04:56 +0100
Message-ID: <CACRpkdb4Dv9i1JqrdrrhoDO6cP=ygyX+zp14A+n-=Ap9ZxmOGg@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33187 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761660AbdAIPE6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 10:04:58 -0500
Received: by mail-qt0-f176.google.com with SMTP id v23so137853039qtb.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 07:04:57 -0800 (PST)
In-Reply-To: <1483102054-1752-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Removing the callback also enables us to remove the sh_mmcif_get_cd()
> altogether, as we convert to use mmc_gpio_get_cd() to the same kind of
> work.
>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks correct, would need a Tested-by ideally?
Geert can you have a quick look at the Renesas patches in this
series?

Yours,
Linus Walleij
