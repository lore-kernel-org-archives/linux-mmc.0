Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC3FC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Sep 2021 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44B761214
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Sep 2021 09:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhIOJz5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Sep 2021 05:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhIOJz5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Sep 2021 05:55:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3813DC061574;
        Wed, 15 Sep 2021 02:54:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bt14so4910907ejb.3;
        Wed, 15 Sep 2021 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=C0cbjXlxhi/IJX0ZL0bzzsNP2N3UaUFrpqoamrREuVM=;
        b=dmKwRqsVoY/mgSzV4I7aWm1Qo/Ao+VYMqo2VCxA3+yoqsvycJLGdSRQmIl8O9NLYao
         AlCc/OJPOtw+ee6zHGFT2VYrZKyynvYrsHWWVAArRLRzVBEoj02fvCI1hpAt4IonXgGV
         QlxNE1dGEeMzfgzVjNFFyiAu563OdL+YYIXzWrLRERTioqAC7/joBKB3BRZmlXBR2MMu
         2CgwTPItgTuN5u2i6BPtYo64i8oiT0DGukLjzSrcfNUH6KAv38Zn/xzIyzZY3+njpy2/
         lrCviuLYZ9L8jPf5THmfen4oLEY1ZuHBqJ6ld9EVpKW5D9Nk3mI5IjVcAXq3KY8AdrqD
         tzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=C0cbjXlxhi/IJX0ZL0bzzsNP2N3UaUFrpqoamrREuVM=;
        b=PShx59ZtGgCEfn7VDbJ014En/b/V/1e6Yh60iPmG1iYV7/ehcP3n08Y0pZgj30b7+8
         yHjxasJQkRP+7aVv9oQuOrt7w/WSLl7+dgGlKPU64z8LXJ3PwgA9LLYFD0r5JwjRgdLy
         gWyz8HT0TGDmwhh9VJxvKLEp3Lz696NVO/BhDmc31fNu0E946BM8yjbWASM+23mjaJYL
         MstI0u/ly+nV6YaYys7NUvU6mJ3ACbLOjRc/i302SR9g839BlRQFO3Z0MpFwxYJnWnjL
         Ic/b8SeQVODriNN2EtSAT/AU6ssQmBRsZwjNNEpYXjr/Yte4XCCUvN+7Yp+vUtalPCH1
         +gPA==
X-Gm-Message-State: AOAM531lfzLXjQLF1a6QUG80XfRNs79Q6gr9jQ+gCsTp8hAmfjZc8ZkC
        KNqAyYbxv2/kyUtDM6WsFpE=
X-Google-Smtp-Source: ABdhPJxvlj7F7ixjasXkN5qo7dsDG1qROcpX+3+I5JQYqZF3AILJ6azwzHYrJTPhhUDCSkt+4SrbAQ==
X-Received: by 2002:a17:906:dfe3:: with SMTP id lc3mr12487415ejc.478.1631699676829;
        Wed, 15 Sep 2021 02:54:36 -0700 (PDT)
Received: from ubuntu-laptop ([165.225.203.49])
        by smtp.googlemail.com with ESMTPSA id v25sm5977872eja.83.2021.09.15.02.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 02:54:36 -0700 (PDT)
Message-ID: <92123c0398e154334cc947ce8f16e89ce0c3c9af.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: core: No need to calculate the timeout
 value for CQE data transmission
From:   Bean Huo <huobean@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Date:   Wed, 15 Sep 2021 11:54:35 +0200
In-Reply-To: <CAPDyKFpC6iei96n-UcRTNrxTaHeejzfQX+rka7GSwSZjXN7-4g@mail.gmail.com>
References: <20210907151204.118861-1-huobean@gmail.com>
         <20210907151204.118861-3-huobean@gmail.com>
         <CAPDyKFpC6iei96n-UcRTNrxTaHeejzfQX+rka7GSwSZjXN7-4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 2021-09-14 at 10:13 +0200, Ulf Hansson wrote:
> >          }
> > +       /*
> > +        * In case CQE is enabled, the timeout will be set a
> > maximum timeout in
> > +        * sdhci_cqe_enable(), so, no need to go through the below
> > algorithm.
> > +        */
> > +       if (host->cqe_enabled)
> 
> 
>  I don't think this is a good idea. For example, host->cqe_enabled is
> 
> set for the hsq case well.

Uffe,

My apologies for this, I forgot to check hsq, hsq will call
sdhci_send_command() as well.


How about changing it to this?

 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 240c5af793dc..7235e398ef93 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -649,6 +649,7 @@ EXPORT_SYMBOL(mmc_wait_for_cmd);
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card
*card)
 {
        unsigned int mult;
+       struct mmc_host *host = card->host;
 
        /*
         * SDIO cards only define an upper 1 s limit on access.
@@ -659,6 +660,13 @@ void mmc_set_data_timeout(struct mmc_data *data,
const struct mmc_card *card)
                return;
        }
 
+       /*
+        * For the CQE use case, the data transfer timeout will be set
a maximum
+        * timeout value in HW timer in function sdhci_cqe_enable(),
so, no need
+        * to go through the below algorithm.
+        */
+       if (host->cqe_enabled && !host->hsq_enabled)
+               return;
        /*
         * SD cards use a 100 multiplier rather than 10
         */

I have another timeout change associated with data transfer as well, if
this change is acceptible, I will submit it with that together.

Kind regards,
Bean

