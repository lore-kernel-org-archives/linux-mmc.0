From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND] mmc: dw_mmc: fix fifo access for 64-bit
Date: Thu, 04 Apr 2013 09:56:16 -0400
Message-ID: <87zjxepfgf.fsf@octavius.laptop.org>
References: <001c01ce292a$54a35a80$fdea0f80$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57874 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760382Ab3DDN4V (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 4 Apr 2013 09:56:21 -0400
In-Reply-To: <001c01ce292a$54a35a80$fdea0f80$%jun@samsung.com> (Seungwon
	Jeon's message of "Mon, 25 Mar 2013 16:28:22 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>

Hi,

On Mon, Mar 25 2013, Seungwon Jeon wrote:
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

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
