Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7482FC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 18:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiK3Sjh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiK3Sjc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 13:39:32 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF44294929
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 10:39:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o12so8641129pjo.4
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 10:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94a/10FNMRBp1pJUiEwB1lJ+61t4949X29jZ2H2E1CU=;
        b=GpvhglE5FGqgVk1yHbclrlcYWDyr1kHuAzyu54V+9t56KHi8r9hxOHs57nLgNN0qKY
         VsjGINV86vXFtLCTFgvi1wTnNRnJ1CkVd/OL9vZCD3MmNd6dsAJGTWuwSxUTZIOzjTRi
         mOe0J54OPc7gb3KCqz0qreQeylpURMe+oWs+/f1WkJ+ghTGM8C0fZpM0ctP3qsCzsf1u
         jXhdTefDPE2O4jAaOgtBsOXJN4tk6SZtuUbtSwf8yXrtg2edloczfKjY8mqj9ywCIphQ
         1dgIwsQJi1DUJ5ASQkGV0Xj1blZ68yDxuMaV8gUOvHEwQ9qphjo6VrSlUufzTNot2e6e
         hlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94a/10FNMRBp1pJUiEwB1lJ+61t4949X29jZ2H2E1CU=;
        b=WF574/rm5nFGwXVP8DTDD+yAJOmRJ0w6i3WH6Tn79lR2AC/ZMx91hMGDYx2x8+G6Mf
         5g1I5lguuhpPNNj48rBWP2byAgZU6kwn1ENIO+CK5RBK6op568q1WrsfU0gmlANFg9+x
         +rmDj27hM3+Fqrg/chY0Zo3qeTa+9NjCt2s69CXBsubOh+kbtYWVlZTubD2ZjTMKxyz7
         BnvDl1od/H7DziSw8LeCjjlKv0iQT38e1+HwxXh3epHXIr/l1tQzBfMmtnCxzRR6GT5i
         z1ZyPJC6Fnlg9XF5cC1YEl0I6q2tSCUr0W1nD2tsMgiTugAJw0cQnKAIdWtAfG/pFCNS
         xq4w==
X-Gm-Message-State: ANoB5pnyi5/ZK1YDi7iLlzU4kWfK9fokolKY0HaavCCHAdHdZflhJwnu
        JN+7fJpTEwH4EiGAl5LjoBE=
X-Google-Smtp-Source: AA0mqf4i17iaPmzdwKq2drHYqiTTHmPpgGdHDanGwGjP1XiwqUdvIOGWoDHor+FMA5orNePTfdVnUg==
X-Received: by 2002:a17:902:b416:b0:187:3157:a0ee with SMTP id x22-20020a170902b41600b001873157a0eemr49344483plr.146.1669833570125;
        Wed, 30 Nov 2022 10:39:30 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e9-20020aa79809000000b0057507bbd704sm1725886pfl.5.2022.11.30.10.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 10:39:29 -0800 (PST)
Message-ID: <962458b5-c891-e552-5469-1dbb650a0f3c@gmail.com>
Date:   Wed, 30 Nov 2022 10:39:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 2/4] mmc: sdhci: Avoid unnecessary re-configuration
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Chevron Li <chevron.li@bayhubtech.com>,
        linux-mmc@vger.kernel.org
References: <20221128133259.38305-1-adrian.hunter@intel.com>
 <20221128133259.38305-3-adrian.hunter@intel.com>
 <b040b2b2-10c2-5414-1c8f-fd02fc3b300e@gmail.com>
 <1acb9b87-088c-06f8-a2de-63b3054c55bc@intel.com>
 <CAOX2RU54TPBowXdbJMc-x+eO8XhKjREn9R0zwv9thya3kyCP-g@mail.gmail.com>
 <26ad873f-b673-3ea0-3039-f61d69939c6f@intel.com>
 <CAOX2RU4UQ_xOor3sPBP+fg48EGsCmbw03Dcc0oU5VDDV=7+yzg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAOX2RU4UQ_xOor3sPBP+fg48EGsCmbw03Dcc0oU5VDDV=7+yzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/30/22 09:24, Robert Marko wrote:
> On Wed, 30 Nov 2022 at 15:16, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 30/11/22 15:00, Robert Marko wrote:
>>> On Wed, 30 Nov 2022 at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 30/11/22 13:54, Robert Marko wrote:
>>>>>
>>>>> On 28. 11. 2022. 14:32, Adrian Hunter wrote:
>>>>>> Avoid re-configuring UHS and preset settings when the settings have not
>>>>>> changed, irrespective of whether the clock is turning on.
>>>>>>
>>>>>> Tested-by: Haibo Chen <haibo.chen@nxp.com>
>>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>>
>>>>> Hi, this is breaking sdhci-msm on IPQ8074 in next-20221130 for me
>>>>> and reverting it makes the eMMC work again.
>>>>>
>>>>> I get a lot of:
>>>>>
>>>>> [    2.727287] mmc0: tuning execution failed: -5
>>>>> [    2.727323] mmc0: error -5 whilst initialising MMC card
>>>>> [    3.846540] mmc0: tuning execution failed: -5
>>>>> [    3.846564] mmc0: error -5 whilst initialising MMC card
>>>>> [    4.966517] mmc0: tuning execution failed: -5
>>>>> [    4.966539] mmc0: error -5 whilst initialising MMC card
>>>>> [    6.096486] mmc0: tuning execution failed: -5
>>>>> [    6.096508] mmc0: error -5 whilst initialising MMC card
>>>>> [    7.206431] mmc0: tuning execution failed: -5
>>>>> [    7.206454] mmc0: error -5 whilst initialising MMC card
>>>>
>>>> Thanks for the report!  Are you able to debug this any more?
>>>> What transfer mode is it? e.g. HS400?  Can you enable debug
>>>> messages and get more information?
>>>
>>> With some guidance yes, it's in HS200 as there is an issue with HS400
>>> to HS200 switch on this SoC so I have HS400 disabled.
>>>
>>> With CONFIG_MMC_DEBUG and loglevel=8 I dont have any new
>>> messages.
>>
>> You should get a lot more with:
>>
>> CONFIG_DYNAMIC_DEBUG=y
>>
>> and kernel commandline option:
>>
>> dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"
> 
> Unfortunatelly not:

Are you sure you have debug messages enabled with your current console 
loglevel? Might want to add "debug" at the end of your kernel command 
line and try again.
-- 
Florian

