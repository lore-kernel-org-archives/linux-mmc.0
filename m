Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE1C33CB1
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 13:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5A62073A
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 13:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3MkQlYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgAONCY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:02:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36255 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgAONCY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2020 08:02:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so15673826wru.3;
        Wed, 15 Jan 2020 05:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dd/fpZjUl0bvpdYK2/HoiWMjO/ltnHe3ct+x9nyIfFk=;
        b=p3MkQlYTQj+lULTBr6mWn5nKzLDUF5GJ9cat1feO+Q3nCwwmKt7aJRqL3jb8Xypk6t
         5K3Zyc5pjjBItrPOQkjZpSi+P+SBB6aY9ZSoI7Dkwuczv7HnBk9NKnzWO91rxXupd4A1
         ucnu3R3CAPXZQAGX0XU+Lt/U7EgARw1EwYbNZ8/cul9gYaEeW00ZQ5+lB3iIFdGO5wa8
         zg+4xaiTNx+kSKfvHbOTyQhwokkdI1VaCx0nGVZcC6v/EJ3+8Q6YoTiur4K5TW8vWdV3
         rHxz6NYn2z0u+1WamRmX0on1wJU/FN1ZzovgHY9f4qsArULVd2M/p6dKrDnfrgJFVjdD
         OKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dd/fpZjUl0bvpdYK2/HoiWMjO/ltnHe3ct+x9nyIfFk=;
        b=Qj+77oRXMMevL3Un4fornuls6pZkb7eTr3U47+jCbARTgnCziq7E01YplbXNs/1FrL
         tkC5z/dbnqcdxBJ55WSmkwg0sWAep4lPcyCBcJ1LaOrE35jNzVSEEngmitK0oiq/nv6Y
         QW8YVXxx8ixvlZVasPcwyBPpODqppdcKLHGCc0GWJpnTQ65tBeq4K24mI1QGRHZT6Fgy
         KuuPir0tq849TMfZO3GT8oPjqFIJcFzPmDH5w850LlhKMwAvrb9NlbbPJOSIFevN7FE9
         MVZmBchbEuPHZ5PgXa/3da9+Luf9Z1ZcCJDUxSjWELEs0ZbmB+z+OEygu2d/DpCG7FTb
         QMew==
X-Gm-Message-State: APjAAAU7npScLRJawNEYqU0Psjm2GMk2tFr9COrx62EmF2qTW2OZ4Ake
        dzb6ocvOiTLSiljcmq+Y7VY=
X-Google-Smtp-Source: APXvYqxcOwmlY+O6QGUZ/kxCeDj2gNn1kTWrnJRjeqw5YwD9D/edsH1lRUE34oPl6X1lmo7nvZDggA==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr30163062wrr.309.1579093342407;
        Wed, 15 Jan 2020 05:02:22 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p26sm22390808wmc.24.2020.01.15.05.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 05:02:21 -0800 (PST)
Subject: Re: [RFC PATCH v1 1/3] dt-bindings: mmc: combine common mmc and
 dw-mshc properties
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <20200114213809.27166-1-jbx6244@gmail.com>
 <CAL_Jsq+8X0oRykiQOKVyaxis4H0yO=nzUtnFF_BXdwBkuigr7g@mail.gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <12bbbdbc-027e-90de-fd57-291013167b06@gmail.com>
Date:   Wed, 15 Jan 2020 14:02:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+8X0oRykiQOKVyaxis4H0yO=nzUtnFF_BXdwBkuigr7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Thank you for your explanation.
I was not aware that was playing.
So now we go from a 'simple' txt to yaml conversion to a complete
'change your node name first' operation.
Can you indicate if that common yaml file for dw-mshc and Rockchip
is still a good idea?

Thanks


On 1/14/20 11:06 PM, Rob Herring wrote:
> On Tue, Jan 14, 2020 at 3:38 PM Johan Jonker <jbx6244@gmail.com> wrote:
>>
>> Combine the common properties for mmc and dw-mshc in
>> mmc-controller-common.yaml
>
> Commit messages should explain the why, not what.
>
> AFAICT, the only reason is to not have a node name of 'mmc'. That's
> entirely the reason why it is defined. Fix your node names to use the
> standard name.
>
>
>
> Rob
>
