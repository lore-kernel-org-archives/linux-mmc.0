Return-Path: <SRS0=EyEY=5Z=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27F0C2BA2B
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Apr 2020 12:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5A520771
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Apr 2020 12:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586434236;
	bh=Rcql0G1zaTLlaXT50Qt+WXX+iAv8vAulksVHyNn6ZWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=InDyqgWztXg2QJwjCDwD1JgK1SeVONdh9zIWG5r7WgDtx7zhxU8IdQkIMv2BMFZL3
	 9naD9JGv6MxCH73V4/fS0BEFozGdwjlTvzWOwCjHi4ayIoaT3Uq3JL5O0K7jDwBDWg
	 fsMwkcVrYeWETHLjiYz0+/wRWzRhXJQ4QFrrFxXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgDIMKf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:10:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44403 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDIMKf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Apr 2020 08:10:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id cb27so1650274edb.11
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2020 05:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QcTbv4R3SMIJhOkQGuv2vupR8PXJgTGjWpmKYkmEOZg=;
        b=XuFJdW47gxCZP+FLDU0jkYrakspvsHHm5cVC3qxvgPjy19PCMdB/+C4e9iG9TAce+/
         6HaMD/fUEpTVvtW7269R7TxoYE7Y9ShH0hDxlPiaQFgQ1jGZD1PKZhlnrCCqrIAXf+LG
         vRqkPajFMzNp6t92oMSPEatgD4E5LC9ePNYDixk3PP8/H2YHhm9/Fcnd57628Uj2iA7p
         GF1Qadj8tx8VBK/B/eS2H0ckc1+/WthQPU36FK06lfK4ea6JZPJHCcQLJFN0uwgFdvoz
         3PF9WXDI0w+5u/+AOfM4lTWLLAj9Uc6Merv3XdECm2jrEWJ6BI2ytYbT2YnPTOhq6P9+
         g4SA==
X-Gm-Message-State: AGi0PuaD9M6uhCnPIX3GEMncjEFe+ovsBCWcyPsuq0xVkb0a8TVSCY/k
        Z3eSrwzEC/iFlFWF9sTOYK0=
X-Google-Smtp-Source: APiQypLflLHY8KxVKbY32LMbCrMQxxkMw4tn1fzViDL2PxMKlTZZ1w2pVHO8Kdjg+plFuaik+Nhydw==
X-Received: by 2002:a17:907:b17:: with SMTP id h23mr11009718ejl.40.1586434234405;
        Thu, 09 Apr 2020 05:10:34 -0700 (PDT)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id o33sm3079332eda.30.2020.04.09.05.10.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Apr 2020 05:10:34 -0700 (PDT)
Date:   Thu, 9 Apr 2020 14:10:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCH] mmc: s3cmci: Drop redundant code in s3cmci_setup_data()
Message-ID: <20200409121032.GA640@kozik-lap>
References: <20200407143903.22477-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200407143903.22477-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Apr 07, 2020 at 04:39:03PM +0200, Ulf Hansson wrote:
> The in-parameter struct mmc_data *data is never NULL, because the caller
> always provides a valid pointer. Hence drop the corresponding redundant
> code.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/s3cmci.c | 7 -------
>  1 file changed, 7 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

