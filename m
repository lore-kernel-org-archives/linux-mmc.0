Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD3BC00A5A
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Jan 2023 03:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjARDUr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Jan 2023 22:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjARDUq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2023 22:20:46 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DDD5140F
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jan 2023 19:20:45 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7FCFF84D64;
        Wed, 18 Jan 2023 04:20:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1674012043;
        bh=bAJ7njRKpzGLJCFz/dYZmQXI9tf09SAg8UAaVxxUvuU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hS5CO3f26QrKC9lm0GmpRj/4DS3D1rasduIf+aXRlnAAnbN4CjpiUseqbEBIFFxxx
         R1Vt6s6DGUGJAEFUglyxiAK1s5DKve4G4Ja2eifxvlhHeo8Uc2RU7s5T/+KsKXitxn
         ChSOWmCy9dzZL1TZHdIzLl+WvwsMF1ikhMVZjksZBpWf3VA5vq8OusaUMyZ53v6vXF
         LuCiKK1UgVCU4zr2ewivI4KeB3qjmk6Uyvf/bj6emOVotZbylF2n/CnVUtLKFLFdvI
         LtOdFo0o+Bar+hcKvbUg4B5p9vLzNZTcUi4EoJcl0p5GVDdBsEbYhIKgrHDLjCyp8Q
         tco+Gv1JEEn+g==
Message-ID: <17bbb55d-557e-28bb-77d8-1a4f0eeaffd4@denx.de>
Date:   Wed, 18 Jan 2023 04:20:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mmc: sdhci: Always apply sdhci-caps-mask and sdhci-caps
 to caps
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc:     Bough Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zach Brown <zach.brown@ni.com>
References: <20230105144628.223420-1-marex@denx.de>
 <967beb8d-93f0-55ca-8b6b-f3be96a96c6c@intel.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <967beb8d-93f0-55ca-8b6b-f3be96a96c6c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/13/23 12:32, Adrian Hunter wrote:
> On 5/01/23 16:46, Marek Vasut wrote:
>> The original implementation in the commit referenced below only modifies
>> caps in case no caps are passed to sdhci_read_caps() via parameter, this
>> does not seem correct. Always modify the caps according to the properties
>> from DT.
>>
>> While at it, drop the always NULL caps and caps1 function parameters.
> 
> Please re-base on top of:
> 
> https://lore.kernel.org/linux-mmc/20230113110011.129835-1-adrian.hunter@intel.com/T/#t

Rebase on top of that series means I can just discard this entire patch, 
so done.
