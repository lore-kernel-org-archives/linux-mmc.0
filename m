From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH V3 1/3] mmc: sdhci: Allow platform controlled voltage switching
Date: Thu, 15 Nov 2018 15:17:00 -0800
Message-ID: <CAE=gft7VCzVDS+hDQUiXh=76ytkg4Djf8kZXtESsQsxoPJrwXA@mail.gmail.com>
References: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
 <1539004739-32060-2-git-send-email-vbadigan@codeaurora.org>
 <CAE=gft631u+ie3PRFkc5t1f3iYwuhbxDbxKUqvdZS5cFJaJbsA@mail.gmail.com>
 <dcb4a579-b308-76c0-7cc3-22bb95147470@codeaurora.org> <9a4708c8-cc43-a690-7ef7-da351eb1f967@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9a4708c8-cc43-a690-7ef7-da351eb1f967@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vbadigan@codeaurora.org
Cc: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, robh+dt@kernel.org, Doug Anderson <dianders@google.com>, asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayali <sayalil@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, vviswana@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 14, 2018 at 6:36 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> >>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> >>> index b001cf4..3c28152 100644
> >>> --- a/drivers/mmc/host/sdhci.h
> >>> +++ b/drivers/mmc/host/sdhci.h
> >>> @@ -524,6 +524,7 @@ struct sdhci_host {
> >>>          bool pending_reset;     /* Cmd/data reset is pending */
> >>>          bool irq_wake_enabled;  /* IRQ wakeup is enabled */
> >>>          bool v4_mode;           /* Host Version 4 Enable */
> >>> +       bool vqmmc_enabled;     /* Vqmmc is enabled */
> >> I still don't love this, since it doesn't mean what it says. Everyone
> >> else that has a vqmmc_enabled member uses it to actually mean "vqmmc
> >> is enabled", but this doesn't mean that. For example, you don't clear
> >> this when you disable the regulator in patch 3, so this would be set
> >> even if the regulator is disabled, and you don't set it when sdhci
> >> enables the regulator, so the regulator is on when this flag is not
> >> set.
> >>
> Hi Evan
>
> This flag is meant to say "disable vqmmc *only* if it is enabled by host
> driver (sdhci_host)".
> If host driver doesn't enable vqmmc (enabled by platfrm driver) or if it
> fails to enable it, then don't call disable vqmmc.
>
> Agree with you, the present name is not conveying its purpose.
> It must be something like "vqmmc_enabled_by_host".
>
> Please let me know if you have any suggestions on this name.

Yeah. Maybe vqmmc_pltfrm_controlled? Or vqmmc_enabled_by_platfrm as
you suggested?
-Evan
