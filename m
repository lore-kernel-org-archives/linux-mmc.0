Return-Path: <SRS0=ySr4=3G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDB9C33CB1
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 15:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211EA2083E
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 15:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyT8LCxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgAQPlr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:41:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37807 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgAQPlr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2020 10:41:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so18686567lfc.4;
        Fri, 17 Jan 2020 07:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bjNAA894HypFtC+HqN0qFxQlTwc+VZ8apApQMaLAIM8=;
        b=fyT8LCxkLnDZzaRXL1FmS0gRdRQpqouUhY/8iZqYs8NJ0fwyMg97gTLA29QJrI1bD3
         u8NYbJ3cdbTm3Ol4rrqWRJYXwJ7BX3uMwm1PG8CgNFbNKfP1KR7ezlF5Oher/KkxSvw+
         uXeLLt/vmEkHkCVh+eGVjLPFOLNWdLjvP7DAb6uLc6rOjCV/DI4yaJWwZwLsnOyxnonv
         FpQsLlgrzF8UvCFTjubvRKWkp3wciw6pQn+SH9hM/vhHr67dP0+gMIJUEvSrAvnEycqf
         7Ch6yihGRPRp3t/1OvbfUZmKkkamN7AHClDkRhLLpEYveqBGThd0lgy9dlHN3WT0tm0C
         jS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bjNAA894HypFtC+HqN0qFxQlTwc+VZ8apApQMaLAIM8=;
        b=L9a2iNIjV3Wi46HqRLJlDm+w00++CqEx68EQ89lqWUSMW2ZUIXZRlf7HAZQyD+wLfj
         /QX8TrHb58DAhvi40p3xeZjsd5wecrlVeKZFgMolGPZRFUmwZegHJD8opOQBNsD5d9ko
         vyU/FC2vCeRZlwo+dUxplX8WWSBSiy3yS7RjsaurTgI1x5OJfIrfaFyVTpraE6CjFu6x
         Yhh6RkHtiJPAIpUW/k5WXcZL46vZKuzEUT1VAKEzZBcdh34CZx0SRtwuDKZ65Rp5cs7l
         EK9iN6xQpwCGxFsE+n1VMYDWJUAq/Gqyc+wkdXcSZlOLSy3vJ5CG9uBEwgh0dOrhT8RP
         S7Zg==
X-Gm-Message-State: APjAAAWY8P4mN108bMrWNRaqP9+SsVSL01UrKFzPV/oKPYa9mEsi/83o
        egQFCdEM+bt75HfnYnOqalvrwtUh
X-Google-Smtp-Source: APXvYqy+HXGhOEViyKTkzAPTLJYK9Ofk4wOAPuLAwk+GkTb5KOspMGKqeRlVT1s5/xAgtU2Nl1f0fQ==
X-Received: by 2002:ac2:42ca:: with SMTP id n10mr3296793lfl.215.1579275704224;
        Fri, 17 Jan 2020 07:41:44 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id y11sm14244102lfc.27.2020.01.17.07.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 07:41:43 -0800 (PST)
Subject: Re: [PATCH v3] mmc: tegra: fix SDR50 tuning override
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lucas Stach <dev@lynxeye.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9aff1d859935e59edd81e4939e40d6c55e0b55f6.1578390388.git.mirq-linux@rere.qmqm.pl>
 <CAPDyKFqXmbnH_NWZZTHHCE+Lt-f3JHAhJ8-=aoKNEPyQed44YA@mail.gmail.com>
 <20200117141145.GD26135@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dbac86b6-a0b7-cf55-645a-ff0f39b7ae55@gmail.com>
Date:   Fri, 17 Jan 2020 18:41:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200117141145.GD26135@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

17.01.2020 17:11, Michał Mirosław пишет:
> On Thu, Jan 16, 2020 at 03:39:54PM +0100, Ulf Hansson wrote:
>> On Tue, 7 Jan 2020 at 10:47, Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:
>>>
>>> Commit 7ad2ed1dfcbe inadvertently mixed up a quirk flag's name and
>>> broke SDR50 tuning override. Use correct NVQUIRK_ name.
>>>
>>> Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
>>> Cc: <stable@vger.kernel.org> # 4f6aa3264af4: mmc: tegra: Only advertise UHS modes if IO regulator is present
>>
>> I am dropping this tag, simply because I don't understand what it should tell.
> 
> It tells the maintainer that he needs to cherry-pick this commit if
> its not in particular stable version already. I guess this is only
> for v4.4, as v4.9+ already have it, and v3.16 does not include the
> Fixed commit.

I guess it could be: Cc: <stable@vger.kernel.org> # v4.4+

And then you could email Greg KH or Sasha Levin, asking to pick up the
additional commit to the stable kernel, or they will ask you by
themselves about why the patch isn't applying and how to handle it.
