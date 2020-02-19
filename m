Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B97C34031
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 03:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA56122B48
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 03:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582081349;
	bh=6J4gvmOrNVM4xpdjbyq9vV77jRckHXg7aBDMpUrixmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FtQerYhlPjNQvD8lWvEy1dmBAqRJ9o5GDMpeWWkUoVjySJ1Sw63cnpCLZkKm6SQuJ
	 HDshxi/NRq3V57jJF5cJ6uI1/+JN6I2BWQsIwwkEjHiXG7CN2yeUACrSlJGMfT4/Fx
	 UYFzqpRHV2CDJjURxyjaovPRkBQQAupELKv8uuFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgBSDC3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:02:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38938 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgBSDC3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2020 22:02:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so21716155oty.6;
        Tue, 18 Feb 2020 19:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wM36jiU/uEy31IzeR1mb5iKzvzrpChL40oT2SOGRUi0=;
        b=qzskkf1RXfl7KmjISWu0PLlSrs2kIyEPEHbiHpF3eLRENVEvhyfxeKgDBWx1ZUvbYz
         Shve/mgNLvkGEEdMsIJE4fjgQewaSooGPXqmyalV7CXRgOhEWyFmdEktaoTF2/aM1uuY
         uVpRcFCobrVdaGfdQMJkbXzL60byL5G5P2f16HvzvnSNvnSAn3vbzLrtp65cSUDMFItl
         FS4AbYXl8FqbeFqzVctYyfcXgGb9OeN0Psb1vQXn+2EVPh5JNM44CZGtu5EvK4SHY/bh
         TFuS6wr3EFy+GPdbcAI1c84Yowb7TTx9JkeYNrilXlA2hixBUh2KgaKIkmpQXRjA2LFT
         GXKw==
X-Gm-Message-State: APjAAAVhCqStcEPGrJftglz/4k16poa2JDve43k6ufUc+Ls/lV1193Vv
        qdzco7FDRk06NQvbYKPVVQ==
X-Google-Smtp-Source: APXvYqyK+6EWyXhC3a/7xDZK0yFV9OL48vn100QsFjIeQ8ddy37zTQgKDMZU5KOrzSI/ZG374IuWig==
X-Received: by 2002:a9d:4c8e:: with SMTP id m14mr17131477otf.245.1582081348149;
        Tue, 18 Feb 2020 19:02:28 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b15sm199703otl.60.2020.02.18.19.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 19:02:27 -0800 (PST)
Received: (nullmailer pid 14862 invoked by uid 1000);
        Wed, 19 Feb 2020 03:02:25 -0000
Date:   Tue, 18 Feb 2020 21:02:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>
Subject: Re: [PATCH v3 4/4] dt-bindings: mmc: mediatek: Add document for
 mt6779
Message-ID: <20200219030225.GA14824@bogus>
References: <1581922564-24914-1-git-send-email-chun-hung.wu@mediatek.com>
 <1581922564-24914-5-git-send-email-chun-hung.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581922564-24914-5-git-send-email-chun-hung.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 17 Feb 2020 14:56:04 +0800, Chun-Hung Wu wrote:
> Add compatible node for mt6779 mmc
> 
> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
