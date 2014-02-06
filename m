From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v3 8/8] mmc: dw_mmc: fix the checking whether card is
 present
Date: Thu, 06 Feb 2014 20:29:52 +0900
Message-ID: <002a01cf232e$c0d44bc0$427ce340$%jun@samsung.com>
References: <52EF7A5B.3030902@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59958 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755766AbaBFL3y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Feb 2014 06:29:54 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0K009CTNXTCLB0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 06 Feb 2014 20:29:53 +0900 (KST)
In-reply-to: <52EF7A5B.3030902@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>

On Mon, February 03, 2014, Jaehoon Chung wrote:
> Broken card detection is assumed "the card is present".
> Non-removable card didn't call get_cd().
> dw-mmc controller didn't check whether card is present or not.
> Because DW_MMC_CARD_PRESENT flag is set into dw_mci_get_cd().
> If cd-pin is used, then dw_mci_get_cd() is called.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ac2907d..0d6ab8f 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -910,6 +910,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
>  	struct dw_mci *host = slot->host;
> +	struct dw_mci_board *brd = host->pdata;
> 
>  	WARN_ON(slot->mrq);
> 
> @@ -920,7 +921,8 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	 */
>  	spin_lock_bh(&host->lock);
> 
> -	if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
> +	if (!(brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION) &&
> +			!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {

I think 'non-removable' property doesn't indicate DW_MCI_QUIRK_BROKEN_CARD_DETECTION.
Actually DW_MCI_QUIRK_BROKEN_CARD_DETECTION is set with 'broken-cd' property as quirk.
Still, DW_MMC_CARD_PRESENT flag won't be set  with 'non-removable' property.

The following part was removed from commit bf626e5(mmc: dw_mmc: use slot-gpio to handle cd pin).
It would be better to restore that to resolved this problem. 

<Quoted>
static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
@@ -2197,12 +2223,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 #endif /* CONFIG_MMC_DW_IDMAC */
        }

-       if (dw_mci_get_cd(mmc))
-               set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
-       else
-               clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
-
</Quoted>

Then, Needed to check 'non-removable' case in dw_mci_get_cd().
I think MMC_CAP_NONREMOVABLE is useful.

Thanks,
Seungwon Jeon

