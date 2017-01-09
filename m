From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 07/21] mmc: dw_mmc: Remove the public dw_mmc header file
Date: Mon, 9 Jan 2017 16:13:34 +0100
Message-ID: <CACRpkdZa-vdWpWfVi4=fE=qck_xEdMjTCsZqBhGw1mdwzGgONA@mail.gmail.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org> <1483102054-1752-8-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36733 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969810AbdAIPNk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2017 10:13:40 -0500
Received: by mail-qk0-f176.google.com with SMTP id 11so44788923qkl.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jan 2017 07:13:35 -0800 (PST)
In-Reply-To: <1483102054-1752-8-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

On Fri, Dec 30, 2016 at 1:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> There are currently no external users of the public dw_mmc header file,
> except the dw_mmc driver itself. Therefore let's move the definitions from
> the public dw_mmc header file into the existing private dw_mmc header file
> and then remove the public one.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
