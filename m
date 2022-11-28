Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3A8C43217
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 12:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiK1MXN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Nov 2022 07:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiK1MWs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2022 07:22:48 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79481D317;
        Mon, 28 Nov 2022 04:20:50 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso6767709otr.9;
        Mon, 28 Nov 2022 04:20:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CleQloKxs/oV4Y+k4xNQxImH9pxlbxqGqLN+aVF09SU=;
        b=jgF/+psGjEeVLGBfJjb4zZ/ja1xlgwvYwznefMbdRLzC5zCR8+vWsxde/NsWGfEKvU
         tLRu8vPrHkyRVmwR4UE+JxSQFJUUs9r6anqAlxdmdPC+Mib1rYV9KafMyfvVr2TUrq2A
         HKz3oaRs68Eq6FmYGQwLyt8YybOhII5INPz4kaUPvuOZX/m1r5YuJWsgpcVQh/aDw68t
         M8Z5cxSX4aYqkha0x66PhxsQdoZ0zfBgQnlQyRxpHvSr5ivmtgyiP9qJUaLu6Va79qy/
         DtPcISfvMWaWou/8JUFYYv9ghxJctd9A2bPw0nYAMEFQv91+QqeUVhcqDaNqcTYzQcgk
         L7OA==
X-Gm-Message-State: ANoB5pmy1xRP52yeKWy4Md5m4yZj6O/zf0zMkPP5nlXGK0p4g6u7MGr/
        Uc3g+/6HeYi4HbP21ny9UR+9A1b9RQ==
X-Google-Smtp-Source: AA0mqf42E2M2bJSW49JtpbEKaOSL2UsN1IllQhZkqt/G7VXesQweSe2b32Evwp+LT0v+UglXDXKnhg==
X-Received: by 2002:a9d:6186:0:b0:661:a7b9:dbea with SMTP id g6-20020a9d6186000000b00661a7b9dbeamr15291960otk.77.1669638049878;
        Mon, 28 Nov 2022 04:20:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e32-20020a9d2aa3000000b00666a5b5d20fsm4594137otb.32.2022.11.28.04.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 04:20:49 -0800 (PST)
Received: (nullmailer pid 477526 invoked by uid 1000);
        Mon, 28 Nov 2022 12:20:47 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Doug Brown <doug@schmorgal.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
In-Reply-To: <20221128024407.224393-9-doug@schmorgal.com>
References: <20221128024407.224393-1-doug@schmorgal.com>
 <20221128024407.224393-9-doug@schmorgal.com>
Message-Id: <166963790392.472903.12789917850226152279.robh@kernel.org>
Subject: Re: [PATCH 8/8] dt-bindings: mmc: sdhci-pxa: add pxav1
Date:   Mon, 28 Nov 2022 06:20:47 -0600
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Sun, 27 Nov 2022 18:44:07 -0800, Doug Brown wrote:
> Add a compatible for the pxav1 controller in the PXA168, along with
> optional pinctrl properties to use for an errata workaround.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-pxa.yaml    | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml: properties:pinctrl-names: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'default'}, {'const': 'state_cmd_gpio'}] is too long
	[{'const': 'default'}, {'const': 'state_cmd_gpio'}] is too short
	False schema does not allow 2
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221128024407.224393-9-doug@schmorgal.com

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command.

