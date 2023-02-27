Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E9AC64ED8
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Feb 2023 07:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjB0H3h (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Feb 2023 02:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0H3h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2023 02:29:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A201ABC7
        for <linux-mmc@vger.kernel.org>; Sun, 26 Feb 2023 23:29:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bw19so5072622wrb.13
        for <linux-mmc@vger.kernel.org>; Sun, 26 Feb 2023 23:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KsRQq5oeEGSKy9PF9dlOeWeRcXZ+MxlwhABL2z/sIp8=;
        b=XNum5whVNftmVGHjkwx53sxcphurLIDBBm2YwqD2DUGB1s60gJJ9z4lnLCsSKU6ooZ
         xt6swSJcpDkJrZEDHHaxhYwWMiGpswwTvfVTy7t08fMzfhuZKzuqvcXXIiLerUZdvrgF
         WKvS/Cqd8urNgle3e8J/jFBJNjnkKoDt1bVeY8y2p+C16lXc8TDRpINYZVpbfvBmvi3A
         RzX1leIIAyRv3iI+hHdVMlv9brBrdwMKR8u78lSv1l+1ZplYimelt24/WcSi6Gsma7+O
         EK96HUY0OrShjCPzV8LLgelwYMOCNNbqA8VTHMKotpHflpnWmikBwKRGGgubyluWqjWu
         vU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsRQq5oeEGSKy9PF9dlOeWeRcXZ+MxlwhABL2z/sIp8=;
        b=hsvhYxwODfkAdUDLtVUpJ6pk3gmYaPaSWsrYlbosqJHorpoyPuP2kUF25IxWXgPi/W
         yfHwL+26OlOG5v85sDF9Oe0917OtTw/3+hz69Hh1JaUEbnWn6IkNm0ei2l94+iLM5gWd
         vAJXTNaVKcYenHl8OpXCCSI1x7Txi5FY8j4xbaB/2+Ct6L5Np/ZsyIr7TShnH45N5vyY
         IbYLUaOpveg9I7pisXZKL+v31JvwicnGsWKcdCpk3xq/3IkS8kSQgcjiUP+yAwQEbC4Q
         FU2/0rndFmlkVLWlgpMCSOi/KNcBgWZeYjl2ScxLHwO5/HQ4TUq+4+RZb/u7f7Ol7FN4
         Y3CQ==
X-Gm-Message-State: AO0yUKUVQMT2l8HKSDEDq2kHhzgUQxf6r2ZVkrdgJcjZxiG4LnVRlxF3
        4pNyaBvR8/u3e6jAINa9TnbJbKiuHQ4=
X-Google-Smtp-Source: AK7set/k/94kAXZrk7236ocgFnwZLGTm3lu4kdfJhi5e0MBq2VEJmJUOp0SDmQCvQslhmWOmG6dMjQ==
X-Received: by 2002:a5d:410b:0:b0:2c5:58f5:3c40 with SMTP id l11-20020a5d410b000000b002c558f53c40mr17040787wrp.47.1677482974319;
        Sun, 26 Feb 2023 23:29:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k18-20020a056000005200b002c54c7153f0sm6399806wrx.1.2023.02.26.23.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 23:29:33 -0800 (PST)
Date:   Mon, 27 Feb 2023 10:29:30 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-mmc@vger.kernel.org
Subject: Re: [bug report] mmc: starfive: Add sdio/emmc driver support
Message-ID: <Y/xb2nqWVQ8Xc3HI@kadam>
References: <Y/xWiEW/npStWjTF@kili>
 <c32bdbe3-2e3a-d1e1-94c3-9aed2b31afc4@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c32bdbe3-2e3a-d1e1-94c3-9aed2b31afc4@starfivetech.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Feb 27, 2023 at 03:26:58PM +0800, William Qiu wrote:
> 
> 
> On 2023/2/27 15:06, Dan Carpenter wrote:
> > Hello William Qiu,
> > 
> > The patch 9e622229bbf4: "mmc: starfive: Add sdio/emmc driver support"
> > from Feb 15, 2023, leads to the following Smatch static checker
> > warning:
> > 
> > 	drivers/mmc/host/dw_mmc-starfive.c:77 dw_mci_starfive_execute_tuning()
> > 	error: uninitialized symbol 'prev_err'.
> > 
> > drivers/mmc/host/dw_mmc-starfive.c
> >     47 static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
> >     48                                              u32 opcode)
> >     49 {
> >     50         static const int grade  = MAX_DELAY_CHAIN;
> >     51         struct dw_mci *host = slot->host;
> >     52         struct starfive_priv *priv = host->priv;
> >     53         int rise_point = -1, fall_point = -1;
> >     54         int err, prev_err;
> >     55         int i;
> >     56         bool found = 0;
> >     57         u32 regval;
> >     58 
> >     59         /*
> >     60          * Use grade as the max delay chain, and use the rise_point and
> >     61          * fall_point to ensure the best sampling point of a data input
> >     62          * signals.
> >     63          */
> >     64         for (i = 0; i < grade; i++) {
> >     65                 regval = i << priv->syscon_shift;
> >     66                 err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
> >     67                                                 priv->syscon_mask, regval);
> >     68                 if (err)
> >     69                         return err;
> >     70                 mci_writel(host, RINTSTS, ALL_INT_CLR);
> >     71 
> >     72                 err = mmc_send_tuning(slot->mmc, opcode, NULL);
> >     73                 if (!err)
> >     74                         found = 1;
> >     75 
> >     76                 if (i > 0) {
> > --> 77                         if (err && !prev_err)
> > 
> > prev_err was never initialized to zero.
> > 
> Hi Carpenter,
> 
> I will fixed it. But what should I do next，send a new version to fixed 
> it or send a patch to you?

Heh?!  No, leave me out of it.  Just send a patch with a Fixes tag to
the linux-mmc@vger.kernel.org and the maintainers and so on.  Please
give me a Reported-by: Dan Carpenter <error27@gmail.com> credit though.

regards,
dan carpenter

