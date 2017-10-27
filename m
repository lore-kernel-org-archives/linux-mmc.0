From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 1/3] mmc: core: activate pre-erased multiple write
 support for sd card
Date: Fri, 27 Oct 2017 14:36:32 +0200
Message-ID: <20171027123632.GA5382@hc>
References: <1506483638-115756-1-git-send-email-shawn.lin@rock-chips.com>
 <699af9d0-c69b-e02b-54c1-7b0dd3f5369c@rock-chips.com>
 <CAPDyKFrdXPp4+Gu_2uE_Kdw0vLFC3uQ7ZBc9kYa+HKCgYc06Vg@mail.gmail.com>
 <20171026110316.GD12640@hc>
 <b7acd6a7-6a17-47be-5659-bf5c264d7552@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:13136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752346AbdJ0Mgr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 27 Oct 2017 08:36:47 -0400
Content-Disposition: inline
In-Reply-To: <b7acd6a7-6a17-47be-5659-bf5c264d7552@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Oct 27, 2017 at 09:46:32AM +0800, Shawn Lin wrote:
> Could you kindly try this on top of this series? And do some write test
> for the SD cards.
> 
> @@ -2210,9 +2210,9 @@ static struct mmc_blk_data
> *mmc_blk_alloc_req(struct mmc_card *card,
> 
>         if (mmc_host_cmd23(card->host)) {
>                 if ((mmc_card_mmc(card) &&
> -                    card->csd.mmca_vsn >= CSD_SPEC_VER_3) ||
> -                   (mmc_card_sd(card) &&
> -                    card->scr.cmds & SD_SCR_CMD23_SUPPORT))
> +                    card->csd.mmca_vsn >= CSD_SPEC_VER_3))
> +                   //(mmc_card_sd(card) &&
> +                    //card->scr.cmds & SD_SCR_CMD23_SUPPORT))
>                         md->flags |= MMC_BLK_CMD23;

Did that and tested read/write to SD card, works fine on the Cavium
tn81xx arm64 board.

Feel free to add:
Tested-by: Jan Glauber <jglauber@cavium.com>

--Jan
