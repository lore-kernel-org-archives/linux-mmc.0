From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: confusion regarding the CMD19 and CMD21 in eMMC/SD card spec
Date: Fri, 16 Sep 2011 12:47:08 +0800
Message-ID: <20110916044706.GA4030@lovegaga>
References: <CAGxe1ZH=mrAdfVR7Uw8mYNAD43BAbW7VGuhA1pN9hbSjTG9HVA@mail.gmail.com>
 <0356427A-B949-4DA6-9F5D-FE0DD54AEDFF@marvell.com>
 <CAGxe1ZG4QjwB5OfrxupG_C+DtQ7sTQ4_EURaF-QrqPPSA3A0jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGxe1ZG4QjwB5OfrxupG_C+DtQ7sTQ4_EURaF-QrqPPSA3A0jw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 16, 2011 at 09:41:04AM +0530, Girish K S wrote:
> but there is only one host controller to handle these commands.
> the generic sdhci driver has cmd19 hard coded, thats the reason I
> asked the question.
> you can also check it in the function sdhci_execute_tuning it is hard coded as
> cmd.opcode = MMC_SEND_TUNING_BLOCK; where the macro value is 19.
> So in case of SD card insertion it will send a SEND_TUNING_BLOCK
> command to the device. but if
> MMC card is inserted then it will send a BUS_TEST_W command to the device.

sdhci_execute_tuning will only be called if the inserted card is a sd card
and it is operating at SDR104 or SDR50 mode(UHS-I).

The host's tuning function is called from the mmc_sd_init_uhs_card,
and for a mmc card, there is no chance of that function being called.

-Aaron
