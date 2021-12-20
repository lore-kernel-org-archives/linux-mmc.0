Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C985C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Dec 2021 10:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhLTKkE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Dec 2021 05:40:04 -0500
Received: from smtp1.axis.com ([195.60.68.17]:40900 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhLTKkE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Dec 2021 05:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1639996804;
  x=1671532804;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=VLroCuA+HQwcMwKp0/ZNdCT4a3i07oLjzHJCYHuUIKw=;
  b=SBkuN7/eOJGKuy1Dti4qjmN4CQEpphW01hI0PdFPS+a+i5E4Xwl8lVTV
   H1kVe8/gmUGIv1eGn2WQhxn71+J5TgGF1NypS9PjnJSXocOdk8/IEjkWo
   AlieH8nnwzdRRYjzv3PCmcEcAEnPrAO9gFkekAYcM2RSbiolNXZTRZYGU
   S5HAnctwsctUAovi9v7zjKB8voLMHXwtvnm4LXhi4JsVeb1pS+SSHCo6+
   auwn8EaodKiWeSTCY4ypO9yHASyGUOGShnFFUkjtRBw5mjxQnZzvyi78Y
   NdhUPqg0FtGGVxS4n6tLFKVUzbAWakAdV2b3sQMZpu0ohAqdptXGYSoub
   Q==;
Date:   Mon, 20 Dec 2021 11:40:02 +0100
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Jaehoon Chung <jh80.chung@samsung.com>,
        =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] mmc: dw_mmc: clean up a debug message
Message-ID: <20211220104002.GA8585@axis.com>
References: <20211217150348.GD16611@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211217150348.GD16611@kili>
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Dec 17, 2021 at 04:03:48PM +0100, Dan Carpenter wrote:
> The "0x" prefix is redundant when # flag is used.  It prints "0x0x".
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index f2a14a434bef..bec4796283fe 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1307,7 +1307,7 @@ static void dw_mci_set_data_timeout(struct dw_mci *host,
>  		tmout |= (tmp & 0xFFFFFF) << 8;
>  
>  	mci_writel(host, TMOUT, tmout);
> -	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%#08x",
> +	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: %#08x",
>  		timeout_ns, tmout >> 8);
>  }
>  
> -- 
> 2.20.1
> 

Reviewed-by: Mårten Lindahl <marten.lindahl@axis.com>

Kind regards
Mårten
