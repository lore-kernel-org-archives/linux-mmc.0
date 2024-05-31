Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678F7156242;
	Fri, 31 May 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717151536; cv=none; b=DfLq4tkP7QyIIaDnBdaaEa8+c/hHsGvtCts2GxHPbrk6y/nM8pB+JV0l0rMNDHRa185zmTm3rxT/JybBOz/vkaLBjV412bRMzFNKgwoZ7SL0C0aF0UVTQXWpWX1wYmW3+UDIj3XvG1EQeRfAOk2cItd70EnfEYUSbn7tjaTmYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717151536; c=relaxed/simple;
	bh=BhfDWRQAxg2H0nNvxN8ST80r+VkjlyGPhD/DEZuE9cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ja1rvNOY6Y32Rl3AsLlgX6KvzPwD6DbNlmuDeXjg12WDnXzZ2kxeHWWegCCKMoka4GJjd+ZkEwxiGQDUB+e4oPVGk/S+kK/z2Wo7E4D9W1VynzUlXbxTsAj7x+ZNijQwLs6OTV/SeC8rNKYn2jLbwMcKOek641t65jfMciJz7/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFqgR77B; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFqgR77B"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4e4eff99f16so645298e0c.1;
        Fri, 31 May 2024 03:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717151533; x=1717756333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HS0R4iju6FvJzIbu0g7hhKx4uFltPTHH/SC2V6Zi2U=;
        b=QFqgR77BRRKftpefS+UmcyAYv9s60ebwnwL8MzURxweO3qLstQaTql+tVeoJFZ+vAX
         c7s4ctDIg57lAhCNo3jcw8hd+4hfC+S6anZifocJY8s+Edu2ru4pRzu6D/j36b7mQe9B
         0TC/izaOjLFOtSx0mdCe8WamPni4vSB4yUOhfOyVYPzIUXxyLwG9lEJyZWeGmg4HHTrj
         Ygn1X72c/XCi95kk4incjSebcEowKwHsYySv5vZ/8Dr2/RNbrM0MC1k+85HKSLTUaeaM
         E7ZkSrnoqih+1CmC8X+kIGcZwqBGYwB7PSeS8KrF+J4tW8gVAQ0zIeEmDomuh7stW8Vl
         IdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717151533; x=1717756333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HS0R4iju6FvJzIbu0g7hhKx4uFltPTHH/SC2V6Zi2U=;
        b=VSDT2jY62GaDLzErB4DJZWf5+8UbM+UxHYcK09njl95iTano7uiocECt3Q+Mfq9D2F
         jIKJkw3LZV7Yv+VhDAfAGngHBkF0eP9kzrcdVrXgHC+yHobJl/DhKc321wyxCYJJhwq+
         aH1ND/Ovddn7492lD9JHKu9yjEy8yF86pJf8L/MqikdnPclf5N+fk5aA6Ax0/JtmzIYP
         +Sb+UKVGq8fwpWyF4hvdWXKOQqdCAl1Q0SsSyv807SpXQEHvQyqxjjMi+SulibyEf21G
         8+oPNndpIigHQ2Oge79Xj3z68poEwyU9U21fnsmd0sOMUjO6oEWtzww3KP7Pt5pI6D7v
         Mg3w==
X-Forwarded-Encrypted: i=1; AJvYcCVk1P77eTai8hL4+5nG4y9dNUBJJGFmIw2CkEGIbJa9/jhqo3UI3QJNYFr96BQm2KG0dTf8SRQr0TRO7XzX0WPUOLZjo6RnJZDqjvS4
X-Gm-Message-State: AOJu0YyUBip2g5rfge7TzRUujXN/IItGyHa9b5AT2NqIgFSxeqrDL7WW
	cTth4yhYKtMZq7PANsawH1UwBAkXcugXG5FaFNbO4jb2FfSM/MhCT6dc0or3NqKsWFW3zmSZXVe
	A7ajMXwLLhw176F4cEkqNfGUxDaw=
X-Google-Smtp-Source: AGHT+IG46cRNTa/gtranYKJdBT6/dNezPeSoykLRMIt4Z33qyDiPIc0MZ/By/svPwuzcGaqNtVEed7QZH55x6+hKuhU=
X-Received: by 2002:a05:6122:458d:b0:4e4:eda9:ec32 with SMTP id
 71dfb90a1353d-4eb02e5a92bmr1688549e0c.10.1717151533191; Fri, 31 May 2024
 03:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522110909.10060-1-victorshihgli@gmail.com>
 <20240522110909.10060-13-victorshihgli@gmail.com> <42f2b1d4-e6c2-4860-956d-4f10c3b05529@intel.com>
In-Reply-To: <42f2b1d4-e6c2-4860-956d-4f10c3b05529@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 31 May 2024 18:32:00 +0800
Message-ID: <CAK00qKBA81zx=QmU7m=pZXOzdY4syOht4p_-SU7fdw+-an0ciQ@mail.gmail.com>
Subject: Re: [PATCH V16 12/23] mmc: sdhci-uhs2: add reset function function
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 3:23=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 22/05/24 14:08, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V15:
> >  - Refer the SD Host Controller Standard Specification Section 3.10
> >    to add reset command data mechanism.
> >
> > Updates in V14:
> >  - Since mmc_card_uhs2() is the same as sdhci_uhs2_mode(), so drop
> >    sdhci_uhs2_mode() and use mmc_card_uhs2() instead of sdhci_uhs2_mode=
().
> >
> > Updates in V13:
> >  - Use ios timing to stead MMC_UHS2_SUPPORT for indicate the UHS2 mode.
> >
> > Updates in V8:
> >  - Adjust the position of matching brackets.
> >
> > Updates in V6:
> >  - Remove unnecessary functions and simplify code.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-uhs2.c | 57 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  1 +
> >  drivers/mmc/host/sdhci.c      |  3 +-
> >  drivers/mmc/host/sdhci.h      |  1 +
> >  4 files changed, 61 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 9cb0f1b2a37d..7652158ea151 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -10,7 +10,9 @@
> >   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >   */
> >
> > +#include <linux/delay.h>
> >  #include <linux/module.h>
> > +#include <linux/iopoll.h>
> >
> >  #include "sdhci.h"
> >  #include "sdhci-uhs2.h"
> > @@ -21,6 +23,8 @@
> >  #define SDHCI_UHS2_DUMP(f, x...) \
> >       pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
> >
> > +#define UHS2_RESET_TIMEOUT_100MS             100000
> > +
> >  void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> >  {
> >       if (!(mmc_card_uhs2(host->mmc)))
> > @@ -49,6 +53,57 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >
> > +/*********************************************************************=
********\
> > + *                                                                    =
       *
> > + * Low level functions                                                =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +/**
> > + * sdhci_uhs2_reset - invoke SW reset
> > + * @host: SDHCI host
> > + * @mask: Control mask
> > + *
> > + * Invoke SW reset, depending on a bit in @mask and wait for completio=
n.
> > + */
> > +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> > +{
> > +     u32 val;
> > +
> > +     sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
> > +
> > +     if (mask & SDHCI_UHS2_SW_RESET_FULL)
> > +             host->clock =3D 0;
> > +
> > +     /* hw clears the bit when it's done */
> > +     if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
> > +                                  UHS2_RESET_TIMEOUT_100MS, true, host=
, SDHCI_UHS2_SW_RESET)) {
> > +             pr_warn("%s: %s: Reset 0x%x never completed. %s: clean re=
set bit.\n", __func__,
> > +                     mmc_hostname(host->mmc), (int)mask, mmc_hostname(=
host->mmc));
> > +             sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
> > +             return;
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> > +
> > +static void sdhci_uhs2_reset_cmd_data(struct mmc_host *mmc)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +
> > +     sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> > +
> > +     if (host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_A ||
> > +         host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_A_HD ||
> > +         host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> > +         host->mmc->ios.timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD) {
>
> Please use mmc_card_uhs2()
>

Hi, Adrian

     I will update this in the v17 version.

Thanks, Victor Shih

> > +             sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> > +
> > +             sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> > +             sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> > +             sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI=
_UHS2_INT_ERROR_MASK);
> > +     }
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > @@ -57,6 +112,8 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >
> >  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
> >  {
> > +     host->mmc_host_ops.uhs2_reset_cmd_data =3D sdhci_uhs2_reset_cmd_d=
ata;
>
> As noted for patch 8, any host controller resets needed
> should be done before completing the request, so a call
> back function should not be needed.
>

Hi, Adrian

     I want to confirm further, so can I call
sdhci_uhs2_reset_cmd_data() directly
     in the mmc_wait_for_req_done()?
     Am I understanding something wrong?

Thanks, Victor Shih

> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
> > index 2bfe18d29bca..caaf9fba4975 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -177,5 +177,6 @@
> >  struct sdhci_host;
> >
> >  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> > +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 8fc3e001db74..f212da6dc2aa 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -236,7 +236,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_reset);
> >
> > -static bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
> > +bool sdhci_do_reset(struct sdhci_host *host, u8 mask)
> >  {
> >       if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
> >               struct mmc_host *mmc =3D host->mmc;
> > @@ -249,6 +249,7 @@ static bool sdhci_do_reset(struct sdhci_host *host,=
 u8 mask)
> >
> >       return true;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_do_reset);
> >
> >  static void sdhci_reset_for_all(struct sdhci_host *host)
> >  {
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 13703f1a3710..83d994c8d89e 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -845,6 +845,7 @@ void sdhci_request(struct mmc_host *mmc, struct mmc=
_request *mrq);
> >  int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq=
);
> >  void sdhci_set_bus_width(struct sdhci_host *host, int width);
> >  void sdhci_reset(struct sdhci_host *host, u8 mask);
> > +bool sdhci_do_reset(struct sdhci_host *host, u8 mask);
> >  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)=
;
> >  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> >  int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
>
