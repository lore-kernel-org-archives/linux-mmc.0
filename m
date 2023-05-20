Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429BDC7EE29
	for <linux-mmc@archiver.kernel.org>; Sat, 20 May 2023 11:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjETLY6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 20 May 2023 07:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjETLY6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 20 May 2023 07:24:58 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159BAE49
        for <linux-mmc@vger.kernel.org>; Sat, 20 May 2023 04:24:56 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af2696fd1cso17457931fa.2
        for <linux-mmc@vger.kernel.org>; Sat, 20 May 2023 04:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684581894; x=1687173894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lrNs85kAq9XhckWf1UT0NKaqZUc8tJA22A6j/dwyNw=;
        b=lXwBsnALCk92bZuUepZPseNyV09F7cHI5BTJY8v6ERpBK85TmX/jDuRGAIrBAeCjj8
         vs8NvLrdyngI/HOLk5WYZ8wMthiO73TXB8qb2HcUdjJ+BGV9cBk+N9YYGZPwDXIeIQJX
         eauC1ksgtlms2EyXrgv0wGmqWS0B/E/x71IMVd48jtwxt8dFLS0QOztjN6lKsRtsi+5B
         +Tg0xJ9TAgbwWOnn/ZdaY/yjCBfRXNvNWAzhKGuebJwkn7MLdY0awf7Ria72I3X05ZN6
         9la3DGCPO23cNtqZlAQfh4u/vCsKGwqFRh+wMl+C3GjCxG1rSGj40IVSJqWUkxAEjovI
         h6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684581894; x=1687173894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lrNs85kAq9XhckWf1UT0NKaqZUc8tJA22A6j/dwyNw=;
        b=S2wZosLpBXkrXDlRHfbSM6s6hiLpaD4sgbngj/sIJC7uuEvK+tlTGNmnjaCVZz1bIW
         kMT5b2u9TGx/5j66dJ2iWj0NCcgZxTclOfheK/zwCHzDRNNfpwqghIpYfnWiF5yVnVfd
         jpIv/Vez+upuj8xY+yscFb3gcp1NxE/q+iQRTgux2sIqJtmOKvSLH+8TFXFdXk6Xk3tI
         EXULjDj+L7yZgBXVNg1TCQZ7zIrZ5USu1+gzUhlK2+CppWxyBlJ48mRtfb5osjnTNUr7
         H1dzEC/F01JJySk6OQB5UFaJpC123U1bKyKb97N/oz+K20vBnG7OVHU4N3PlTLGRb6sw
         BUpQ==
X-Gm-Message-State: AC+VfDyXcdgxZ0NMRwzXkdsgDY0VxjZykM+13Fc6E7NpUIG7RoyYgB2X
        ECkefuboXQOlKXlo5oCcGC7AWA==
X-Google-Smtp-Source: ACHHUZ5xAT9cKC2kVy+ZvHQ13nooWPvhxXZDUzKf7XNuFBm5q6et9yq3g6mTQoPEWTyjZyRYI8lX+Q==
X-Received: by 2002:a2e:7811:0:b0:2ac:85d7:342b with SMTP id t17-20020a2e7811000000b002ac85d7342bmr1861429ljc.29.1684581894318;
        Sat, 20 May 2023 04:24:54 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id u11-20020a2e9f0b000000b002a8ec99e0e0sm258638ljk.70.2023.05.20.04.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 May 2023 04:24:53 -0700 (PDT)
Message-ID: <ed4c33d3-ae5d-d695-eda0-0b09a4a26644@linaro.org>
Date:   Sat, 20 May 2023 13:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230519085122.15758-1-quic_kbajaj@quicinc.com>
 <20230519085122.15758-5-quic_kbajaj@quicinc.com>
 <8e3c745a-2e37-2927-7dbf-e23a777702f3@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <8e3c745a-2e37-2927-7dbf-e23a777702f3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 19.05.2023 12:13, Bhupesh Sharma wrote:
> 
> On 5/19/23 2:21 PM, Komal Bajaj wrote:
>> Add sdhci node for emmc in qdu1000-idp.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> index 9e9fd4b8023e..b2526e991548 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> @@ -451,3 +451,14 @@
>>   &uart7 {
>>       status = "okay";
>>   };
>> +
>> +&sdhc_1 {
>> +    status = "okay";
>> +
>> +    pinctrl-0 = <&sdc1_on_state>;
>> +    pinctrl-1 = <&sdc1_off_state>;
>> +    pinctrl-names = "default", "sleep";
>> +
>> +    vmmc-supply = <&vreg_l10a_2p95>;
>> +    vqmmc-supply = <&vreg_l7a_1p8>;
>> +};
> 
> Again, please follow alphabetical order for adding new node entries.
> 
> Also, we have been placing 'status = .. ' entry at the end for new .dts (or .dts entry), but if that is the format used across this board dts
> I am ok with the same.
Komal,

since you're already touching this file, would you mind making a
separate commit moving status last for all nodes?

Konrad
> 
> Thanks,
> Bhupesh
