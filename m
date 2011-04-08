From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 00/12] mmc: use nonblock mmc requests to minimize latency
Date: Fri, 8 Apr 2011 18:49:17 +0200
Message-ID: <BANLkTikZVDejarZ4O5KgNS7S4fxBLSmANA@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54704 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab1DHQtT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2011 12:49:19 -0400
In-Reply-To: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Chris Ball <cjb@laptop.org>

On Wed, Apr 6, 2011 at 9:07 PM, Per Forlin <per.forlin@linaro.org> wrote:

> The intention for introducing none blocking mmc requests is to minimize the
> time between a mmc request ends and another mmc request starts.

Acked-by: Linus Walleij <linus.walleij@linaro.org> FWIW, I've looked at the
patches so many times I'm already blind for any remaining bugs...

Yours,
Linus Walleij
