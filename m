Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954A4EEAA4E
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 15:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbjINPHF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 11:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbjINPHE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 11:07:04 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF33A8
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 08:07:00 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d81b9f0487eso178412276.2
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694704020; x=1695308820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk1zfhhe6JPFaB+z2q0yx4wsz7+R2d86W0fVR7Z+Who=;
        b=tl2etwl188wUBy5ou/56NAJs+5hYGnbeYJQ613TXG48u8r4EW/b5tIQ9LE7if4NO46
         qCEzZmKd/r1097Zyu4kqVbeDi252dn1zpi/Cz4OQbpsUS7AAMantSSSwywLL5iVzUzWp
         GMaUvgZgjkI0Pb7hT4EheMHSTfdEZvFKEKqg3796t97b+o//ZZITu6pFrAetI7zQC3rD
         14SQIVajAG2SlehrsIXTIW+AhyHHpGxCopwSdAGV1C0Vvqsqw6nsGU0/Aqwk36xmtF2w
         mY3sqFpWwc5dO6xekM2XIuA9llTwosXWH7dVxy5ISpNAKSb3LQo5ENhC9bXOyhGOB7LN
         a4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694704020; x=1695308820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dk1zfhhe6JPFaB+z2q0yx4wsz7+R2d86W0fVR7Z+Who=;
        b=YEZz6EWXIEtH6E+iKICeiL2G9mBoU9pLzbbA2rmsUAK4B2UUWyAWkdfMXYO0myxs/i
         HRyv3uh2X/4NM6l3D7FkfDgISE89h+bvrjeKGhjpCb0ivzrTNikn25QziQBCmaBSwG7B
         hz9gRtdzuIBKYE36kifDOqqvQXokTWbQWCysvlO3XHv1VCQ9rPF7yu7XDq68BznY9nAm
         DvTSrw3dePrujM7CiGky18qUwhyqPTYBfnnmj9woG99TS4PcoiGRNAE6d/KZVhlA/KXH
         YlhDO7WHa85bwqMB70x05/ZGQ2sCn7FWaZMbdvpgrk75HS2c7hO9QkyJBH8DXMyxO7y5
         ODzg==
X-Gm-Message-State: AOJu0YzjY9JbWNdMx5yKaAPYqRNaw2+DS4m476z46Z1UUlwzXw0FpYgP
        5I0qCjZ8hqoanxoalvbsUtx5duRYUXxFlAZtKeDYYQ==
X-Google-Smtp-Source: AGHT+IGpmpLTQfyZsYu/3gVdW8yFDYo6WesgROzbFyj3lcVEqCEzq6WLE/dWuEvCOkweyudTmrWS/5MZXipYnJLRrhI=
X-Received: by 2002:a25:212:0:b0:d80:2525:9f1 with SMTP id 18-20020a250212000000b00d80252509f1mr4986428ybc.43.1694704020001;
 Thu, 14 Sep 2023 08:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230908095330.12075-1-victorshihgli@gmail.com> <20230908095330.12075-6-victorshihgli@gmail.com>
In-Reply-To: <20230908095330.12075-6-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 17:06:23 +0200
Message-ID: <CAPDyKFoCj=XGaCXzEGj4FbuNF=ds_XwHgF5FHqix4e4Pn68g1A@mail.gmail.com>
Subject: Re: [PATCH V11 05/23] mmc: core: Add definitions for SD UHS-II cards
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 8 Sept 2023 at 11:53, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Add UHS-II specific data structures for commands and defines for
> registers, as described in Part 1 UHS-II Addendum Version 1.01.
>
> UHS-II related definitions are listed below:
>   1. UHS-II card capability: sd_uhs2_caps{}
>   2. UHS-II configuration: sd_uhs2_config{}
>   3. UHS-II register I/O address and register field definitions: sd_uhs2.h
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>

[...]

>
>  enum sd_uhs2_operation {
> @@ -358,6 +381,7 @@ struct mmc_host {
>         u32                     max_current_330;
>         u32                     max_current_300;
>         u32                     max_current_180;
> +       u32                     max_current_180_vdd2; /* UHS2 vdd2 max curt. */

Looks unused in the series, please drop it.

[...]

Kind regards
Uffe
