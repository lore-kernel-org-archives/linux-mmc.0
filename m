From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: add quirk for O2 Micro dev 0x8620 rev 0x01
Date: Thu, 27 Sep 2018 01:48:58 +0200
Message-ID: <CAPDyKFqiUO-7O6bgrszuR3YKMkEoPT4976gvDKvUWpYuNp03ag@mail.gmail.com>
References: <20180923203924.68452-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180923203924.68452-1-yuzhao@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Zhao <yuzhao@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 23 September 2018 at 22:39, Yu Zhao <yuzhao@google.com> wrote:
> This device reports SDHCI_CLOCK_INT_STABLE even though it's not
> ready to take SDHCI_CLOCK_CARD_EN. The symptom is that reading
> SDHCI_CLOCK_CONTROL after enabling the clock shows absence of the
> bit from the register (e.g. expecting 0x0000fa07 = 0x0000fa03 |
> SDHCI_CLOCK_CARD_EN but only observed the first operand).
>
> mmc1: Timeout waiting for hardware cmd interrupt.
> mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00000603
> mmc1: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
> mmc1: sdhci: Present:   0x01ff0001 | Host ctl: 0x00000001
> mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
> mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> mmc1: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
> mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
> mmc1: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x00002077
> mmc1: sdhci: Cmd:       0x00000000 | Max curr: 0x005800c8
> mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
> mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> mmc1: sdhci: Host ctl2: 0x00000008
> mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> mmc1: sdhci: ============================================
>
> The problem happens during wakeup from S3. Adding a delay quirk
> after power up reliably fixes the problem.
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 77e9bc4aaee9..3e5ecf7ce101 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -490,6 +490,8 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>                 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
>                 break;
>         case PCI_DEVICE_ID_O2_SEABIRD0:
> +               if (chip->pdev->revision == 0x01)
> +                       chip->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
>         case PCI_DEVICE_ID_O2_SEABIRD1:
>                 /* UnLock WP */
>                 ret = pci_read_config_byte(chip->pdev,
> --
> 2.19.0.444.g18242da7ef-goog
>
