From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 09/12] mmc: mmci: add f_max to variant structure
Date: Wed, 11 Jun 2014 14:47:27 +0200
Message-ID: <CACRpkdbeGSwq8fAxj-M75NRLN=Jqqn4ExJ7bF3XC=o2FRVySJA@mail.gmail.com>
References: <1401699818-11329-1-git-send-email-srinivas.kandagatla@linaro.org>
	<1401700187-11793-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:65191 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbaFKMr1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jun 2014 08:47:27 -0400
Received: by mail-ob0-f180.google.com with SMTP id vb8so5072730obc.39
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jun 2014 05:47:27 -0700 (PDT)
In-Reply-To: <1401700187-11793-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On Mon, Jun 2, 2014 at 11:09 AM,  <srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Some of the controller have maximum supported frequency, This patch adds
> support in variant data structure to specify such restrictions. This
> gives more flexibility in calculating the f_max before passing it to
> mmc-core.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
