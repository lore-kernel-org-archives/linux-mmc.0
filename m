From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Wed, 15 Jan 2014 21:26:28 +0900
Message-ID: <001c01cf11ed$039b6270$0ad22750$%jun@samsung.com>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org>
 <1389780469-32633-1-git-send-email-zhangfei.gao@linaro.org>
 <001701cf11e9$25b5fe50$7121faf0$%jun@samsung.com> <52D67A9B.4090607@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36816 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbaAOM0a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 07:26:30 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZF000MDZW4MY40@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 15 Jan 2014 21:26:28 +0900 (KST)
In-reply-to: <52D67A9B.4090607@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'zhangfei' <zhangfei.gao@linaro.org>, 'Kevin Hilman' <khilman@linaro.org>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Wed, January 15, 2014, Zhangfei Gao wrote:
> On 01/15/2014 07:58 PM, Seungwon Jeon wrote:
> > On Wed, January 15, 2014, Zhangfei Gao wrote:
> >> Introduced from commit bf626e5550f24aec24975a0e85ad8e572ca76a6b
> >> CDETECT is ignored since negated return value of mmc_gpio_get_cd(mmc)
> >> can not be checked by IS_ERR_VALUE.
> >> Add spin_lock_bh(&host->lock) for atomic accessing DW_MMC_CARD_PRESENT,
> >> otherwise sd detect may occasionally fail.
> >>
> >> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> >> Reported-by: Kevin Hilman <khilman@linaro.org>
> >> Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> Tested-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> ---
> >>   drivers/mmc/host/dw_mmc.c |    9 ++++++---
> >>   1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> >> index a776f24f4311..9ded62c8225e 100644
> >> --- a/drivers/mmc/host/dw_mmc.c
> >> +++ b/drivers/mmc/host/dw_mmc.c
> >> @@ -1033,7 +1033,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
> >>   	int present;
> >>   	struct dw_mci_slot *slot = mmc_priv(mmc);
> >>   	struct dw_mci_board *brd = slot->host->pdata;
> >> -	int gpio_cd = !mmc_gpio_get_cd(mmc);
> >> +	struct dw_mci *host = slot->host;
> >> +	int gpio_cd = mmc_gpio_get_cd(mmc);
> >>
> >>   	/* Use platform get_cd function, else try onboard card detect */
> >>   	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
> >> @@ -1041,11 +1042,12 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
> >>   	else if (brd->get_cd)
> >>   		present = !brd->get_cd(slot->id);
> >>   	else if (!IS_ERR_VALUE(gpio_cd))
> >> -		present = !!gpio_cd;
> >> +		present = !gpio_cd;
> > !!gpio_cd or gpio_cd is correct, isn't it?
> >
> 
> No, mmc_gpio_get_cd(mmc) has to revert.
I'm missing something?
If card is detected, mmc_gpio_get_cd() returns non-zero, right?
I guess gpio_cd should be kept.

> !!gpio_cd is used before since gpio_cd = !mmc_gpio_get_cd(mmc) is used
> before.
> 
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

