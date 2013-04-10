From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH v2 2/2] mmc: mxs-mmc: add non-removable property
Date: Wed, 10 Apr 2013 10:19:54 +0200
Message-ID: <516520AA.8030300@digi.com>
References: <1365166070-9370-1-git-send-email-mkl@pengutronix.de> <1365166070-9370-3-git-send-email-mkl@pengutronix.de> <51643053.7030302@digi.com> <516431F9.8010302@digi.com> <51644302.6000109@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51644302.6000109@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "cjb@laptop.org" <cjb@laptop.org>, "aletes.xgr@gmail.com" <aletes.xgr@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Tue 09 Apr 2013 06:34:10 PM CEST, Marc Kleine-Budde wrote:
> On 04/09/2013 05:21 PM, Hector Palacios wrote:
>> On 04/09/2013 05:14 PM, Hector Palacios wrote:
>>> @@ -95,7 +97,8 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
>>>           struct mxs_mmc_host *host = mmc_priv(mmc);
>>>           struct mxs_ssp *ssp = &host->ssp;
>>>
>>> -       return !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
>>> +       return host->non_removable || host->broken_cd ||
>>> +              !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
>>>                    BM_SSP_STATUS_CARD_DETECT);
>>>    }
>>
>> Sorry, I missed your original XOR here, when merging my changes:
>
> Can you send an incremental patch against my 2/2 with your
> Signed-off-by, I'll squash your patch into mine and repost the series.

Sure. Here it is:

>From 18f6199947bc2681d2d63b307506019535018646 Mon Sep 17 00:00:00 2001
From: Hector Palacios <hector.palacios@digi.com>
Date: Wed, 10 Apr 2013 09:16:31 +0200
Subject: [PATCH] mmc: mxs-mmc: handle 'broken-cd' property

According to bindings documentation for mmc, the property 'broken-cd'
can be used to indicate card-detection is not available and polling
must be used instead. This patch retrieves this property
and sets a custom flag. On the get_cd() hook, it returns 1 if
the flag is set, to always assume the card is present.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 drivers/mmc/host/mxs-mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 75dee88..10c07a8 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -73,6 +73,7 @@ struct mxs_mmc_host {
        int                             wp_gpio;
        bool                            wp_inverted;
        bool                            cd_inverted;
+       bool                            broken_cd;
        bool                            non_removable;
 };

@@ -97,7 +98,7 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
        struct mxs_mmc_host *host = mmc_priv(mmc);
        struct mxs_ssp *ssp = &host->ssp;

-       return host->non_removable ||
+       return host->non_removable || host->broken_cd ||
                !(readl(ssp->base + HW_SSP_STATUS(ssp)) &
                  BM_SSP_STATUS_CARD_DETECT) ^ host->cd_inverted;
 }
@@ -689,6 +690,7 @@ static int mxs_mmc_probe(struct platform_device 
*pdev)
                mmc->caps |= MMC_CAP_4_BIT_DATA;
        else if (bus_width == 8)
                mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
+       host->broken_cd = of_property_read_bool(np, "broken-cd");
        host->non_removable = of_property_read_bool(np, 
"non-removable");
        if (host->non_removable)
                mmc->caps |= MMC_CAP_NONREMOVABLE;
--
1.8.2
