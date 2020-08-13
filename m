Return-Path: <SRS0=OPc0=BX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F20CC433E1
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Aug 2020 13:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B79920774
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Aug 2020 13:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agccP1KP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHMNy6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMNy6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Aug 2020 09:54:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E4EC061757;
        Thu, 13 Aug 2020 06:54:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a5so5368624wrm.6;
        Thu, 13 Aug 2020 06:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sf/SftiD46KRmjklcq1t9/LS42BB5ZSQCo3saQVqHK4=;
        b=agccP1KPb72z/gkb04zLo4qeG+xd1UJrYMzK6+6w2B5gLm7docgWCP89TW72fBpoDC
         gK3gYReadqOvxeO3T3OBj/myfHOMgMIXdtASuHjb+Mo8O81lOlagy1/PmU1qOF52zfjk
         zQgRoDH8U9pV24TmfiDp1egqvLvJRcU9M1NOM0MBFNh+uuh75gvtvbV4X9DCFQCPc8hI
         6rupc6mD5ELdrBa9CKbNWdrjC5wMPQXnLkH4lUH6vw3WoITYNcI+/7JvJYML5FXe5U4b
         ak5dCSGmE3XPBAyu25fDau+VFmXGAXBLylk/PE17rShq8CfrErx4lRoDYwVDOweHf7kd
         lHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sf/SftiD46KRmjklcq1t9/LS42BB5ZSQCo3saQVqHK4=;
        b=GR3VvZ6i1d6wUNpKqivzk/cwcJRFRGvWqT1O86+M0BUmLyvuGMMKeiq5UQ99+0+53k
         i4O4OtCzKLB/TgRsPwE2TTNP0LEL9e+h9RS91O4XhE53F8xay9jb8R6XBp3JTPtXIvxL
         aMpVLgaZ2cdP7mQMTL/8HcysLhA41IRVi4jpz1Weoxn+eroZ8+/3gfJvi6mrWO7a9hCw
         oAYh2WevVAWYtCcyKcTh81ARef5EFhMYvF8v3BJ8Ynl5YaCr+BTunSQoq6bVJmqxIq9n
         +K9t+ZcPNsxcSDNpMzSyiTQAbfIpe1dJgckrvpJzsWPJX+B6sLJyMf/MBuxNm7i16Tq8
         LpBA==
X-Gm-Message-State: AOAM5331GCq0qX33tKv/V2w0E/79QLWd8TTE7yZC4XqrxGM7R1ipsTRr
        wVx65u1H7x/weg8pWSeIK+g=
X-Google-Smtp-Source: ABdhPJyMDNz+ijdz996HXAu4epKQmW0kjeI+dQKGPU5iYnfmtaSci40eu1LwseA1AoxXvZNnOWVDuA==
X-Received: by 2002:adf:e504:: with SMTP id j4mr4292799wrm.205.1597326893217;
        Thu, 13 Aug 2020 06:54:53 -0700 (PDT)
Received: from ziggy.stardust ([213.195.117.232])
        by smtp.gmail.com with ESMTPSA id z8sm9339432wmf.42.2020.08.13.06.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 06:54:52 -0700 (PDT)
Subject: Re: [v4,0/3] mmc: mediatek: add optional reset property mmc:
 mediatek: add optional module reset property arm64: dts: mt7622: add reset
 node for mmc device Documentation/devicetree/bindings/mmc/mtk-sd.txt | 2 ++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 ++ drivers/mmc/host/mtk-sd.c |
 13 +++++++++++++ 3 files changed, 17 insertions(+)
To:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
References: <20200813090618.28009-1-wenbin.mei@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <195c7bfc-38e4-8d5e-af79-cc3f00b552a4@gmail.com>
Date:   Thu, 13 Aug 2020 15:54:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813090618.28009-1-wenbin.mei@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It would be good to provide a list of the changes, so that one can easily 
understand what's the difference between v3 and v4. On a quick glimpse I didn't 
see any changes.

Regards,
Matthias

On 13/08/2020 11:06, Wenbin Mei wrote:
> --
> 2.18.0
> 
