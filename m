From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4] mmc: card: Skip secure option for MoviNAND.
Date: Sun, 19 Aug 2012 00:21:12 +0200
Message-ID: <CACRpkdZjssRDyE6FRsY6O6_30XBNRk4_TTS7B1=7DcmXvo8Hhw@mail.gmail.com>
References: <502C8247.7070209@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:57283 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab2HRWVN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Aug 2012 18:21:13 -0400
Received: by vcbfk26 with SMTP id fk26so3983429vcb.19
        for <linux-mmc@vger.kernel.org>; Sat, 18 Aug 2012 15:21:12 -0700 (PDT)
In-Reply-To: <502C8247.7070209@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: IAN CHEN <ian.cy.chen@samsung.com>
Cc: cjb@laptop.org, linkinjeon@gmail.com, adrian.hunter@intel.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, d.j.shin@samsung.com, jongtae22.kim@samsung.com, kyungmin.park@samsung.com, jh80.chung@samsung.com

On Thu, Aug 16, 2012 at 7:16 AM, IAN CHEN <ian.cy.chen@samsung.com> wrote:

> For several MoviNAND, there are some known issue with secure option.
> For these specific MoviNAND device, we skip secure option.
>
> You could refer this discussion in XDA developers.
> http://forum.xda-developers.com/showthread.php?t=1644364
> https://plus.google.com/111398485184813224730/posts/21pTYfTsCkB#111398485184813224730/posts/21pTYfTsCkB
>
> Signed-off-by: Ian Chen <ian.cy.chen@samsung.com>

Looking good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
