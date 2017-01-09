From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 06/21] mmc: sh_mmcif: Remove unused clk_ctrl2_present from
 the platform data
Date: Mon, 9 Jan 2017 16:06:28 +0100
Message-ID: <CACRpkdYyRC4BfT0v1knwvPNZrKej-X7usM_oVZ6A6T-HEp_V3Q@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-7-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:32795 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034420AbdAIPG3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 10:06:29 -0500
Received: by mail-qk0-f179.google.com with SMTP id s140so120099661qke.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 07:06:29 -0800 (PST)
In-Reply-To: <1483102054-1752-7-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> There are currently no users of the clk_ctrl2_present member from the
> platform data, so let's remove it.
>
> Note, as some of the sh_mmcif variants may support clk_ctrl2, let's keep
> the current code in the driver, which deals with this. For future support,
> we should invent a DT binding instead, but let's leave that until it's
> needed.
>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
