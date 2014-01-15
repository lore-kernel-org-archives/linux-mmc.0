From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Wed, 15 Jan 2014 23:32:15 +0800
Message-ID: <52D6A9FF.3000603@linaro.org>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org> <1389780469-32633-1-git-send-email-zhangfei.gao@linaro.org> <001701cf11e9$25b5fe50$7121faf0$%jun@samsung.com> <52D67A9B.4090607@linaro.org> <001c01cf11ed$039b6270$0ad22750$%jun@samsung.com> <52D6938A.9050806@linaro.org> <002c01cf11ff$6790a8a0$36b1f9e0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:58200 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbaAOPc1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 10:32:27 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb1so1301029pad.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2014 07:32:26 -0800 (PST)
In-Reply-To: <002c01cf11ff$6790a8a0$36b1f9e0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, 'Kevin Hilman' <khilman@linaro.org>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org


On 01/15/2014 10:38 PM, Seungwon Jeon wrote:
>> Hmm, looks you are right.
>> Though not see clearly mmc_gpio_get_cd declaratoin, other drivers
>> directly set get_cd as mmc_gpio_get_cd.
>> .get_cd	= mmc_gpio_get_cd
>>
>> However, in our board cd =0 when card is deteced while cd=1 when card is
>> removed.
>> In order to mmc_gpio_get_cd return 1, MMC_CAP2_CD_ACTIVE_HIGH has to be
>> set, as well as new property "caps2-mmc-cd-active-low".
> 
> Ok, you could do more.
> mmc_gpio_get_cd() is expected to return non-zero if card is detection.

> I think your board seems not to use pull-up on GPIO line for card detection.
> So, MMC_CAP2_CD_ACTIVE_HIGH would be needed.

Unfortunately, the specific cd pin can not be configured.
Suspect on our board the cd =1 when card is inserted, can not measure as
no clear resister and need check with hardware guy tomorrow.

"cd-inverted" may be required as mentioned by Arnd.
Will update the patch as following if no problem.

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9ded62c8225e..8326e54b96a8 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1042,7 +1042,7 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
        else if (brd->get_cd)
                present = !brd->get_cd(slot->id);
        else if (!IS_ERR_VALUE(gpio_cd))
-               present = !gpio_cd;
+               present = gpio_cd ^ brd->cd_inverted;
        else
                present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
                        == 0 ? 1 : 0;
@@ -2414,6 +2414,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct
dw_mci *host)
        if (of_find_property(np, "caps2-mmc-hs200-1_2v", NULL))
                pdata->caps2 |= MMC_CAP2_HS200_1_2V_SDR;

+       if (of_get_property(np, "cd-inverted", NULL))
+               pdata->cd_inverted = 1;
+
        return pdata;
 }

diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 6ce7d2cd3c7a..4535282589ab 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -238,6 +238,7 @@ struct dw_mci_board {
        u32 caps;       /* Capabilities */
        u32 caps2;      /* More capabilities */
        u32 pm_caps;    /* PM capabilities */
+       u8 cd_inverted;
