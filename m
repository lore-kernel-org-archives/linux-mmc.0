Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59955C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 14:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7E420825
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 14:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ZzMSRq86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgESOAI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 10:00:08 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:21404 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728725AbgESOAI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 10:00:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589896808; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=eLQlBtr65E965ED8VgWttrf28Jic4su3n2v7Vzwtums=;
 b=ZzMSRq86aohTemx2kar/sGuntJ4QGS6/wehfr5ijCCQlwaao2L9TQhVHMbhB1Sd57B9aNRny
 LyJw+McqJ6D6yfrf8NJ/wtiFprA84BaHOehv9BKpAprtAv8mV7WbsJWKDxoCMPshMN0wESqE
 JHbfbsDaRRJLAwyPISMvpf2FOTA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ec3e662a2156719d9057573 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 May 2020 14:00:02
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D5BCCC433D2; Tue, 19 May 2020 14:00:01 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sartgarg)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D651C433F2;
        Tue, 19 May 2020 14:00:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 May 2020 19:30:01 +0530
From:   sartgarg@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        vbadigan@codeaurora.org, stummala@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-mmc-owner@vger.kernel.org
Subject: Re: [PATCH V1 1/7] dt-bindings: mmc: Add information for DLL register
 properties
In-Reply-To: <20200515025047.GA27895@bogus>
References: <1588838535-6050-1-git-send-email-sartgarg@codeaurora.org>
 <1588838535-6050-2-git-send-email-sartgarg@codeaurora.org>
 <20200515025047.GA27895@bogus>
Message-ID: <754eb06777c76dcfaedf42083ad13bb5@codeaurora.org>
X-Sender: sartgarg@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2020-05-15 08:20, Rob Herring wrote:
> On Thu, May 07, 2020 at 01:32:08PM +0530, Sarthak Garg wrote:
>> Add information regarding DLL register properties for getting target
>> specific configurations. These DLL register settings may vary from
>> target to target.
>> 
>> Also new compatible string value for sm8250 target.
>> 
>> Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 14 
>> ++++++++++++++
>>  1 file changed, 14 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt 
>> b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 5445931..b8e1d2b 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -17,6 +17,7 @@ Required properties:
>>  		"qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
>>  		"qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
>>  		"qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
>> +		"qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
>>  		"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
>>  		"qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
>>  		"qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
>> @@ -46,6 +47,13 @@ Required properties:
>>  	"cal"	- reference clock for RCLK delay calibration (optional)
>>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
>> 
>> +- qcom,ddr-config: Certain chipsets and platforms require particular 
>> settings
>> +	for the DDR_CONFIG register. Use this field to specify the register
>> +	value as per the Hardware Programming Guide.
>> +
>> +- qcom,dll-config: Chipset and Platform specific value. Use this 
>> field to
>> +	specify the DLL_CONFIG register value as per Hardware Programming 
>> Guide.
> 
> Board specific or SoC specific? If the latter, imply this from the
> compatible string.

Reposting again as can't find my comment on the 
https://patchwork.kernel.org/ page.
Whatever DLL settings are SOC specific are being taken care with the 
compatible string.
That is the reason we introduced qcom,sm8250-sdhci string.
The above listed two configuration can change from board to board 
as-well.
