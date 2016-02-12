From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix card detect when using runtime PM
Date: Fri, 12 Feb 2016 12:01:39 +0100
Message-ID: <CAPDyKFpU+fRb6qR8Wzh2D2TjKK-givGo0FYOAksyj_db91Z3SA@mail.gmail.com>
References: <1455198537-21791-1-git-send-email-ludovic.desroches@atmel.com>
	<CAPDyKFpPE31maSEVxLZx6BXD5i1Ugs79+OVQojpUCR2EzMeM3A@mail.gmail.com>
	<20160212083828.GI14937@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160212083828.GI14937@odux.rfo.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

>>
>> According to the below commit, SDHCI_QUIRK_BROKEN_CARD_DETECTION was
>> invented because of unreliable card detection mechanism inside the
>> sdhci controller.
>> Therefore it required polling to be used, but also to make ->get_cd()
>> to always return 1 in these cases.
>>
>> Although, as I understand it that's not the case here. You can still
>> rely on card detection to work, but as you don't have wakeups you
>> can't fully make use of card detect, when combined with runtime PM.
>> I am not sure we should add more users of
>> SDHCI_QUIRK_BROKEN_CARD_DETECTION, especially since in this case it's
>> not reflecting the capability of the hardware.
>>
>> Can't we think of another way?
>
> Sorry but I am not sure to understand. In the previous thread, you told
> me to use MMC_CAP_NEEDS_POLL which is set if we have
> SDHCI_QUIRK_BROKEN_CARD_DETECTION. I was not confortable to do this
> because as you say it is not reflecting the capability of the hardware.
>
> Do you mean that I can simply add MMC_CAP_NEEDS_POLL after sdhci_add_host()?

Yes, something like that, but...

Within this context, I realize that the DT binding "broken-cd" has two
different meanings, while comparing the generic MMC bindings towards
SDHCI's. That's bad.

In the SDHCI case it means, enable MMC_CAP_NEEDS_POLL *and* make
->get_cd() to always return 1 (via adding
SDHCI_QUIRK_BROKEN_CARD_DETECTION).

In the generic MMC case, it means only to enable MMC_CAP_NEEDS_POLL,
which is exactly what you want.

Perhaps you wonder why I think it's a good good idea to use DT to
decide if MMC_CAP_NEEDS_POLL should be enabled?
It allows flexibility for future platforms. For example, there may be
platforms adding GPIO card detect support or even cards that's
non-removable.

I realize that the fix to solve this regression would then mean that
sdhci-of-at91 need to clear SDHCI_QUIRK_BROKEN_CARD_DETECTION after
parsing the shdci DTB, but then the DTB for your platform also needs
an update as the "broken-cd" options needs to be set.

Do you think this can work?

Kind regards
Uffe
