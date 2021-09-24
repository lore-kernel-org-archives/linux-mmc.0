Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45365C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 09:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F9A9603E9
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 09:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244623AbhIXJSk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 05:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244462AbhIXJSk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2021 05:18:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C8EC061574;
        Fri, 24 Sep 2021 02:17:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t7so25174229wrw.13;
        Fri, 24 Sep 2021 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KmHJWAfs9pjed5mRaYoAGE9AN2TP/56P8NVpQ0/fMVg=;
        b=QgVOGerfe2rJpKOqgpTTsb2dQxu7nwmEUppkBfdvLl7CgWRvpapJZiaBrblorwInO/
         ovQ3g5sxuGHKvRv4c/F233/lfxxygwva8yxyhC1wOrJB0QOgCK7sOYaj2dOTJCroOnS6
         fpUFhdM6PUAI4j8j5Dq1hpwLBchO6xnIPXOATuUYiTSD+1VzROVeKitxLFVzaR2gDnm5
         eJz8HJTebnTPEsL8bID5F+pclIDgQ1mbM1nACLG071flLIUHVoj3JtHfjsuT7107HoDw
         fDHvp95OfC+sixakJKiBJ1kE0QTaXY4FauYQl3fBjl0JCf3hdqlktjRW9TQNUJ19Ck36
         ZEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KmHJWAfs9pjed5mRaYoAGE9AN2TP/56P8NVpQ0/fMVg=;
        b=g8iM8u7qeL37b6TW+sD4MJXTZFWB179tf0XPnDxwxewrCae9lpNWEHcRWHKT3Sr3/F
         ICeh/tAWRgvH7xNQ4C/+Xjhrs2B5HSrkoddI2qN833eF2T49laP3Yt64UlBD3Z3gn7Zf
         YyJ+tTiPrKk+3MfrYDMRf+Ig51cOoeB1wm4XXPdP3+tsluA1/1vtjgZplH+LMUPrIqxf
         luBRPjCyRc69B4U3hpHlb0G9Y8+6Pmo/a66qD+ZMvF5gePx8Me5qDPpXwK/1V212LwR4
         fE1gnKiXfGbxgJZYtbPRdQ8cp/qaaL/WttNtMG/mF9NuSBlnPXdCQiyFQM0qhbBrb3Qu
         w9XA==
X-Gm-Message-State: AOAM533CtLdN0do0rSFNBIVUz7asTZ4gWFclNY9AqvQ9ZxdZUCIi+AIe
        nptG40mNSk8iY85YHQdH92s=
X-Google-Smtp-Source: ABdhPJxG3ibjirvmMpd1Hf0QkJm63b7qA2fp0KKkO5LWFs5GiBkGS+/LxijE0526PlkLQn5jWgcd4A==
X-Received: by 2002:adf:f208:: with SMTP id p8mr10086633wro.379.1632475026082;
        Fri, 24 Sep 2021 02:17:06 -0700 (PDT)
Received: from p200300e94717cfc52fe6da3ec1ed0822.dip0.t-ipconnect.de (p200300e94717cfc52fe6da3ec1ed0822.dip0.t-ipconnect.de. [2003:e9:4717:cfc5:2fe6:da3e:c1ed:822])
        by smtp.googlemail.com with ESMTPSA id x5sm9596511wmk.32.2021.09.24.02.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 02:17:05 -0700 (PDT)
Message-ID: <beda2d5ecc3c15e9bf9aa18383c22c2a90d31dab.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci: Use the SW timer when the HW timer
 cannot meet the timeout value required by the device
From:   Bean Huo <huobean@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 11:17:05 +0200
In-Reply-To: <fc14d8e1-9438-d4b0-80f4-ccf9055ab7d3@intel.com>
References: <20210917172727.26834-1-huobean@gmail.com>
         <20210917172727.26834-3-huobean@gmail.com>
         <fc14d8e1-9438-d4b0-80f4-ccf9055ab7d3@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2021-09-24 at 08:29 +0300, Adrian Hunter wrote:
> > If the data transmission timeout value required by the device
> > exceeds
> > the maximum timeout value of the host HW timer, we still use the HW
> > timer with the maximum timeout value of the HW timer. This setting
> > is
> > suitable for most R/W situations. But sometimes, the device will
> > complete
> > the R/W task within its required timeout value (greater than the HW
> > timer).
> > In this case, the HW timer for data transmission will time out.
> > Currently, in this condition, we  disable the HW timer and use the
> > SW
> > timer only when the SDHCI_QUIRK2_DISABLE_HW_TIMEOUT quirk is set by
> > the
> > host driver. The patch is to remove this if statement restriction
> > and
> > allow data transmission to use the SW timer when the hardware timer
> > cannot
> > meet the required timeout value.
> 
> 
> The reason it is a quirk is because it does not work for all
> hardware.
> 
> For some controllers the timeout cannot really be disabled, only the
> 
> interrupt is disabled, and then the controller never indicates
> completion
> 
> if the timeout is exceeded.

Hi Adrian,
Thanks for your review.

Yes, you are right. But this quirk prevents disabling the hardware timeoutIRQ. The purpose of this patch is to disable the hardware timeout IRQ and
select the software timeout.

void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command
*cmd)
{
        bool too_big = false;
        u8 count = sdhci_calc_timeout(host, cmd, &too_big);

        if (too_big) {
                sdhci_calc_sw_timeout(host, cmd);
                sdhci_set_data_timeout_irq(host, false); // disable IRQ
        } else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
                sdhci_set_data_timeout_irq(host, true);
        }

        sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
}


The driver has detected that the hardware timer cannot meet the timeout
requirements of the device, but we still use the hardware timer, which will
allow potential timeout issuea . Rather than allowing a potential
problem to exist, why can’t software timing be used to avoid this
problem?


Kind regards,
Bean

