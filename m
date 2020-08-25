Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603AEC433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 09:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1AE20706
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 09:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Cd6Y0NWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgHYJfW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:35:22 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:1801 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgHYJfV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2020 05:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1598348121; x=1629884121;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=imehd6Av3YkuYC+nc5UVG2QVM5uP2/002Rwbm57LAj4=;
  b=Cd6Y0NWOanAEZw3eQHwoC6WO34L1SevvlxNpOztC+X4IRCm5fWY9dt41
   sGhPOReeBL8Sr5X7JBuGvF3Nb0XuGcwiyUhfvYYgcdd8C9eNpD5qnhgEL
   8W7B6LsColU9CGhhPWSYJvPqnlNT3h1FgjqknR159Axcn5fVHtappYim0
   PNMpCMi+YG7qi1xIbxrFcUY7lJceH4ty57XP5Brcw7szT2Mcr6V0Pning
   R3x0t0yxNbVib2IsQVxYe36pKH1qADcfBE6U/wT0IPVezdJh5qw8R/s/m
   6L4ushcLkg4H/LhhVTEWxsiyp8bvl6x+CR0JMw4TFJbB/i6XwOHOnFROE
   g==;
IronPort-SDR: 6EmdwmgpID8mju0ri4n9FZNsRpGabVlBIRftulRHk0+bN0Q3pcW2ZTdmkcGbEyz9ZHKAevKDM1
 HQLmw9DCfYKm8B6KoTGDcnYOMhlh4ZKvoKbmBoEN1STE+lGM8seasctMwl6UbWUHceXp7Lv6uq
 BWfJmpS8xo9+ZQpO2BM36xw3/Yj1TbKhNtoqdOl0MzS1nAldHV/NH9dLRn9utQTOL6nd8jsvXZ
 n9UkcaZAG/9t2zVdM00UDmO3cvPmdnJaz97xjeQKi/uGK5rCZ7YSUpOX7BYHxkvahf5IweYcLp
 CGs=
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="88417367"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2020 02:35:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 25 Aug 2020 02:34:38 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 25 Aug 2020 02:35:14 -0700
References: <20200824151035.31093-1-lars.povlsen@microchip.com> <20200824151035.31093-2-lars.povlsen@microchip.com> <CAPDyKFoBom1n4AHniiukPiE_szskHrhcmVXfMpKTvNo9Xw9v0w@mail.gmail.com> <20200825084752.GD2389103@piout.net>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: <soc.lore.kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "SoC Team" <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller bindings
In-Reply-To: <20200825084752.GD2389103@piout.net>
Date:   Tue, 25 Aug 2020 11:35:14 +0200
Message-ID: <87blizxe3x.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


Alexandre Belloni writes:

> On 25/08/2020 09:33:45+0200, Ulf Hansson wrote:
>> On Mon, 24 Aug 2020 at 17:10, Lars Povlsen <lars.povlsen@microchip.com> wrote:
>> >
>> > The Sparx5 SDHCI controller is based on the Designware controller IP.
>> >
>> > Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> > ---
>> >  .../mmc/microchip,dw-sparx5-sdhci.yaml        | 65 +++++++++++++++++++
>> >  1 file changed, 65 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
>> >
>> > diff --git a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
>> > new file mode 100644
>> > index 0000000000000..55883290543b9
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
>> > @@ -0,0 +1,65 @@
>> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/mmc/microchip,dw-sparx5-sdhci.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: Microchip Sparx5 Mobile Storage Host Controller Binding
>> > +
>> > +allOf:
>> > +  - $ref: "mmc-controller.yaml"
>> > +
>> > +maintainers:
>> > +  - Lars Povlsen <lars.povlsen@microchip.com>
>> > +
>> > +# Everything else is described in the common file
>> > +properties:
>> > +  compatible:
>> > +    const: microchip,dw-sparx5-sdhci
>> > +
>> > +  reg:
>> > +    maxItems: 1
>> > +
>> > +  interrupts:
>> > +    maxItems: 1
>> > +
>> > +  clocks:
>> > +    maxItems: 1
>> > +    description:
>> > +      Handle to "core" clock for the sdhci controller.
>> > +
>> > +  clock-names:
>> > +    items:
>> > +      - const: core
>> > +
>> > +  microchip,clock-delay:
>> > +    description: Delay clock to card to meet setup time requirements.
>> > +      Each step increase by 1.25ns.
>> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
>> > +    minimum: 1
>> > +    maximum: 15
>> > +
>> > +required:
>> > +  - compatible
>> > +  - reg
>> > +  - interrupts
>> > +  - clocks
>> > +  - clock-names
>> > +
>> > +examples:
>> > +  - |
>> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> > +    #include <dt-bindings/clock/microchip,sparx5.h>
>> > +    sdhci0: mmc@600800000 {
>>
>> Nitpick:
>>
>> I think we should use solely "mmc[n]" here. So:
>>
>> mmc0@600800000 {
>>
>> Please update patch3/3 accordingly as well.
>
> This is not what the devicetree specification says. 2.2.2 says that the
> generic name is mmc, not mmc[n]. Since there is a proper unit-address, I
> don't see the need for an index here.
>

Alex,

Yeah, I thought so as well - and the existing DTs have practically all
variations..

Nevertheless, I followed suit since I had to refresh the patch set
anyhow.

Cheers,

---Lars

-- 
Lars Povlsen,
Microchip
