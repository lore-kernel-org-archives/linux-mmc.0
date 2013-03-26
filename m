From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH RESEND] mmc: dw_mmc: fix fifo access for 64-bit
Date: Tue, 26 Mar 2013 21:02:59 +0900
Message-ID: <51518E73.3080604@samsung.com>
References: <001c01ce292a$54a35a80$fdea0f80$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:52532 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939Ab3CZMDA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Mar 2013 08:03:00 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MK9003GMO4TMY00@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 26 Mar 2013 21:02:58 +0900 (KST)
In-reply-to: <001c01ce292a$54a35a80$fdea0f80$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 03/25/2013 04:28 PM, Seungwon Jeon wrote:
> mci_writew causes a failure of fifo access for 64-bit.
> mci_writeq is correct.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a443820..753c55c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1373,8 +1373,9 @@ static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt)
>  		int len = dw_mci_push_part_bytes(host, buf, cnt);
>  		buf += len;
>  		cnt -= len;
> +
>  		if (host->part_buf_count == 8) {
> -			mci_writew(host, DATA(host->data_offset),
> +			mci_writeq(host, DATA(host->data_offset),
>  					host->part_buf);
>  			host->part_buf_count = 0;
>  		}
> 

