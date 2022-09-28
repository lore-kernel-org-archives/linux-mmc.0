Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3100DC6FA82
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Sep 2022 18:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiI1Shi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Sep 2022 14:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiI1Shi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2022 14:37:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1903120F;
        Wed, 28 Sep 2022 11:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6264B821B8;
        Wed, 28 Sep 2022 18:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22B4C433C1;
        Wed, 28 Sep 2022 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664390254;
        bh=wL7UOH3S4eqsJ4E3R2ab95HnIC13RJOkkXx3Tmcyk7c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cyewp5yDiE78tp+ep8wc1+7z0jmW/4GgKUDtZeoiVB3JIKO79gGUfSF9HlDKJounK
         c3teRlo7MwxrXa7CgTS+Kml3BhNq9M/dYukJQOQYvrOVD7MYclfTa+UfIWGmGqHqMR
         2lj3Hen2iJvOqfKFb/43/A4l6TKzCx/aX8MLwxzBA2Eh9A+MIvqCpDmf1kTQXUE/A9
         qiMihaDiSCYYhU23ZVyEtoLv0wX5geEZ/7Dg9hpYuB1TRHAsSQEZbhEESVGBppje+m
         FvVm63qF0j/prPlYGZdCuWD8FwdNxRNqiupfHoq640OTXTxC05ARgBQvJX8h3H+nj2
         NRQi4Epe7LQ6g==
Message-ID: <02967018-8a04-bd82-49e6-1ee475916ebb@kernel.org>
Date:   Wed, 28 Sep 2022 13:37:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220928165420.1212284-1-dinguyen@kernel.org>
 <ef396764-af53-8e5a-5203-f3e103bbb7a3@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <ef396764-af53-8e5a-5203-f3e103bbb7a3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 9/28/22 12:15, Krzysztof Kozlowski wrote:
> On 28/09/2022 18:54, Dinh Nguyen wrote:
>> Document the optional "altr,sysmgr-syscon" binding that is used to
>> access the System Manager register that controls the SDMMC clock
>> phase.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +
>> +allOf:
>> +  - $ref: "synopsys-dw-mshc-common.yaml#"
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const:
>> +              - altr,socfpga-dw-mshc
> 
> It still should not be an array, even if there is no warning.
> 

I apologize, but I'm confused with the message. Do you mean it should 
not be a "const"?

Dinh
