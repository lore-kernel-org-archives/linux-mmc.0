From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Do not release spinlock in request_end
Date: Wed, 12 Oct 2011 11:41:19 +0200
Message-ID: <CACRpkdb5pn=q+hQSsrTgKbCvuKR83vHn1iAfvzMFXQeAgv--+Q@mail.gmail.com>
References: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51255 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab1JLJlU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2011 05:41:20 -0400
Received: by qyk30 with SMTP id 30so4517385qyk.19
        for <linux-mmc@vger.kernel.org>; Wed, 12 Oct 2011 02:41:20 -0700 (PDT)
In-Reply-To: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Lee Jones <lee.jones@linaro.org>

On Tue, Oct 11, 2011 at 4:06 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> The patch "mmc: core: move ->request() call from atomic context",
> is the reason to why this change is possible. This simplifies the
> error handling code execution path quite a lot and potentially also
> fixes some error handling hang problems.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Adrian do you agree with this?

To me it looks correct,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
