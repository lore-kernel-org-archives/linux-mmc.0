Return-Path: <SRS0=5vaz=BW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FAAC433E3
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 22:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD0820781
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Aug 2020 22:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHLWcj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:32:39 -0400
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:41486 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726605AbgHLWcj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2020 18:32:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C315D100E7B65;
        Wed, 12 Aug 2020 22:32:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: board29_4d052b526fef
X-Filterd-Recvd-Size: 2655
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Aug 2020 22:32:33 +0000 (UTC)
Message-ID: <f5dedf2d8d8057de3eaa2f9126f44cebb0653b09.camel@perches.com>
Subject: Re: [PATCH] dt-bindings: Whitespace clean-ups in schema files
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Wed, 12 Aug 2020 15:32:32 -0700
In-Reply-To: <20200812203618.2656699-1-robh@kernel.org>
References: <20200812203618.2656699-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2020-08-12 at 14:36 -0600, Rob Herring wrote:
> Clean-up incorrect indentation, extra spaces, long lines, and missing
> EOF newline in schema files. Most of the clean-ups are for list
> indentation which should always be 2 spaces more than the preceding
                                     ^
> keyword.
[]
> diff --git a/Documentation/devicetree/bindings/arm/arm,integrator.yaml b/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> index 192ded470e32..f0daf990e077 100644
> --- a/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> @@ -67,9 +67,9 @@ patternProperties:
>        compatible:
>          items:
>            - enum:
> -            - arm,integrator-ap-syscon
> -            - arm,integrator-cp-syscon
> -            - arm,integrator-sp-syscon
> +              - arm,integrator-ap-syscon
> +              - arm,integrator-cp-syscon
> +              - arm,integrator-sp-syscon

Confused a bit here.
          - enum:
	10 spaces to dash
old line:
            - arm,integrator-ap-syscon
	12 spaces to dash
new line:
              - arm,integrator-ap-syscon
	14 spaces to dash

Is it supposed to be 2 spaces more than the preceding line
or 4 more?


