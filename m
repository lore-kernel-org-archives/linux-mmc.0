From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] ARM: mmci: add support for the Nomadik MMCI variant
Date: Tue, 10 Apr 2012 15:44:51 +0200
Message-ID: <4F843953.6070503@stericsson.com>
References: <1334005410-20539-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:58592 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753175Ab2DJNpO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Apr 2012 09:45:14 -0400
In-Reply-To: <1334005410-20539-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 04/09/2012 11:03 PM, Linus Walleij wrote:
> The Nomadik variant is somewhere inbetween the U300 and the Ux500
> variant, its actually expose the same primecell ID as the U300
> but had different characteristics so it needs a small revision
> bump and hard-coding from the board/device tree. After this it
> works just fine.
>
> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>

Looks good to me. Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>
