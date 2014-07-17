From: prakash.burla@smartplayin.com
Subject: RE: Fwd: [PATCH v6 04/12] mmc: mmci: Add Qcom datactrl register variant
Date: Thu, 17 Jul 2014 06:26:39 -0400 (EDT)
Message-ID: <1405592799.65820182@apps.rackspace.com>
References: <1401699818-11329-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1401700146-11588-1-git-send-email-srinivas.kandagatla@linaro.org>
 <CA+neC=Of9Ua5OxUiezmTHfzq9zkXVRCFei3xKMbXi3OGV84EHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CA+neC=Of9Ua5OxUiezmTHfzq9zkXVRCFei3xKMbXi3OGV84EHw@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: linux@arm.linux.org.uk, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

tested-by: Prakash Burla <prakash.burla@smartplayin.com>
This driver tested on AP806X with mmc Driver.

----------------------------------------------------------------------------------
From:  <srinivas.kandagatla@linaro.org>
Date: Mon, Jun 2, 2014 at 2:39 PM
Subject: [PATCH v6 04/12] mmc: mmci: Add Qcom datactrl register variant
To: Russell King <linux@arm.linux.org.uk>, Ulf Hansson
<ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org,
linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org, Srinivas


From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Instance of this IP on Qualcomm's SOCs has bit different layout for datactrl
register. Bit position datactrl[16:4] hold the true block size instead of power
of 2.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index ed20bf5..72981f6 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -60,6 +60,8 @@ static unsigned int fmax = 515633;
  * @sdio: variant supports SDIO
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
  * @blksz_datactrl16: true if Block size is at b16..b30 position in
datactrl register
+ * @blksz_datactrl4: true if Block size is at b4..b16 position in datactrl
+ *                  register
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @signal_direction: input/out direction of bus signals can be indicated
  * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
@@ -75,6 +77,7 @@ struct variant_data {
        bool                    sdio;
        bool                    st_clkdiv;
        bool                    blksz_datactrl16;
+       bool                    blksz_datactrl4;
        u32                     pwrreg_powerup;
        bool                    signal_direction;
        bool                    pwrreg_clkgate;
@@ -731,6 +734,8 @@ static void mmci_start_data(struct mmci_host
*host, struct mmc_data *data)

        if (variant->blksz_datactrl16)
                datactrl = MCI_DPSM_ENABLE | (data->blksz << 16);
+       else if (variant->blksz_datactrl4)
+               datactrl = MCI_DPSM_ENABLE | (data->blksz << 4);
        else
                datactrl = MCI_DPSM_ENABLE | blksz_bits << 4;

--
1.9.1

