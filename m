From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: core/mmci: restore pre/post_req behaviour
Date: Mon, 30 Jan 2017 09:26:56 +0100
Message-ID: <CACRpkdadrTRkfq06Q+WQ=tQtb4WRicE62E4ahzzdmgPCcNbW5g@mail.gmail.com>
References: <20170127140454.7990-1-linus.walleij@linaro.org> <CAPDyKFomNHTPMDUT_CUjQuG-goTuQoXqzn+vOgdP9njUTWjGXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33076 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbdA3I1D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 03:27:03 -0500
Received: by mail-io0-f173.google.com with SMTP id v96so5861902ioi.0
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2017 00:26:58 -0800 (PST)
In-Reply-To: <CAPDyKFomNHTPMDUT_CUjQuG-goTuQoXqzn+vOgdP9njUTWjGXg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Russell King <linux@arm.linux.org.uk>

On Fri, Jan 27, 2017 at 3:18 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Do you think this is material for stable, or we could just see it as
> an improved behaviour of the core and mmci?

It's not regressing anything so just put it in for next, no hurry.

The important thing is to get rid of it from core for the future.

Yours,
Linus Walleij
