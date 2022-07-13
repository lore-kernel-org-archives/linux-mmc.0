Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0846CCA485
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jul 2022 11:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbiGMLEe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jul 2022 07:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiGMLEc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2022 07:04:32 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E2E165A6
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 04:04:29 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id h200so10469314iof.9
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCWkQHq8E/9pRymMvNTDBdyH+L3Z3PKTyfStJb644/I=;
        b=TLVRz1KFaaSXT2nPn8AqocicoaCf5v5CQA+y3ngeUFMYhIbERjhtN4cKh2rGrSJ36S
         2BpQ3AV0wJMK2Wuk2ENkgBsziUX+jMx8sT3K3vCW+EWQMsBuxsdNg6y+gUtY3ObGTHjE
         Bm2l436iPXVDQ2IVxZODaX1GoUeAXmslE/sjBF/0WeqpzCrWQJHgDMu57PDHZvxPhQ+x
         FFAdiuo/aQXmj83bUiFCPV6r+ttlyCQ5UglVGka4CqycsiDtxVJqQswC47/eIeyuLlXr
         4Fcrno/DTJNyV2TVzeEHfCxGwEjJATAh2xbfagdY55cVHQdO5eSmTyMrSx344ozYO6sD
         +3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCWkQHq8E/9pRymMvNTDBdyH+L3Z3PKTyfStJb644/I=;
        b=BFlQQ9+e1BOEN+thfqnRq7ammn1zNKKOH5UJnaFUzJyrWlLnCMNNKqCL/2XSn62K17
         qDPsGI3OYhrANKeMlieYjjD9aZbuRpjUE1id5jgfY0fZzeYKwMm3QaBvEfQTJytcdv9l
         BSy0b2WTPf9U3b/pgggTWoy95b1oTPR+e2e51P95vgyQltDm6oy0jmP+KXzcQbz7r+Uz
         y0Ye90bk6ePTJI/eEMARgA0muFkJ+mCUNV3Eo04+jo+whXvRgVKbvt5K9S90JsXENna/
         l4mXleAHNyXAcGNoOZ50h4kZfyhqHewNjiOFubKu6Obo+2FdJ++c8x7Wb5zuB6ljPP4E
         44hQ==
X-Gm-Message-State: AJIora/SKcr9X6FwcAjt5/ozh0lHO+6f4DqWV0L3nrXTcujB/IguGNVN
        qEkZFheKIp9pi9/55DFtZGUX287QYrJvjaUDgcJa8z0p/Ew=
X-Google-Smtp-Source: AGRyM1uXT9mKJPwa2y3lHJIwQz2aaBOfD4HanhyCvdApzfs160u5A8gJMbUOOvY+SpywF1QxgC0r1hzCLngNukwXq2M=
X-Received: by 2002:a05:6638:31c2:b0:335:dd22:83ec with SMTP id
 n2-20020a05663831c200b00335dd2283ecmr1563870jav.88.1657710268855; Wed, 13 Jul
 2022 04:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <AM5PR0701MB2964A49C4E5EEA8905926120EFB89@AM5PR0701MB2964.eurprd07.prod.outlook.com>
 <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575A3FE605E0AE1C92B4EB1FCB89@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jul 2022 13:03:52 +0200
Message-ID: <CAPDyKFrTkRLe=kFFq26ao7krgqS2Hh2CRMeuDbo=LYBvgyGzMw@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: correct and clean up the file handling
To:     Avri Altman <Avri.Altman@wdc.com>,
        "Matic, Bruno (Nokia - DE/Ulm)" <bruno.matic@nokia.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 28 Jun 2022 at 23:55, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> Hi Bruno,
> Thank you for your patch.
>
> > Add the check if the whole firmware was loaded.
> > Cleaned up the leftovers of handling the file in chunks.
> >
> > Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
> Christian proposed a fix to do_ffu about a week ago,
> see e.g. https://www.spinics.net/lists/linux-mmc/msg70961.html.
>
> Would you mind waiting for few more days to allow it to finalize,
> And then rebase your change and resend?

FYI, the patch from Christian has been applied now. Apologize for the delay.

[...]

Kind regards
Uffe
