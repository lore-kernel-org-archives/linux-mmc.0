From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH RESEND v7 1/3] mmc: core: Add packed command feature of eMMC4.5
Date: Mon, 18 Jun 2012 23:09:46 +0900
Message-ID: <CAKYAXd8J+ijMKvR0AOTRUS6h6WxeRq7-hsz3pRc5f5-fFOB9xQ@mail.gmail.com>
References: <007a01cd4d15$2bba3d10$832eb730$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33179 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab2FROJr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jun 2012 10:09:47 -0400
In-Reply-To: <007a01cd4d15$2bba3d10$832eb730$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>, "S, Venkatraman" <svenkatr@ti.com>

2012/6/18 Seungwon Jeon <tgih.jun@samsung.com>:
> This patch adds packed command feature of eMMC4.5.
> The maximum number for packing read(or write) is offered
> and exception event relevant to packed command which is
> used for error handling is enabled. If host wants to use
> this feature, MMC_CAP2_PACKED_CMD should be set.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
Looks good to me.
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>

Thanks.
