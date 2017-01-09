From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 05/21] mmc: sh_mmcif: Remove unused ccs_unsupported from
 the platform data
Date: Mon, 9 Jan 2017 16:05:46 +0100
Message-ID: <CACRpkdZJD2D=9nWTiFGedTnNk-3Y=MXUaaKC+d3axtvx8SE=AQ@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-6-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33729 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762264AbdAIPFs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 10:05:48 -0500
Received: by mail-qt0-f169.google.com with SMTP id v23so137878177qtb.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 07:05:47 -0800 (PST)
In-Reply-To: <1483102054-1752-6-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> There are currently no users of the ccs_unsupported member from the
> platform data, so let's remove it.
>
> Note, as some of the sh_mmcif variants may not support ccs, let's keep the
> current code in the driver, which deals with this. For future support, we
> should invent a DT binding instead, but let's leave that until it's needed.
>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
