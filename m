From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: MMC block addressing mode.
Date: Fri, 21 Apr 2017 10:23:45 +0200
Message-ID: <CAPDyKFpiS8mk6q3MYZ-=b9gkan5x+rRUaa+6FUWcxog5wqemjA@mail.gmail.com>
References: <f1cbb93e-68f0-df11-5e89-7b52e00a0b79@cavium.com>
 <CAPDyKFqfEQ6POgoSFL=t0nP62CB13DNL0m8m-Vzqaw0GMAV3qg@mail.gmail.com>
 <ef902f01-96fb-a314-e57c-bde8e1545b66@cavium.com> <c503aae1-4162-4398-1645-9e2acab5d002@caviumnetworks.com>
 <ebc19d7d-c6a2-0886-a17a-e1b4d82f957e@cavium.com> <fdc1864b-9d5a-25ad-5d15-dc094f1c0886@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36726 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036592AbdDUIXq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Apr 2017 04:23:46 -0400
Received: by mail-qt0-f180.google.com with SMTP id g60so64478062qtd.3
        for <linux-mmc@vger.kernel.org>; Fri, 21 Apr 2017 01:23:46 -0700 (PDT)
In-Reply-To: <fdc1864b-9d5a-25ad-5d15-dc094f1c0886@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Steven J. Hill" <Steven.Hill@cavium.com>
Cc: David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jan.glauber@caviumnetworks.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 20 April 2017 at 23:28, Steven J. Hill <Steven.Hill@cavium.com> wrote:
> On 04/20/2017 04:24 PM, Steven J. Hill wrote:
>> On 04/20/2017 12:12 PM, David Daney wrote:
>>>
>>> Steven and Jan:  Can we get around this requirement by:
>>>
>>> - Always set MIO_EMM_DMA[MULTI] = 1;  This way by SECTOR mode may be unimportant.
>>>
>>> - Always set MIO_EMM_DMA[SECTOR] = SUITABLE_CONSTANT.
>>>
>> No, this does not work. The 1.88GB card plugged into my 78xx
>> board gives the output below. We cannot just blindly set the
>> MULTI bit for all cards. These results are identical for all
>> four combinations of SECTOR and MULTI values hardcoded.
>>
> ...for 3 of the 4 combinations. Obviously the correct one works.

I get it, thanks for the clarifications!

I have cooked a patch below, providing you with the API I think you
need. If it works, please fold in the patch in the series when you
post you updated Cavium driver(s).

Kind regards
Uffe

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 21 Apr 2017 08:31:15 +0200
Subject: [PATCH] mmc: core: Export API to allow hosts to get the card address
 mode

Some hosts controllers, like Cavium, needs to know whether the card
operates in byte- or block-address mode. Therefore export a new API,
mmc_card_is_blockaddr(), which provides this information.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c  | 6 ++++++
 include/linux/mmc/card.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0bb3979..f053ef5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2558,6 +2558,12 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_calc_max_discard);

+bool mmc_card_is_blockaddr(struct mmc_card *card)
+{
+       return card ? mmc_card_blockaddr(card) : false;
+}
+EXPORT_SYMBOL(mmc_card_is_blockaddr);
+
 int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 {
        struct mmc_command cmd = {};
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 85b5f2b..aad015e 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -315,6 +315,8 @@ static inline bool mmc_large_sector(struct mmc_card *card)
        return card->ext_csd.data_sector_size == 4096;
 }

+bool mmc_card_is_blockaddr(struct mmc_card *card);
+
 #define mmc_card_mmc(c)                ((c)->type == MMC_TYPE_MMC)
 #define mmc_card_sd(c)         ((c)->type == MMC_TYPE_SD)
 #define mmc_card_sdio(c)       ((c)->type == MMC_TYPE_SDIO)
-- 
2.7.4
