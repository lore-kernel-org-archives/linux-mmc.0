Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE188004F;
	Wed, 22 May 2024 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368696; cv=none; b=byxMnhyNqYk+n6Pcec4bigp8c+Hdhc4ueS+fjQ/WIISLQky2d2odxuEjloSJCFIWQTY7Xf4C5mOVW0gHOBrahK11qBsXD9+rmSm9qz5kXWV04AkrnIH9fxcWFd363iNZ07IZfxbHpQ0MkzNyZ9CgTz6l0/SARck2YC1auC6CTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368696; c=relaxed/simple;
	bh=hKGD0B1XptHj5DDxstCGsRvuPM4DAj9Ti4tf2s6Tphg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fd6FLv+zPTurfYjph2M5v58mC8qFqyOZYRxjsnNcpXllUuh7wiCFJFOGh5hy14tA9BiuWHN2jGXYxTTgN8iNaJnAVAShCVwlPPs0sWL0RhLV230bCLVlMw0VR7dg9Zhf4/V5WaUoZGsgkGhEJz4UfrIo6JM6yBewkVhD7P9gvE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBtN5xmN; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBtN5xmN"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80312cb791dso189943241.3;
        Wed, 22 May 2024 02:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716368693; x=1716973493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4RV0VMfAMTyyv7ottk6RZJdLcA2zF+Qdq3qgEyF6xI=;
        b=lBtN5xmNSe+I6TVyovIG4cA+pM8y8GiUuECqMKUzan3kZNwf8SKsw8FewtdRJJCoxQ
         3+GrwOgeJbCHfC/ezwDsc4OqDmo7x6TSj8lI9d/f8maV0gkKLEoRiScM7GDIVVpyr0Zt
         +N9EKnx+iTnOXZuCOpbfKxnCC9R//o8yf81Qs4QhmSozP0C3ld7XA4f5rS3KRHoE2eo2
         Tn0RpGJYWMRypFf6aHzM9Ut97clyTWTm77F19yCKzgU5ZVljenKCahBPNZara0AWcAml
         M3RtHZv2G6lpuXPKCO1NLkC+UprJKY+xeBwCxJXdkEc1pudeJour+CLe9CRxTpWHWeyD
         df5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368693; x=1716973493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4RV0VMfAMTyyv7ottk6RZJdLcA2zF+Qdq3qgEyF6xI=;
        b=oqxvyAErKhOryxrGpP1EDmMlbE6OU3IGB5qDllGngtEIJIhe9U8LFygsiD0LUQ6cu+
         0aYG4OQ2aLYtTW7jGV1K+FqeMEyliNIHSkUkbL6PJvrIL1rjT1erp5foBCNr9ysM8NW9
         qjA6SCNUvseI7/1I2mosCwVku8d3z+0eELdrY3Vk0fxjFitIhCvMEF/Amr72PuVcxmFx
         KpYH7+yrF1BULvtBcQ/UdBKP/E6iKMqXAj1Lx9sYvETVvUePyVy0vTeIt+OFA+rMWpDM
         Sc83jxyk2h2cGturEcCTZ1bwSCFh5ZmceeMn4fNtHe372R8stno/opNFJd3X6ZRyJpUC
         5mAA==
X-Forwarded-Encrypted: i=1; AJvYcCXr3Xmirv3fDHczUte4LOViG665l0iuAOtnU8Lk3zzNWOxwM6SXSKwaQv7RbEtU0JW9xMpd5vmLPo+CIgxpLCm7Plfi6GXvWgdadvLgrXB0/aD45ujFtHaW4GoE0oTDhP+SEpH3cTUE
X-Gm-Message-State: AOJu0YyaqtEEOOwLiZKOpXEKRvEoprmMndcJL5rc8VABQyTaSGnmDOdN
	TnWoNTcrRDvxrDP9P03YUgJL5Do1v3tuNK0O6HlZz58UDT96pvz1wbEqKCmpp8pee9E0IytYVcw
	AR+e8tpsDu9z3Q3+9WonUWCfpkeg=
X-Google-Smtp-Source: AGHT+IGB3ASNE+XiQUSUcZXcTXWuSMgZHZW1XU4VgvRHPycANDAilwt8//hXngq1qLIgmMlfgEWf2s8wwj0EKztOsHo=
X-Received: by 2002:a05:6102:419e:b0:47f:3955:9b6c with SMTP id
 ada2fe7eead31-489043fb003mr1335197137.15.1716368693056; Wed, 22 May 2024
 02:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123062827.8525-1-victorshihgli@gmail.com>
 <20240123062827.8525-17-victorshihgli@gmail.com> <e7d7a434-665b-4912-a2ae-a51e10e332d5@intel.com>
In-Reply-To: <e7d7a434-665b-4912-a2ae-a51e10e332d5@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Wed, 22 May 2024 17:04:40 +0800
Message-ID: <CAK00qKDW1S9qRJEavKou3n_LOTJnaTOGyi=U1XqUvSDjZ31fDg@mail.gmail.com>
Subject: Re: [PATCH V14 16/21] mmc: sdhci-uhs2: add request() and others
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 11:31=E2=80=AFPM Adrian Hunter <adrian.hunter@intel=
.com> wrote:
>
> On 23/01/24 08:28, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a sdhci version of mmc's request operation.
> > It covers both UHS-I and UHS-II.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >
> > Updates in V14:
> >  - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> >    sdhci_uhs2_request().
> >
> > Updates in V13:
> >  - Re-order function to avoid declaration.
> >  - Remove unnecessary function.
> >
> > Updates in V11:
> >  - Drop the check mmc_card_uhs2_hd_mode(host->mmc)
> >    in sdhci_uhs2_set_transfer_mode().
> >
> > Updates in V10:
> >  - Use tmode_half_duplex to instead of uhs2_tmode0_flag
> >    in sdhci_uhs2_set_transfer_mode().
> >
> > Updates in V9:
> >  - Modify the annotations in __sdhci_uhs2_send_command().
> >
> > Updates in V8:
> >  - Adjust the position of matching brackets in
> >    sdhci_uhs2_send_command_retry().
> >  - Modify CameCase definition in __sdhci_uhs2_finish_command().
> >  - Modify error message in __sdhci_uhs2_finish_command().
> >  - sdhci_uhs2_send_command_retry() to instead of sdhci_uhs2_send_comman=
d()
> >    in sdhci_uhs2_request().
> >  - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_request_atomic(=
).
> >  - Add forward declaration for sdhci_send_command().
> >
> > Updates in V7:
> >  - Cancel export state of some functions.
> >  - Remove unnecessary whitespace changes.
> >
> > Updates in V6:
> >  - Add uhs2_dev_cmd() to simplify code.
> >  - Remove unnecessary functions.
> >  - Cancel export state of some functions.
> >  - Drop use CONFIG_MMC_DEBUG().
> >  - Wrap at 100 columns in some functions.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-uhs2.c | 379 +++++++++++++++++++++++++++++++++-
> >  drivers/mmc/host/sdhci.c      |  49 +++--
> >  drivers/mmc/host/sdhci.h      |   8 +
> >  3 files changed, 420 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 0c543899ed6c..b47bcf6f890f 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -14,6 +14,8 @@
> >  #include <linux/module.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/mmc/host.h>
> >
> >  #include "sdhci.h"
> >  #include "sdhci-uhs2.h"
> > @@ -29,6 +31,8 @@
> >  #define UHS2_INTERFACE_DETECT_TIMEOUT_100MS  100000
> >  #define UHS2_LANE_SYNC_TIMEOUT_150MS         150000
> >
> > +#define UHS2_ARG_IOADR_MASK 0xfff
> > +
> >  void sdhci_uhs2_dump_regs(struct sdhci_host *host)
> >  {
> >       if (!(mmc_card_uhs2(host->mmc)))
> > @@ -63,6 +67,11 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
> >   *                                                                    =
       *
> >  \*********************************************************************=
********/
> >
> > +static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
> > +{
> > +     return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_M=
ASK;
> > +}
> > +
> >  static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> >                                           struct regulator *supply,
> >                                           unsigned short vdd_bit)
> > @@ -140,7 +149,7 @@ static void sdhci_uhs2_set_power(struct sdhci_host =
*host, unsigned char mode, un
> >
> >  static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res=
, u8 *dead_lock)
> >  {
> > -     /* timeout in us */
> > +     /* timeout in us */#define UHS2_ARG_IOADR_MASK 0xfff
>
> Extraneous "#define UHS2_ARG_IOADR_MASK 0xfff"
>
>

Hi, Adrian

I will fix this issue in patch series v16.
Please help review changes in patch series v16.

Thanks, Victor Shih
