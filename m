From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: Fix init_card in 52Mhz
Date: Wed, 30 Sep 2015 11:24:04 +0300
Message-ID: <560B9C24.3090209@intel.com>
References: <1443583688-1952-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443583688-1952-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Johan Rudholm <johan.rudholm@axis.com>, Gwendal Grignou <gwendal@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

On 30/09/15 06:28, Chaotian Jing wrote:
> Suppose that we got a data crc error, and it triggers the mmc_reset.
> mmc_reset will call mmc_send_status to see if HW reset was supported.
> before issue CMD13, it will do retune, and if EMMC was in HS400 mode,
> it will reduce frequency to 52Mhz firstly, that results in card init
> was doing at 52Mhz, So need ensure frequency is lower than 400Khz when
> re-init card.

The call to mmc_send_status() was originally only done for mmc_test and
doesn't belong in a real reset.  However the test parameter was removed
to simplify the code by:

commit 83533ab28380f6957af39a7b322e639e42dbdaf1
Author: Johan Rudholm <johan.rudholm@axis.com>
Date:   Mon Jan 12 15:38:04 2015 +0100

    mmc: core: always check status after reset
    
    Always check if the card is alive after a successful reset. This allows
    us to remove mmc_hw_reset_check(), leaving mmc_hw_reset() as the only
    card reset interface.
    
    Signed-off-by: Johan Rudholm <johanru@axis.com>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

IMHO having a test to check whether hw reset actually did reset the card
is useful, so I would suggest putting back mmc_hw_reset_check() and
removing the check from the non-test path.

An alternative is to recognize that we don't want retuning here, and it is
unlikely to be needed in the mmc_test case.  So if retuning is needed, just
skip the call to mmc_send_status() i.e.

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f2d0c2ae85b1..c3749ba42739 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1938,7 +1938,7 @@ static int mmc_reset(struct mmc_host *host)
 	host->ops->hw_reset(host);
 
 	/* If the reset has happened, then a status command will fail */
-	if (!mmc_send_status(card, &status)) {
+	if (!host->need_retune && !mmc_send_status(card, &status)) {
 		mmc_host_clk_release(host);
 		return -ENOSYS;
 	}

Could then make mmc_test aware of that:

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index b78cf5d403a3..7b105b97be78 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -2272,6 +2272,16 @@ static int mmc_test_hw_reset(struct mmc_test_card *test)
 	if (!mmc_card_mmc(card) || !mmc_can_reset(card))
 		return RESULT_UNSUP_CARD;
 
+	err = mmc_send_status(card, NULL);
+	if (err)
+		return err;
+
+	if (host->need_retune) {
+		pr_info("%s: cannot test hw reset because retune needed\n",
+			mmc_hostname(test->card->host));
+		return RESULT_FAIL;
+	}
+
 	err = mmc_hw_reset(host);
 	if (!err)
 		return RESULT_OK;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f2d0c2ae85b1..c3749ba42739 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1938,7 +1938,7 @@ static int mmc_reset(struct mmc_host *host)
 	host->ops->hw_reset(host);
 
 	/* If the reset has happened, then a status command will fail */
-	if (!mmc_send_status(card, &status)) {
+	if (!host->need_retune && !mmc_send_status(card, &status)) {
 		mmc_host_clk_release(host);
 		return -ENOSYS;
 	}




> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/core/mmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e726903..f2d0c2a 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1945,6 +1945,7 @@ static int mmc_reset(struct mmc_host *host)
>  
>  	/* Set initial state and call mmc_set_ios */
>  	mmc_set_initial_state(host);
> +	mmc_set_clock(host, host->f_init);
>  	mmc_host_clk_release(host);
>  
>  	return mmc_init_card(host, card->ocr, card);
> 
