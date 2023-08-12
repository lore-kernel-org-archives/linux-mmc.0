Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F1AC04A6A
	for <linux-mmc@archiver.kernel.org>; Sat, 12 Aug 2023 02:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbjHLCB1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Aug 2023 22:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjHLCBZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Aug 2023 22:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD4E30F8;
        Fri, 11 Aug 2023 19:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07A4364B7D;
        Sat, 12 Aug 2023 02:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F8CC433C7;
        Sat, 12 Aug 2023 02:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691805684;
        bh=Y7lfIglGpHMORL+CytKKzL5JgDIO00z7yfwPmN9EYtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOqvcunbx7UPFNwxjzmJIbDCpvRf2Blf/JEGbJlSVgGF0eqGutzO/Np09zGl985/s
         A1Vi80oi7dZhRbvbFi7PHv8PefhLb0x8QPKVacfxpENKmrKwrYcoMYkQzv1Jor0xCc
         Z3JoYHupKuA8okM4dYdU8OGeNCgSlsQprty2Ul/VldziACWdcobWcoxdXWv9MOXiUf
         ZNA9ZQ3QXH2ab8pktBNDSKiGnutXOlaF8MNpISEB2rERxQgIt5ASE0sgPsc8Ub7bYZ
         8K3dDJ5CYluQI2cahYKOqXDiiK0ZNax2uTs3SOPsTbzzJutj1YkjjdAVcubuwNQls0
         S10cYnSzmR+7g==
Date:   Sat, 12 Aug 2023 10:01:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        kernel@puri.sm, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        David Heidelberg <david@ixit.cz>,
        Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: imx8mq-librem5-devkit: Drop
 power-supply
Message-ID: <20230812020107.GI151430@dragon>
References: <cover.1691684726.git.agx@sigxcpu.org>
 <c1ed057f5cf27dd8ea649ddf5c67e4f73efd4120.1691684726.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1ed057f5cf27dd8ea649ddf5c67e4f73efd4120.1691684726.git.agx@sigxcpu.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Aug 10, 2023 at 07:59:51PM +0200, Guido Günther wrote:
> It's not a valid binding. Instead move the sdio_rst line to the power
> sequence and use w_disable1 as the vmmc-supply bringing it more in line
> with other SDIO M2 cards.
> 
> Resolves following warning:
> 
> arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb: mmc@30b50000: Unevaluated properties are not allowed ('power-supply' was unexpected)
>         from schema $id: http://devicetree.org/schemas/mmc/fsl-imx-esdhc.yaml#
> 
> Reported-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Applied, thanks!
