Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A978C05052
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Jul 2023 12:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjG0M2c (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Jul 2023 08:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbjG0M14 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jul 2023 08:27:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB79230E9
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jul 2023 05:27:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe0bb9500aso1570217e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jul 2023 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690460831; x=1691065631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbBc/Xp5vDhN57+nyWdnfZit+Hhf7+7jO6GicfM9MZY=;
        b=SKk5HURndFjmfQs/6/dI4mSdYP1Ma7B9aBTIJFoRTdIBlRIMcmuDR5FNLHh5k+HNkk
         PjvB2BConz/Mr/IDFLR/wHDEioT9km4Gbh/B+VVp1M6kNhqChbihwJ0QsDAwOOppOJp0
         2xB3jqxayJbYjNxxFP3/ZeToVAPfXJzjWL5fLres+d1jdf7wgHjwpBNk1mCiOS4fzKy3
         72qqCwLbHmLcX+4Nn0W4CsvUd4sZ8SiGEYMN3mNSyoAYPYtrA23FYcIRd0Ogcog9Xfh0
         uKl1yK/gjLnSlj/8FD3WFQii3iC0/JDipq4d1rN5E6Auc/x7kttZbQxCfzR/DDPsS7pZ
         /6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690460831; x=1691065631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbBc/Xp5vDhN57+nyWdnfZit+Hhf7+7jO6GicfM9MZY=;
        b=YjiVTS3NydhUXVEPfZ+3t+DiE+zULf40B7uRGkLFqxN3MEOaZCLzFocOj5iHDwvkb1
         3bugdsFIdrF5Kv4JtFugrLDSXRgkZILHqylz22NaXilvirGv5a72snlDNjqCvDKnftsu
         ESVPkMdUlXNw0P1GONMZn2j9abIxyk09FRFHOLpJjOfDZsNWwm9xAUwPkbRGr9r3vseC
         Ob1IacTkYN1SQbeBd3Sb2U6/A/aB75vW+7Se+WaVijpLlR/Ptn49FvsYq2+bQUb4JVHv
         wA5qFCzXU5lp0wzM0hnLuuzg309HDVtdjonECsR4ekAH/lUxHbEwXcautAToyhrwa8t/
         5nvg==
X-Gm-Message-State: ABy/qLb3ubOe0DjvHArGabe2NcDtQ9CXnHxnK+qw+iAFjeN2VU23+W58
        tGEmsAdv9D/MLgxYa8l0FL5+Rg==
X-Google-Smtp-Source: APBJJlHSr8IB03GxRhMBlFdFfdlZPoqNJpO9iIuq9aU4JtzQR+GUoz8bwVuMY1X2x4tOPFXaa5Gerw==
X-Received: by 2002:a05:6512:1591:b0:4f8:58ae:8ea8 with SMTP id bp17-20020a056512159100b004f858ae8ea8mr1930432lfb.58.1690460831464;
        Thu, 27 Jul 2023 05:27:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s25-20020a056402165900b0051d9dbf5edfsm594934edx.55.2023.07.27.05.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 05:27:10 -0700 (PDT)
Message-ID: <e9a4e015-7e25-92be-9a7a-8e5dcf3848fa@linaro.org>
Date:   Thu, 27 Jul 2023 14:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] dt-bindings: qcom: Update RPMHPD entries for some SoCs
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc:     mathieu.poirier@linaro.org, mchehab@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, quic_vgarodia@quicinc.com,
        konrad.dybcio@linaro.org, agross@kernel.org,
        freedreno@lists.freedesktop.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, jonathan@marek.ca,
        conor+dt@kernel.org, robh+dt@kernel.org, airlied@gmail.com,
        linux-mmc@vger.kernel.org, quic_tdas@quicinc.com,
        stanimir.k.varbanov@gmail.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        mturquette@baylibre.com, dmitry.baryshkov@linaro.org,
        linux-remoteproc@vger.kernel.org, sean@poorly.run,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org, mani@kernel.org,
        linux-media@vger.kernel.org, sboyd@kernel.org,
        quic_abhinavk@quicinc.com, bhupesh.sharma@linaro.org,
        linux-arm-msm@vger.kernel.org, marijn.suijten@somainline.org,
        neil.armstrong@linaro.org, robdclark@gmail.com
References: <1690448953-23425-1-git-send-email-quic_rohiagar@quicinc.com>
 <169045659774.1058731.6391693092002547810.robh@kernel.org>
 <fa84ec4f-bdb9-dace-c56a-46174a9b47ee@quicinc.com>
 <2edb92b8-a6a8-c115-757c-daccef6be5f0@linaro.org>
 <432ab1d3-0f9e-4072-ff4d-6362886584b8@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <432ab1d3-0f9e-4072-ff4d-6362886584b8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27/07/2023 14:21, Rohit Agarwal wrote:
>>> https://lore.kernel.org/all/1689744162-9421-1-git-send-email-quic_rohiagar@quicinc.com/
>> Please mention the dependency in patch changelog ---, so it is obvious
>> for people applying it and also for the bot.
> Sure. Will send a cover letter for this patch mentioning the changelogs 
> and will
> keep the version as v2 since there no change at all in the patch.

There is no need for cover letter for one patch.

Best regards,
Krzysztof

