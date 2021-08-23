Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB1DC4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 07:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9104661371
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 07:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhHWHyE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Aug 2021 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbhHWHyE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Aug 2021 03:54:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC19C061575;
        Mon, 23 Aug 2021 00:53:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d26so4537078wrc.0;
        Mon, 23 Aug 2021 00:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=fc41RHpGSLm7yZNljm3ipeJe276/QT9sJLIfnCrAz/8=;
        b=T5ke9boWANF+x+UIfGqhhEo+T+Z/yAw7CV0N9f9NkXIL72U8yygob0hClxrxw9B2HO
         JcxsvXwaX4k6uN0FUPJv8Bg9HrSuInm8bU58jSsBYYTsQhlIzgk90PrJt1WepprP9h0R
         7cLYeEs8EKzk1qtXHZNbRc0o964yAbPuNw5IaYDvEGzOkv3vcO+SlaO2twAyUcHO2isU
         GikLOA9Uvo+Q8op9kJSoFt2t3s4w3mtTghADf08g5w/0if7j+gIwYAv7zDzpT2KWecaX
         qX2DPzumWqDWtTw5SGU1ZeoHtVPkWMLMzdiVAvB7EBX7dAF9XZHZ+UUBWETwNMfyP9Eq
         s/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fc41RHpGSLm7yZNljm3ipeJe276/QT9sJLIfnCrAz/8=;
        b=NlMBeO2+BqNP0R5ANW2H+dDLAhkCv6ZUPwZle9bLIzk3XN9PEFdyD27IAwI/NEBxD2
         7SlXhIuIDR/hwebmZC7kXx0SzSWshbsmeSj3a2S1D84bmADO/Gqvhk924XzsgdGo1sGA
         rW6rfPMMtZSUJ4cgMI9nzJw8JrVyiMSpNGzro58S3IsLIyMsZ/gKw5xKu9nh8I2ODm9k
         t/zaz91yGJgLd+m83eSalmrvFBewKkj8B+KPhob0jMK6W3GSwRscB1yLPyfskTnC59ii
         X432yHSiwACWnmUWfIZnzOLzthTR4Te1nJnSGtysSFhBDZ5fJv/EgAUu1PTNLXf2oHGQ
         /4dg==
X-Gm-Message-State: AOAM531SsIYkVpUcxjkXpMYVlLFQQJQPdb1jD6J7ilPSXXXkqrOxl9Fi
        Fv58d2ZcanorZFF7uM2G34e0VSOrRlo=
X-Google-Smtp-Source: ABdhPJy/aZvrCWzb0mgkhM+8dV3YqaZAFm72/ieH7QHNukzNYi5tHbMbvd6/lUizWivDE47PYqYFKQ==
X-Received: by 2002:a5d:4c4e:: with SMTP id n14mr11756957wrt.226.1629705200488;
        Mon, 23 Aug 2021 00:53:20 -0700 (PDT)
Received: from ubuntu-laptop (ip5f5bec31.dynamic.kabel-deutschland.de. [95.91.236.49])
        by smtp.googlemail.com with ESMTPSA id t14sm2711270wrw.59.2021.08.23.00.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 00:53:20 -0700 (PDT)
Message-ID: <c2beac013060b64d94664d0ee9bd06dd68138386.camel@gmail.com>
Subject: Re: [PATCH v1 0/2] two minor changes of eMMC BKOPS
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Date:   Mon, 23 Aug 2021 09:53:19 +0200
In-Reply-To: <20210817224208.153652-1-huobean@gmail.com>
References: <20210817224208.153652-1-huobean@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ullf,
Any thought about this patch?

Thanks
Bean

On Wed, 2021-08-18 at 00:42 +0200, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> 
> Bean Huo (2):
>   mmc: core: Issue HPI in case the BKOPS timed out
>   mmc: core: Let BKOPS timeout readable/writable via sysfs
> 
>  drivers/mmc/core/mmc.c     | 32 ++++++++++++++++++++++++++++++++
>  drivers/mmc/core/mmc_ops.c | 14 ++++++++++----
>  include/linux/mmc/card.h   |  1 +
>  3 files changed, 43 insertions(+), 4 deletions(-)
> 

