Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8912C77B7E
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jun 2023 08:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjFAI2q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jun 2023 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjFAI2Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jun 2023 04:28:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51D01B4
        for <linux-mmc@vger.kernel.org>; Thu,  1 Jun 2023 01:28:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f4f757d575so831412e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Jun 2023 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685608099; x=1688200099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3JaUYYseOOR1R5d/w1KWzjRPShmvJQ99IwvOrfCTtD8=;
        b=kyjaFKGlVHtkgiS7AeIPYAxVpfoDRZtNX7g/jpyd2QRt+Z3F+N8HWMgKXY0hPQspIw
         cflIasbBv0qnkUEYdUxba+5O2RGZstZ5b7QJMxdKWLsjypkSEFzwM/xgaO6zIwm25W9B
         JHfmtqUQzS8MX/wwvFkaWnNNiJYUgo0tGPJE0QX9YMeX1NLVrEurQhwZeX0IEfAYuFlw
         Y3ASRyk+iVdbl5a7a74vkaeQW8p4KeKHpHuwoZ2gAGn3B98DsdI3tq/KsMWNO6SuW2Kl
         zGRXAn5AK6Jl8lduDGwoDTQSbyu8PtxiLKFZTJxRBUHuJ3E0BQT0Np0WA7ucPQt7/xlJ
         ljGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608099; x=1688200099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JaUYYseOOR1R5d/w1KWzjRPShmvJQ99IwvOrfCTtD8=;
        b=ABEg6lfeVCbjVjzjE8zmbSbNkdgZRoiOYCPEK0MRYE3Bi55BsEsyW3mNhiyRVUymYB
         TurArCh42g5506cpazPh1vdblpLGit0jztsGq3YtGWyB6J6lLx5Qv11KMDbL0eWNWrv7
         SkvQSFS3F+dzbfkW4utdTwhc801HmvpLOiSgCJqC9/RvoHeyTjnpAhZaNtk2scTjItQ/
         HTiDLYvnGqblM1A1tN34f0US+OJ+HRkrj7l3JzMIx0fa+wkQkRzVYsijD+TrqqZQmMDa
         VMmzgKo+RK8K42/CziPMQwAOjFBN+Okr75QDzIS83SDLjB+AB+h1pRBZoVOaEp7qeSkG
         8BdQ==
X-Gm-Message-State: AC+VfDzXz+Aj7T5rw1tNkYBXz33WuuY/adGzLBGL8TP1Adsl6bwPEnwd
        wtzLunXzSf2AjnZU4wvQMeKQLal5ZtaXXoZXcZU=
X-Google-Smtp-Source: ACHHUZ4y/eNZdAB2djIfl0TSzTeH+aF3XX5y9faw3mmCYSyHd5sMa7YaASS9oCqpOP15lIkUZ2ruyg==
X-Received: by 2002:ac2:59db:0:b0:4f5:bc4e:80f7 with SMTP id x27-20020ac259db000000b004f5bc4e80f7mr352194lfn.14.1685608098640;
        Thu, 01 Jun 2023 01:28:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id q20-20020a19a414000000b004edb0882ce7sm1002385lfc.133.2023.06.01.01.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 01:28:18 -0700 (PDT)
Message-ID: <9e67709a-246e-95be-dc85-21e652306ea6@linaro.org>
Date:   Thu, 1 Jun 2023 10:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: qdu1000: Add SDHCI pin
 configuration to DTSI
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601065805.18079-1-quic_kbajaj@quicinc.com>
 <20230601065805.18079-4-quic_kbajaj@quicinc.com>
 <96f40b17-ad7a-ede2-dcbc-a35b6b7df1d2@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <96f40b17-ad7a-ede2-dcbc-a35b6b7df1d2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 1.06.2023 09:00, Krzysztof Kozlowski wrote:
> On 01/06/2023 08:58, Komal Bajaj wrote:
>> Add required pins for SDHCI, so that the interface can work reliably.
>>
> 
> This is not a separate commit. The pin configuration by itself does not
> make sense and we don't need it. It's part of adding SDHCI, so squash it.
keep my rb for the squashed patch

Konrad
> 
> Best regards,
> Krzysztof
> 
