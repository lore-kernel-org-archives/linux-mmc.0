Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CAFC6FA82
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 22:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiI0WFg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiI0WFd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 18:05:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81624EEEBC;
        Tue, 27 Sep 2022 15:05:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53EDB61BF5;
        Tue, 27 Sep 2022 22:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA08C4314B;
        Tue, 27 Sep 2022 22:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664316321;
        bh=PT9L3gVgvk+NtjJTnya/r6tVxlGqzoJ1UQygKoxMIbE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TZJUughhtGRTj3Ms19FBBZKRRiVI8m7qZFPhF2r0zmZBT6eHGpDxptxfOOoecBESs
         Pj4RgZTmYkKaGTcUO+kwa2trqrV2d7+rb0qd5jy6iqtqa6GM2x5eQ7rHStLaI7iTat
         zLHonFAx2CNuYPIBar7d1cUUIkZklP9yAtDhSHlepFnR7v2GN1+0pDiVuWKiwUG5Sj
         DN5IionQuJ10iE/0ZnzRJ2iz0IBU/s0q7jDdRVT6dPQSb0PLe019oY/+NeGhr+dYE3
         wzj5l1u2115qsFMGjo7tYUSe/KW1p1WwIQHScJCYKdRmyRcd89c67/RCldWegBQo+K
         upcNrw6qLCISw==
Received: by mail-vs1-f46.google.com with SMTP id j7so11000943vsr.13;
        Tue, 27 Sep 2022 15:05:21 -0700 (PDT)
X-Gm-Message-State: ACrzQf3Ud60dw6d3l2Tf0goh6qKGRC5ZKPL0bU5bhdsEiVvf+AzVMCOV
        JXR54jOCloTl51YJXsY8sKXN8RV/ukm+kuHH2w==
X-Google-Smtp-Source: AMsMyM5W0GcaSRnIx3xT9MsFQVa6C2yfhAclAga6IA7giEMLVq64/7bTyJ3c/aHSQjJl4sv7pPyEo2cpR5IcHdxPt7k=
X-Received: by 2002:a67:c18a:0:b0:398:4c72:cafb with SMTP id
 h10-20020a67c18a000000b003984c72cafbmr11756375vsj.53.1664316320606; Tue, 27
 Sep 2022 15:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140932.820050-1-dinguyen@kernel.org> <f4d29a38-c195-43f7-4837-43a6176a0a58@linaro.org>
 <d8706eb0-6e1c-22ae-a88b-ea183e6bcede@kernel.org>
In-Reply-To: <d8706eb0-6e1c-22ae-a88b-ea183e6bcede@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 27 Sep 2022 17:05:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ty4HShTWhQ+NTOWRWjNTw1=Z6YO-co6_BhDXPuU+5Yg@mail.gmail.com>
Message-ID: <CAL_Jsq+ty4HShTWhQ+NTOWRWjNTw1=Z6YO-co6_BhDXPuU+5Yg@mail.gmail.com>
Subject: Re: [PATCHv3 1/3] dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jh80.chung@samsung.com, ulf.hansson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Sep 26, 2022 at 11:49 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
>
>
> On 9/26/22 10:35, Krzysztof Kozlowski wrote:
> > On 26/09/2022 16:09, Dinh Nguyen wrote:
> >> +allOf:
> >> +  - $ref: "synopsys-dw-mshc-common.yaml#"
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const:
> >> +              - altr,socfpga-dw-mshc
> >> +    then:
> >> +      required:
> >> +        - altr,sysmgr-syscon
> >
> > else:
> >    properties:
> >      altr,sysmgr-syscon: false
> > and then you will probably see the warnings leading to error in syntax
> > (const is not an array)...
> >
>
> Hmm, okay. I ran dt_binding_check and did not see the warning. I'll
> check it again.

Indeed, it does not warn. An array is allowed here as you could have a
constant array value. Expect a warning soon though, as I'm working on
adding one.

Rob
