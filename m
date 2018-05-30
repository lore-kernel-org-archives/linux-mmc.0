From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v2 4/4] mmc: sdhci-msm: Add sdhci msm register write APIs
 which wait for pwr irq
Date: Wed, 30 May 2018 18:57:56 +0300
Message-ID: <06d8c601-3d9f-c08e-3cfa-b33df91486f6@linaro.org>
References: <1506490483-46871-1-git-send-email-vviswana@codeaurora.org>
 <1506490483-46871-5-git-send-email-vviswana@codeaurora.org>
 <74a4fe0e-7ae8-9f49-5614-1e01ae977475@linaro.org>
 <6c84f6fc-270c-d826-6d87-7f9f6fc5015f@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6c84f6fc-270c-d826-6d87-7f9f6fc5015f@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Vijay,

On 05/30/2018 10:11 AM, Vijay Viswanath wrote:
> Hi Georgi,
> 
> Thanks for testing the patch on 8096 and pointing out this issue.
> The issue is coming because, when card is removed, the HOST_CONTROL2
> register is retaining the 1.8V Signalling enable bit till SDHCI reset
> happens after a new card is inserted.
> 
> Adding the change you suggested can avoid this wait, but I feel a better
> solution is to clear the 1.8V signalling bit when the card is removed.
> When a new card is inserted, we shouldn't be keeping the 1.8V bit set
> until we send cmd11 to the SD card. A new SD card should start with 3V.
> 
> One solution is to explicitly clear the HOST_CONTROL2 register when card
> is removed.
> 
> Other way is to revert the commit:
> 9718f84b85396e090ca42fafa730410d286d61e3 "mmc: sdhci-msm: Do not reset
> the controller if no card in the slot"
> 
> The sdhci-msm doesn't require "SDHCI_QUIRK_NO_CARD_NO_RESET". The issue
> which above commit is trying to avoid is fixed by the pwr-irq patches.
> Resetting the controller will clear the HOST_CONTROL2 register and avoid
> this issue.
> 
> Can you please try this ? I tested reverting the QUIRK on two platforms:
> db410c(8916) and sdm845. SD card insert/remove worked fine after that
> and I didn't get any "Reset 0x1 never completed" error during card
> insert/remove or shutdown.

Thank you! I have submitted a patch to remove the quirk and tested it on
db410c and db820c.

BR,
Georgi
