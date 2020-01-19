Return-Path: <SRS0=bclj=3I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F8EC33CAF
	for <linux-mmc@archiver.kernel.org>; Sun, 19 Jan 2020 20:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896E4206B7
	for <linux-mmc@archiver.kernel.org>; Sun, 19 Jan 2020 20:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uq+q6Cs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgASUMp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 19 Jan 2020 15:12:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41098 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgASUMp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jan 2020 15:12:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so26880232otc.8;
        Sun, 19 Jan 2020 12:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N1QlW5+ESSHKmdKwLymeXI/WjMGPsFxu1rPdBv2tr08=;
        b=uq+q6Cs0lEcX75ocY472Zgm9rPfPQxXPLVnbxbPzCSq9ENg5x+G4rj0kJg+TBjp1tu
         29np9UO55CBZJCbrMVeNrL/EMjreQUMwCkUI84HZJJ8upJtruJBlLtRIn7gl3+mpeRdw
         QlYg418ZBWEyvQC77N2W58TILhCiPvfdbvJrPeX/1/Wd8YReKYRHPhvRNmsLmQHQWcEF
         n9HfCLfLr612qrAswv6+r5ZRkGjIRyRR8GleT8w4ZVF1Icm97bmx9MQesCXu5MUkpqtB
         CwMh21pG8zQL6mSaxlmZ2Qm1BS91TukroFSNKxQRokc7jvT26b7uVzVDqjVBRQ7mt/ta
         rE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N1QlW5+ESSHKmdKwLymeXI/WjMGPsFxu1rPdBv2tr08=;
        b=hTwClxxExMdR2YQN1+P1l+OK9RgvtUb/HSlI6HQoP7aDzNBwT/wMjZD3xzW0BtWTdh
         /eTOVvmQpDiT2VEdYKHnqm6nPXGX4NFMK+AwmEEBhUbaX6ohWj47J/+r0p7yatAbFg1m
         HQWgf/r97Y+zZACJHdaYcneHS/UFkcZZMf/8B2ZmmbTq28iRqYf4rNGiQ/l4wA5zxinN
         +y5+mYtJecXS3VbvjsJmqfLcRml8I8c0wV9gaAkAuKCN8DS7jMgT97bqVWvqg10mcTLX
         P/+bDkOwf0f6pZZ23/0edLsqgMrYbmQAN3a7f86eyZVHm8GBSYolA5z3fhh6RE1VYoGV
         WgGw==
X-Gm-Message-State: APjAAAVq3vsBklO1UEfWcfP068fKojH6IpzCNt0K4Z4PN7PzmgeSYppZ
        KM0iAd0nqgK6Xo0jOFNxFb4=
X-Google-Smtp-Source: APXvYqwv5AvJUHDWpNU31FO2Kz6kxgn5L5SyDnjDPQndmx4yysajcL24OTKkORdM9fCjre/k76psPw==
X-Received: by 2002:a05:6830:2361:: with SMTP id r1mr13031284oth.88.1579464764967;
        Sun, 19 Jan 2020 12:12:44 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 97sm11652456otx.29.2020.01.19.12.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Jan 2020 12:12:44 -0800 (PST)
Date:   Sun, 19 Jan 2020 13:12:43 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mmc: sdhci: fix an issue of mixing different types
Message-ID: <20200119201243.GA15269@ubuntu-x2-xlarge-x86>
References: <20200119034902.20688-1-zhang.chunyan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119034902.20688-1-zhang.chunyan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Jan 19, 2020 at 11:49:02AM +0800, Chunyan Zhang wrote:
> Fix an issue reported by sparse, since different type of parameter is
> used on calling dmaengine_prep_slave_sg().
> 
> Fixes: 36e1da441fec (mmc: sdhci: add support for using external DMA devices)
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 30b5a624b50e..4503009f993b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1235,8 +1235,8 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
>  		return -EINVAL;
>  
>  	desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
> -				       mmc_get_dma_dir(data),
> -				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +			(enum dma_transfer_direction) mmc_get_dma_dir(data),
> +			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!desc)
>  		return -EINVAL;
>  
> -- 
> 2.20.1
> 

Clang also noticed this through its -Wenum-conversion. I don't really
like implicit conversions as I think it defeats the point of using the
enum. I had an explicit conversion locally which I attached below.
Regardless, this should resolve this issue (although I am not sure I
like the indentation shift.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
7index 30b5a624b50e..98fa25ba3756 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1201,6 +1201,7 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
 				    struct mmc_command *cmd)
 {
 	int ret, i;
+	enum dma_transfer_direction dir;
 	struct dma_async_tx_descriptor *desc;
 	struct mmc_data *data = cmd->data;
 	struct dma_chan *chan;
@@ -1234,8 +1235,12 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
 	if (sg_cnt <= 0)
 		return -EINVAL;
 
-	desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
-				       mmc_get_dma_dir(data),
+	if (mmc_get_dma_dir(data) == DMA_TO_DEVICE)
+		dir = DMA_MEM_TO_DEV;
+	else
+		dir = DMA_DEV_TO_MEM;
+
+	desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len, dir,
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc)
 		return -EINVAL;
