From: "Dorfman, Konstantin" <kdorfman@codeaurora.org>
Subject: Re: [PATCH 1/5] mmc: core: Add support to read command queue parameters
Date: Thu, 04 Dec 2014 14:27:01 -0800
Message-ID: <5480DFB5.5000104@codeaurora.org>
References: <20141202115629.GA27638@asutoshd-ics.in.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:59544 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbaLDW1E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Dec 2014 17:27:04 -0500
In-Reply-To: <20141202115629.GA27638@asutoshd-ics.in.qualcomm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org


On 12/2/2014 3:56 AM, Sujit Reddy Thumma wrote:
> eMMC cards with EXT_CSD version >= 7, optionally support command
> queuing feature as defined by Jedec eMMC5.1. Add support for probing
> command queue feature for such type of cards.
>
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>   drivers/mmc/core/mmc.c   | 15 +++++++++++++++
>   include/linux/mmc/card.h |  7 +++++++
>   include/linux/mmc/mmc.h  |  6 ++++++
>   3 files changed, 28 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 1ab5f3a..0ef3af5 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -571,6 +571,21 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>   		card->ext_csd.data_sector_size = 512;
>   	}
>   
> +	if (card->ext_csd.rev >= 7) {
> +		card->ext_csd.cmdq_support = ext_csd[EXT_CSD_CMDQ_SUPPORT];
> +		if (card->ext_csd.cmdq_support)
> +			card->ext_csd.cmdq_depth = ext_csd[EXT_CSD_CMDQ_DEPTH];
> +	}
Remove duplicated code.
> +
> +	if (card->ext_csd.rev >= 7) {
> +		card->ext_csd.cmdq_support = ext_csd[EXT_CSD_CMDQ_SUPPORT];
> +		if (card->ext_csd.cmdq_support)
> +			card->ext_csd.cmdq_depth = ext_csd[EXT_CSD_CMDQ_DEPTH];
 From the spec (7.4.19 CMDQ_DEPTH [307]) [4:0]: N, a parameter used to 
calculate the Queue Depth of task queue in the device. Queue Depth = N+1.

