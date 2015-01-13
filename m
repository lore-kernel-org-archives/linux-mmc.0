From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH] mmc: dw_mmc: rockchip: Add DW_MCI_QUIRK_RETRY_DELAY
Date: Tue, 13 Jan 2015 09:51:37 -0800
Message-ID: <1421171497-9440-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:45430 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbbAMRvx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jan 2015 12:51:53 -0500
Received: by mail-ig0-f172.google.com with SMTP id l13so5242241iga.5
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jan 2015 09:51:53 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Alexandru Stan <amstan@chromium.org>, addy.ke@rock-chips.com, Doug Anderson <dianders@chromium.org>, chris@printf.net, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org

We've seen at least one card that can get confused during all the
errors generated during tuning on rk3288.  These errors seem to go
away with DW_MCI_QUIRK_RETRY_DELAY.  That quirk is documented to be
for 2.11a and on rk3288 I believe we have 2.70a, but it seems to be
the same type of problem.

Specifically it looks like in certain error conditions (I saw this
with Response CRC errors) that data keeps showing up in the FIFO even
after the error is reported and the CD (command done) bit is set.  If
we don't wait for this data to finish transferring then it confuses
the next transaction.  In the specific failure case I ran into I found
that I could monitor the data_state_mc_busy bit and wait for it to
clear, but in other failure cases this bit was stuck at busy when we
saw an error.  Hence a generic big delay seems like the only option.

I have seen this on rk3288, but adding it as a quirk for all Rockchip
IP for now since most previous quirks have shown up on older IP as
well.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
NOTES:
* This is based atop Addy's patch (mmc: dw_mmc: add quirk for broken
data transfer over scheme) at
<https://patchwork.kernel.org/patch/5565431/>, but it would be trivial
to apply this patch without that one if that were desirable.
* If someone has a better solution to this problem, I'm all ears.

 drivers/mmc/host/dw_mmc-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index ba92ebd..b4caf1a 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -74,7 +74,8 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 	host->sdio_id0 = 8;
 
 	/* It needs this quirk on all Rockchip SoCs */
-	host->pdata->quirks |= DW_MCI_QUIRK_BROKEN_DTO;
+	host->pdata->quirks |= DW_MCI_QUIRK_BROKEN_DTO |
+		DW_MCI_QUIRK_RETRY_DELAY;
 
 	return 0;
 }
-- 
2.2.0.rc0.207.ga3a616c

