From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: call mmc_of_parse to fill in common
 options
Date: Mon, 20 Jan 2014 13:53:10 +0900
Message-ID: <52DCABB6.6000000@samsung.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-3-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27075 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbaATEw4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jan 2014 23:52:56 -0500
In-reply-to: <1390190215-22700-3-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, galak@codeaurora.org, chris@printf.net

Hi, Olof.

It looks good to me. When use the mmc_of_parse, we can also remove the duplicated property.
I have also worked the patch for using mmc_of_parse().

1. caps2-mmc-hs200-1_8v/1_2v capability can be moved into mmc_of_parse.
then we can remove parsing of dt into dw_mmc.c
2. keep-power-in-suspend/enable-sdio-wakeup can be removed.

If i missed other patch, let me know, plz.

how about?
if you're ok, i will send the patch-set on this week.

Best Regards,
Jaehoon Chung

On 01/20/2014 12:56 PM, Olof Johansson wrote:
> The shared of parse function fills in common options for capabilities,
> etc, but it needs to be called from each driver that wants to make use
> of it. dw_mmc was missing the call.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  drivers/mmc/host/dw_mmc.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a776f24..7119f63 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2137,6 +2137,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	if (!mmc)
>  		return -ENOMEM;
>  
> +	mmc_of_parse(mmc);
> +
>  	slot = mmc_priv(mmc);
>  	slot->id = id;
>  	slot->mmc = mmc;
> 

