Return-Path: <SRS0=OcmH=2C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05802C43603
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 17:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C717022527
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 17:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmMDPPQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfLLRbm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:31:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35891 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730162AbfLLRbm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Dec 2019 12:31:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so3195609ljg.3;
        Thu, 12 Dec 2019 09:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oGsvTQEy/RBQXjMjGG41MqumsiVigoFMqEdJYu2rJvg=;
        b=RmMDPPQjFnDduo/ja4oiNR9uvy57bclI0nxhkskq+2ymRGCioVhrJuYAknL7NmPbBV
         geHAdpqc9EQNG2WKBCC+4v0hNwB/tcpQWJy6Oy2+Jnoim+yJCc+ABmgz90+cSNPZrHh/
         06iywjOQVcI+RkOyn7/N20/PhkXpN89TSdauu3cTnNrdDh6o3PFwJYtrGedYtI3zySmm
         nob7ljG3jqjUBJYH4cK2j2595Zyv/Mr1ETY6HuF/XlcuDyfNH9KUg+dmoX6l2ApWmgI1
         zpCGd4woLTjxDSY8d5XVwP+ZHuTfvSl94GQEWVIpxJH5np7gHead3D2444XYvVi4fKy2
         TmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oGsvTQEy/RBQXjMjGG41MqumsiVigoFMqEdJYu2rJvg=;
        b=ZWec56Qn9iZ1a9nQkdP1XLlBzMLUCkAg6YOlbuhEJ5p8ugv8RJLh673QwOmLwBFb9H
         qPhcIDB4hSZhCN5eG5pw1rC4zl4UvugsSf61X1U3tG+AyfTTs4E5rds1HzP3ioItBm1m
         qBZLBe66ViNdB6gRxfk0iQUP/Q6Kxh7u3ZwfQnNhq+KZ0A+nn/Jt3BppPkbjK16KMmoB
         DgAPxu4ZLj0J/QNWDFpGAyp5jIA6LapfvecuhkFTcXtgYEMvir50Q+ONY3jY9fOdIArW
         X6iVEWk5pxXn5lqTN3yQGnR36hY05SrM/PHcmONzYbLGcfkEDhvjwcAms9mhxxrCoxIm
         1S5A==
X-Gm-Message-State: APjAAAVnwuFmbI3RPJnfYycFEevbGRG59tBQWiIVWeh9OElCNHhFLPMO
        HTCZttowyUFHaR09dzwjsUdvmJRL
X-Google-Smtp-Source: APXvYqyIm3f+OC3laK1GIKYGmlQgfSWLC3opWbyHkD84OxuNLtZqK0SvUeCm12YnfXoUCUNbdORHww==
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr6631586ljc.76.1576171898711;
        Thu, 12 Dec 2019 09:31:38 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u20sm3333264lju.34.2019.12.12.09.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 09:31:37 -0800 (PST)
Subject: Re: [PATCH v1] sdhci: tegra: Add workaround for Broadcom WiFi
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191210014011.21987-1-digetx@gmail.com>
 <CAPDyKFpMe09PNQqinvvidF+wfASx2nuvgf7=Hx5+cGni8pdcRA@mail.gmail.com>
 <28045442-6a1c-1e0b-0dfe-c36fa9de149a@gmail.com>
 <CAPDyKFpWO_McZEoefX1T=SE=RYm_GU3S+LgYZrgJY_SJgv7egA@mail.gmail.com>
 <44f99e56-468e-c3f9-3785-73c2cf8ba118@gmail.com>
 <d4933cb1-d2c1-8055-e0f4-f6fcbe9973bc@gmail.com>
 <CAPDyKFq26Wcd9f3VJ1afxv9TVDJQu4wi+yLS-4Pi1bYnFLyWsg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2495b666-58d1-2aab-d4db-240691cf5884@gmail.com>
Date:   Thu, 12 Dec 2019 20:31:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq26Wcd9f3VJ1afxv9TVDJQu4wi+yLS-4Pi1bYnFLyWsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

12.12.2019 18:07, Ulf Hansson пишет:
> On Thu, 12 Dec 2019 at 15:23, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 11.12.2019 19:29, Dmitry Osipenko пишет:
>>> 11.12.2019 19:10, Ulf Hansson пишет:
>>>> On Wed, 11 Dec 2019 at 16:46, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>
>>>>> Hello Ulf,
>>>>>
>>>>> 11.12.2019 11:11, Ulf Hansson пишет:
>>>>>> On Tue, 10 Dec 2019 at 02:40, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>>>
>>>>>>> All Tegra20 boards that have embedded Broadcom WiFi SDIO chip are affected
>>>>>>> by a problem where WiFi chip reports CCCR v1.10, while it should v1.20.
>>>>>>> In a result high-speed mode isn't enabled for the WiFi card and this
>>>>>>> results in a malfunctioning SDIO communication.
>>>>>>
>>>>>> Does that also mean SDIO_SPEED_SHS bit is set when reading SDIO_CCCR_SPEED?
>>>>>
>>>>> Yes, the SDIO_SPEED_SHS bit is set.
>>>>>
>>>>>>>  brcmfmac: brcmf_sdio_readframes: read 304 bytes from channel 1 failed: -84
>>>>>>>  brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame, send NAK
>>>>>>>
>>>>>>> Downstream kernels are overriding card's CCCR info in SDHCI driver to fix
>>>>>>> the problem, let's do the same in upstream.
>>>>>>>
>>>>>>> The change is inspired by omap_hsmmc_init_card() of OMAP's HSMMC driver,
>>>>>>> which overrides card's info for the TI wl1251 WiFi.
>>>>>>
>>>>>> This is a temporary solution and should be replaced by doing the DT
>>>>>> parsing during
>>>>>>
>>>>>> So, yes, let's see if we can use a card quirk instead. That's the first option.
>>>>>>
>>>>>> A second option is simply to parse the DT subnode for a new DT
>>>>>> property during mmc_sdio_init_card(). Along the lines of what we do
>>>>>> for the broken-hpi DT binding for eMMC.
>>>>>
>>>>> Let's try the first option. My understanding is that the problem affects
>>>>> only the specific model of the WiFi chip and it's not a board-specific
>>>>> problem. I'll add Broadcom driver people to CC for the next version of
>>>>> the patch, maybe they'll have something to say.
>>>>
>>>> Okay, sounds reasonable. By looking at your latest attempt for a fix,
>>>> I have two minor nitpicks, otherwise it looks good.
>>>>
>>>> The nitpicks:
>>>> I suggest to rename MMC_QUIRK_HIGH_SPEED_CARD to MMC_QUIRK_HIGH_SPEED
>>>> and mmc_card_need_high_speed_toggle() to mmc_card_quirk_hs().
>>>
>>> I'll take it into account, thanks.
>>
>> Looks like I managed to figure out what's really going on:
>>
>>   1. The BCM4329 doc clearly states that High Speed is supported, see
>> page 49 (Section 11: WLAN Interfaces, SDIO v1.2)
>>
>> https://www.cypress.com/file/298626/download
>>
>>   2. I googled for performance results of the BCM4329 SDIO WiFi and came
>> to a conclusion that ~40 Mbit/s is a realistic maximum of the WiFi-data
>> throughput for NVIDIA Tegra20 boards due to antenna configuration
>> limitations and whatever.
> 
> Okay.
> 
>>
>>   3. The Tegra's SDHCI clock is pre-configured to 48MHz at the time of
>> kernel's boot-up.
>>
>>   4. IIUC, the maximum clock rate for the legacy SD signaling mode is
>> ~25MHz and that is more than enough for a 4-lane SDIO data-bus that
>> allows up to 100 Mbit/s for the WiFi which is capped to 40 Mbit/s anyways.
> 
> Yes, I see.
> 
>>
>>   5. Apparently MMC core doesn't limit the clock rate for the Normal
>> Speed cards.
> 
> It should, else it's a bug (I would be really surprised if that's the
> case, but who knows).
> 
>>
>>
>> So, I added "max-frequency = <25000000>;" to the SDHCI node of the
>> board's device-tree and ta-da! WiFi works absolutely fine without the
>> quirk! Thus the SDIO card quirk isn't really needed and I'm dropping it
>> for now.
>>
>> Ulf, do you know if it's a bug or a feature of the MMC core that it
>> doesn't limit clock rate for the Normal Speed cards?
> 
> It should limit the speed, else it's a bug. Can you perhaps check what
> the requested clock rate is via some debug prints in the host ops
> ->set_ios()? And also what the real rate becomes after dividers.
> 
> If it's not a bug in the core, I suspect that there may be generic
> problem dealing with initialization frequencies for sdhci-tegra.
> 
> For example, mmc_rescan_try_freq() tries to initialize the SDIO card
> at 400KHz, then 300, then 200 then 100 (in that order, and note
> *KHz*). When a frequency is successful, initialization continues and
> later on the clock rate should be increased to 25MHz, for legacy speed
> mode.

I made the following change:

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index ebb387aa5158..d37b61223290 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -372,12 +372,16 @@ static unsigned mmc_sdio_get_max_clock(struct
mmc_card *card)
                 * mandatory.
                 */
                max_dtr = 50000000;
+               dev_err(mmc_dev(card->host), "fixed max_dtr %u\n", max_dtr);
        } else {
                max_dtr = card->cis.max_dtr;
+               dev_err(mmc_dev(card->host), "card max_dtr %u\n", max_dtr);
        }

-       if (card->type == MMC_TYPE_SD_COMBO)
+       if (card->type == MMC_TYPE_SD_COMBO) {
                max_dtr = min(max_dtr, mmc_sd_get_max_clock(card));
+               dev_err(mmc_dev(card->host), "combo max_dtr %u\n", max_dtr);
+       }

        return max_dtr;
 }
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 7bc950520fd9..3833be5ceeb5 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -730,6 +730,8 @@ static void tegra_sdhci_set_clock(struct sdhci_host
*host, unsigned int clock)
        struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
        unsigned long host_clk;

+       dev_err(mmc_dev(host->mmc), "%s %u\n", __func__, clock);
+
        if (!clock)
                return sdhci_set_clock(host, clock);
---

and got the following log:

 sdhci-pltfm: SDHCI platform and OF driver helper
 sdhci-tegra c8000000.sdhci: allocated mmc-pwrseq
 mmc0: Missing autocal timeout 3v3-pad drvs
 mmc0: Missing autocal timeout 3v3-pad drvs
 mmc0: Missing autocal timeout 1v8-pad drvs
 mmc0: Missing autocal timeout 1v8-pad drvs
 mmc0: Invalid maximum block size, assuming 512 bytes
 sdhci-tegra c8000000.sdhci: tegra_sdhci_set_clock 0
 sdhci-tegra c8000000.sdhci: tegra_sdhci_set_clock 843750
 mmc0: SDHCI controller on c8000000.sdhci [c8000000.sdhci] using ADMA
 mmc0: queuing unknown CIS tuple 0x80 (50 bytes)
 mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
 mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
 mmc0: queuing unknown CIS tuple 0x02 (1 bytes)
 sdhci-tegra c8000000.sdhci: card max_dtr 50000000
 sdhci-tegra c8000000.sdhci: tegra_sdhci_set_clock 50000000
 mmc0: new SDIO card at address 0001
 brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4329-sdio for chip
BCM4329/32
 ...

which tells that MMC core doesn't limit Normal Speed, assuming that card
reports an adequate max_dtr value.

The following MMC core change works:

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index ebb387aa5158..da1e28892831 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -373,7 +373,7 @@ static unsigned mmc_sdio_get_max_clock(struct
mmc_card *card)
                 */
                max_dtr = 50000000;
        } else {
-               max_dtr = card->cis.max_dtr;
+               max_dtr = min(card->cis.max_dtr, 25000000u);
        }

        if (card->type == MMC_TYPE_SD_COMBO)

