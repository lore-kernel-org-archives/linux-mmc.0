Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50103C433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 07:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18EE16105A
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Apr 2021 07:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhDZHap (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Apr 2021 03:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhDZHao (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2021 03:30:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A530BC061574;
        Mon, 26 Apr 2021 00:30:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n10so17301827plc.0;
        Mon, 26 Apr 2021 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSkcP15Ns1kAwtVg2PMjnrCnhxuuDVvHOr4fXBeFdqg=;
        b=VuSwlwaAvTv4k9aLudb9CtzbPfwVFEjOREgZfC1AjSkvb99bD/m3qlCa56eHkJRKqO
         plD6aq5i01LC9JcilJJoclpgkRoqvvRGiA5R82LoGLd/e4bt7fouki4lkQJ6yP/vLbvo
         ZVFlwB6my/tFm4Al9m6NvJ3c8iiBspM07sTTUkLJsQ2rHqmxGHhf2xGJyS/HxqHIIJX/
         p4G3At/lODq6wXS5rMC130rhnubK9QGjHTfbOsmYXOzYkwePzvctipCSt6vn0GqihbIJ
         E3fsB+qek82N120kx3nUeeJc6Yajzc28nc349a++gH5v794zA53qrm8F0O0G8/C7t+Tc
         5lNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSkcP15Ns1kAwtVg2PMjnrCnhxuuDVvHOr4fXBeFdqg=;
        b=ugNZKSZpsUczE4xSUZ1fv9x2+26ea4X/8qaoZ3L2f9kMW5/8VdUqQUUgaE3GqcIE3G
         TkHCEbVaXqUe+3EJIh8jnxhDLCU5JpHJnN/h96zvWI2hUY5xnnz1/nQoBS0tT9SbwLw9
         3AV65+Kqd8gXHXGC4bniFU2PvLzwVX9HZTRA5xsPlBcYlbJpMLoz1TxJga7nIycYGjxa
         oy5FQ4DRN1sHQ7HdjpA6gF3he5ZThxVuv8rRRxaseAYpghIGIoFDgpvAnfQHniOY4mLQ
         ZwExlUp+06RfAeVTcGNR8QYyNCWX6c+no0XXAwm3jg0jaYG81pDpmBdhsIDTwdPObgar
         dZzQ==
X-Gm-Message-State: AOAM532lOjkpagVwwYwzWuUGMQ2H6q7vsFMX+XtexN22IpgaMDzWxEpD
        Gx+wjftf34UdjjADlytw0bw=
X-Google-Smtp-Source: ABdhPJw0wyrQebS7h0snSgJTDJtgFjSeLVyIGfV5I0nCe7nxR7VMU2oU7pmJp+WtFSIiR5m7MVAdzQ==
X-Received: by 2002:a17:90b:1e01:: with SMTP id pg1mr21310323pjb.156.1619422203240;
        Mon, 26 Apr 2021 00:30:03 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id m11sm10487246pgs.4.2021.04.26.00.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 00:30:02 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     dlbeer@gmail.com
Cc:     adrian.hunter@intel.com, ben.chuang@genesyslogic.com.tw,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, benchuanggli@gmail.com
Subject: Re: [PATCH] mmc: sdhci-pci-gli: increase 1.8V regulator wait
Date:   Mon, 26 Apr 2021 15:32:51 +0800
Message-Id: <20210426073251.7726-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210424081652.GA16047@nyquist.nev>
References: <20210424081652.GA16047@nyquist.nev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Daniel,

> Inserting an SD-card on an Intel NUC10i3FNK4 (which contains a GL9755)
> results in the message:
> 
>     mmc0: 1.8V regulator output did not become stable
> 
> Following this message, some cards work (sometimes), but most cards fail
> with EILSEQ. This behaviour is observed on Debian 10 running kernel
> 4.19.188, but also with 5.8.18 and 5.11.15.

Glad to receive your report. Thanks.

> 
> The driver currently waits 5ms after switching on the 1.8V regulator for
> it to become stable. Increasing this to 10ms gets rid of the warning
> about stability, but most cards still fail. Increasing it to 20ms gets
> some cards working (a 32GB Samsung micro SD works, a 128GB ADATA
> doesn't). At 50ms, the ADATA works most of the time, and at 100ms both
> cards work reliably.

If it is convenient, can you provide the appearance pictures and product
links of these two cards? We want to buy them.

> 
> Signed-off-by: Daniel Beer <dlbeer@gmail.com>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 592d79082f58..061618aa247f 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -627,8 +627,13 @@ static void sdhci_gli_voltage_switch(struct sdhci_host *host)
>  	 *
>  	 * Wait 5ms after set 1.8V signal enable in Host Control 2 register
>  	 * to ensure 1.8V signal enable bit is set by GL9750/GL9755.
> +	 *
> +	 * ...however, the controller in the NUC10i3FNK4 (a 9755) requires
> +	 * slightly longer than 5ms before the control register reports that
> +	 * 1.8V is ready, and far longer still before the card will actually
> +	 * work reliably.
>  	 */
> -	usleep_range(5000, 5500);
> +	usleep_range(100000, 110000);

Looks good for me.

>  }
>  
>  static void sdhci_gl9750_reset(struct sdhci_host *host, u8 mask)
> -- 
> 2.20.1
> 
> 

Best regards,
Ben
