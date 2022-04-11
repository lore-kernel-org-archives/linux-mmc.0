Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815CAC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Apr 2022 07:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiDKHaH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Apr 2022 03:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242651AbiDKHaF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 03:30:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF963CFD8
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 00:27:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso3666716pjf.5
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 00:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dPQb2XUhCwirAl6RZqcjJK++gcgif/8kvwh+CadUz3I=;
        b=vk8tSK2SuBtu1pR68M+NpcoBAAxowa3wJlU3AMOY72md1Hscl+QNeJNVcx10ejkuuV
         NKZxxgnF1yldlX2MkwYMlndhvYLdVpauINzM1OJe7Gm4Ja0ONJJ+moREvoB2tju7IFxG
         S2uciJD12fnvlOYAOjli/Oc0252AsxXr19m7FjVkfEfVt7d+4W8EhVfPiayUUIK55VO2
         1OYinPvHp8r7yCmeTFS6M61kgx9Sby11bwnsIxYHeJC71r9vlPUoCggPbNqj876PY8KC
         MZ55RMC5eFxv0ZOnQF7zxi+0Nfwm8wE7DR3hGUQhMy9kF/pIKmngY7NXMpyUPOcxegs5
         ID2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dPQb2XUhCwirAl6RZqcjJK++gcgif/8kvwh+CadUz3I=;
        b=n3X+OztgMyt4UaoqikAp00syOl9U97I/E14+VdPeypDhKUYIK/UJLF0dRjDnn5xGZr
         aWwrts/E3KVQPmSAu/AYZn8W3YDS5j9U4lKQKPWdOgHxd/wACRKXdSKVnrq1TB6hRXI0
         NZhgrWDAcsfQzDnAbguF+/eu9F1oSmmOF+Rh8LOG6vqgV5lRxEiO6mcl9uvq5IfgCUqu
         CjKfZCvl65FJHnEPkPWov+ca6iafSz4NegqQ1XUpnSjUmFQt75Fu0UlJw15NDjEN/5lc
         pVNaEPfwxKFxDpWEqUOC5wwSuv7tQxvKk40Cw9GUIOI+uD3UCBM3EqSUPE2avihH/eAt
         SuSQ==
X-Gm-Message-State: AOAM5327CZ5W/Olv+i+JErwSHqSkZfDUHeTHUcGHNmNFDJhG31x9TxkM
        V35DypD41QOFSijDyOZUIsWn
X-Google-Smtp-Source: ABdhPJwfZOmz7bn126D73jA4tU3ELBxulz6f/9h9UuNvv751oKovp9R+buhc7tnYmqMckMjra91bgA==
X-Received: by 2002:a17:902:f68e:b0:154:6518:69ba with SMTP id l14-20020a170902f68e00b00154651869bamr31399663plg.60.1649662072219;
        Mon, 11 Apr 2022 00:27:52 -0700 (PDT)
Received: from thinkpad ([117.217.182.106])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090ade0100b001cb3feaddfcsm8828185pjv.2.2022.04.11.00.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 00:27:51 -0700 (PDT)
Date:   Mon, 11 Apr 2022 12:57:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/7] SDX65 devicetree updates
Message-ID: <20220411072743.GA24975@thinkpad>
References: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 11, 2022 at 12:25:36PM +0530, Rohit Agarwal wrote:
> Hello,
> 
> This series adds devicetree nodes for SDX65. It adds
> reserved memory nodes, SDHCI, smmu and tcsr mutex support.
> 

Please CC me to all SDX65 related patches as I'd like to review them.

Thanks,
Mani

> Thanks,
> Rohit.
> 
> Rohit Agarwal (7):
>   ARM: dts: qcom: sdx65: Add reserved memory nodes
>   dt-bindings: mmc: sdhci-msm: Document the SDX65 compatible
>   ARM: dts: qcom: sdx65: Add support for SDHCI controller
>   dt-bindings: arm-smmu: Add binding for SDX65 SMMU
>   ARM: dts: qcom: sdx65: Enable ARM SMMU
>   ARM: dts: qcom: sdx65: Add support for TCSR Mutex
>   ARM: dts: qcom: sdx65: Add Shared memory manager support
> 
>  .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts               |  21 ++++
>  arch/arm/boot/dts/qcom-sdx65.dtsi                  | 110 +++++++++++++++++++++
>  4 files changed, 133 insertions(+)
> 
> -- 
> 2.7.4
> 
