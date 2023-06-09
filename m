Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9FBC7EE25
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Jun 2023 11:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjFIL3R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Jun 2023 07:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjFIL2s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2023 07:28:48 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2512712
        for <linux-mmc@vger.kernel.org>; Fri,  9 Jun 2023 04:28:46 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1a1b95cc10eso599375fac.0
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jun 2023 04:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686310125; x=1688902125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h+xlmvh6V5XUTOvaVdo2oTM812lLj1/E/Gtn582Obak=;
        b=uTs0VD/ITW7mLUURZ5Ak/QYqWcuuDnloinfJm3WFEXFYd3//u2zGnKOP6Ts/OZZvYI
         8vpIl1qtvPyUlt/+7r6OBL4/WprFUavnChMrZ185PWXpYSub7nSxc0QBgTjmlQGJ0Xaa
         01CdDKIGtMzpD27tl5dRiXvrrj79EKn2rmtTxgwCqjf/dpyqZjYCim9yIb0EyltJl2gZ
         PtxALFR4gCZFmziUVp4YY3BaH35EaFo8y3Xnk0cl/gIneGoik4TxFgimCzHbnAf54J1Q
         3c78ZDeJrV3zbswcbZeoYEFViUC+4V0jj5VoAZgou183e2shSkU3CqXC0Iq/vL8JIKbJ
         ofCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686310125; x=1688902125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+xlmvh6V5XUTOvaVdo2oTM812lLj1/E/Gtn582Obak=;
        b=ZHIDx1yjtz6S68obZf4mP8XSUxrYbWqeC3A5uwOk/YYsftJD1/lXYlgv2ddqkfBbdQ
         9gUx+5y6TxtJiLSmk8Ps9To+2X58OLzIvBrdcJveZEnZwnBnufaJOAdlBAO0rblpW/+1
         Tp6iZZQxrZrF0Mc26eV16aH3aLeC/HZdGDpeEydYQOS6wPqZ+Dxxl9s0hB/kqf69yGim
         eEhFRAHKthMD4/1f/pEjaiq9EKyHwBD2lQPDdUO31+urY1I8lBJzadfvrGpeMldJn8vW
         gFHiQCyJofwLUKtYvtunHXfbNyVxwTxSVuN3XbDkNUNjGIAD9ytBSfwFNWfnKUshpf0y
         y+6Q==
X-Gm-Message-State: AC+VfDwCrQcs1XqEbTj0VzpfForRuwCV66rHHSf6ZxsdyvtnYzTBrWjE
        /BCnw5RYYW+Ow4x7PdUn9Bb4LZjmPFQ2RlJpVsDnTQ==
X-Google-Smtp-Source: ACHHUZ5bvJWQ2B+G0u8EMiVWzaEFYIgGCw5RRiYPOkFWx/IaFZ885mQfPKSIdWEuuVd3xOp55Qqn1oA9kXRygQ2mMjs=
X-Received: by 2002:a05:6870:e14b:b0:19d:6f68:c3f with SMTP id
 z11-20020a056870e14b00b0019d6f680c3fmr958102oaa.33.1686310125565; Fri, 09 Jun
 2023 04:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230609071441.451464-1-victorshihgli@gmail.com>
 <20230609071441.451464-4-victorshihgli@gmail.com> <CAK00qKDkZ1wbxO+iyryrWv2KeXoZ6DMMrip215A2rds494hkGQ@mail.gmail.com>
In-Reply-To: <CAK00qKDkZ1wbxO+iyryrWv2KeXoZ6DMMrip215A2rds494hkGQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jun 2023 13:28:09 +0200
Message-ID: <CAPDyKFoe8jjTseeqS8532jgjMj28A80WW4U7YdStVgxtOqcq1g@mail.gmail.com>
Subject: Re: [PATCH V6 3/4] mmc: sdhci: Add VDD2 definition for power control register
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Jun 2023 at 09:40, Victor Shih <victorshihgli@gmail.com> wrote:
>
> Hi, Ulf
>
>       This patch has been acked by Adrian in patch v5, but I forgot to
> add in this patch version, sorry.

Thanks for letting me know, I have added Adrian's ack.

[...]

Kind regards
Uffe
