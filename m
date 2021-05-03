Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070B8C433ED
	for <linux-mmc@archiver.kernel.org>; Mon,  3 May 2021 15:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C697C6135F
	for <linux-mmc@archiver.kernel.org>; Mon,  3 May 2021 15:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhECPVo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 May 2021 11:21:44 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:39885 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhECPVl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 May 2021 11:21:41 -0400
Received: by mail-ot1-f52.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso5376957otv.6;
        Mon, 03 May 2021 08:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=GdRfS0NHErZVUqqjMY2tvcA6NmXLytui8eUHJOfx6FM=;
        b=PiFNPOjwt7FumqSiTYHzGh3JpR+Pmu+X7o/5oRdOhDfydSruReApvh0RSUKSuaInZN
         fyaUkU3b0QM34W1z4bWnhBbISD0ZmLAZQWCGPTtUFvbFYTKMRAUb3WFXUVLeYuJmVXay
         Ku65gpGa+mxJqmNrYtnC3fiqGVKNDa5NsCifRRWbmDNMME7q5YBbHuGjb/mg6orXjdfQ
         wgPF7Oh4zEzyFPBIQ6x49GNsbwJjnuh6+CuEAYZLqd521T1H3gpdD4YalNA7annbWSo/
         vWVOVSRnQEG3qcghb+V1x3RW5bRH2mj/SprcWlQ9JJlgkDuE+IxMWoR1ljQVIc7Fymxh
         FSwQ==
X-Gm-Message-State: AOAM531hIH9Q2oHF33zD2bxxAnAwpKSSkQ8JzSPDqe6PIUHNkIR7KP88
        66LE+CMokHBmoQiY6Ko6nw==
X-Google-Smtp-Source: ABdhPJw/6Y4/5RNWt0aDLiFM9Q40lQB7DmrNe23N623XZAxpH+zo50yvHPFA1QJ/fbU0MbLiUUK6Qg==
X-Received: by 2002:a05:6830:205a:: with SMTP id f26mr15125496otp.118.1620055247487;
        Mon, 03 May 2021 08:20:47 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a19sm24101otk.31.2021.05.03.08.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 08:20:46 -0700 (PDT)
Received: (nullmailer pid 1846828 invoked by uid 1000);
        Mon, 03 May 2021 15:20:45 -0000
From:   Rob Herring <robh@kernel.org>
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, ryan_chen@aspeedtech.com,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>, chin-ting_kuo@aspeedtech.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Hongweiz@ami.com
In-Reply-To: <20210503014336.20256-2-steven_lee@aspeedtech.com>
References: <20210503014336.20256-1-steven_lee@aspeedtech.com> <20210503014336.20256-2-steven_lee@aspeedtech.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: sdhci-of-aspeed: Add description for AST2600 EVB.
Date:   Mon, 03 May 2021 10:20:45 -0500
Message-Id: <1620055245.319540.1846827.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 03 May 2021 09:43:34 +0800, Steven Lee wrote:
> Add the description for describing the AST 2600 EVB reference design of
> GPIO regulators and provide the example in the document.
> 
> AST2600-A2 EVB has the reference design for enabling SD bus
> power and toggling SD bus signal voltage by GPIO pins.
> 
> In the reference design, GPIOV0 of AST2600-A2 EVB is connected to
> power load switch that providing 3.3v to SD1 bus vdd. GPIOV1 is
> connected to a 1.8v and a 3.3v power load switch that providing
> signal voltage to
> SD1 bus.
> 
> If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
> disabled.
> If GPIOV1 is active high, 3.3v power load switch is enabled, SD1
> signal voltage is 3.3v. Otherwise, 1.8v power load switch will be
> enabled, SD1 signal voltage becomes 1.8v.
> 
> AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
> The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and
> GPIOV3 as power-switch-gpio.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml:97:5: [error] syntax error: expected <block end>, but found '<scalar>' (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/mmc/aspeed,sdhci.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 421, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 109, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.parser.ParserError: while parsing a block mapping
  in "<unicode string>", line 5, column 1
did not find expected key
  in "<unicode string>", line 97, column 5
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/mmc/aspeed,sdhci.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml:  while parsing a block mapping
  in "<unicode string>", line 5, column 1
did not find expected key
  in "<unicode string>", line 97, column 5
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
make: *** [Makefile:1414: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1472993

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

