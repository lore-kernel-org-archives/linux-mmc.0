From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/3] mmc: esdhc: enable polling to detect card by itself
Date: Thu, 18 Oct 2012 13:50:33 +0800
Message-ID: <20121018054053.GA4513@S2101-09.ap.freescale.net>
References: <1348828113-19668-1-git-send-email-yongd@marvell.com>
 <1348828113-19668-2-git-send-email-yongd@marvell.com>
 <20121007140648.GA10148@S2101-09.ap.freescale.net>
 <89813612683626448B837EE5A0B6A7CB30388601C9@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <89813612683626448B837EE5A0B6A7CB30388601C9@SC-VEXCH4.marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Ding <yongd@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Wolfram Sang <w.sang@pengutronix.de>, Daniel Drake <dsd@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Wilson Callan <wilson.callan@savantsystems.com>, Ben Dooks <ben-linux@fluff.org>, Zhangfei Gao <zgao6@marvell.com>, Kevin Liu <kliu5@marvell.com>, Jialing Fu <jlfu@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Oct 16, 2012 at 09:01:40PM -0700, Yong Ding wrote:
> Shawn,
> Thanks for your comment. And sorry for my so late due to illness:-)
> SDHCI_QUIRK_BROKEN_CARD_DETECTION is used for notifying we don't use the host internal card detection method so that we don't need enable/disable those relevant interrupt bits of host(sdhci_set_card_detection in sdhci.c). 
> And as I double-checked the latest kernel code, actually sdhci-esdhc-imx sets this flag by default, and then will clear it only when the detection type is ESDHC_CD_CONTROLLER. So this aligns with my understanding. 

What I was saying is the bit will be cleared when the detection type is
ESDHC_CD_CONTROLLE or ESDHC_CD_GPIO.  You may have missed the fact that
there is no "break" in case ESDHC_CD_GPIO but a "fall through" comment.

        switch (boarddata->cd_type) {
        case ESDHC_CD_GPIO:
                err = gpio_request_one(boarddata->cd_gpio, GPIOF_IN, "ESDHC_CD");
                if (err) {
                        dev_err(mmc_dev(host->mmc),
                                "no card-detect pin available!\n");
                        goto no_card_detect_pin;
                }

                err = request_irq(gpio_to_irq(boarddata->cd_gpio), cd_irq,
                                 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
                                 mmc_hostname(host->mmc), host);
                if (err) {
                        dev_err(mmc_dev(host->mmc), "request irq error\n");
                        goto no_card_detect_irq;
                }
                /* fall through */

        case ESDHC_CD_CONTROLLER:
                /* we have a working card_detect back */
                host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
                break;

        case ESDHC_CD_PERMANENT:
                host->mmc->caps = MMC_CAP_NONREMOVABLE;
                break;

        case ESDHC_CD_NONE:
                break;
        }

Shawn

> What I want to do is that 1st we shall set MMC_CAP_NEEDS_POLL by our host driver itself and 2nd remove the improper logic in sdhci_add_host() . How do u think? Thanks.
> 
