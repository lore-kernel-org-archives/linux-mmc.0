From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: exynos: remove incorrect __exit_p()
Date: Mon, 26 Jan 2015 12:49:28 -0800
Message-ID: <CAD=FV=XWz1EktXSX_emtKpEhJKdseeuvgg4yTwaCVHBZ_sDfSg@mail.gmail.com>
References: <20150124003340.GA16286@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35527 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbbAZUt3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Jan 2015 15:49:29 -0500
Received: by mail-ie0-f171.google.com with SMTP id tr6so11225391ieb.2
        for <linux-mmc@vger.kernel.org>; Mon, 26 Jan 2015 12:49:28 -0800 (PST)
In-Reply-To: <20150124003340.GA16286@dtor-ws>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Kukjin Kim <kgene@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Dmitry,

On Fri, Jan 23, 2015 at 4:33 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> dw_mci_pltfm_remove() is not (nor should it be) marked as __exit,
> so we should not be using __exit_p() wrapper with it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Nice catch, thanks!

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
