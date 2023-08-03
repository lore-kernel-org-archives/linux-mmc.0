Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA2C001DF
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Aug 2023 15:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbjHCPoD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Aug 2023 11:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237211AbjHCPn4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Aug 2023 11:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4AF35BC;
        Thu,  3 Aug 2023 08:43:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15CE461DFB;
        Thu,  3 Aug 2023 15:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A36C433C8;
        Thu,  3 Aug 2023 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691077433;
        bh=vyWLLySlQGq6BpkO155sr4fjzQO0x4nPVHkn/8pgy4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DidcLERA1v5cl2LaEXvD9wf7sjQqPuE2JtM7P5ZD9Z0iNBPWSESq3AdYuYKJ15uvW
         ljjiTdlt4AGX1IoCBtARXN146sqyHgzgL//Ht/zD8jsB5ale1WcKqNEKEwGqw+kIT/
         ArMBb/SsStNf5oFwvc6gxWLCwvl8jPwWxq+mq/Vbg02qoED7CnvoFHomdmg37GPKre
         ixVjiipuRa51piejKIJSVcWADeV8+oPCkwpjtz6bPGf0GdfP9YeXTFNRSbAW5Vrald
         Y16YwNUBcDbDTMxuweR+5RllWeuHyHA7sMLwviU5ubF8eNH24GmcCZvm5j0tpD/sws
         5/40gpR7sfoDQ==
Date:   Thu, 3 Aug 2023 16:43:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Adrian Hunter <adrian.hunter@intel.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: arasan,sdci: Add power-domains and
 iommus properties
Message-ID: <20230803-reliant-swinger-f98ada14e059@spud>
References: <bf912d5f5e74b43903a84262565f564bfe0fed7e.1691047370.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="972CNa3f6Fri15w5"
Content-Disposition: inline
In-Reply-To: <bf912d5f5e74b43903a84262565f564bfe0fed7e.1691047370.git.michal.simek@amd.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--972CNa3f6Fri15w5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 09:22:56AM +0200, Michal Simek wrote:
> ZynqMP SDHCI Arasan IP core has own power domain and also iommu ID that's
> why describe optional power-domains and iommus properties.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--972CNa3f6Fri15w5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMvLNAAKCRB4tDGHoIJi
0jD7AQCASIbcpy4j/M7mzHggqyrxbfmlTC8pyAeDYWu74qD84QD+JfEN/IZRHqdl
v3FafNA5z7pkBIn0H/DiCfC0abQuqgg=
=5Uj6
-----END PGP SIGNATURE-----

--972CNa3f6Fri15w5--
