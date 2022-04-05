Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C83C433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Apr 2022 15:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiDEPEp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Apr 2022 11:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiDEN4t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2022 09:56:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E4EB12
        for <linux-mmc@vger.kernel.org>; Tue,  5 Apr 2022 05:56:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k21so23120967lfe.4
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2022 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RGi3wdqEmb8bOd+XtGboC+n40TEtF0S3Ny1xAXSWPpw=;
        b=qUent6wGui7nCIEVw9WbCQAr1HMcwKn0ulXfuo6ucPOZB9RuGM0I3RNYHNgYmU18qf
         2E0TBJc/667dA3RMGQu9G+uluOhBEJ5ZHHa/0Dg3OOdQjv6ZNkHK3w2Tc0A3QsQdASH5
         Wx4QzkIGUqOD287+KDgdcFYdL3WNTkcxdQMS1kWSN1x6OrN5c73DGfWZyXI4ekebinTj
         Efe5HxgcRJFy7NXNZwW01najt1HneNBBx/TzsKH52QV6/Aju/csCU7XnKSfjZTYTPmex
         3ugbXkIWuiXejOkNlEUMvhUDp6YbiBVgZ6FqH0YXnsgWEpFh5Ou5+lhhkp33toJdOkij
         NsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RGi3wdqEmb8bOd+XtGboC+n40TEtF0S3Ny1xAXSWPpw=;
        b=we+Q3rSvWqrxN/btYiagi4QSBcwTtDmMZyBbNnuZqCoIaS2eiwwkYalxPWzN93JMWY
         oULjtQ2IRuGE3I5t3C7L5SX51gwqEZPPy1oj+ca0dVAdv2nQKUAuNBKuHM89sKVV3kLQ
         P+AjRUgIp0tMmkNe0unpYuhONZwyA3XwpApQY9V6EJOTqCFER5SxwjifIER9Oj6DPHXE
         Ig0+xvoBAlyjsFcAT/TnPVau846TspCgTigesUFX1i2bIfx089pv7z8V+zqonWX/3jnO
         WI/7z82aO+52IrpbyjIPDN99H0Yicjo7ENW1amJLoGvuKCOeX+ny8jQvjhuOj0d0lTBB
         exqw==
X-Gm-Message-State: AOAM531ukeo5RC2xDYM9QqaaTYPl+la9DtTjR06g/ReZwtRk8CWKBhNm
        Ii141J7r8kYYTZLPUQpNSRU68r9VKqHT/fq85bxUEQ==
X-Google-Smtp-Source: ABdhPJyPnt90BGsp9MQfi8pMUfikS551+uaydptc6Mr6i289uBfmsYBBLH7TZFDhHmNkQM8iXvEVUs7GJlUn3tTOUXc=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr2713577lfr.233.1649163396464; Tue, 05
 Apr 2022 05:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20c6efa9a4c7423bbfb9352705c4a53a@hyperstone.com>
 <5eaae8e215d84dd3a4f7e09782478a29@hyperstone.com> <YkW1qGY3uJPhrmf1@smile.fi.intel.com>
 <c1726b6966e74c9fa9fb4a6ac56dedf9@hyperstone.com>
In-Reply-To: <c1726b6966e74c9fa9fb4a6ac56dedf9@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 Apr 2022 14:56:00 +0200
Message-ID: <CAPDyKFr=5HyNPc0Ly8ARHCk5hk2vWe4QEG=qu4iRYiGC1TD7LA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: mmc_spi: enable Highspeed for above 25MHz
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 5 Apr 2022 at 11:20, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> Understood and sure, then I'll take 2/2 back.
> @Ulf, would you like a v2 just containing 1/2 or is it fine like this?

It's fine as is, I will pick up patch1 very soon.

Kind regards
Uffe

>
>
>
>
> From: andriy.shevchenko@linux.intel.com <andriy.shevchenko@linux.intel.co=
m>
> Sent: Thursday, March 31, 2022 4:07 PM
> To: Christian L=C3=B6hle
> Cc: Ulf Hansson; linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org;=
 adrian.hunter@intel.com; digetx@gmail.com; avri.altman@wdc.com
> Subject: Re: [PATCH 2/2] mmc: mmc_spi: enable Highspeed for above 25MHz
>
> On Thu, Mar 31, 2022 at 07:29:37AM +0000, Christian L=C3=B6hle wrote:
> > Any setup supporting more than 25MHz is able to utilize
> > highspeed, so enable it even when not explicitly specified.
>
> I'm not sure about this. I prefer to be on the safer side, i.e.
> follow only what is supplied by firmware (ACPI / DT).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>     =3D
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
