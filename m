From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH] mmc: card: Skip secure option for MoviNAND.
Date: Mon, 13 Aug 2012 22:02:53 +0900
Message-ID: <CAKYAXd--Ta1xL2uMEsArmpsg99x+B21ScJOQAty=RFWWCQ6M2w@mail.gmail.com>
References: <5028CDED.2020307@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:40435 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab2HMNCy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Aug 2012 09:02:54 -0400
In-Reply-To: <5028CDED.2020307@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: IAN CHEN <ian.cy.chen@samsung.com>
Cc: cjb@laptop.org, adrian.hunter@intel.com, subhashj@codeaurora.org, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, d.j.shin@samsung.com, jongtae22.kim@samsung.com, kyungmin.park@samsung.com, jh80.chung@samsung.com

Hi. Ian.

known issue ? Would you explain more ?

Thanks.

2012/8/13 IAN CHEN <ian.cy.chen@samsung.com>:
> From 5c60eb8be04c7440d6e33b8f72ea2046a3657ac4 Mon Sep 17 00:00:00 2001
> From: ian.cy.chen <ian.cy.chen@samsung.com>
> Date: Mon, 13 Aug 2012 10:53:55 +0900
> Subject: [PATCH] mmc: card: Skip secure option for MoviNAND.
>
> For several MoviNAND, there are some known issue with secure option.
> For these specific MoviNAND device, we skip secure option.
>
> Signed-off-by: Ian Chen <ian.cy.chen@samsung.com>
> ---
>  drivers/mmc/card/block.c |   24 +++++++++++++++++++++++-
>  include/linux/mmc/card.h |    1 +
>  2 files changed, 24 insertions(+), 1 deletions(-)
>
