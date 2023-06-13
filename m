Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9272FC001E0
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 23:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjFMXry (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 19:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjFMXrY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 19:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0957C2D53;
        Tue, 13 Jun 2023 16:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B305863C7E;
        Tue, 13 Jun 2023 23:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECABC433D9;
        Tue, 13 Jun 2023 23:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699950;
        bh=u6IpGYU2UCvx1R9A5MVeRKXpTQfKKrkb1k0a8Wb+o5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tDqM0iKhi0pkDjM95+qnd4ZviYxTwhDw2Z4wvQEE7MMuJ6wRaC9VvE9yobzIZXApj
         ehBXm0fzgDztZio3qfX5nSnigbhzRpCh9XOftCeRLT9ugBgkm2XU9nMpvvEfdIEQud
         QUYSPjeszS38CGCg4CBjy7SO2Vr5ktZOWvnFWVrD9uNYQSZFG/tTQ41gt+DutaWE4W
         uWruhc9EAj2JQmrCgN90AdpDkR/q5FIN6SkxlB1yMHPCer/HMwURmrsipTGYIhDQAN
         jvH11+HidMrnzd0pcVte8br5MoA9wXsdQANj4uh2XroO7TpfvjBr4QofXvcIIfOFRp
         WkICyU+G5dRPQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/3] arm64: dts: qcom: qdu1000: add SDHCI
Date:   Tue, 13 Jun 2023 16:48:53 -0700
Message-Id: <168670013502.1400697.2351855852052474721.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601111128.19562-1-quic_kbajaj@quicinc.com>
References: <20230601111128.19562-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 1 Jun 2023 16:41:25 +0530, Komal Bajaj wrote:
> Changes in v5 -
>  * Combined sdhc node addition and pin configuration into one commit.
> 
> Changes in v4 -
>  * Fixed the subject prefix to arm64.
>  * Updated the pinctrl entries alphabetically.
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: qdu1000: Add SDHCI node
      commit: 90c8c4eb4bbb5e2e241fd5286bd43dd30a850b9d
[3/3] arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc
      commit: 6901ff9987469fa33d06990463adc8a63f8be5d0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
