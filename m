Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D13C64ED6
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Feb 2023 07:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjB0HHB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Feb 2023 02:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0HHB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2023 02:07:01 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287D01B548
        for <linux-mmc@vger.kernel.org>; Sun, 26 Feb 2023 23:06:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r18so5081702wrx.1
        for <linux-mmc@vger.kernel.org>; Sun, 26 Feb 2023 23:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+3YUaVm1so+fxmmDD/HMzzZWUARg93unAKjOH2z7dY=;
        b=aRXniXxCrM7O+3sIu4wl42mjJbveado5Am4oXdlqFIdbLEfRqfR/OxKaID6lVDpitf
         hJ1X4oCzJWV8w9T67WCtU2WdUFjg17NJ6HFwS8NmaNDrtrAJfKunYjpL23Sfuho87BzO
         ZYzlorumcMDZvAWViIypzIPsEybSpldVOBiVwwwbrhfoCiuZ58PdPOQAx3QskfGKffjk
         NwM8MSAmVqkj5AitieL9kOOUDqfQe1M2bVY9vDZAgg7dh5vMlxGWfVUtfAZaE6GevCxn
         RnKqYakWfKaPSklt5VjQhOn7EzHOKZnTC5E4uvD1lU+kBrIocrI8i6+dBcnrNmIVLG61
         k23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+3YUaVm1so+fxmmDD/HMzzZWUARg93unAKjOH2z7dY=;
        b=6wPlRAqPAWA9ojHlJ5GekgIJ5hyS9xUr25IYYRFn2tAYP8U7xAA+eJF3/tM3xqfzUR
         8rZnSbJtNv0zVKnbv1IyFR1oQuLqzhS2cqjhN7IOFU6bF8KF3K6MVNZ9EHMTEWYpHFnK
         FI+MNNenBWYiWLEqZtKKeSu1qf2YWPzDQuJp353SOH89qzhU+3Zim1z7baZE7wW8v7RF
         Y5uw627y4FjmqV/i4blDQhTFvCFIGHQRJ+AeMMVlGdSnuuCy+SPcK3gqqkiBvV7I3Hkl
         ovU8FVTMk6LAlP9qHidGjRxjnUk4/3t7pli7MC583e+huvY2fX26sU2f23Fx1mI1aBqZ
         +g+Q==
X-Gm-Message-State: AO0yUKV4YIC6PR3W60wtmx3ZcCjVCPesvCkyup6ZYOlS2zbP3B85qpCv
        qQ0OLzTNQSi/WHTpEzle/gQ=
X-Google-Smtp-Source: AK7set9bqkmzw+oYiQAOx3VVgqSAE6I92SJgcOdG+6eWQGHXNbFv9Yhf7ZkjR1ygqdst8hIOphwHcA==
X-Received: by 2002:adf:f1d1:0:b0:2c9:a6be:34e1 with SMTP id z17-20020adff1d1000000b002c9a6be34e1mr5641481wro.55.1677481615494;
        Sun, 26 Feb 2023 23:06:55 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l8-20020adff488000000b002c557f82e27sm6245835wro.99.2023.02.26.23.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 23:06:54 -0800 (PST)
Date:   Mon, 27 Feb 2023 10:06:48 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     william.qiu@starfivetech.com
Cc:     linux-mmc@vger.kernel.org
Subject: [bug report] mmc: starfive: Add sdio/emmc driver support
Message-ID: <Y/xWiEW/npStWjTF@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello William Qiu,

The patch 9e622229bbf4: "mmc: starfive: Add sdio/emmc driver support"
from Feb 15, 2023, leads to the following Smatch static checker
warning:

	drivers/mmc/host/dw_mmc-starfive.c:77 dw_mci_starfive_execute_tuning()
	error: uninitialized symbol 'prev_err'.

drivers/mmc/host/dw_mmc-starfive.c
    47 static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
    48                                              u32 opcode)
    49 {
    50         static const int grade  = MAX_DELAY_CHAIN;
    51         struct dw_mci *host = slot->host;
    52         struct starfive_priv *priv = host->priv;
    53         int rise_point = -1, fall_point = -1;
    54         int err, prev_err;
    55         int i;
    56         bool found = 0;
    57         u32 regval;
    58 
    59         /*
    60          * Use grade as the max delay chain, and use the rise_point and
    61          * fall_point to ensure the best sampling point of a data input
    62          * signals.
    63          */
    64         for (i = 0; i < grade; i++) {
    65                 regval = i << priv->syscon_shift;
    66                 err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
    67                                                 priv->syscon_mask, regval);
    68                 if (err)
    69                         return err;
    70                 mci_writel(host, RINTSTS, ALL_INT_CLR);
    71 
    72                 err = mmc_send_tuning(slot->mmc, opcode, NULL);
    73                 if (!err)
    74                         found = 1;
    75 
    76                 if (i > 0) {
--> 77                         if (err && !prev_err)

prev_err was never initialized to zero.

    78                                 fall_point = i - 1;
    79                         if (!err && prev_err)
    80                                 rise_point = i;
    81                 }
    82 
    83                 if (rise_point != -1 && fall_point != -1)
    84                         goto tuning_out;
    85 
    86                 prev_err = err;
    87                 err = 0;
    88         }
    89 

regards,
dan carpenter
