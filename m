Return-Path: <SRS0=ypud=CJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88E2C433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 03:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE63206A5
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 03:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598844178;
	bh=zps3Ebkx7JECyCsvQtan53Rh4MEowUTfCqk7UueZZ2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QR6EzNeTRhMlCsqwLgIbZbxt3glqc7/TzjhfNPoeTe5tg0r+8g6tcM65J9K0auR0A
	 j+3lV/Y1geYmOPTs6crExuDJwpyp25rD+myns/wQ+reR3l81AKYDRYLawJSVYpyT9G
	 ERH64UhhIpZwWP1GXyqzIz0LwwTjoMCl5J80K9oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgHaDWv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbgHaDWu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 30 Aug 2020 23:22:50 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82896206A5;
        Mon, 31 Aug 2020 03:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598844170;
        bh=zps3Ebkx7JECyCsvQtan53Rh4MEowUTfCqk7UueZZ2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDArH0M2PvSJ/mhuTPtKSpFMXQOwvEMnW/ojzgFKDDdwmbueGXpnRAT1ViwRLjS86
         iJ3uz3j9jRMRLmvBvXyirqsS1CGUfj3QRHTFuSV+7dW5G32Ji1KXwMa0Q6e0QMJl/0
         s8RCbwOQ3wIsGyzuGMBhBumct7YoewPaFeYP32Bk=
Date:   Mon, 31 Aug 2020 11:22:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 15/19] dt-bindings: arm: fsl: Add ZII Ultra boards
 binding
Message-ID: <20200831032241.GG4488@dragon>
References: <20200825193536.7332-1-krzk@kernel.org>
 <20200825193536.7332-16-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825193536.7332-16-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Aug 25, 2020 at 09:35:32PM +0200, Krzysztof Kozlowski wrote:
> Document the binding for Zodiac Inflight Innovations Ultra Boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thanks.
