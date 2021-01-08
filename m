Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5192C433DB
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Jan 2021 21:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C70223A9B
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Jan 2021 21:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbhAHV2H (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Jan 2021 16:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbhAHV2G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jan 2021 16:28:06 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AD1C061757;
        Fri,  8 Jan 2021 13:27:26 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 30so8441168pgr.6;
        Fri, 08 Jan 2021 13:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V8393qx4scJU4faH8ig8dx2vCEhaz8WiAL5SDT2jmW0=;
        b=thlILBumuvYo8e1Zzbd2G1tBIBvj+h1i+wn8IGjDZxkbfMYqv1YLnQOBkpFQiYuQiC
         PmMsJaFtUrNns959uPj1V1OzR7vcKe1nOb1UuMQK75k+dGKnSWkDKT7MrOaZ1Z3DfDa3
         9Ae7QmcIBy0/8bBeay5Ekvwj3ax1gSNNZdtvp69sZAljJZi1SKKiC0E4vOlI+nNhYsH2
         LSF1VqIAq4ZZt1q/gdMr610qyOK2NeOugvG0Wfg6m/R+XSdYpnzxTC5ihbgtPGb+IybE
         +r3wrpE3VtsteTgOF/jN9rWnLWn6zGaXXOOt3ZQXSVKyxoPWOFn5lIJCjtMoFQHNbQCJ
         uSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V8393qx4scJU4faH8ig8dx2vCEhaz8WiAL5SDT2jmW0=;
        b=Il6QxR8PlPYiyinySYskc/I6weYXzC0H3qFkyixt7l7VOJN/tPJyhAuZ1Z+ghAg5HW
         fzwA1a8MMyduJp837KfQxvLB8SxBMEpC425IDNh648kcNQO2QlcApIME4G42Q80Fy06d
         EN+VgongxxGuinKqIXucjOaROA+VQSKoj0ifz8h6IPWJoX4/Cb0mSIwi60/o9uXjdcoI
         pPlysxxZ6AlmUMtwTYr6E8N1EdjCcYGasY+dbGWu2SqyOksI/M3pSExZPNaei5goD1Hu
         c942EDr4Tbi8Sz2ucPOWV9SbCyh+V9P5rpyxqq3aOXfhfjgRNxOejCjy0x6hlAdP4kUY
         w00A==
X-Gm-Message-State: AOAM533MWAMTRP01kMi2HtQboDk35wuEzcVs2yT3VCp3GiUg4R81ZZac
        gVAKQOV75rXICipRU/Zc/eE=
X-Google-Smtp-Source: ABdhPJzSSVXsFl5yhs8r2lf7VXdpaDqZMvNMVbVEPjgKDwVOC6JrNKm/g/s/fRWx5sfSjxW1Cj57zg==
X-Received: by 2002:a05:6a00:885:b029:19b:9057:16f with SMTP id q5-20020a056a000885b029019b9057016fmr5424462pfj.80.1610141246104;
        Fri, 08 Jan 2021 13:27:26 -0800 (PST)
Received: from [10.230.29.29] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a23sm5796838pju.31.2021.01.08.13.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 13:27:24 -0800 (PST)
Subject: Re: [PATCH] mmc: sdhci-iproc: Add ACPI bindings for the rpi4
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-mmc@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, sbranden@broadcom.com,
        rjui@broadcom.com, ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com
References: <20210108211339.1724769-1-jeremy.linton@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1d4a4c55-59dc-b81d-3e92-7cdc036b789c@gmail.com>
Date:   Fri, 8 Jan 2021 13:27:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108211339.1724769-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 1/8/2021 1:13 PM, Jeremy Linton wrote:
> The rpi4 has a Arasan controller it carries over
> from the rpi3, and a newer eMMC2 controller.
> Because of a couple "quirks" it seems wiser to bind
> these controllers to the same driver that DT is using
> on this platform rather than the generic sdhci_acpi
> driver with PNP0D40.
> 
> So, we use BCM2847 for the older Arasan and BRCME88C
> for the newer eMMC2.
> 
> With this change linux is capable of utilizing the
> SD card slot, and the wifi on this platform
> with linux.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

As far as ACPI ID's go:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
