Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="neGvdV0Q"
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1D9D6C
	for <linux-mmc@vger.kernel.org>; Thu, 30 Nov 2023 02:34:55 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-db539f21712so327082276.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Nov 2023 02:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701340494; x=1701945294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j350QJDKEuHqSIhgnqrzjS7NiG3vRDy7K5wFB+bsbRE=;
        b=neGvdV0QQLiEVpfl0eQmDr6ELBYno7YaSQTuOBwf12qNB3IdA1/PxvfOtSGkl11UO5
         5lGGzMPGEuod6RqhbEICZ0Bjfp2oLnxkFQ4RKzKYacjJCOMQe/fEXs0EA0adW9ny+q1h
         5Y90gAwsV0YNuJHh3OYDlSVMVKr3bAHwQz9sic6hV/f1i5gNzBvs5Z6u4OuSoMIiPxbx
         wD70Ln/ecm9ts0DnrwziKZk4LKh8wXdquqIEIVWgd1FlD0BqFvxhObSXCUzeGE48SAdb
         ft77Uz693+1lYXBmjnJwS58S0MJVvt/1cGopsVR/ngWcRhBTii/4VNs9wOyRqX1Nnahx
         SDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701340494; x=1701945294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j350QJDKEuHqSIhgnqrzjS7NiG3vRDy7K5wFB+bsbRE=;
        b=n51J/oXqTWwiQTnQSz6kLGYDZf7goFUp7UyISWh1njnqWz9ewSk1mMyd0ZLDp5h0mC
         kdrvD+gZIC5JuDmnwebQhMniH7rKRErYam3185oVaL1Oswu/XbX8FLaR2vFBJlnEcFDH
         7fanokc6BIp0m3Hn0DmhwvetFGbN1hOSC15j6JRpmDVh3V0Lp3xideqEIfcqNkz77lLZ
         ij+uuX3wM1QveGUUG+leWmJHB4ZGiMhxZ72v8F1HKSPs8+TRYIHjBtoGNpdfsxsAocI7
         1ccJ0pptD4JsZUHtdH3DNig0Np+kNpsqkKKRLnKYOH8/okjclKglbEJIr5b5VJh9wzI4
         9oJQ==
X-Gm-Message-State: AOJu0YxUrCvdGG8Vsx+8emCE9NqSH7Cn30O/21PqBfP7RydQP576rrFK
	qNx31d2S9uvwV4ASJnU0wNX6n3wgoXyIzciPfrwiQw==
X-Google-Smtp-Source: AGHT+IHIGd5TmO3x8SVxvdIBwlzRcFlSXh5JGmBGlxogwl199SBDEnpsMYwlXtjGSw6Qw2kKIimMEWvc8SIZXKYejaM=
X-Received: by 2002:a25:9708:0:b0:db4:354b:77b1 with SMTP id
 d8-20020a259708000000b00db4354b77b1mr16979757ybo.32.1701340494561; Thu, 30
 Nov 2023 02:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129160533.2827458-1-jorge@foundries.io>
In-Reply-To: <20231129160533.2827458-1-jorge@foundries.io>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Nov 2023 11:34:18 +0100
Message-ID: <CAPDyKFpg+7W1ODGHw5oXy_wzWA1Qqzg9w_12rhQ8qW4o--6dWg@mail.gmail.com>
Subject: Re: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
To: Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc: CLoehle@hyperstone.com, adrian.hunter@intel.com, jinpu.wang@ionos.com, 
	hare@suse.de, beanhuo@micron.com, yangyingliang@huawei.com, asuk4.q@gmail.com, 
	yibin.ding@unisoc.com, victor.shih@genesyslogic.com.tw, marex@denx.de, 
	rafael.beims@toradex.com, robimarko@gmail.com, ricardo@foundries.io, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Nov 2023 at 17:05, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
>
> On the eMMC SanDisk iNAND 7250 configured with HS200, requesting a
> re-tune before switching to the RPMB partition would randomly cause
> subsequent RPMB requests to fail with EILSEQ:
> * data error -84, tigggered in __mmc_blk_ioctl_cmd()
>
> This commit skips the retune when switching to RPMB.
> Tested over several days with per minute RPMB reads.

This sounds weird to me and needs more testing/debugging in my
opinion, especially at the host driver level. Perhaps add some new
tests in mmc_test, that does a partition switch to/from any partition
and then run regular I/O again to see if the problem is easier to
reproduce?

The point is, I wonder what is so special with RPMB here? Note that,
it has been quite common that host drivers/controllers have had issues
with their tuning support, so I would not be surprised if that is the
case here too.  Certainly I would be surprised if the problem is at
the eMMC card side, but I may be wrong.

Kind regards
Uffe

>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>  Fixes v1: kernel test robot identified typo causing build failure
>            CIF_MANFID_SANDISK_SD --> CID_MANFID_SANDISK_SD
>
>  drivers/mmc/core/block.c  | 6 +++++-
>  drivers/mmc/core/card.h   | 7 +++++++
>  drivers/mmc/core/quirks.h | 7 +++++++
>  include/linux/mmc/card.h  | 1 +
>  4 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 152dfe593c43..9b7ba6562a3b 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -860,6 +860,11 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
>                                 return ret;
>                 }
>                 mmc_retune_pause(card->host);
> +
> +               /* Do not force retune before RPMB switch */
> +               if (mmc_can_retune(card->host) &&
> +                   mmc_card_broken_rpmb_retune(card))
> +                       card->host->need_retune = 0;
>         }
>
>         return ret;
> @@ -3143,4 +3148,3 @@ module_exit(mmc_blk_exit);
>
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
> -
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index b7754a1b8d97..1e1555a15de9 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -85,6 +85,7 @@ struct mmc_fixup {
>  #define CID_MANFID_MICRON       0x13
>  #define CID_MANFID_SAMSUNG      0x15
>  #define CID_MANFID_APACER       0x27
> +#define CID_MANFID_SANDISK2     0x45
>  #define CID_MANFID_KINGSTON     0x70
>  #define CID_MANFID_HYNIX       0x90
>  #define CID_MANFID_KINGSTON_SD 0x9F
> @@ -284,4 +285,10 @@ static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
>  {
>         return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
>  }
> +
> +static inline int mmc_card_broken_rpmb_retune(const struct mmc_card *c)
> +{
> +       return c->quirks & MMC_QUIRK_BROKEN_RPMB_RETUNE;
> +}
> +
>  #endif
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index cca71867bc4a..56c79b6b3537 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -130,6 +130,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
>                   MMC_QUIRK_BROKEN_SD_DISCARD),
>
> +       /*
> +        * SanDisk iNAND 7250 DG4064, this quirk shall disable the retune
> +        * operation enforced by default when switching to RPMB.
> +        */
> +       MMC_FIXUP("DG4064", CID_MANFID_SANDISK2, 0x100, add_quirk_mmc,
> +                 MMC_QUIRK_BROKEN_RPMB_RETUNE),
> +
>         END_FIXUP
>  };
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 7b12eebc5586..bd6986189e8b 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -296,6 +296,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_SD_DISCARD    (1<<14) /* Disable broken SD discard support */
>  #define MMC_QUIRK_BROKEN_SD_CACHE      (1<<15) /* Disable broken SD cache support */
>  #define MMC_QUIRK_BROKEN_CACHE_FLUSH   (1<<16) /* Don't flush cache until the write has occurred */
> +#define MMC_QUIRK_BROKEN_RPMB_RETUNE   (1<<17) /* Don't force a retune before switching to RPMB */
>
>         bool                    written_flag;   /* Indicates eMMC has been written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
> --
> 2.34.1
