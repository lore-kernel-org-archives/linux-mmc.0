From: prakash.burla@smartplayin.com
Subject: RE: Fwd: [PATCH v6 12/12] mmc: mmci: Add Qualcomm Id to amba id table
Date: Thu, 17 Jul 2014 04:31:32 -0400 (EDT)
Message-ID: <1405585892.574323701@apps.rackspace.com>
References: <1401699818-11329-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1401700213-11917-1-git-send-email-srinivas.kandagatla@linaro.org>
 <CA+neC=PRkUqcL63yNkvJNgRQqvQ+c+1g+qptM7vXH5c9-b5UDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CA+neC=PRkUqcL63yNkvJNgRQqvQ+c+1g+qptM7vXH5c9-b5UDw@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org
List-Id: linux-mmc@vger.kernel.org

tested-by: Prakash Burla <prakash.burla@smartplayin.com>
This driver tested on AP806X with mmc Driver.
--------------------------------------------------------------------
From:  <srinivas.kandagatla@linaro.org>
Date: Mon, Jun 2, 2014 at 2:40 PM
Subject: [PATCH v6 12/12] mmc: mmci: Add Qualcomm Id to amba id table
To: Russell King <linux@arm.linux.org.uk>, Ulf Hansson
<ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org,
linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org, Srinivas
Kandagatla <srinivas.kandagatla@linaro.org>


From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds a fake Qualcomm ID 0x00051180 to the amba_ids, as Qualcomm
SDCC controller is pl180, but amba id registers read 0x0's.
The plan is to remove SDCC driver totally and use mmci as the main SD
controller driver for Qualcomm SOCs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/host/mmci.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 08ff8d2..fa851d5 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -190,6 +190,23 @@ static struct variant_data variant_ux500v2 = {
        .pwrreg_nopower         = true,
 };

+static struct variant_data variant_qcom = {
+       .fifosize               = 16 * 4,
+       .fifohalfsize           = 8 * 4,
+       .clkreg                 = MCI_CLK_ENABLE,
+       .clkreg_enable          = MCI_QCOM_CLK_FLOWENA |
+                                 MCI_QCOM_CLK_SELECT_IN_FBCLK,
+       .clkreg_8bit_bus_enable = MCI_QCOM_CLK_WIDEBUS_8,
+       .datactrl_mask_ddrmode  = MCI_QCOM_CLK_SELECT_IN_DDR_MODE,
+       .data_cmd_enable        = MCI_QCOM_CSPM_DATCMD,
+       .blksz_datactrl4        = true,
+       .datalength_bits        = 24,
+       .pwrreg_powerup         = MCI_PWR_UP,
+       .f_max                  = 208000000,
+       .explicit_mclk_control  = true,
+       .qcom_fifo              = true,
+};
+
 static int mmci_card_busy(struct mmc_host *mmc)
 {
        struct mmci_host *host = mmc_priv(mmc);
@@ -1831,6 +1848,12 @@ static struct amba_id mmci_ids[] = {
                .mask   = 0xf0ffffff,
                .data   = &variant_ux500v2,
        },
+       /* Qualcomm variants */
+       {
+               .id     = 0x00051180,
+               .mask   = 0x000fffff,
+               .data   = &variant_qcom,
+       },
        { 0, 0 },
 };

--
1.9.1

