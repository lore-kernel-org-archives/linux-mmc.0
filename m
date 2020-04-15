Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E464C2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 08:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1268208FE
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 08:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG0bzlxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408069AbgDOIa1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728878AbgDOIaW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 04:30:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B11C061A0C
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 01:30:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so17849830wma.4
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 01:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dc4svgaoPj8cPa0X2dzfQwqB2qRNRWZMSYToFXDF5KE=;
        b=rG0bzlxFzy677BKze67UF7CXkmR2Q/Auc9M7XyyiXZi0Qq30jBZXR8TnP1QdtsjY0f
         tKmJmZx4f1xlczlt8tEqxgiF2doiOQjiry69QWMRcD91rmWb8xGHm4Hg569STgyF0u36
         ySLUhgOS7o3e81Ynsy7ogaVtKFH+DFa8hvwbVuewvUt/VB2RKcEhXhUtlUOWLpf7CPzJ
         51XmOycTh2x/gAzcg92/sMXG4RwK35EKyC69OdXyRcUwPw7mQPkqKArCCWbXTqhr2uPH
         omkpOwCbjJoLzGt84OPEWT03VBkpVCtK19jIlZXTpPPlh18VTohtyjCnf50S7NCRbgMe
         1IZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dc4svgaoPj8cPa0X2dzfQwqB2qRNRWZMSYToFXDF5KE=;
        b=e0UKDJCMuaCB5NplBKnHfxzKIDcqc7yDm8Uo7UwnADP0qWzs9opgqw2tHkY4srJggp
         gGTnYNaTH5USmkcQmnFSvTygUbD1N2km4bfqpOB4uvrhALmcx1Rmxd72235hkF7y7V8I
         tO9ZrwTQoKjMjOK1rK6i2l73CFyeux1u65qwzs5s5/8NIZkB0ddV7nJsjGfrOd69yToP
         2fu9bEsEKb1kNIMh5iclxtbC4xthW1Hx+sIgccUE0XMhJzrV6WQ34VAxxKI2WSs7krDj
         +qXS9zGKxZciG/VlNpOnmWe7MF9KRmlnHtymaDwOqa2pEwlee37p10qQjdcbKqcQtwjZ
         VobQ==
X-Gm-Message-State: AGi0PuY0zCfZ6zQ3j4xUfQZspnrQFDPekdxpxeexC+D0YgjAyXeSvnHT
        BAK7a1zp2IhD66XaosGZb3U=
X-Google-Smtp-Source: APiQypLjonbFDJi3jxw1i1ANZLx5+YHURwfAKrIwK8Wglw04haWqjrRQ0EvRnmT0qeJUEyVbL8dgkA==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr4305096wmf.128.1586939420233;
        Wed, 15 Apr 2020 01:30:20 -0700 (PDT)
Received: from arch-thunder.localdomain (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id 74sm9797001wrk.30.2020.04.15.01.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 01:30:19 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:30:15 +0100
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Alex Dubov <oakad@yahoo.com>,
        Sascha Sommer <saschasommer@freenet.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mirq-linux@rere.qmqm.pl, Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH 19/19] staging: greybus: sdio: Respect the
 cmd->busy_timeout from the mmc core
Message-ID: <20200415083015.g6dhlnznmyvq5ibs@arch-thunder.localdomain>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
 <20200414161413.3036-20-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414161413.3036-20-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,
Thanks for the patch.

On Tue, Apr 14, 2020 at 06:14:13PM +0200, Ulf Hansson wrote:
> Using a fixed 1s timeout for all commands is a bit problematic.
> 
> For some commands it means waiting longer than needed for the timeout to
> expire, which may not a big issue, but still. For other commands, like for
> an erase (CMD38) that uses a R1B response, may require longer timeouts than
> 1s. In these cases, we may end up treating the command as it failed, while
> it just needed some more time to complete successfully.
> 
> Fix the problem by respecting the cmd->busy_timeout, which is provided by
> the mmc core.
> 
> Cc: Rui Miguel Silva <rmfrfs@gmail.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: greybus-dev@lists.linaro.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
LGTM

Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>

------
Cheers,
     Rui

> ---
>  drivers/staging/greybus/sdio.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/sdio.c b/drivers/staging/greybus/sdio.c
> index 68c5718be827..c4b16bb5c1a4 100644
> --- a/drivers/staging/greybus/sdio.c
> +++ b/drivers/staging/greybus/sdio.c
> @@ -411,6 +411,7 @@ static int gb_sdio_command(struct gb_sdio_host *host, struct mmc_command *cmd)
>  	struct gb_sdio_command_request request = {0};
>  	struct gb_sdio_command_response response;
>  	struct mmc_data *data = host->mrq->data;
> +	unsigned int timeout_ms;
>  	u8 cmd_flags;
>  	u8 cmd_type;
>  	int i;
> @@ -469,9 +470,12 @@ static int gb_sdio_command(struct gb_sdio_host *host, struct mmc_command *cmd)
>  		request.data_blksz = cpu_to_le16(data->blksz);
>  	}
>  
> -	ret = gb_operation_sync(host->connection, GB_SDIO_TYPE_COMMAND,
> -				&request, sizeof(request), &response,
> -				sizeof(response));
> +	timeout_ms = cmd->busy_timeout ? cmd->busy_timeout :
> +		GB_OPERATION_TIMEOUT_DEFAULT;
> +
> +	ret = gb_operation_sync_timeout(host->connection, GB_SDIO_TYPE_COMMAND,
> +					&request, sizeof(request), &response,
> +					sizeof(response), timeout_ms);
>  	if (ret < 0)
>  		goto out;
>  
> -- 
> 2.20.1
> 
