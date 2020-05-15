Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13CCC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 15:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08E720709
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 15:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IgrV4I+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgEOPul (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 11:50:41 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:10795 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgEOPuk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 11:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589557840; x=1621093840;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=MDIagMcn7mtuRjSwV1TW+kBgMJmNhc1GuhsOuPDwSjA=;
  b=IgrV4I+2QUMtSMcQN9d30JNmW6QuUBbWS+shwerFeBwTTsFZfyXZOoRH
   eMHuGVCfHhPa6PXWqSK3Nhnw5QwQZ3aLkDZ5rOEOYrTq1TkXEmWmuEAcN
   LRyERW7dPm2jSd4iBo9BG8yooc55xkRUVkipYlzMBJ2wCUnx9UeQILBj5
   t7AsuranZ/fMSuyAbIpgcPBy1/ain4hrRiEo5WQWHy/oShS+z7TpXRsZW
   ZaMXMfk4bKubDrtLMQUQDsYbrjk1zkx8/V2s6kKw7aF1AH5MtEZxcZFEr
   FxCQOptrmJG+HaYyWD/OThg9iSNMQf7oma3jOrYiXFIYl7JBUGmgFinkf
   w==;
IronPort-SDR: I/qRcPDftRSuDS3oZ/Yg8hkzzKz87JMkmZGRX/CRyKNK9aOiBJLrIHXEjMtIKvh7ilKQjxCYBt
 0caWAGW27FWHrET47n3/5mCkj1k00dKIfJVFzi5/Q/aRnwhxytJg7FSNzrd6iVj9C4kMkZktJ3
 oFzLG8QKXY1eGP2E0krhyvx5q3nBCOtHqBva0jGRk8LlxJqe23IGOxjOPoI/BI3eLmEspPit8K
 7cwXiTKFJltJ2R8MYABxTUHdYiyqNYNf35oPm92VuNmoUVNOqHLt0xSASMqikAAS25EM7Fp+Ed
 pI4=
X-IronPort-AV: E=Sophos;i="5.73,395,1583218800"; 
   d="scan'208";a="12522245"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2020 08:50:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 08:50:42 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 15 May 2020 08:50:36 -0700
References: <20200513133122.25121-1-lars.povlsen@microchip.com> <20200513133122.25121-2-lars.povlsen@microchip.com> <20200514130351.GA17797@bogus>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Rob Herring <robh@kernel.org>
List-Id: <soc.lore.kernel.org>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "SoC Team" <soc@kernel.org>, <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller bindings
In-Reply-To: <20200514130351.GA17797@bogus>
Date:   Fri, 15 May 2020 17:50:35 +0200
Message-ID: <87zha9nqno.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


Rob Herring writes:

> On Wed, 13 May 2020 15:31:20 +0200, Lars Povlsen wrote:
>> The Sparx5 SDHCI controller is based on the Designware controller IP.
>>
>> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> ---
>>  .../mmc/microchip,dw-sparx5-sdhci.yaml        | 57 +++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
>>
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.example.dts:20:18: fatal error: dt-bindings/clock/microchip,sparx5.h: No such file or directory
>          #include <dt-bindings/clock/microchip,sparx5.h>
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> scripts/Makefile.lib:312: recipe for target 'Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.example.dt.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Makefile:1300: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
> See https://patchwork.ozlabs.org/patch/1289290
>

Rob,

The header file is added with the "parent" SoC series for Sparx5, which
was submitted separately to the SoC list.

Should I rewrite the example to avoid using the (normal) header file, or
can you add the header file?

I have verified the YAML pass dt_binding_check with the header file.

> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
>
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
>
> Please check and re-submit.

-- 
Lars Povlsen,
Microchip
